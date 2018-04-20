{def $node_class = array()
	 $anchor_class = array()
	 $anchor_data_toggle = ''
	 $sub_menu_class_filter = appini( 'MenuContentSettings', 'SubTopIdentifierList', array() )
	 $sub_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
														'sort_by', $node.sort_array,
														'limitation', array(),
														'class_filter_type', 'include',
														'class_filter_array', $sub_menu_class_filter ) )}
{if $key|eq(0)}
  {set $node_class = $node_class|append("firstli")}
{/if}
{if $top_menu_items_count|eq( $key|inc )}
  {set $node_class = $node_class|append("lastli")}
   {if gt($sub_menu_items|count(),0)}
	{set $node_class = $node_class|append("navbar-right")}
   {/if}
{/if}
{if gt($sub_menu_items|count(),0)}
  {set $node_class = $node_class|append("dropdown")}
{/if}

{if eq( $node.class_identifier, 'link')}
  <li id="node_id_{$node.node_id}" data-node="{$node.node_id}"{if $node_class} class="{$node_class|implode(" ")}"{/if}>
	<a class="menu-item-link" href={$node.data_map.location.content|ezurl}{if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if} title="{$node.data_map.location.data_text|wash}" rel={$node.url_alias|ezurl}>{if $node.data_map.location.data_text}{$node.data_map.location.data_text|wash()}{else}{$node.name|wash()}{/if}</a>
{else}
  <li id="node_id_{$node.node_id}" data-node="{$node.node_id}"{if $node_class} class="{$node_class|implode(" ")}"{/if}>
  {if and(gt($sub_menu_items|count(),0), $show_dropdown)}
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">{$node.name|wash()}  <i class="fa fa-angle-down"></i></a>
    {else}
    <a href={$node.url_alias|ezurl}>{$node.name|wash()}</a>
  {/if}
{/if}


{if and(gt($sub_menu_items|count(),0), $show_dropdown)}
  <ul class="nav dropdown-menu">
  {if $show_overview}
    <li><a href={$node.url_alias|ezurl}>{'Overview'|i18n('ocbootstrap')}</a></li>
  {/if}
  {foreach $sub_menu_items as $subitem}
    {def $subitem_class = array()}
    {if or(eq( $subitem.class_identifier, 'link'),eq( $subitem.class_identifier, 'servizio_intracoop'))}
      <li id="node_id_{$subitem.node_id}" data-node="{$subitem.node_id}" {if $subitem_class} class="{$subitem_class|implode(" ")}"{/if}>
        <a href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if} title="{$subitem.data_map.location.data_text|wash}" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem.name|wash()}{/if}</a>
      </li>
    {else}
      <li id="node_id_{$subitem.node_id}" data-node="{$subitem.node_id}" {if $subitem_class} class="{$subitem_class|implode(" ")}"{/if}>
        <a href={$subitem.url_alias|ezurl}>{$subitem.name|wash()}</a>
      </li>
    {/if}
    {undef $subitem_class}
  {/foreach}
  </ul>
{/if}
</li>
