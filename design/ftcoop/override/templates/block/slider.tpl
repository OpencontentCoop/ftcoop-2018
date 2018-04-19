{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}

  <h3><a href={$parent_node.url_alias|ezurl()}>{if $block.name}{$block.name}{else}{$parent_node.name|wash()}{/if}</a> {*<a class="btn btn-default pull-right" href={$events_node.url_alias|ezurl()}>Vedi tutti gli eventi</a>*}</h3>
  <div class="carousel-container owl-carousel-contained">
    {include uri='design:atoms/owl_carousel.tpl' items=$valid_nodes i_view='grid_item'}
  </div>

{/if}

{undef $valid_nodes}