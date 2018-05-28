{def $valid_node = $block.valid_nodes[0]}

{def $image = false()}
{if and( is_set( $valid_node.data_map.image ), $valid_node.data_map.image.has_content) }
    {set $image =  $valid_node.data_map.image}
{else}
    {def $related = fetch( 'content', 'related_objects', hash( 'object_id', $valid_node.contentobject_id ))}
    {foreach $related as $rel}
    {if $rel.class_identifier|eq( 'image' )}
        {set $image = $rel.data_map.image}
    {/if}
    {/foreach}
{/if}

<div class="mainstory-item">

    <h2 class="mainstory-item-title"><a href="{$valid_node.url_alias|ezurl(no)}">{$valid_node.name|wash()}</a></h2>
    
    {if $image}
        {attribute_view_gui href=$valid_node.url_alias|ezurl() attribute=$image image_class=reference fluid=true()}
    {/if}
	
    {if $valid_node|has_abstract()}
    <div class="mainstory-item-abstract abstract">
        {$valid_node|abstract()}
        <p class="goto"><a href="{$valid_node.url_alias|ezurl(no)}">Scopri di +</a></p>
    </div>	
    {/if}
	
</div>


{undef $valid_node}
