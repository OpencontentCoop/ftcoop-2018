{def $zones = $#node.data_map.page.content.zones
     $this_zone = false()
     $append_zone_name = ''}
{foreach $zones as $zone}
    {foreach $zone.blocks as $b}
        {if $b.id|eq( $block.id )}
            {set $this_zone = $zone}
            {break}
        {/if}
    {/foreach}
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
    {def $classes = cond( is_set( $block.custom_attributes.class ), $block.custom_attributes.class|explode( ',' ), array() )
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
        {set $valid_nodes = fetch( 'content', 'tree', hash(
                                                    'parent_node_id', $parent_node.node_id,
                                                    'sort_by', array('published', false()),
                                                    'limit', $limit,
                                                    'offset', $offset
                                                    )|merge( $classes_hash ) )}
    {/if}
{/if}

{if $valid_nodes|count()|gt(0)}

{ezscript_require(array( 'ezjsc::jquery', 'ezjsc::jqueryUI' ) )}

<script type="text/javascript">
{literal}
$(function() {
	$('.block-lista_color .ui-blocks-nav li a').each(function(index) {
		$(this).attr( 'href', '#'+$('span', this).attr('class') );
	});
	$("#block-{/literal}{$block.id}{literal}").tabs({ 
		tabTemplate: '<![CDATA[<li><a href="#{href}"><span>#{label}</span></a></li>]]>'
	}).tabs("rotate", 4000);
});


{/literal}
</script>


<div class="content-view-block block-type-itemlist block-{$block.view} block-lista_color">
	{if $block.name}
        	<h1 class="block-title">{$block.name}</h1>
	{/if}
    
	<div id="block-{$block.id}" class="ui-tabs block-content float-break">	
        <ul class="ui-blocks-nav">
            {def $count = 1}
            {foreach $valid_nodes as $index => $node max 12}
            <li class="{$node.name|slugize()} {if $index|eq(0)}ui-state-active{else}ui-state-default{/if}">											
                <a rel="tooltip" href={$node.url_alias|ezurl()} title="{$node.name|wash()}">
                {if $node.data_map.image.has_content}
                    <span class="{$node.name|slugize()}">
                        {attribute_view_gui attribute=$node.data_map.image image_class='block_colors' alt='' use_colorbox=false()}
                    </span>
                {else}
                    <span class="{$node.name|slugize()}">
                        <img class="color_{$index}" src={'ftcoop/space.png'|ezimage()} />
                    </span>
                {/if}
                </a>
            </li>
            {/foreach}
        </ul>	
		<div class="tabs-panels">			
			{foreach $valid_nodes as $index => $node max 12}
			<div id="{$node.name|slugize()}" class="{if $index|gt(0)}no-js-hide {/if}ui-tabs-hide">
                {node_view_gui content_node=$node view="main_story_block_item" image_class="medium" use_colorbox=false() zone=$this_zone}
			</div>
			{/foreach}
		</div>		
	</div>

</div>

{/if}
