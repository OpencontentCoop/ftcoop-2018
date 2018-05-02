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

<div class="content-view-block block-type-mainstory block-view-single2 block-view-{$block.view}">
    {if $image}
    <div class="block-image object-center text-center">
        {attribute_view_gui href=$valid_node.url_alias|ezurl() attribute=$image image_class=imagefull fluid=true()}
    </div>
    {/if}
</div>

{undef $valid_node}
