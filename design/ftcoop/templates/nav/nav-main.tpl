{def $base_num = 1
	 $globalRoot = fetch( 'content', 'node', hash( 'node_id', ezini( 'SiteSettings', 'GlobalSiteRootNodeID', 'site.ini' ) ) )}

{if and( $subsite, $subsite.data_map.show_submenu.content|eq(1) )}
  {set $root_node = $subsite
  	   $base_num = 2}
{/if}

{def $top_menu_items = array()}
{if $root_node|has_attribute('top_menu')}
    {foreach $root_node|attribute('top_menu').content.relation_list as $item}
        {set $top_menu_items = $top_menu_items|append(fetch(content, node, hash('node_id', $item.node_id)))}
    {/foreach}
{else}
    {set $top_menu_items = fetch( 'content', 'list', hash(
        'parent_node_id', $root_node.node_id,
        'sort_by', $root_node.sort_array,
        'limit', 7,
        'limitation', array(),
        'class_filter_type', 'include',
        'class_filter_array', appini('MenuContentSettings', 'TopIdentifierList', array())
    ))}
{/if}

<div class="nav-main collapse navbar-collapse" id="main-navbar">

    {def $top_menu_items_count = $top_menu_items|count()
         $noOverviewNodes = appini('NavmainSettings', 'NavmainItemNoOverview', array())
         $noDropdownNodes = appini('NavmainSettings', 'NavmainItemNoDropdown', array())
         $overview = true()
         $dropdown = true()}

    {if $top_menu_items_count}
        <ul class="nav navbar-nav navbar-right">
        {foreach $top_menu_items as $key => $item}

            {if $noOverviewNodes|contains($item.node_id)}
                {set $overview = false()}
            {else}
                {set $overview = true()}
            {/if}

            {if $noDropdownNodes|contains($item.node_id)}
                {set $dropdown = false()}
            {else}
                {set $dropdown = true()}
            {/if}

            {node_view_gui
                content_node=$item
                view='nav-main_item'
                key=$key
                top_menu_items_count=$top_menu_items_count
                show_overview=$overview
                show_dropdown=$dropdown}
        {/foreach}
        </ul>
    {/if}

</div>
<script>{literal}$(document).ready(function () {
    $('.nav-main li[data-node]').each(function () {
        if ($(this).data('node') === CurrentNode) {
            $(this).addClass('active');
        }else if ($.inArray($(this).data('node'), PathArray) > -1){
            $(this).addClass('current');
        }
    });
});{/literal}</script>
{*
	<ul class="nav navbar-nav navbar-right">
		<li class="firstli"><a href="/Chi-siamo">Chi siamo</a></li>
		<li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown">Le persone <i class="fa fa-angle-down"></i></a>
			<ul class="nav dropdown-menu">
				<li><a href="#">In breve</a></li>
				<li><a href="#">Dipendenti delle Federazione</a></li>
				<li><a href="#">Amministratori di Cooperative</a></li>
			</ul>
		</li>
		<li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown">Servizi alle coop <i class="fa fa-angle-down"></i></a>
			<ul class="nav dropdown-menu">
				<li><a href="#">Servizio 1</a></li>
				<li><a href="#">Servizio 2</a></li>
				<li><a href="#">Servizio 3</a></li>
			</ul>
		</li>
		<li><a href="#">Diventa uno di noi</a></li>
		<li><a href="#">News</a></li>
		<li class="alt lastli"><a class="" href="#">Le Cooperative</a></li>
	</ul>
*}

