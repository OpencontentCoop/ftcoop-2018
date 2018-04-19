{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}
  {foreach $valid_nodes as $i => $valid_node}
    {*node_view_gui view='block_item' image_class='articlethumbnail' content_node=$valid_node*}


    {include uri='design:atoms/banner.tpl'
    items=$valid_node
    title=$block.name
    blubar=false()
    }


  {/foreach}
{/if}
<br />
{undef $valid_nodes}