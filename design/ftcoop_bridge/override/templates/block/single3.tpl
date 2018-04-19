{def $validnode = $block.valid_nodes[0]}

{def $image = false()
	 $noLinkClasses = array( 'image' )}
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

<div class="content-view-block block-view-{$block.view}">    
    {if $block.name}
      <h2 class="block-title">{$block.name|wash()}</h2>
    {/if}
    
	{if $image}
	  {def $url = $validnode.url_alias|ezurl()}
	  {if $noLinkClasses|contains( $validnode.class_identifier )}
		  {set $url = false()}
	  {/if}
	  {attribute_view_gui
		  href=$url
		  attribute=$image
		  alignment=center
		  image_class=appini( 'ContentViewBlock', 'DefaultImageClass', 'wide' )
		  fluid=true()}	  
    {/if}
</div>

{undef}
