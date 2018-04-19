{if is_set($shorten)|not}
	{def $shorten=200}
{/if}

{if is_set($image_class)|not()}
{def $image_class = 'small'}
{/if}
{if is_set($style)|not()}
{def $style = ''}
{/if}

{def $latest_search = fetch( 'ezfind', 'search', hash(
                                                    'subtree_array', array( $node.node_id ),
                                                    'class_id', array( 'comunicato', 'article', 'event' ),
                                                    'limit', 10,
                                                    'sort_by', hash( 'published', 'desc', solr_field('publish_date', 'date'), 'desc' ),
                                                    ) )
     $latest = cond( $latest_search.SearchCount|gt(0), $latest_search.SearchResult, array() )}

<div class="class-{$node.class_identifier} content-view-block-item {$style}">
	<div class="content-view-block-item-design float-break ">
        
        {if is_set($node.data_map.image)}
        {if $node.data_map.image.has_content}
        <div class="subsitelogo">{attribute_view_gui href=$node.url_alias|ezurl() attribute=$node.data_map.image image_class=medium}</div>
        {/if}
        {/if}
        
        <div class="intro">
        
            {if $node|has_abstract}
                {$node|abstract()}
                
            {elseif $latest|count()|gt(0)}
            
            {ezscript_require(array( 'ezjsc::jquery', 'jcarousel.js' ) )}
                {ezcss_require( array( 'arrows.css' ) )}
                <script type="text/javascript">
                {literal}
                $(document).ready(function() {
                    $("#children-{/literal}{$node.node_id}{literal}").jcarousel({
                        vertical: true,
                        scroll: 2
                    });
                });
                {/literal}
                </script>
                
                <ul id="children-{$node.node_id}" class="cycle">              
                {foreach $latest as $index => $child max 7 sequence array( 'odd', 'even' ) as $_style}
                    <li class="{$_style} evento-cycle {if $latest|eq($index|inc())}lastli{/if}{if $index|eq(2)} no-js-lastli{/if}{if $index|ge(3)} no-js-hide{/if}">	
                    {node_view_gui content_node=$child view='listitem'}
                    </li>
                {/foreach}
                </ul>
            
            {elseif $node.children_count}
                <ul>
                {foreach fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                       'sort_by', $node.sort_array,
                                                       'class_filter_type', 'include',
                                                       'class_filter_array', ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' ) ) ) as $child max 7}
                    {node_view_gui content_node=$child view='list'}
                {/foreach}
                </ul>
            {/if}
        
        </div>
    </div>
</div>
