{def $valid_nodes = $block.valid_nodes
	 $target_url = false()}

<div class="content-view-block block-banners">
  <ul class="list-unstyled">
  {foreach $valid_nodes as $valid_node}
    <li>
      {if $valid_node|has_attribute( 'url' )}
		{set $target_url = $valid_node.data_map.url.content}
	  {/if}
      
	  {if $valid_node|has_attribute( 'internal_link' )}	  
        {set $target_url = fetch('content','object', hash('object_id',$valid_node|attribute( 'internal_link' ).content.id)).main_node.url_alias|ezurl(no)}
      {/if}
	  
      {if $target_url}
        <a class="figcontainer" href="{$target_url}" title="{$valid_node.name|wash()}">
          {attribute_view_gui attribute=$valid_node.data_map.image image_class=original use_colorbox=false()}
        </a>
      {else}
        <span class="figcontainer">
          {attribute_view_gui attribute=$valid_node.data_map.image image_class=original use_colorbox=false()}
        </span>
      {/if}
    </li>
  {/foreach}
  </ul>
</div>

{undef}