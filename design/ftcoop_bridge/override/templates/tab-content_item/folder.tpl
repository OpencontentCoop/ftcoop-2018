{def $children = fetch_alias( children, hash( 'parent_node_id', $node.node_id, 'limit', 3, sort_by, $node.sort_array ) )}

{$node|abstract()}

<ul class="media-list">
  {foreach $children as $_node}
	{node_view_gui content_node=$_node view="media-list_item"}
  {/foreach}
</ul>

{if or( $node.children_count|gt( count( $children ) ), $node.children_count|eq(0) )}
<p class="goto"><a href={$node.url_alias|ezurl()} title="{$node.name|wash()}">{$node.name|wash()}</a></p>
{/if}