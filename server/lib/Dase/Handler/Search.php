<?php

class Dase_Handler_Search
{

    protected static function getAttributes() : array {
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

    /**
     * @param array $q
     * @param PDO $pdo
     * @return array
     * @throws Dase_DBO_Exception
     */
    public static function getColumnSearch(array $q, PDO $pdo) : array {
        $max = 50;

        if ($q['page'] ?? false) {
            $page = (int)$q['page'];
        } else {
            $page = 1;
        }
        $start = (($page - 1) * $max) + 1;

        $total_found = self::do_search($q, $pdo);

        $speech_ids = array_keys($total_found);
        $lines_total = 0;
        foreach ($speech_ids as $speech_key)    //populate speech array
        {
            $speeches = new Dase_DBO_Speech($pdo);
            $speeches_found = $speeches->load($speech_key);
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
            'att_names'=>self::getAttributes()
        ];
    }

    /**
     * @param PDO $pdo
     * @param $att
     * @param $type
     * @return array
     */
    public static function getColumn(PDO $pdo, $att, $type) : array {
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

    /**
     * @param array $q
     * @param PDO $pdo
     * @return array
     * @throws Dase_DBO_Exception
     */
    public static function getDisplayRow(array $q, PDO $pdo) : array {
        $text = new Dase_DBO_Line($pdo);
        $agent_role = new Dase_DBO_AgentRole($pdo);
        $agent = new Dase_DBO_Agent($pdo);
        $speech = new Dase_DBO_Speech($pdo);
        $section = new Dase_DBO_Section($pdo);
        $agent_list = array();
        $index = 1;
        if ($q['id'] ?? false) {
            $item = $speech->load($q['id']);
        } else {
            $total_found = self::do_search($q, $pdo);
            foreach ($total_found as $speech_id=>$speech) {
                if ($index == $q['num']) {
                    $speech = new Dase_DBO_Speech($pdo);
                    $item = $speech->load($speech_id);
                    break;
                }
                $index++;
            }
        }
        $agent_role->speech_id = $item->id;
        foreach ($agent_role->findAll(1) as $role) {
            $agent_id = $role->agent_id;
            $new_agent = $agent->load($agent_id);
            if (array_key_exists($new_agent->name, $agent_list)) {
                $agent_list[$new_agent->name][] = $role->role;
            } else {
                $agent_list[$new_agent->name][] = $agent->gender;
                $agent_list[$new_agent->name][] = $role->role;
            }
        }
        $fields = self::getAttributes();
        $section->speech_id = $item->id;
        $text->book = $item->book_number;
        $text->work = $item->work;
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
            'sections'=>$section->findAll(1),
            'texts'=>$text->findAll(1),
            'total'=>$q['total'] ?? null,
            'view_link'=>$view_link_params,
            'num'=>$q['num'] ?? null,
            'item'=>$item,
            'att_names'=>$fields
        ];
    }

    /**
     * @param array $q
     * @param PDO $pdo
     * @return array
     * @throws Dase_DBO_Exception
     */
    protected static function do_search(array $q, PDO $pdo): array
    {
        $set_array = array();
        //Create initial set with gender search paramaters and combine with other results to find intersection between sets
        //Uses speech id to find the first instance of an item with the speech id in searchable, so sets store only entries w/ attribute of book number for gender searches
        foreach (['addressee', 'addressee_of_enclosing', 'narrator_of_enclosing', 'speaker'] as $type) {
            if ($q[$type . '_gender'] ?? false) {
                $set = array();
                $agent = new Dase_DBO_Agent($pdo);
                if ($q['logic_' . $type . '_gender'] === 'include') {
                    $agent->gender = $q[$type . '_gender'];
                } else {
                    $agent->addWhere('gender', $q[$type . '_gender'], '!=');
                }
                foreach ($agent->findAll(1) as $agents) {
                    $role = new Dase_DBO_AgentRole($pdo);
                    $role->agent_id = $agents->id;
                    foreach ($role->findAll(1) as $k => $v) {
                        if ($v->role === $type) {
                            $searchable = new Dase_DBO_Searchable($pdo);
                            $searchable->speech_id = $v->speech_id;
                            $set[] = $searchable->findOne();
                        }
                    }
                }
                $set_array[] = $set;
            }
        }
        unset($set);

        foreach (self::getAttributes() as $field => $field_name) {
            $searchable = new Dase_DBO_Searchable($pdo);
            $searchable->attribute = $field;
            if (!array_key_exists($field, $q)) {
                continue;
            }
            if (!trim($q[$field]) && '0' !== ($q[$field])) {
                continue;
            }

            if ($q[$field . '1'] ?? false) {
                if ($q['logic_' . $field] === 'include') {
                    $searchable->addWhere('value', $q[$field], '>=');
                    $searchable->addWhere('value', $q[$field . '1'], '<=');
                    $set = $searchable->findAll(1);
                } else {
                    $searchable->addWhere('value', $q[$field], '<');
                    $set = $searchable->findAll(1);
                    $searchable = new Dase_DBO_Searchable($pdo);
                    $searchable->attribute = $field;
                    $searchable->addWhere('value', $q[$field . '1'], '>');
                    $temp_set = $searchable->findAll(1);
                    array_splice($set, count($set), 0, $temp_set);
                }
            } else {
                if ($q['logic_' . $field] === 'include') {
                    $searchable->addWhere('value', $q[$field], '=');
                } else {
                    $searchable->addWhere('value', $q[$field], '!=');
                }
                $set = $searchable->findAll(1);
            }
            $set_array[] = $set;
        }

        unset($temp_set);

        // compute the intersection of all the result clauses, based on their speech ids
        $temp_set = $set_array[0];
        foreach ($set_array as $set) {
            $temp_set = array_uintersect(
                $temp_set,
                $set,
                static function ($item1, $item2) {
                    return strcmp($item1->speech_id, $item2->speech_id);
                }
            );
        }

        //Must pass additional test here.. use searchable->findall to pass the test
        $total_found = [];
        if (!empty($temp_set)) {
            foreach ($temp_set as $t) {
                $searchable = new Dase_DBO_Searchable($pdo);
                $searchable->speech_id = $t->speech_id;
                if (!isset($total_found[$t->speech_id])) { //don't copy entries
                    $total_found[$t->speech_id] = $searchable->findAll(1);
                }
            }
        }

        ksort($total_found);
        return $total_found;
    }

}
