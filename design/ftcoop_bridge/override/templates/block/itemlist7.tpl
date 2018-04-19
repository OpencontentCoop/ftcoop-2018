{def $zones = $#node.data_map.page.content.zones
     $this_zone = false()
     $append_zone_name = ''}
{foreach $zones as $zone}
    {foreach $zone.blocks as $b}
        {if $b.id|eq( $block.id )}
            {set $this_zone = $zone}
            {break}
        {/if}
    {/foreach}
{/foreach}

{def $valid_nodes = $block.valid_nodes}

{if $block.type|eq( 'ItemTree' )}
    {def $subtree = array()}
    {foreach $valid_nodes as $n}
        {set $subtree = $subtree|append( $n.node_id )}
    {/foreach}
    {def $search_nodes = fetch( 'ezfind', 'search', hash( 'subtree_array', $subtree, 'limit', 3, 'sort_by', hash( 'published', false() ) ) )}
    {set $valid_nodes = $search_nodes.SearchResult}
{elseif $block.type|eq( 'ItemChildren' )}
    {def $classes = cond( $block.custom_attributes.class|ne( '' ), $block.custom_attributes.class|explode( ',' ), array() )
         $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 10 )
         $offset = cond( is_set( $block.custom_attributes.offset ), $block.custom_attributes.offset, 0 )
         $parent_node_id = cond( is_set( $block.custom_attributes.parent_node_id ), $block.custom_attributes.parent_node_id, 0 ) }
    {if $parent_node_id|eq(0)}
        <div class="warning"><strong>Avviso per l'editor:</strong><br/>Inserire un nodo <em>sorgente</em> valido.</div>
        {set $valid_nodes = array()}
    {else}
        {def $classes_hash = hash()
             $parent_node = fetch( 'content', 'node', hash( 'node_id', $parent_node_id ) )}
        {if $classes|count()}
            {set $classes_hash = hash( 'class_filter_type', 'include', 'class_filter_array', $classes )}
        {/if}
        {set $valid_nodes = fetch( 'content', 'list', hash(
                                                    'parent_node_id', $parent_node.node_id,
                                                    'sort_by', $parent_node.sort_array,
                                                    'limit', $limit,
                                                    'offset', $offset
                                                    )|merge( $classes_hash ) )}
    {/if}
{/if}
<!-- BLOCK: START -->

<div class="block block-type-itemlist block-type-{$block.view}">
{if $block.name}
<div class="block-header">
    {if is_set($parent_node)}
    <h2 class="blocktitle"><a href={$parent_node.url_alias|ezurl()}>{$block.name|wash()}</a></h2>    
    {else}
    <h2 class="blocktitle">{$block.name|wash()}</h2>
    {/if}
</div>
{/if}
<div class="content-view-children">
    {foreach $valid_nodes as $valid_node sequence array( 'light', 'dark' ) as $style}
       {node_view_gui content_node=$valid_node view="banner" style=$style image_class="rss" zone=$this_zone}
    {/foreach}
</div>

</div>

<!-- BLOCK: END -->

{undef $valid_nodes}