
{def $valid_nodes = null
     $classes = cond( $block.custom_attributes.class|ne( '' ), $block.custom_attributes.class|explode( ',' ), array() )
     $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 8 )
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

{if $valid_nodes}

  {switch match=$block.view}

    {case match="slider"}

      <h3><a href={$parent_node.url_alias|ezurl()}>{if $block.name}{$block.name}{else}{$parent_node.name|wash()}{/if}</a> {*<a class="btn btn-default pull-right" href={$events_node.url_alias|ezurl()}>Vedi tutti gli eventi</a>*}</h3>
      <div class="carousel-container owl-carousel-contained">
        {include uri='design:atoms/owl_carousel.tpl' items=$valid_nodes i_view='grid_item'}
      </div>

    {/case}
    {case}

      {foreach $valid_nodes as $item}
        {node_view_gui content_node=$item view=line}
      {/foreach}

    {/case}

  {/switch}


{/if}