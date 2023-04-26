<?php


//PHP ERROR REPORTING -- turn off for production
//ini_set('display_errors',1);
//ini_set('display_startup_errors',1);
//error_reporting(E_ALL);

require_once('./vendor/autoload.php');

date_default_timezone_set('America/Chicago');

// includes
define('BASE_PATH',dirname(__FILE__));

// db setup
$pdo = new PDO('sqlite:/database.sqlite3');

// template-rendering logic
$pathinfo = $_SERVER['REQUEST_URI'];
$path = trim(str_replace('.html','',$pathinfo),'/');
$path = explode('?', $path)[0];

function renderTemplate($path, $data=[]) {
    $loader = new \Twig\Loader\FilesystemLoader('/var/www/html/templates');
    $twig = new \Twig\Environment($loader, array(
        'cache' => '/tmp',
        'auto_reload' => false,
    ));
    $content = $twig->render($path,$data);

    header('Content-Type','text/html');
    echo($content);
    exit;
}

// URL handling
if ($path==='home') {
    renderTemplate('home.tpl');
} else if ($path==='about') {
    renderTemplate('about.tpl');
} else if ($path==='about/credits') {
    renderTemplate('credits.tpl');
} else if ($path==='notes') {
    renderTemplate('user_notes.tpl');
} else if ($path==='examples') {
    renderTemplate('examples.tpl');
} else if ($path==='search') {
    renderTemplate('search.tpl', ['nav'=>'search']);
} else if ($path==='search/column') {
    $data = getColumnSearch($_GET, $pdo);
    renderTemplate('search_table.tpl', $data);
} else if ($path==='search/display') {
    $data = getDisplayRow($_GET, $pdo);
    renderTemplate('display_row.tpl', $data);
} else if (strpos($path, 'search')===0 && strpos($path, 'count')!==FALSE) {
    $att = $_GET['attr'] ?? '';
    $parts = explode('/', $path);
    $type = $parts[1];
    $data = getColumn($pdo, $att, $type);
    renderTemplate('unique.tpl', $data);
} else {
    header('Location: /home');
    exit;
}


function getSearchAttributes() : array {
    $fields = [];
    $fields["book_number"]="Book Number";
    $fields["end_verse"]="End Verse";
    $fields["end_verse_of_enclosing"]="End Verse Of Enclosing";
    $fields["length"]="Length";
    $fields["length_of_enclosing"]="Length Of Enclosing";
    $fields["move_of_enclosing"]="Move Of Enclosing";
    $fields["narrative_level"]="Narrative Level";
    $fields["notes"]="Notes";
    $fields["speech_act_subtype_of_enclosing"]="Speech Act Subtype Of Enclosing";
    $fields["speech_act_type_of_enclosing"]="Speech Act Type Of Enclosing";
    $fields["start_verse"]="Start Verse";
    $fields["start_verse_of_enclosing"]="Start Verse Of Enclosing";
    $fields["subordinate_clause"]="Subordinate Clause";
    $fields["type_of_speech_repr"]="Type Of Speech Repr";
    $fields["verb_of_speaking"]="Verb Of Speaking";
    $fields["verse_number"]="Verse Number";
    $fields["work"]="Work";
    $fields["speech_act_subtype"]="Speech Act Subtype";
    $fields["speech_act_type"]="Speech Act Type";
    $fields["move"]="Move";
    $fields["addressee"]="Addressee";
    $fields["speaker"]="Speaker";
    $fields["narrator_of_enclosing"]="Narrator Of Enclosing";
    $fields["addressee_of_enclosing"]="Addressee Of Enclosing";

    return $fields;
}

function getColumnSearch(array $q, PDO $pdo) : array {
    $max = 50;

    if ($q['page'] ?? false) {
        $page = (int)$q['page'];
    } else {
        $page = 1;
    }
    $start = (($page - 1) * $max) + 1;

    $total_found = do_search($q, $pdo);

    $speech_ids = array_keys($total_found);
    $lines_total = 0;
    $speech_array = [];
    foreach ($speech_ids as $speech_key)    //populate speech array
    {
        $speech_sql = "SELECT * FROM speech WHERE id=:id";
        $speech_stmt = $pdo->prepare($speech_sql);
        $speech_stmt->setFetchMode(PDO::FETCH_OBJ);
        $speech_stmt->execute([':id'=>$speech_key]);
        $speeches_found = $speech_stmt->fetch();

        $lines_total += (int)$speeches_found->length;
        $first3LinesArray = array_slice(explode(' ', $speeches_found->speech_text), 0, 40);
        $first3LinesString = implode(' ', $first3LinesArray);
        $speech_array[] = $first3LinesString;
    }
    $total_displayed = array_slice($total_found, $start - 1, $max);
    $speech_array = array_slice($speech_array, $start - 1, $max);
    $total = count($total_found);
    $total_pages = ceil(($total / $max) - .001);
    $order_list = ['work', 'book_number', 'start_verse', 'end_verse', 'speaker', 'addressee',
        'length', 'verb_of_speaking', 'verse_number', 'subordinate_clause', 'narrative_level', 'type_of_speech_repr', 'speech_act_type', 'speech_act_subtype', 'move',
        'start_verse_of_enclosing', 'end_verse_of_enclosing', 'length_of_enclosing', 'narrator_of_enclosing', 'addressee_of_enclosing',
        'speech_act_type_of_enclosing', 'speech_act_subtype_of_enclosing', 'move_of_enclosing'];

    $view_link_params = "";
    foreach ($q as $key=>$value) {
        if (!in_array($key, ['num','id','page'])) {
            $view_link_params .= "&" . $key . "=" . $value;
        }
    }

    return [
        'order'=>$order_list,
        'speech_array'=>$speech_array,
        'total_pages'=>$total_pages,
        'page'=>$page,
        'max'=>$max,
        'view_link'=>$view_link_params,
        'result'=>$total_displayed,
        'total'=>$total,
        'lines_total'=>$lines_total,
        'att_names'=>getSearchAttributes()
    ];
}

function getColumn(PDO $pdo, $att, $type) : array {
    if (substr($type, -strlen('_gender')) === '_gender') {
        $stmt = $pdo->prepare(<<<TAG
SELECT agent.gender as value, count(*) as ct 
FROM agent, agent_role 
WHERE agent.id=agent_role.agent_id AND agent_role.role=:role 
GROUP BY gender
TAG
        );
        $stmt->execute([':role'=>str_replace('_gender', '', $type)]);
    } else {
        $stmt = $pdo->prepare(<<<TAG
SELECT value,count(*) as ct 
FROM searchable 
WHERE attribute=:attr 
GROUP BY value
TAG
        );
        $stmt->execute([':attr' => $type]);
    }
    $stmt->setFetchMode(PDO::FETCH_OBJ);
    $searched = $stmt->fetchAll() ?: [];
    $sub = [];
    foreach ($searched as $s) {
        $sub[$s->value] = $s->ct;
    }

    $keys = array_keys($sub);
    if (is_numeric(array_shift($keys))) {
        ksort($sub, SORT_NUMERIC);
    } else {
        ksort($sub);
    }
    return [
        'attr'=>$att,
        'column_name'=>$type,
        'sub'=>$sub
    ];
}

function getDisplayRow(array $q, PDO $pdo) : array {
    $index = 1;
    if ($q['id'] ?? false) {
        $speech_sql = "SELECT * FROM speech WHERE id=:id";
        $speech_stmt = $pdo->prepare($speech_sql);
        $speech_stmt->setFetchMode(PDO::FETCH_OBJ);
        $speech_stmt->execute([':id'=>$q['id']]);
        $item = $speech_stmt->fetch();
    } else {
        $total_found = do_search($q, $pdo);
        foreach ($total_found as $speech_id=>$speech) {
            if ($index == $q['num']) {
                $speech_sql = "SELECT * FROM speech WHERE id=:id";
                $speech_stmt = $pdo->prepare($speech_sql);
                $speech_stmt->setFetchMode(PDO::FETCH_OBJ);
                $speech_stmt->execute([':id'=>$speech_id]);
                $item = $speech_stmt->fetch();
                break;
            }
            $index++;
        }
    }
    $agent_sql = "SELECT * FROM agent, agent_role WHERE agent_role.speech_id=:speech_id and agent_role.agent_id = agent.id";
    $agent_stmt = $pdo->prepare($agent_sql);
    $agent_stmt->setFetchMode(PDO::FETCH_OBJ);
    $agent_stmt->execute([':speech_id'=>$item->id]);
    $agents = $agent_stmt->fetchAll() ?: [];

    $agent_list = [];
    foreach ($agents as $agent) {
        if (array_key_exists($agent->name, $agent_list)) {
            $agent_list[$agent->name][] = $agent->role;
        } else {
            $agent_list[$agent->name][] = $agent->gender;
            $agent_list[$agent->name][] = $agent->role;
        }
    }
    $fields = getSearchAttributes();

    $section_sql = "SELECT * FROM section WHERE speech_id=:speech_id";
    $section_stmt = $pdo->prepare($section_sql);
    $section_stmt->setFetchMode(PDO::FETCH_OBJ);
    $section_stmt->execute([':speech_id'=>$item->id]);
    $sections = $section_stmt->fetchAll() ?: [];

    $text_sql = "SELECT * FROM line WHERE book=:book AND work=:work";
    $text_stmt = $pdo->prepare($text_sql);
    $text_stmt->setFetchMode(PDO::FETCH_OBJ);
    $text_stmt->execute([':book'=>$item->book_number, ':work'=>$item->work]);
    $texts = $text_stmt->fetchAll() ?: [];

    $order_list = array('work', 'book_number', 'start_verse', 'end_verse', 'speaker', 'addressee', 'length', 'verb_of_speaking', 'verse_number', 'subordinate_clause', 'narrative_level', 'type_of_speech_repr', 'speech_act_type', 'speech_act_subtype', 'move', 'start_verse_of_enclosing', 'end_verse_of_enclosing', 'length_of_enclosing', 'narrator_of_enclosing', 'addressee_of_enclosing', 'speech_act_type_of_enclosing', 'speech_act_subtype_of_enclosing', 'move_of_enclosing');

    $view_link_params = "";
    foreach ($q as $key=>$value) {
        if (!in_array($key, ['num','id','page'])) {
            $view_link_params .= "&" . $key . "=" . $value;
        }
    }

    return [
        'nav'=>'view',
        'q'=>$q['q'] ?? null,
        'agent_list'=>$agent_list,
        'order'=>$order_list,
        'sections'=>$sections,
        'texts'=>$texts,
        'total'=>$q['total'] ?? null,
        'view_link'=>$view_link_params,
        'num'=>$q['num'] ?? null,
        'item'=>$item,
        'att_names'=>$fields
    ];
}

function do_search(array $q, PDO $pdo): array
{
    $set_array = array();
    //Create initial set with gender search paramaters and combine with other results to find intersection between sets
    //Uses speech id to find the first instance of an item with the speech id in searchable, so sets store only entries w/ attribute of book number for gender searches
    foreach (['addressee', 'addressee_of_enclosing', 'narrator_of_enclosing', 'speaker'] as $type) {
        if ($q[$type . '_gender'] ?? false) {
            $set = array();
            $op = '=';
            if ($q['logic_' . $type . '_gender'] === 'include') {
            } else {
                $op = '!=';
            }

            $agent_sql = "SELECT * FROM agent,agent_role WHERE gender ".$op." :gender AND role=:role AND agent_role.agent_id = agent.id";
            $agent_stmt = $pdo->prepare($agent_sql);
            $agent_stmt->setFetchMode(PDO::FETCH_OBJ);
            $agent_stmt->execute([':gender'=>$q[$type . '_gender'], ':role'=>$type]);
            $agents = $agent_stmt->fetchAll() ?: [];

            foreach ($agents as $agent) {
                $set[] = $agent->speech_id;
            }
            $set_array[] = $set;
        }
    }
    unset($set);

    foreach (getSearchAttributes() as $field => $field_name) {
        if (!array_key_exists($field, $q)) {
            continue;
        }
        if (!trim($q[$field]) && '0' !== ($q[$field])) {
            continue;
        }

        if ($q[$field . '1'] ?? false) {
            if ($q['logic_' . $field] === 'include') {
                $sql1 = "SELECT * FROM searchable WHERE attribute=:attribute AND cast(value as int)>=:value AND cast(value as int)<=:value1";
            } else {
                $sql1 = "SELECT * FROM searchable WHERE attribute=:attribute AND cast(value as int)<:value OR cast(value as int)>:value1";
            }
            $text_stmt = $pdo->prepare($sql1);
            $text_stmt->setFetchMode(PDO::FETCH_OBJ);
            $text_stmt->bindValue(':attribute', $field);
            $text_stmt->bindValue(':value', $q[$field], PDO::PARAM_INT);
            $text_stmt->bindValue(':value1', $q[$field . '1'], PDO::PARAM_INT);
            $text_stmt->execute();
            $set = $text_stmt->fetchAll() ?: [];
        } else {
            if ($q['logic_' . $field] === 'include') {
                $sql1 = "SELECT * FROM searchable WHERE attribute=:attribute AND value=:value";
            } else {
                $sql1 = "SELECT * FROM searchable WHERE attribute=:attribute AND value!=:value";
            }
            $text_stmt = $pdo->prepare($sql1);
            $text_stmt->setFetchMode(PDO::FETCH_OBJ);
            $text_stmt->execute([':attribute'=>$field, ':value'=>$q[$field]]);
            $set = $text_stmt->fetchAll() ?: [];
        }
        $speech_ids = [];
        foreach ($set as $searchable) {
            $speech_ids []= $searchable->speech_id;
        }
        $set_array[] = $speech_ids;
    }

    unset($temp_set);

    // compute the intersection of all the result clauses, based on their speech ids
    $temp_set = $set_array[0];
    foreach ($set_array as $set) {
        $temp_set = array_intersect(
            $temp_set,
            $set
        );
    }

    //Must pass additional test here.. use searchable->findall to pass the test
    $total_found = [];
    if (!empty($temp_set)) {
        foreach ($temp_set as $speech_id) {
            if (!isset($total_found[$speech_id])) { //don't copy entries
                $sql = "SELECT * FROM searchable WHERE speech_id = :speech_id";
                $sth = $pdo->prepare($sql);
                $sth->setFetchMode(PDO::FETCH_OBJ);
                $sth->execute([":speech_id" => $speech_id]);
                $total_found[$speech_id] = $sth->fetchAll();
            }
        }
    }

    ksort($total_found);
    return $total_found;
}