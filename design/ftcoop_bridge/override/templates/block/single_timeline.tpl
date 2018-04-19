{def $valid_node = $block.valid_nodes[0]}

<div class="content-view-block block-type-mainstory block-view-{$block.view}">

    {if $block.name}
    <div class="block-header">
        <h2 class="block-title">{$block.name|wash()}</h2>
    </div>
    {/if}

    {def $timeline = hash(  'subtree_array', array( $valid_node.node_id ),
                            'sort_by', hash( solr_field('from_time', 'date'), 'asc', 'published', 'asc' )
                            )|to_query_string()}


	{def $lang = ezini( 'RegionalSettings', 'Locale', 'site.ini' )}
	{def $locale = 'javascript/timeline-locale/it.js'|ezdesign()}
	{if $lang|eq('eng-GB')}
		{set $locale='javascript/timeline-locale/en.js'|ezdesign()}
	{/if}

    <div id="timeline-embed"></div>
    <script type="text/javascript">
        var timeline_config = {ldelim}
            width:				"100%",
            lang:   	        {$locale},
            height:				"480",
            source:				{concat( 'ezjscore/call/opencontent::timeline::', $valid_node.node_id, '::', $timeline)|ezurl()},
            start_at_end: 		false,
            css:				{'stylesheets/timeline.css'|ezdesign()},
            js:					{'javascript/timeline-min.js'|ezdesign()}
        {rdelim}
    </script>
    {ezscript( array( 'timeline-embed.js' ) )}

</div>
{undef}
