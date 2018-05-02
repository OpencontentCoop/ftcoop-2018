{def $children = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'limit', 3 ) )}
<div class="intro">
    {$node|abstract()}
    {if $node.children_count|gt( count( $children ) )}
        <p class="goto"><a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">{$node.name|wash()}</a></p>
    {/if}
</div>

<div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots" data-autoheight="true">
    {include uri='design:atoms/owl_carousel.tpl' items=$children i_view='grid_item' show_number=1}
</div>
