{set_defaults( hash(
                'image_class', 'imagefull',
                'items', array(),
                'wide_class', 'imagefullwide',
                'show_number', 3,
                'i_view' , 'owl_carousel_item',
                'images_only' , false()
))}

{ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" , "owl-carousel-activation.js" ) )}
{*ezcss_require( array( 'plugins/owl-carousel/owl.carousel.min.css', 'plugins/owl-carousel/owl.theme.default.css', "plugins/blueimp/blueimp-gallery.css" ) )*}
{ezcss_require( array( "plugins/blueimp/blueimp-gallery.css" ) )}

<div id="{$items[0].name|slugize()}" class="owl-carousel owl-theme">
  {foreach $items as $item}

    {node_view_gui content_node=$item view=$i_view image_class=$image_class wide_class=$wide_class show_images_only=$images_only}

  {/foreach}

</div>
