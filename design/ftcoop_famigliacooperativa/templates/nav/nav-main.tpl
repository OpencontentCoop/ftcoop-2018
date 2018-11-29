{def $top_menu_node_ids = openpaini( 'TopMenu', 'NodiCustomMenu', array() )}
{def $top_menu_node_ids_count = $top_menu_node_ids|count()}


<div class="nav-main collapse navbar-collapse" id="main-navbar">

    {if $top_menu_node_ids_count}        
        <ul class="nav navbar-nav">
        {foreach $top_menu_node_ids as $id}
            {def $tree_menu = tree_menu( hash( 'root_node_id', $id, 'scope', 'top_menu'))}

            {include recursion=0
                     name=top_menu
                     uri='design:nav/nav-main-item.tpl'
                     menu_item=$tree_menu}
  
            {undef $tree_menu}
        {/foreach}
        <li class="lastli pull-right"><a href="#" id="orari-di-apertura" data-toggle="modal" data-target="#orari-di-apertura-modal">Orari di apertura <i class="fa fa-shopping-cart"></i></a></li>
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
