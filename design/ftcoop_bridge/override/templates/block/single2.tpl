{def $validnode = $block.valid_nodes[0]}

{def $image = false()}
{if $validnode|has_attribute( 'image' ) }
    {set $image =  $validnode|attribute( 'image' )}
{else}
    {def $related = fetch( 'content', 'related_objects', hash( 'object_id', $validnode.contentobject_id ))}
    {foreach $related as $rel}
    {if $rel.class_identifier|eq( 'image' )}
        {set $image = $rel|attribute( 'image' )}
    {/if}
    {/foreach}
{/if}

<div class="content-view-block block-view-{$block.view} carousel-inner carousel">
    {if $image}
	  {attribute_view_gui attribute=$image image_class=appini( 'ContentViewBlock', 'DefaultImageClass', 'wide' ) fluid=true() href=$validnode.url_alias}	  
    {/if}
    <div class="carousel-caption">
        <h3><a href="{$validnode.url_alias|ezurl(no)}">{$validnode.name|wash()}</a></h3>
    </div>
</div>

{undef}