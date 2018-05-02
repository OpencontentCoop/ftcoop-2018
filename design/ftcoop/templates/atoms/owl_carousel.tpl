{set_defaults( hash(
    'image_class', 'imagefull',
    'items', array(),
    'wide_class', 'imagefullwide',
    'show_number', 3,
    'i_view' , 'owl_carousel_item',
    'images_only' , false()
))}
{if and(is_set($is_subheader), $is_subheader|eq(true()))}
	{set $i_view = 'owl_carousel_subheader_item'}
	{set $wide_class = concat('subheaderoverlay', appini('SiteSettings', 'StyleSuffix', ''))}
{/if}

{if count($items)|gt(0)}

<div id="{$items[0].name|slugize()}" class="owl-carousel owl-theme">
  {foreach $items as $item}

    {node_view_gui content_node=$item view=$i_view image_class=$image_class wide_class=$wide_class show_images_only=$images_only}

  {/foreach}

</div>
{/if}
