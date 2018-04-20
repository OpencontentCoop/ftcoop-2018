{def $node_class = array( 'footer-menu-item' )
	 $anchor_class = array()
	 $anchor_data_toggle = ''
	 $root_node = fetch( 'content' , 'node' , hash( 'node_id' , ezini( 'NodeSettings', 'RootNode', 'content.ini' )))
	 $subsite_menuhidden = ezini( 'FederazioneSettings', 'TopmenuSottositiNascosti', 'ftcoop.ini' )
	 $current_path = false()
	 $sub_menu_class_filter = ezini( 'FederazioneSettings', 'TopmenuClassiSottositi', 'ftcoop.ini' )
	 $sub_menu_items_t = fetch( 'content', 'list', hash( 'parent_node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
	  											  'sort_by', $root_node.sort_array,
													  'limitation', array(),
													  'attribute_filter', array( array( 'section', 'in', array( 1, 10 ) ) ),
													  'class_filter_type', 'include',
													  'class_filter_array', $sub_menu_class_filter ) )}


{def $sub_menu_items = array()}
{foreach $sub_menu_items_t as $it}
	{if $subsite_menuhidden|contains($it.node_id)|not()}
		{set $sub_menu_items=$sub_menu_items|append($it)}
	{/if}
{/foreach}

{if $key|eq(0)}
  {set $node_class = $node_class|append("firstli")}
{/if}
{if $menu_items_count|eq( $key|inc )}
  {set $node_class = $node_class|append("lastli")}
   {if gt($sub_menu_items|count(),0)}
	{set $node_class = $node_class|append("navbar-right")}
   {/if}
{/if}
{if $node.node_id|eq( $current_node_id )}
  {set $node_class = $node_class|append("active")}
{elseif $current_path|contains( $node.node_id )}
  {set $node_class = $node_class|append("current")}
{/if}
{if gt($sub_menu_items|count(),0)}
  {set $node_class = $node_class|append("dropdown")}
{/if}

{if eq( $node.class_identifier, 'link')}
  <li {if $node_class} class="{$node_class|implode(" ")}"{/if}>
	<a class="menu-item-link" {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $node.node_id)|ezurl}{else}href={$node.data_map.location.content|ezurl}{if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$node.data_map.location.data_text|wash}" rel={$node.url_alias|ezurl}>{if $node.data_map.location.data_text}{$node.data_map.location.data_text|wash()}{else}{$node.name|wash()}{/if}</a>
{else}
  <li {if $node_class} class="{$node_class|implode(" ")}"{/if}>  
	<a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $node.node_id)|ezurl}{else}{$node.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$node.name|wash()}</a>  
{/if}

{if gt($sub_menu_items|count(),0)}
  <ul class="list-unstyled">	
	{foreach $sub_menu_items as $subitem}
	  {def $subitem_class = array()}
	  
	  {if $subitem.node_id|eq( $current_node_id )}
		{set $subitem_class = $subitem_class|append("active")}
	  {elseif $current_path|contains( $subitem.node_id )}
		{set $subitem_class = $subitem_class|append("current")}
	  {/if}
	  
	  {if eq( $subitem.class_identifier, 'link')}
		<li {if $subitem_class} class="{$subitem_class|implode(" ")}"{/if}><a {if eq( $ui_context, 'browse' )}href={concat("content/browse/", $subitem.node_id)|ezurl}{else}href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if}{/if}{if $pagedata.is_edit} onclick="return false;"{/if} title="{$subitem.data_map.location.data_text|wash}" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a></li>
	  {else}
		<li {if $subitem_class} class="{$subitem_class|implode(" ")}"{/if}><a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $subitem.node_id)|ezurl}{else}{$subitem.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$subitem.name|wash()}</a></li>
	  {/if}
	  {undef $subitem_class}
	{/foreach}
  </ul>

{/if}
</li>