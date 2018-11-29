{def $valid_node = $block.valid_nodes[0]
     $image_attribute = $valid_node|attribute('image')
     $image = false()}

{if and($image_attribute, $image_attribute.content['agid_wide_carousel'])}
  {set $image = $image_attribute.content['agid_wide_carousel'].url|ezroot(no)}
{/if}

{def $openpa_valid_node = object_handler($valid_node)}
<div class="openpa-widget singolo_in_evidenza {$block.view}">
  <div class="showcase">
    {node_view_gui content_node=$valid_node view=carousel_evidence image_class=agid_carousel items_per_row=1}
  </div>
</div>
{undef $openpa_valid_node}
