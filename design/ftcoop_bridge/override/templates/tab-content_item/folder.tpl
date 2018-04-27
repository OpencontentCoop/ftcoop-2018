{def $children = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'limit', 3, sort_by, $node.sort_array ) )}
<div class="intro">
{$node|abstract()}
</div>

<div class="carousel-container owl-carousel-contained" data-items=1 data-navstyle="dots" data-autoheight="true">
	{include uri='design:atoms/owl_carousel.tpl' items=$children i_view='grid_item' show_number=1}
</div>

<script>
$(document).ready(function() {ldelim}
  $("#item-folder-{$node.name|slugize()}").owlCarousel({ldelim}
	items : 1,	
  	pagination: true
  {rdelim});
{rdelim});
</script>
