{def $children = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'limit', 3 ) )}

<div class="intro">
{$node|abstract()}
{if or( $node.children_count|gt( count( $children ) ), $node.children_count|eq(0) )}
<p class="goto"><a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">Scopri di +</a></p>
{/if}
</div>

<div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots" data-autoheight="true">
	{include uri='design:atoms/owl_carousel.tpl' items=$children i_view='grid_item' show_number=1}
</div>

