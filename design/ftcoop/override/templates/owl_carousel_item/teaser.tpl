<div class="carousel-item" style="background-image: url({$node|attribute( 'image' ).content[$wide_class].url|ezroot(no)})">

  {def $url= null}

  {if $node|has_attribute( 'link_external' )}
    {set $url=$node.data_map.link_external.content}
  {/if}

  {if $node|has_attribute( 'link_internal' )}
    {def $goto=fetch('content','node',hash('node_id',$node.data_map.link_internal.content.relation_list[0].node_id))}
    {set $url=$goto.url_alias|ezurl(no) }
  {/if}

  <div class="carousel-item-content{if $node|has_attribute( 'text_white' )} text-white{/if}">
    {def $item_title = $node.name|explode('|')}
    <h2 class="carousel-item-title">
      {$item_title[0]}
      {if $item_title|count()|gt(1)}
        <span class="text-alt">{$item_title[1]}</span>
      {/if}
    </h2>
    {if $node|has_attribute( 'description' )}
      <div class="carousel-item-body">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}

    {if $url}
    <a class="cta" href="{$url}">
      {if $node|has_attribute( 'link_text' )}
        <i class="fa fa-plus-circle"></i>
        {attribute_view_gui attribute=$node|attribute( 'link_text' )}
      {else}
        Scopri
      {/if}
    </a>
    {/if}
  </div>
</div>
