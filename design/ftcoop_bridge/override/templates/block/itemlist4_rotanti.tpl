{def $valid_nodes = $block.valid_nodes}

{if $block.type|eq( 'ItemTree' )}
    {*def $subtree = array()}
    {foreach $valid_nodes as $n}
        {set $subtree = $subtree|append( $n.node_id )}
    {/foreach}
    {def $search_nodes = fetch( 'ezfind', 'search', hash( 'subtree_array', $subtree, 'limit', 3, 'sort_by', hash( 'published', false() ) ) )}
    {set $valid_nodes = $search_nodes.SearchResult*}
{elseif $block.type|eq( 'ItemChildren' )}
    {def $classes = cond( $block.custom_attributes.class|ne( '' ), $block.custom_attributes.class|explode( ',' ), array() )
         $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 10 )
         $offset = cond( is_set( $block.custom_attributes.offset ), $block.custom_attributes.offset, 0 )
         $parent_node_id = cond( is_set( $block.custom_attributes.parent_node_id ), $block.custom_attributes.parent_node_id, 0 ) }
    {if $parent_node_id|eq(0)}
        {editor_warning( 'Inserire un nodo <em>sorgente</em> valido' )}
        {set $valid_nodes = array()}
    {else}
        {def $classes_hash = hash()
             $parent_node = fetch( 'content', 'node', hash( 'node_id', $parent_node_id ) )}
        {if $classes|count()}
            {set $classes_hash = hash( 'class_filter_type', 'include', 'class_filter_array', $classes )}
        {/if}
        {set $valid_nodes = fetch( 'content', 'list', hash(
                                                    'parent_node_id', $parent_node.node_id,
                                                    'sort_by', $parent_node.sort_array,
                                                    'limit', $limit,
                                                    'offset', $offset
                                                    )|merge( $classes_hash ) )}
    {/if}
{/if}

{if $valid_nodes|count()|gt(0)}

<div class="content-view-block block-{$block.view}">
	{if $block.name}    
        <h2 class="block-title">{$block.name}</h2>    
    {/if}	

	<ul class="nav nav-tabs">					 
		{foreach $valid_nodes as $index => $node}
		<li class="{if $index|eq(0)}active{/if}">											
			<a href="#{$node.name|slugize()}" title="{$node.name|wash()}" data-toggle="tab">
			  <strong>{$node.name|wash()}</strong>
			</a>					
		</li>
		{/foreach}
	</ul>	
	<div class="tab-content">		
		{foreach $valid_nodes as $index => $node}
		<div id="{$node.name|slugize()}" class="tab-pane{if $index|eq(0)} active{/if}">
			{node_view_gui content_node=$node view="tab-content_item" image_class="medium"}			
		</div>
		{/foreach}
	</div>			

</div>

{/if}
