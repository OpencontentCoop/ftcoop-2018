{def $valid_node = $block.valid_nodes[0]}

<div class="content-view-block block-view-{$block.view}">
  <h2><a href="{$valid_node.url_alias|ezurl(no)}">{$valid_node.name|wash()}</a></h2>

  {if $valid_node.data_map.image.has_content}
    {include uri='design:atoms/image.tpl' item=$valid_node href=$valid_node.url_alias|ezurl() image_class='imagefull'}
  {/if}

</div>

{undef $valid_node}
