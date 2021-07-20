<?php


//PHP ERROR REPORTING -- turn off for production
ini_set('display_errors',1);
ini_set('display_startup_errors',1);
error_reporting(E_ALL);

date_default_timezone_set('America/Chicago');

// includes
define('BASE_PATH',dirname(__FILE__));

ini_set('include_path',BASE_PATH.'/lib');
require_once BASE_PATH.'/lib/Symfony/Component/ClassLoader/UniversalClassLoader.php';
$loader = new Symfony\Component\ClassLoader\UniversalClassLoader();
$loader->registerPrefixes([
  'Twig_Extensions_' => BASE_PATH.'/lib',
  'Twig_'            => BASE_PATH.'/lib',
]);
$loader->useIncludePath(true);
$loader->register();
require_once 'lib/Dase/Handler/Search.php';
require_once 'lib/Dase/DBO/Agent.php';
require_once 'lib/Dase/DBO/AgentRole.php';
require_once 'lib/Dase/DBO/Line.php';
require_once 'lib/Dase/DBO/Searchable.php';
require_once 'lib/Dase/DBO/Section.php';
require_once 'lib/Dase/DBO/Speech.php';


// db setup
$pdo = new PDO('sqlite:/database.sqlite3');

// template-rendering logic
$pathinfo = $_SERVER['REQUEST_URI'];
$path = trim(str_replace('.html','',$pathinfo),'/');
$path = explode('?', $path)[0];

function renderTemplate($path, $data=[]) {
    $loader = new Twig_Loader_Filesystem('/var/www/html/templates');
    $twig = new Twig_Environment($loader, array(
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
    $data = Dase_Handler_Search::getColumnSearch($_GET, $pdo);
    renderTemplate('search_table.tpl', $data);
} else if ($path==='search/display') {
    $data = Dase_Handler_Search::getDisplayRow($_GET, $pdo);
    renderTemplate('display_row.tpl', $data);
} else if (strpos($path, 'search')===0 && strpos($path, 'count')!==FALSE) {
    $att = $_GET['attr'] ?? '';
    $parts = explode('/', $path);
    $type = $parts[1];
    $data = Dase_Handler_Search::getColumn($pdo, $att, $type);
    renderTemplate('unique.tpl', $data);
} else {
    header('Location: /home');
    exit;
}

