{ezpagedata_set('require_container', false())}
<div id="facetcontainer" class="content-view-full class-{$node.class_identifier} cooperative">

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
     $facet_title = 'Filtra per...'
     $navigation = array(
      hash( 'field', 'ufficio.id', 'name', 'Ufficio', 'limit', 100, 'class', 'ufficio' ),
      hash( 'field', 'servizio.id', 'name', 'Servizio', 'limit', 100, 'class', 'servizio' )
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
                {*<div class="row">
                  <div class="col-md-8">*}
                    <h3>{$facet_title}</h3>
                    {foreach $navigation as $item}
                    {def $data = api_search(concat('select-fields [metadata.id as id, metadata.name as name] classes [',$item.class,'] limit 100 sort [name=>asc] language \'ita-IT\''))}
                      <select class="facet-select" data-placeholder="{$item.name|wash()}" name="{$item.name|wash()}" data-field="{$item.field|wash()}" data-sort="alpha" data-limit="100" style="max-width: 50%">
                        <option></option>                    
                        {foreach $data as $facet}                    
                        <option class="facet-option facet-{$facet.id}" 
                                value="{$facet.id}"                             
                                data-name="{$facet.name|wash()}">
                              {$facet.name|wash()}
                        </option>
                        {/foreach}                    
                      </select>
                    {undef $data}
                    {/foreach}
                  {*</div>*}
                  {*<div class="col-md-4">
                    <h3>Ordina risultati per...</h3>
                    <select class="sort-select">
                      <option selected="selected" value="nome">Cognome</option>
                      <option value="ufficio">Ufficio</option>
                      <option value="servizio">Servizio</option>
                    </select>
                  </div>
                </div>*}
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
  <div class="content-view-children"> 
  {{for searchHits ~uriPrefix=uriPrefix ~sortParam=sortParam}}
  <div href="{{:~uriPrefix}}/content/view/full/{{:metadata.mainNodeId}}" title="{{:~i18n(metadata.name)}}" class="line-item alt class-{{:metadata.classIdentifier}} settore-MS_20">
    <div class="line-item-content">
      <h4 class="line-item-heading">
        {{if ~sortParam == 'nome'}}
          {{:~i18n(data, 'cognome')}} {{:~i18n(data, 'nome')}}
        {{else}}
          {{:~i18n(data, 'nome')}} {{:~i18n(data, 'cognome')}}
        {{/if}}
      </h4>
      <div class="line-item-abstract">
        <ul class="list-unstyled">
          {{if ~i18n(data, 'email')}}
          <li><strong>Email</strong> <a href="mailto:{{:~i18n(data, 'email')}}">{{:~i18n(data, 'email')}}</a></li>
          {{/if}}
          {{if ~i18n(data, 'interno')}}
          <li><strong>Telefono interno</strong> <a href="tel:{{:~i18n(data, 'interno')}}">{{:~i18n(data, 'interno')}}</a></li>
          {{/if}}
          {{if ~i18n(data, 'servizio')}}
          <li><strong>Servizio</strong> {{for ~i18n(data, 'servizio')}}{{:~i18n(name)}}{{/for}}</li>
          {{/if}}
          {{if ~i18n(data, 'ufficio')}}
          <li><strong>Ufficio</strong> {{for ~i18n(data, 'ufficio')}}{{:~i18n(name)}}{{/for}}</li>
          {{/if}}
        </ul>
      </div>
    </div>
  </div> 
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
    'plugins/chosen.jquery.js'
))}
<script type="text/javascript" language="javascript">
var ParentNodeId = {ezini('elencotelefonicoimporthandler-HandlerSettings', 'PersonaleParentNodeID', 'sqliimport.ini')};

var uriPrefix = {'/'|ezurl()};
var tools = $.opendataTools;
$.views.helpers(tools.helpers);
tools.settings('endpoint', {ldelim}
    geo: {'/opendata/api/geo/search/'|ezurl()},
    search: {'/opendata/api/content/search/'|ezurl()},
    class: {'/opendata/api/classes/'|ezurl()}
{rdelim})

{literal}
$(document).ready(function () {

    var pageLimit = 20;
    var template = $.templates('#tpl-results');
    var $container = $('#facetcontainer .facet-content');

    var facets = [];
    $('select.facet-select').each(function(){
      facets.push($(this).data());
      $(this).chosen({
        allow_single_deselect:true,
        width:'49.5%'
      }).on('change', function (e) {
        $('.form-facets').trigger('submit');
      });
    });

    $('select.sort-select').each(function(){
      $(this).chosen({
        width:'100%'
      }).on('change', function (e) {
        $('.form-facets').trigger('submit');
      });
    });

    var classQuery = 'classes [personale] ';
    var facetQuery = tools.buildFacetsString(facets);
    var socioFilter = 'socio_o_dipendente.id = 501451 and ';
    var sort = "sort [name=>asc]";
    var mainQuery = classQuery+'subtree [' + ParentNodeId + '] and '+socioFilter+' '+sort+' limit ' + pageLimit + ' facets [' + facetQuery + ']';    

    var currentPage = 0;
    var queryPerPage = [];

    var runQuery = function (query) {        
        $container.css('opacity', '.4');
        tools.find(query, function (response) {            
            queryPerPage[currentPage] = query;
            response.currentPage = currentPage;
            response.prevPageQuery = jQuery.type(queryPerPage[currentPage - 1]) === "undefined" ? null : queryPerPage[currentPage - 1];
            response.uriPrefix = uriPrefix;
            response.sortParam = $('select.sort-select').val() || 'nome';
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

            $container.find('.nextPage').on('click', function (e) {
                currentPage++;
                runQuery($(this).data('query'));
                e.preventDefault();
            });

            $container.find('.prevPage').on('click', function (e) {
                currentPage--;
                runQuery($(this).data('query'));
                e.preventDefault();
            });
            $container.css('opacity', '1');
        });
    };

    var loadContents = function () {
        $('#name').val('');             
        runQuery(mainQuery);
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
        var sortParam = $('select.sort-select').val();
        if (sortParam == 'nome'){
          sort = "sort [name=>asc]";
        }else if (sortParam == 'ufficio'){
          sort = "sort [ufficio.name=>asc,name=>asc]";
        }else if (sortParam == 'servizio'){
          sort = "sort [servizio.name=>asc,name=>asc]";
        }
        var searchQuery = classQuery+'subtree [' + ParentNodeId + '] and '+socioFilter+' ' + filters + ' '+sort+' limit ' + pageLimit + ' facets [' + facetQuery + ']';    
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
<style type="text/css">.line-item.alt:hover a{ldelim}color:#fff !important{rdelim}</style>