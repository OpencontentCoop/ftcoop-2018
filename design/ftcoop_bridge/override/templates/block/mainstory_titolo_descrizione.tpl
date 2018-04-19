{def $valid_node = $block.valid_nodes[0]}

<div class="content-view-block block-type-mainstory block-view-{$block.view}">
  <div class="block-content">
    <h2><a href="{$valid_node.url_alias|ezurl(no)}">{$valid_node.name|wash()}</a></h2>
    {*if $valid_node|has_abstract()}
      {$valid_node|abstract()}
      <p class="text-right"><a href="{$valid_node.url_alias|ezurl(no)}">Leggi tutto &raquo;</a></p>
    {/if*}
    {if $valid_node.data_map.description.has_content}
      {attribute_view_gui attribute=$valid_node.data_map.description}
	    
    {/if}
  </div>

</div>

{undef $valid_node}
