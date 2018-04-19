{def $zones = $#node.data_map.page.content.zones
     $this_zone = false()
     $append_zone_name = ''}
{foreach $zones as $zone}
{if is_set($zone.blocks)}
    {foreach $zone.blocks as $b}
        {if $b.id|eq( $block.id )}
            {set $this_zone = $zone}
            {break}
        {/if}
    {/foreach}
{/if}
{/foreach}

{def $valid_node = $block.valid_nodes[0]}
{*set $valid_node=34266*}
{set $valid_node = fetch( 'content', 'node', hash('node_id', 25061) )}

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


	{def $newsletter_image_node = fetch( 'content', 'node', hash( 'node_id', 520949 ) )}
	{if $newsletter_image_node.data_map.image.has_content}
		{set $image = $newsletter_image_node.data_map.image}
	{/if}


{def $nl = fetch( 'gestione', 'newsletter_inviate', hash( 'list_contentobject_id', 34266) )}
	{*$nl[0]|attribute("show",2)*}

<div class="content-view-block block-view-{$block.view} float-break">

    <div class="block-header">
        <h2><a href="{$valid_node.url_alias|ezurl(no)}">{$block.name|wash()}</a></h2>
    </div>

    <div class="tabs-panels">

    {if $image}
    <div class="block-image object-center text-center">
        {attribute_view_gui href=concat('newsletter/archive/', $nl[0].hash)|ezurl(no) attribute=$image image_class=medium fluid=true()}
    </div>
    {/if}

    <div class="float-break"></div>
    <br/>
	<p><a class="arrows" href="{concat('newsletter/archive/', $nl[0].hash)|ezurl(no)}">Leggi ultima newsletter</a></p>

	</div>

</div>


{undef $valid_node}
