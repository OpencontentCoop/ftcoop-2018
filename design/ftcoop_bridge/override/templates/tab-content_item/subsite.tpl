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

                <div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots" data-autoheight="true">
                    {include uri='design:atoms/owl_carousel.tpl' items=$latest i_view='grid_item' show_number=1}
                </div>
            
            {elseif $node.children_count}
                <div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots" data-autoheight="true">
                    {include uri='design:atoms/owl_carousel.tpl' items=fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                    'sort_by', $node.sort_array,
                    'class_filter_type', 'include',
                    'class_filter_array', ezini( 'MenuContentSettings', 'TopIdentifierList', 'menu.ini' ) ) ) i_view='grid_item' show_number=1}
                </div>

            {/if}
        
        </div>
    </div>
</div>
