<?php

/*
NON è la timeline di pateng ma una versione migliorata
la funzione timeline si aspetta un NodeID e un array di risultati di ezfind
*/
 
class OCTimelineTools 
{
    
    public static function timeline( $headlineNodeID, $results )
    {
        $lastTime = $results["result"]['SearchCount'] > 0 ? $results["result"]['SearchResult'][0]->attribute( 'published' ) : false;
        $cachefile = false;
        if ( $lastTime )
        {
            $fileName = md5( $headlineNodeID . $results["result"]['SearchCount'] ) . '.' . $lastTime . '.json';
            $cachedir = eZSys::cacheDirectory() . '/timeline';
            $cachefilename = $cachedir . '/' . $fileName;
            $cachefile = eZClusterFileHandler::instance( $cachefilename );
            if ( $cachefile->exists() )
            {
                $return = $cachefile->fetchContents();
                header( 'Content-Type: application/json' );
                echo $return;
                eZExecution::cleanExit();
            }
        }
        
        $timeline = new TimelineData();        
        $headline = self::createHeadlinefromNodeID( $headlineNodeID );
        $timeline->addHeadline( $headline );
        
        if ( $results["result"]['SearchCount'] > 0)
        {            
            self::addSearchResultsToTimeline( $results["result"]['SearchResult'], $timeline, array( $headlineNodeID ) );     
        }
        
        if ( $cachefile )
        {
            $return = $timeline->toJSON();
            $cachefile->storeContents( $return );
        }

        header('Content-type: application/json');	
        echo $return;
        eZDB::checkTransactionCounter();
        eZExecution::cleanExit();
    }
    
    private static function addSearchResultsToTimeline( $results, &$timeline, $excludeNodes = array() )
    {
        foreach ( $results as $node )
        {
            if ( in_array( $node->attribute( 'node_id' ), $excludeNodes ) )
            {
               continue; 
            }
            
            $dataMap = $node->attribute( 'data_map' );
            if ( isset( $dataMap['from_time'] ) && $dataMap['from_time']->hasContent() )
            {
                $timestamp = $dataMap['from_time']->attribute( 'content' )->attribute( 'timestamp' );
            }
            elseif( isset( $dataMap['publish_date'] ) && $dataMap['publish_date']->hasContent() )
            {
                $timestamp = $dataMap['publish_date']->attribute( 'content' )->attribute( 'timestamp' );
            }
            else
            {
                $timestamp = $node->attribute( 'object' )->attribute( 'published' );
            }
            
            $endDate = false;
            if ( isset( $dataMap['to_time'] ) && $dataMap['to_time']->hasContent() )
            {
                $endDate = $dataMap['to_time']->attribute( 'content' )->attribute( 'timestamp' );
            }
            
            $url = $node->attribute('url_alias');
            eZURI::transformURI( $url, true, 'full' );
            
            $media = false;
            if ( isset( $dataMap['image'] ) && $dataMap['image']->hasContent() )
            {
                $image = $dataMap['image']->attribute( 'content' )->attribute( 'activity_full' );
                if ( !empty( $image['url'] ) )
                {
                    $media = '/' . $image['url'];
                }
            }
            
            if ( isset( $dataMap['url_video'] ) && $dataMap['url_video']->hasContent() )
            {
                $media = $dataMap['url_video']->attribute( 'content' );
            }
            
            $text = '';
            
            $tpl = eZTemplate::factory();
            $tpl->setVariable( 'node', $node );
            $text = $tpl->fetch( 'design:node/view/timeline_line.tpl' );
            
            
            if ( $text == '' )
            {
                $text = self::getAbstract( $node );
            }
            
            $text = str_replace( '&nbsp;', ' ', $text );
            
            $item = new TimelineItem();
            $item->headline = "<a href='$url'>{$node->attribute( 'name' )}</a>";
            $item->startDate = date( "Y,n,j", $timestamp );
            if ( $endDate )
            {
                $item->endDate = date( "Y,n,j", $endDate );
                //$item->startDate = date( "Y,n,j", $endDate );
            }
            $item->text = $text;
                        
            if ( $image )
            {                
                $itemAsset = new TimelineAsset();
                $itemAsset->media = $media;
                $item->asset = $itemAsset;
            }
            
            $timeline->addData( $item );
        }
    }
    
    private static function createHeadlinefromNodeID( $nodeID )
    {
        $node = eZContentObjectTreeNode::fetch( $nodeID );
        
        if ( !$node )
        {
            return;
        }
        
        $dataMap = $node->attribute( 'data_map' );
        
        $headline = new TimelineHeadline();
        $headline->headline = $node->attribute( 'name' );
        $headline->startDate = date( "Y,n,j" );        
        $headline->text = self::getAbstract( $node );
                
        if ( isset( $dataMap['image'] ) )
        {
            $image = $dataMap['image']->attribute( 'content' )->attribute( 'activity_full' );
            $headlineAsset = new TimelineAsset();
            if ( !empty( $image['url'] ) )
            {
                $headlineAsset->media = '/'. $image['url'];
            }
            $headline->asset = $headlineAsset;
        }
        
        return $headline;
    }
    
    private static function getAbstract( $node )
    {
        $ini = eZINI::instance( 'ocoperatorscollection.ini' );
        $has_content = false;
        $text = false;        
        if ( is_numeric( $node ) )
        {
            $node = eZContentObjectTreeNode::fetch( $node );
        }
        
        if ( $node instanceof eZContentObjectTreeNode )
        {
            if ( $node->hasAttribute( 'highlight' ) )
            {                        
                $text = $node->attribute( 'highlight' );
                $text = str_replace( '&amp;nbsp;', ' ', $text );
        
                if ( strlen( $text ) > 0 )
                {
                    $has_content = true;
                }
            }
            
            if ( !$has_content )
            {
                $attributes = $ini->hasVariable( 'Attributi', 'AttributiAbstract' ) ? $ini->variable( 'Attributi', 'AttributiAbstract' ) : array();
                if ( !empty( $attributes ) )
                {
                    $dataMap = $node->attribute( 'data_map' );
                    foreach ( $attributes as $attr )
                    {
                        if ( isset( $dataMap[$attr] ) )
                        {
                            if ( $dataMap[$attr]->hasContent() )
                            {
                                $has_content = true;
                                $tpl = eZTemplate::factory();
                                $tpl->setVariable( 'attribute', $dataMap[$attr] );
                                $designPath = "design:content/datatype/view/" . $dataMap[$attr]->attribute( 'data_type_string' ) . ".tpl";
                                $text = $tpl->fetch( $designPath );
                                break;
                            }
                        }
                        
                    }
                }
            }
        }
        
        return $text;
    }
}

/*
$timeline = new TimelineData();

$headline = new TimelineHeadline();
$headline->headline = "Johnny B Goode";
$headline->startDate = "2009,1";
$headline->text = "<i><span class='c1'>Designer</span> & <span class='c2'>Developer</span></i>";

$headlineAsset = new TimelineAsset();
$headlineAsset->media = "http://vimeo.com/22439234";
$headlineAsset->credit = "Just for test!";
$headline->asset = $headlineAsset;

$timeline->addHeadline( $headline );

$data = new TimelineItem();
$data->startDate = "2009,2";
$data->headline = "My first experiment in time-lapse photography";
$data->text = "Nature at its finest in this video.";

$dataAsset = new TimelineAsset();
$dataAsset->media = "http://www.youtube.com/watch?v=0-9EYFJ4Clo";
$data->asset = $dataAsset;

$timeline->addData( $data );

header('Content-type: application/json');	
echo $timeline->toJSON();
 
*/

class TimelineData
{    
    public $headline;
    
    public function addHeadline( TimelineHeadline $item )
    {
        $this->headline = $item;
    }
    
    public function addData( TimelineItem $item )
    {
        $this->headline->addData( $item );
    }
    
    function toJSON()
    {
        $result = array( "timeline" => $this->headline );
        return json_encode( $result );
    }
}

class TimelineHeadline
{
    public $type = "default";
    public $headline = '';
    public $text = '';
    public $asset = '';
    public $date = array();
    
    public function addData( TimelineItem $item )
    {        
        $this->date[] = $item;
    }
}

class TimelineItem
{
    public $startDate = '';
    public $headline = '';
    public $text = '';
    public $asset = '';
}

class TimelineAsset
{
    public $media = '';
    public $credit = '';
    public $caption = '';
}

?>