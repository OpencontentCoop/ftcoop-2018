{def $zones = $#node.data_map.page.content.zones
     $this_zone = false()
     $append_zone_name = ''}
{foreach $zones as $zone}
	{if $zone|attribute()|contains('blocks')}
	    {foreach $zone.blocks as $b}
	        {if $b.id|eq( $block.id )}
	            {set $this_zone = $zone}
	            {break}
	        {/if}
	    {/foreach}
	{/if}
{/foreach}

{def $valid_nodes = $block.valid_nodes}

{if $block.type|eq( 'ItemTree' )}
    {def $subtree = array()}
    {foreach $valid_nodes as $n}
        {set $subtree = $subtree|append( $n.node_id )}
    {/foreach}
    {def $search_nodes = fetch( 'ezfind', 'search', hash( 'subtree_array', $subtree, 'limit', 3, 'sort_by', hash( 'published', false() ) ) )}
    {set $valid_nodes = $search_nodes.SearchResult}
{elseif $block.type|eq( 'ItemChildren' )}
    {def $classes = cond( $block.custom_attributes.class|ne( '' ), $block.custom_attributes.class|explode( ',' ), array() )
         $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 10 )
         $offset = cond( is_set( $block.custom_attributes.offset ), $block.custom_attributes.offset, 0 )
         $parent_node_id = cond( is_set( $block.custom_attributes.parent_node_id ), $block.custom_attributes.parent_node_id, 0 ) }
    {if $parent_node_id|eq(0)}
        <div class="warning"><strong>Avviso per l'editor:</strong><br/>Inserire un nodo <em>sorgente</em> valido.</div>
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
{ezscript_require( array('ezjsc::jquery', 'jquery.newsticker.pack.js', 'rullo.js') )}
{ezcss_require( array( 'blocks.css' ) )}
    
<div class="block-type-itemlist block-view-rullo float-break">
    {if $block.name}
    <div class="block-header">
        <h2>{$block.name|wash()} &raquo;</h2>
    </div>
    {/if}
    <ul class="rullo">		
        {foreach $valid_nodes as $index => $_node}			

        {if $_node.class_identifier|eq( 'event' )}
            
            <li{if $index|gt(0)} class="no-js-hide"{/if}>                
                <span>{$_node.data_map.from_time.content.timestamp|l10n('shortdate')} - {$_node.data_map.to_time.content.timestamp|l10n('shortdate')} - </span>                
                <strong><a href={$_node.url_alias|ezurl()}>{$_node.name}</a></strong>
            </li>
            
        {else}
        
            <li{if $index|gt(0)} class="no-js-hide"{/if}>
                <span>{$_node.object.published|l10n('date')} - </span>
                <strong><a href={$_node.url_alias|ezurl()}>{$_node.name}</a></strong>
            </li>
        
        {/if}
        
        {/foreach}		
    </ul>
</div>

{undef $valid_nodes}