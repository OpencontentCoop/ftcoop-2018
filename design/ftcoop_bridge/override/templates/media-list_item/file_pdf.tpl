{def $url = $node.url_alias|ezurl()}
{if $node|has_attribute( 'url' )}
    {set $url = $node.data_map.url.content}
    {if $node|has_attribute( 'internal_link' )}
      {set $url = $node|attribute( 'internal_link' ).content.main_node.url_alias|ezurl()}
    {/if}
{/if}
{if $node|has_attribute( 'location' )}
    {set $url = $node|attribute( 'location' ).content}
{/if}
 
<li class="media">
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squaremini' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
    
	  
	  {if $node|has_attribute( 'publish_date' )}
        <small class="date">{$node|attribute( 'publish_date' ).content.timestamp|l10n('date')}</small>
      {/if}
	  
	  {if is_set( $node.data_map.title )}
		<a href={$url}>{attribute_view_gui attribute=$node.data_map.title}</a>
	  {else}
		<a href={$url}>{$node.name|wash()}</a>
	  {/if}

    {if $node|has_abstract()}
      <p>{$node|abstract()|oc_shorten( 150 )}</p>
    {/if}
	
  </div>
</li>

{undef}