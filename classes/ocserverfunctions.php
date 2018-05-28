<?php

class OCServerFunctions
{
    public static function timeline( $args )
    {
        $headlineNodeID = $args[0];
        $vars = str_replace( '&amp;', '&', $args[1] );
        parse_str( $vars, $params );
        
        $default = array(
            "query" => '',
            "offset" => 0, 
            "limit" => 10,
            "facets" => null,
            "filter" => null,
            "sort_by" => array( 'score', 'desc' ),
            "class_id" => null,
            "section_id" => null,
            "subtree_array" => array( eZINI::instance( 'content.ini' )->variable( 'NodeSettings', 'RootNode' ) )   
        );
        
        //echo '<pre>';print_r( $params );eZDisplayDebug();eZExecution::cleanExit();
        
        $params = array_merge( $default, $params );
        extract( $params );
        
        $ezfModuleFunctionCollection = new ezfModuleFunctionCollection();
        $results = $ezfModuleFunctionCollection->search(
                                                       $query,
                                                       $offset, 
                                                       $limit,
                                                       $facets,
                                                       $filter,
                                                       $sort_by,
                                                       $class_id,
                                                       $section_id,
                                                       $subtree_array
                                                       );
        
        //echo '<pre>';print_r( $results['result']['SearchCount'] );print_r( $results['result']['SearchExtras'] );eZDisplayDebug();eZExecution::cleanExit();
        
        $timeline =  OCTimelineTools::timeline( $headlineNodeID, $results );
        echo $timeline->toJSON();
        eZExecution::cleanExit();
    }
}  