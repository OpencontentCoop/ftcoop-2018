{ezpagedata_set('require_container', false())}
<div id="facetcontainer" class="content-view-full class-{$node.class_identifier} cooperative" data-url="{$node.url_alias|ezurl(no)}">

  <div class="container">
    <div class="row">
      <div class="content-main wide">

        <div class="page-header">
          <h1>{$node.name|wash()}</h1>
        </div>

        {if $node|has_attribute( 'short_description' )}
          <div class="abstract">
            {attribute_view_gui attribute=$node|attribute( 'short_description' )}
          </div>
        {/if}
      </div>
    </div>
  </div>

{def $main_title = 'Cerca'
     $facet_title = 'Filtra ricerca per...'
     $navigation = array(
      hash( 'field', 'settore.id', 'name', 'Settore', 'limit', 100, 'class', 'macrosettore' ),
      hash( 'field', 'comunita.id', 'name', 'Territorio', 'limit', 100, 'class', 'comunita' ),        
      hash( 'field', 'settore_attivita.id', 'name', 'Settore di attivita', 'limit', 100, 'class', 'settore_attivita' )
     )}

  <section>
    <div class="section-header alt2">

      <div class="container">
        <div class="row">
          <div class="max-width">
             <form class="form-facets" role="search">

                <h3>{$main_title}</h3>
                <div class="btn-group" style="width: 100%; margin-bottom: 20px;">
                  <input id="searchfacet" data-content="Premi invio per cercare" type="text" class="form-control" placeholder="Cerca" name="query" value="" style="width:100%;">
                  <span id="searchfacetclear" class="fa fa-times-circle" style="display:none;position: absolute;right: 5px;top: 0;bottom: 0;height: 30px;margin: auto;font-size: 30px;cursor: pointer;color: #ccc;"></span>                  
                </div>

                <h3>{$facet_title}</h3>
                {foreach $navigation as $item}
                  <select class="facet-select" data-placeholder="{$item.name|wash()}" name="{$item.name|wash()}" data-field="{$item.field|wash()}" data-sort="alpha" data-limit="100" style="max-width: 33%">
                    <option></option>
                    {def $data = api_search(concat('select-fields [metadata.id as id, metadata.name as name] classes [',$item.class,'] limit 100 sort [name=>asc]'))}                    
                    {foreach $data as $facet}                    
                    <option class="facet-option facet-{$facet.id}" 
                            value="{$facet.id}" 
                            {if and($item.field|eq('settore.id'), is_set($view_parameters.settore), $view_parameters.settore|eq($facet.id))}selected="selected"{/if}
                            data-name="{$facet.name|wash()}">
                          {$facet.name|wash()}
                    </option>
                    {/foreach}
                    {undef $data}
                  </select>
                {/foreach}
                <button type="submit" class="btn btn-info hide"><i class="fa fa-search"></i>Cerca</button>
              </form>
          </div>
        </div>
      </div>

    </div>

    <div class="container">
      <div class="row">
        <div class="max-width">
          <div class="facet-content has_pagination">            
          </div>
        </div>
      </div>
    </div>
  </section>
</div>

{literal}
<script id="tpl-results" type="text/x-jsrender">
  {{include tmpl="#tpl-pagination"/}}
  <div class="content-view-children" id="searchResults"> 
  {{for searchHits ~uriPrefix=uriPrefix}}
  <a href="{{:~uriPrefix}}/content/view/full/{{:metadata.mainNodeId}}" data-remote="{{:~uriPrefix}}/layout/set/modal/content/view/full/{{:metadata.mainNodeId}}" title="{{:~i18n(metadata.name)}}" class="loadRemote line-item alt class-{{:metadata.classIdentifier}}{{if ~i18n(data, 'settore')}} settore-{{:~i18n(data, 'settore')[0].remoteId}}{{else}}" style="background:#ccc{{/if}}">
    <div class="line-item-content">
      <h4 class="line-item-heading">
        {{:~i18n(metadata.name)}}
        {{if ~i18n(data, 'responsabile')}}
          <small>Responsabile: {{for ~i18n(data,'responsabile')}}{{:~i18n(name)}}{{/for}}</small>
        {{/if}}
      </h4>
      {{if ~i18n(data, 'attivita_e_servizi') || ~i18n(data, 'sigla')}}    
        <div class="line-item-abstract">
        {{if ~i18n(data, 'attivita_e_servizi')}}
            {{:~i18n(data, 'attivita_e_servizi')}}
        {{/if}}
        {{if ~i18n(data, 'sigla')}}
            <strong>Sigla:</strong> {{:~i18n(data, 'sigla')}}
        {{/if}}
        </div>
      {{/if}}
      <i class="far fa-2x fa-plus-square"></i>
    </div>
  </a> 
  {{else}}
    <i class="fa fa-times"></i> Nessun risultato corrisponde ai criteri di ricerca
  {{/for}}
  </div>
  {{include tmpl="#tpl-pagination"/}}
</script>

<script id="tpl-pagination" type="text/x-jsrender">
  <div class="pagination-container text-right">
  <ul class="pagination clearfix" style="display: block;">
  {{if prevPageQuery}}  
    <li class="pull-left"><a href="#" class="prevPage" data-query="{{>prevPageQuery}}">Pagina precedente</a></li>    
  {{/if}}
  {{if nextPageQuery }}
    <li class="pull-right"><a href="#" class="nextPage" data-query="{{>nextPageQuery}}">Pagina successiva</a><li>
  {{/if}}  
  </ul>
  </div>
</script>
{/literal}

{ezscript_require(array(
    'ezjsc::jquery',
    'ezjsc::jqueryUI',
    'jquery.opendataTools.js',
    'moment-with-locales.min.js',
    'jsrender.js',
    'plugins/chosen.jquery.js',
    'plugins/highcharts/highcharts.js',
    'plugins/highcharts/highcharts_theme.js',
    'plugins/leaflet/leaflet.0.7.2.js',
    'plugins/leaflet/leaflet.markercluster.js',
    'plugins/leaflet/Leaflet.MakiMarkers.js',
    'societa.js'
))}

{ezcss_require(array(
  'plugins/leaflet/leaflet.0.7.2.css',
  'plugins/leaflet/MarkerCluster.css',
  'plugins/leaflet/MarkerCluster.Default.css'
))}

<script type="text/javascript" language="javascript">
var ParentNodeId = {$node.object.main_node_id};

var uriPrefix = {'/'|ezurl()};
var tools = $.opendataTools;
$.views.helpers(tools.helpers);
tools.settings('endpoint', {ldelim}
    geo: {'/opendata/api/geo/search/'|ezurl()},
    search: {'/opendata/api/content/search/'|ezurl()},
    class: {'/opendata/api/classes/'|ezurl()}
{rdelim})
var isSelectedSettore = {if is_set($view_parameters.settore)}{$view_parameters.settore|int()}{else}0{/if};
{literal}
$(document).ready(function () {

    var pageLimit = 20;
    var template = $.templates('#tpl-results');
    var $wrapper = $('#facetcontainer');
    var $container = $wrapper.find('.facet-content');

    var facets = [];
    $('select.facet-select').each(function(){
      facets.push($(this).data());
      $(this).chosen({
        allow_single_deselect:true,
        width:'33%'
      }).on('change', function (e) {
        $('.form-facets').trigger('submit');
      });
    });

    var classQuery = 'classes [societa] ';
    var facetQuery = tools.buildFacetsString(facets);
    var mainQuery = classQuery+'subtree [' + ParentNodeId + '] sort [name=>asc] limit ' + pageLimit + ' facets [' + facetQuery + ']';    

    var currentPage = 0;
    var queryPerPage = [];

    var runQuery = function (query) {        
        $container.css('opacity', '.4');
        tools.find(query, function (response) {            
            queryPerPage[currentPage] = query;
            response.currentPage = currentPage;
            response.prevPageQuery = jQuery.type(queryPerPage[currentPage - 1]) === "undefined" ? null : queryPerPage[currentPage - 1];
            response.uriPrefix = uriPrefix;

            var renderData = $(template.render(response));

            $('.facet-option').each(function(){              
              $(this).show().html($(this).data('name')).data('selectable', null);
            });
            $.each(response.facets, function(){
              var select = $('[data-field="'+this.name+'"]');              
              $.each(this.data, function(index, value){
                var option = select.find('option.facet-'+index+'');
                option.html(option.data('name') + ' ('+value+')');
                option.data('selectable', true);
              });              
              
            });
            $('.facet-option').each(function(){              
              if ($(this).data('selectable') == null){
                $(this).hide();
              }
            });
            $('select.facet-select').trigger("chosen:updated");

            $container.html(renderData);

            $container.find('.loadRemote').on('click', function (e) {
                $wrapper.css('opacity', '0.5');
                var self = $(this);
                $.get(self.data('remote'), function(data){
                  var $societa = $(data).find('#societa-container');
                    var closeButton = $('<a href="#" class="btn btn-default btn-xs pull-right">Torna ai risultati della ricerca</a>');
                    closeButton.on('click', function(e){
                        $('#societa-container').remove();
                        $wrapper.show();
                        $wrapper.css('opacity', '1');
                        $([document.documentElement, document.body]).animate({
                            scrollTop: $wrapper.offset().top
                        }, 500);
                        if (window.history.pushState) {
                          history.pushState({}, null, $wrapper.data('url'));
                        }
                        e.preventDefault();
                    });
                    $societa.find('.class-societa').prepend(closeButton);
                    $wrapper.before($societa);                    
                    activateOwlCarousel($societa);
                    $([document.documentElement, document.body]).animate({
                        scrollTop: $societa.offset().top
                    }, 500);
                    $wrapper.hide();
                    if (window.history.pushState) {
                      history.pushState({}, null, $societa.data('url'));
                    }
                }).fail(function(){ 
                    $wrapper.show();
                    $wrapper.css('opacity', '1');
                    alert("Errore");
                });
                e.preventDefault();
            });

            $container.find('.nextPage').on('click', function (e) {
                currentPage++;
                runQuery($(this).data('query'));
                $([document.documentElement, document.body]).animate({
                    scrollTop: $wrapper.offset().top
                }, 500);
                e.preventDefault();
            });

            $container.find('.prevPage').on('click', function (e) {
                currentPage--;
                runQuery($(this).data('query'));
                $([document.documentElement, document.body]).animate({
                    scrollTop: $wrapper.offset().top
                }, 500);
                e.preventDefault();
            });
            $container.css('opacity', '1');
        });
    };

    var loadContents = function () {
        $('#name').val('');     
        if (isSelectedSettore > 0){
          runQuery('settore.id in ['+isSelectedSettore+'] '+mainQuery);
        }else{
          runQuery(mainQuery);
        }        
    };

    $('.form-facets').on('submit', function (e) {
        var name = $('#searchfacet').val();
        var filters = '';
        if (name) {
          var cleanName = name.trim().replace(/'/g, "\\'");
          filters += 'q = "' + cleanName + '" and ';
          $('#searchfacetclear').show();
        }
        $('select.facet-select').each(function(){
          var value = $(this).val();
          if(value){
            if (!$.isArray(value)){
              value = [value];
            }
            filters += $(this).data('field') + ' in [' + value.join(',') + '] and ';
          }
        });
        var searchQuery = classQuery+'subtree [' + ParentNodeId + '] and ' + filters + ' sort [name=>asc] limit ' + pageLimit + ' facets [' + facetQuery + ']';    
        runQuery(searchQuery);        
        currentPage = 0;                      
        e.preventDefault();
    });

    $('#searchfacetclear').on('click', function (e) {
        $('#searchfacet').val('');
        $('#searchfacetclear').hide();
        currentPage = 0;
        runQuery(mainQuery);
        e.preventDefault();
    });

    $('#searchfacet').val('');
    loadContents();
});  
{/literal}
</script>
