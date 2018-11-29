<?php
$Module = array( 
	'name' => 'Image',
	'variable_params' => true 
);

$ViewList = array();
$ViewList['view'] = array(
    'functions' => array('view'),
    'script' => 'view.php',    
    'params' => array('ObjectId', 'Alias'),
    'unordered_params' => array()
);

$FunctionList['view'] = array();