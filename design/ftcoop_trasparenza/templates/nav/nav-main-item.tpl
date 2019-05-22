<li>
  <a class="{if $recursion|eq(0)} toplevel{/if}{if $menu_item.has_children} dropdown-toggle{/if}"
     data-node="{$menu_item.item.node_id}"
     {if and( $recursion|eq(0), $menu_item.has_children )}data-toggle="dropdown" data-target="#"{/if}
     href="{if $menu_item.item.internal}{$menu_item.item.url|ezurl(no)}{else}{$menu_item.item.url}{/if}"
          {if $menu_item.item.target}target="{$menu_item.item.target}"{/if}
     title="Vai a {$menu_item.item.name|wash()}">    
      {$menu_item.item.name|wash()}
      {if and( $recursion|eq(0), $menu_item.has_children )}<b class="caret"></b>{/if}
  </a>
  {if and( $recursion|eq(0), $menu_item.has_children )}
  	{set $recursion = $recursion|inc()}
  	<ul class="nav dropdown-menu">
  		{foreach $menu_item.children as $child}
  			{include recursion=$recursion
                     name=top_menu
                     uri='design:nav/nav-main-item.tpl'
                     menu_item=$child}
  		{/foreach}
  	</ul>
  {/if}
</li>
