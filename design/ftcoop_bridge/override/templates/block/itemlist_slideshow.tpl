
{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}
  <div class="carousel-container owl-carousel-single">
    {include uri='design:atoms/owl_carousel.tpl' items=$valid_nodes is_subheader=cond(is_set($is_subheader), $is_subheader, false())}
  </div>

{/if}

{undef $valid_nodes}
