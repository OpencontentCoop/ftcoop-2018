

{def $timeline = hash(  'subtree_array', array( $node.node_id ),
                        'sort_by', hash( 'attr_from_time_dt', 'asc' ),
                        'class_id', array( 'event' )
                        )|to_query_string()}

<div id="timeline-embed"></div>
<script type="text/javascript">
    var timeline_config = {ldelim}
        width:				"100%",
        lang:   	        {'javascript/timeline-locale/it.js'|ezdesign()},
        height:				"500",
        source:				{concat( 'ezjscore/call/opencontent::timeline::', $node.node_id, '::', $timeline)|ezurl()},
        start_at_end: 		false,
        css:				{'stylesheets/timeline.css'|ezdesign()},		//OPTIONAL PATH TO CSS
        js:					{'javascript/timeline-min.js'|ezdesign()}	//OPTIONAL PATH TO JS
    {rdelim}
</script>
{ezscript( array( 'timeline-embed.js' ) )}

