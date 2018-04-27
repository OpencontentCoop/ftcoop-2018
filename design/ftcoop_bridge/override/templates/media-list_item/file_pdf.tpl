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
<li class="media grid-item ">
  {if $node|has_attribute( 'image' )}
  <div class="grid-item-image">
    <a href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
    {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='large' css_class="media-object"}
    </a>
  </div>
  {/if}
  <div class="grid-item-content">
    
    {if $node|has_attribute( 'publish_date' )}
        <span class="grid-item-date">{$node|attribute( 'publish_date' ).content.timestamp|l10n('date')}</span>
      {/if}
    
    <h3 class="grid-item-title">
      {if is_set( $node.data_map.title )}
      <a href={$url}>{attribute_view_gui attribute=$node.data_map.title}</a>
      {else}
      <a href={$url}>{$node.name|wash()}</a>
      {/if}
    </h3>

    {if $node|has_abstract()}
      <div class="grid-item-abstract">
        <p>{$node|abstract()|oc_shorten( 150 )}</p>
      </div>
    {/if}
  
  </div>
</li>