{def $children = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'limit', 3 ) )}
<div class="intro">
	{$node|abstract()}
</div>

<div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots" data-autoheight="true">
	{include uri='design:atoms/owl_carousel.tpl' items=$children i_view='grid_item' show_number=1}
</div>
