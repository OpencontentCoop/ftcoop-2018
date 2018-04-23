<div class="carousel-item" style="background-image: url({if $node|has_attribute( 'image' )}{$node|attribute( 'image' ).content[$wide_class].url|ezroot(no)}){else}{'images/bg-owl_carousel_subheader_item.jpg'|ezdesign(no)}{/if}">

  {def $url= $node.url_alias|ezurl(no)}

  {if $node|has_attribute( 'link_external' )}
    {set $url=$node.data_map.link_external.content}
  {/if}

  {if $node|has_attribute( 'link_internal' )}
    {def $goto=fetch('content','node',hash('node_id',$node.data_map.link_internal.content.relation_list[0].node_id))}
    {set $url=$goto.url_alias|ezurl(no) }
  {/if}

  <div class="carousel-item-content{if $node|has_attribute( 'text_white' )} text-white{elseif $node|has_attribute( 'image' )} text-white{/if}">
    {def $item_title = $node.name|explode('|')}
    
    <h2 class="carousel-item-title">
      {if $item_title|count()|gt(1)}
        {$item_title[0]}      
        <span class="text-alt">{$item_title[1]}</span>      
      {else}
        {$item_title[0]}
      {/if}
    </h2>
    
    {if $node|has_abstract()}
      <div class="carousel-item-body">
        {$node|abstract()|oc_shorten(200,'...')}
      </div>
    {/if}

    {if $url}
    <a class="cta" href="{$url}">
      <i class="fa fa-plus-circle"></i>
      {if $node|has_attribute( 'link_text' )}        
        {attribute_view_gui attribute=$node|attribute( 'link_text' )}
      {else}
        Scopri
      {/if}
    </a>
    {/if}
  </div>
</div>
