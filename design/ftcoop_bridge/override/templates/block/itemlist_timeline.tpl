{def $valid_nodes = $block.valid_nodes
     
     $curr_ts = currentdate()
     $curr_today = $curr_ts|datetime( custom, '%j')
     $curr_year = $curr_ts|datetime( custom, '%Y')
     $curr_month = $curr_ts|datetime( custom, '%n')
     
     $curr_first = makedate($curr_month, $curr_today, $curr_year)
     $curr_last = makedate($curr_month, sum( $curr_today, 1 ), $curr_year)|sub(1)
     
     $days = $curr_ts|datetime( custom, '%t')
     $static_days = 60|mul( 86400 )

     $first_ts = makedate($curr_month, 1, $curr_year)
     $dayone = $first_ts|datetime( custom, '%w' )
     $last_ts = sum( $curr_first, $static_days )
     
     $ezfind_month_first = $first_ts|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
     $ezfind_month_last = $last_ts|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
     $ezfind_curr_first = $curr_first|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
     $ezfind_curr_last = $curr_last|datetime( 'custom', '%Y-%m-%dT%H:%i:%sZ' )
}

<div class="content-view-block block-view-{$block.view}">
    {if $block.name}
	  <h4 class="blocktitle">
		{$block.name|wash()}
		<a href="{$valid_nodes[0].url_alias|ezurl(no)}"><small>{$valid_nodes[0].name|wash()}</small></a>
	  </h4>
    {/if}

    {def $subtree = array()}
    {foreach $valid_nodes as $valid_node}
        {set $subtree = $subtree|append( $valid_node.node_id )}
    {/foreach}
    
    {def $timeline = hash(  'subtree_array', $subtree,
                            'sort_by', hash( solr_field('from_time', 'date'), 'asc', 'published', 'asc' ),
                            'filter', array(
                                'or',
                                    concat( solr_field('from_time', 'date'),':[', $ezfind_curr_first, ' TO * ]' )
                                )
                            )}
    
    {def $search=fetch( 'ezfind', 'search', $timeline )}
    
    {if $search['SearchCount']|ne(0)}
        {def $timeline_string = $timeline|to_query_string()}
        <div id="timeline-embed"></div>
        <script type="text/javascript">
            var timeline_config = {ldelim}
                width:				"100%",
                lang:   	        {'javascript/timeline-locale/it.js'|ezdesign()},
                height:				"480",
                source:				{concat( 'ezjscore/call/opencontent::timeline::', $valid_nodes[0].node_id, '::', $timeline_string)|ezurl()},
                start_at_end: 		false,
                css:				{'stylesheets/timeline.css'|ezdesign()},
                js:					{'javascript/timeline-min.js'|ezdesign()}
            {rdelim}
        </script>
        {ezscript( array( 'timeline-embed.js' ) )}
    {else}
        <div class="alert alert-warning">
            <p class="text-center"><em>Nessun appuntamento in agenda...</em></p>
        </div>
    {/if}
    
</div>
{undef}
