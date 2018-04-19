{set_defaults(hash(
  'main_title' , 'Cerca',
  'facet_title' , 'Filtra ricerca per...'
))}

{*
<div class="navbar navbar-default nav-facets-horizontal" role="navigation">
	{if $data.navigation|count}
    <form class="form-facets navbar-form navbar-left" role="search" action={concat('facet/proxy/', $node.node_id)|ezurl()}>
	  <div class="btn-group" style="width: 100%; margin-bottom: 20px;">
      <input id="searchfacet" data-content="Premi invio per cercare" type="text" class="form-control" placeholder="Cerca" name="query" value="{$data.query}">
      <span id="searchfacetclear" class="fa fa-times-circle-o" style="position: absolute;right: 5px;top: 0;bottom: 0;height: 14px;margin: auto;font-size: 14px;cursor: pointer;color: #ccc;"></span>
    </div>
    {foreach $data.navigation as $name => $items}
        <select class="facet-select" data-placeholder="{$name|wash()}" name="{$name|wash()}">
          <option></option>
          {foreach $items as $item}
            <option {if $item.active}selected="selected"{/if} value="{$item.query}">{$item.name|wash()} {if $item.count|gt(0)}({$item.count}){/if}</option>              
          {/foreach}
        </select>		
		{/foreach}    
    <button type="submit" class="btn btn-info"><i class="fa fa-search"></i>Cerca</button>
  </form>
	{/if}	
</div>
*}

{* attivare se non si vuole usare ajax
<script>{literal}
$(document).ready(function(){    
  $(".facet-select").chosen({allow_single_deselect:true,width:'200px'});
});
{/literal}</script>
*}

  {if $data.navigation|count}
    <form class="form-facets" role="search" action={concat('facet/proxy/', $node.node_id)|ezurl()}>

      <h3>{$main_title}</h3>
      <div class="btn-group" style="width: 100%; margin-bottom: 20px;">
        <input id="searchfacet" data-content="Premi invio per cercare" type="text" class="form-control" placeholder="Cerca" name="query" value="{$data.query}" style="width:100%;">
        <span id="searchfacetclear" class="fa fa-times-circle" style="position: absolute;right: 5px;top: 0;bottom: 0;height: 30px;margin: auto;font-size: 30px;cursor: pointer;color: #ccc;"></span>
        {*<div class="input-group-addon"><span id="searchfacetclear" class="fa fa-times-circle-o"></span></div>*}
      </div>

      <h3>{$facet_title}</h3>
      {foreach $data.navigation as $name => $items}
        <select class="facet-select" data-placeholder="{$name|wash()}" name="{$name|wash()}">
          <option></option>
          {foreach $items as $item}
            <option {if $item.active}selected="selected"{/if} value="{$item.query}">{$item.name|wash()} {if $item.count|gt(0)}({$item.count}){/if}</option>
          {/foreach}
        </select>
      {/foreach}
      <button type="submit" class="btn btn-info"><i class="fa fa-search"></i>Cerca</button>
    </form>
  {/if}

{unset_defaults(array('main_title','facet_title'))}