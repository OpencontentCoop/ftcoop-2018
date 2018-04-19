{set_defaults( hash(  
  'items', array(),
  'show_number', 3,
  'show_gallery', true(),
  'pagination', true()
))}



{if count($items)|gt(0)}

<div class="carousel-container owl-carousel-single">
  {include uri='design:atoms/owl_carousel.tpl' items=$items}
</div>
{/if}

{* if count($items)|gt(0)}

{ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}

<div id="{$items[0].name|slugize()}" class="owl-carousel">
  {foreach $items as $item}

  {node_view_gui view=owl-slideshow_item content_node=$item wide_class=$wide_class image_class=$image_class}

  {/foreach}  
</div>

<script>
$(document).ready(function() {ldelim}
  $("#{$items[0].name|slugize()}").owlCarousel({ldelim}
	items : {$show_number},
	itemsDesktop : [1000,{$show_number}], // items between 1000px and 901px
  itemsDesktopSmall : [900,2], // betweem 900px and 601px
  itemsTablet: [600,2], // items between 600 and 0
	itemsMobile : [400,1],
  pagination: {cond( $pagination, 'true', 'false')}
  {rdelim});
{rdelim});
</script>

{/if*}