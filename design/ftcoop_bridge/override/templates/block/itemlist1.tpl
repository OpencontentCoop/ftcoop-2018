{def $valid_nodes = $block.valid_nodes}

{if $block.type|eq( 'ItemTree' )}
    {def $subtree = array()}
    {foreach $valid_nodes as $n}
        {set $subtree = $subtree|append( $n.node_id )}
    {/foreach}
    {def $search_nodes = fetch( 'ezfind', 'search', hash( 'subtree_array', $subtree, 'limit', 3, 'sort_by', hash( 'published', 'desc' ) ) )}
    {set $valid_nodes = $search_nodes.SearchResult}

{elseif $block.type|eq( 'ItemChildren' )}
    {def $classes = cond( $block.custom_attributes.class|ne( '' ), $block.custom_attributes.class|explode( ',' ), array() )
         $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 10 )
         $offset = cond( is_set( $block.custom_attributes.offset ), $block.custom_attributes.offset, 0 )
         $parent_node_id = cond( is_set( $block.custom_attributes.parent_node_id ), $block.custom_attributes.parent_node_id, 0 ) }
    {if $parent_node_id|eq(0)}
        {editor_warning( 'Inserire un nodo <em>sorgente</em> valido' )}
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
                                                    'offset', $offset )|merge( $classes_hash ) )}
    {/if}
{/if}

<div class="content-view-block block-type-{$block.view}">
  {if $block.name}
    {if is_set($parent_node)}
      <h3 class="block-title"><a href={$parent_node.url_alias|ezurl()}>{$block.name|wash()}</a></h3>
    {else}
      <h3 class="block-title">{$block.name|wash()}</h3>
    {/if}
  {/if}
  <div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots">
    {include uri='design:atoms/owl_carousel.tpl' items=$valid_nodes i_view='grid_item'}
  </div>

  {if and(is_set($parent_node),is_set( $block.custom_attributes.link_text ))}

    <div class="goto">
      <a href={$parent_node.url_alias|ezurl()}>{$block.custom_attributes.link_text}</a>
    </div>

  {/if}



</div>

<!-- BLOCK: END -->

{undef $valid_nodes}
