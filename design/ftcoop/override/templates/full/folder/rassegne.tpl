{ezpagedata_set('require_container', false())}
{def $anno_di_inzio = 2006}

<div id="facetcontainer" class="content-view-full class-{$node.class_identifier} cooperative">

  <div class="container">
    <div class="row">
      <div class="content-main wide">

        <div class="page-header">
          <h1>{$node.name|wash()}</h1>
        </div>

        {if $node|has_attribute( 'short_description' )}
          <div class="abstract well">
              {attribute_view_gui attribute=$node|attribute( 'short_description' )}
          </div>
        {/if}


          <div class="clearfix">
          {foreach fetch_alias( 'children', hash( 'parent_node_id', ezini('RassegnaStampa', 'RassegnaSpecialeParentNodeID', 'ftcoop.ini'),
                              'sort_by', $node.sort_array,
                              'class_filter_type', 'include',
                              'class_filter_array', array( 'file_pdf'),
                              'limit', ezini('RassegnaStampa', 'FascicoleLimit', 'ftcoop.ini') ) ) as $rassegnaNode }
            <a class="btn btn-primary btn-sm" href={concat("content/download/",$rassegnaNode.data_map.file.contentobject_id,"/",$rassegnaNode.data_map.file.id,"/file/",$rassegnaNode.data_map.file.content.original_filename, "?time=", currentdate())|ezurl}>
              Scarica il fascicolo PDF della Rassegna Stampa di {$rassegnaNode.object.published|datetime('custom','%l %j %F %Y')}
            </a>
          {/foreach}
          {def $fascicoli = fetch( 'content', 'node', hash( 'node_id', ezini('RassegnaStampa', 'RassegnaSpecialeParentNodeID', 'ftcoop.ini') ) )}
          <a class="btn btn-primary btn-sm pull-right" href="{$fascicoli.url_alias|ezurl(no)}">Vai ai fascicoli</a>
        </div>
      </div>
    </div>
  </div>

{def $main_title = 'Cerca'
     $facet_title = 'Filtra ricerca per...'
     $navigation = array(
      hash( 'field', 'topic.id', 'name', 'Argomento', 'limit', 100, 'class', 'topic' ),
      hash( 'field', 'fonte.id', 'name', 'Fonte', 'limit', 100, 'class', 'fonte' ),        
      hash( 'field', 'raw[subattr_date___year____dt]', 'name', 'Anno', 'limit', 100 )
     )}

  <section>
    <div class="section-header alt2">

      <div class="container">
        <div class="row">
          <div class="max-width">
             <form class="form-facets" role="search">

                <h3>{$main_title}</h3>
                <div class="row" style="margin-bottom: 20px;">
                  <div class="col-sm-8">
                    <div class="btn-group" style="width: 100%">
                      <input id="searchfacet" data-content="Premi invio per cercare" type="text" class="form-control" placeholder="Cerca" name="query" value="" style="width:100%;">
                      <span id="searchfacetclear" class="fa fa-times-circle" style="display:none;position: absolute;right: 5px;top: 0;bottom: 0;height: 30px;margin: auto;font-size: 30px;cursor: pointer;color: #ccc;"></span>                  
                    </div>
                  </div>
                  <div class="col-sm-4">
                    <select class="facet-select" data-placeholder="Data" name="Data" data-filter="published">
                      <option></option>
                      <option value="1">Oggi</option>
                      <option value="2">Ultimi sette giorni</option>
                      <option value="3">Ultimo mese</option>
                    </select>
                  </div>
                </div>

                <h3>{$facet_title}</h3>
                <div class="row">
                {foreach $navigation as $item}                  
                <div class="col-sm-4">  
                  <select class="facet-select" data-placeholder="{$item.name|wash()}" name="{$item.name|wash()}" data-field="{$item.field|wash()}" data-sort="alpha" data-limit="100">
                    <option></option>
                    {if is_set($item.class)}
                      {def $data = api_search(concat('select-fields [metadata.id as id, metadata.name as name] classes [',$item.class,'] limit 100 sort [name=>asc] language \'ita-IT\''))}                    
                      {foreach $data as $facet}
                      <option class="facet-option" data-facet="{$facet.id}" value="{$facet.id}" data-name="{$facet.name|wash()}">{$facet.name|wash()}</option>
                      {/foreach}
                      {undef $data}
                    {elseif $item.name|eq('Anno')}
                      {def $anni = array()}
                      {for $anno_di_inzio to currentdate()|datetime( 'custom', '%Y' ) as $counter}
                        {set $anni = $anni|append($counter)}
                      {/for}
                      {set $anni = $anni|reverse()}
                      {foreach $anni as $anno}
                      <option class="facet-option" data-facet="{$anno}-01-01T00:00:00Z" value="{$anno}" data-name="{$anno}">{$anno}</option>
                      {/foreach}
                      {undef $anni}
                    {/if}
                  </select>
                </div>
                {/foreach}
              </div>
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
  <div class="content-view-children row" style="margin-bottom: 15px"> 
  {{for searchHits ~uriPrefix=uriPrefix}}        
    <div class="col-md-4">    
      {{if ~i18n(data, 'file_rassegna')}}
        <a href="{{:~i18n(data, 'file_rassegna').url}}">
      {{else}}
        <a href="{{:~uriPrefix}}/content/view/full/{{:metadata.mainNodeId}}" target="_blank">
      {{/if}}
        {{if ~i18n(data, 'image')}}
          <img src="{{:~i18n(data, 'image').url}}" style="max-width: 100%;" />      
        {{/if}}
      </a>
      {{if ~i18n(data, 'date')}}
        <i class="fa fa-calendar"></i> {{:~formatDate(~i18n(data,'date'), 'D/MM/YYYY')}}
      {{/if}}            
      <h4 style="line-height: 1;margin:0">
        {{if ~i18n(data, 'file_rassegna')}}
          <a href="{{:~i18n(data, 'file_rassegna').url}}">
        {{else}}
          <a href="{{:~uriPrefix}}/content/view/full/{{:metadata.mainNodeId}}" target="_blank">
        {{/if}}
        {{:~i18n(metadata.name)}}
        </a>        
      </h4>      
      {{if ~i18n(data, 'topic')}}
        <span class="text-muted">{{for ~i18n(data, 'topic')}}{{:~i18n(name)}}{{/for}}</span>
      {{/if}}
    </div>    
    {{if ((#index + 1) % 3) == 0}}
      </div><div class="content-view-children row" style="margin-bottom: 15px"> 
    {{/if}}
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
var ParentNodeId = {$node.object.main_node_id};

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

    var pageLimit = 39;
    var template = $.templates('#tpl-results');
    var $container = $('#facetcontainer .facet-content');

    var facets = [];
    $('select.facet-select').each(function(){
      if ($(this).data('field')){
        facets.push($(this).data());
      }      
      $(this).chosen({
        allow_single_deselect:true,
        width:'100%'
      }).on('change', function (e) {
        $('.form-facets').trigger('submit');
      });
    });

    var classQuery = 'classes [rassegna] ';
    var facetQuery = tools.buildFacetsString(facets);
    var mainQuery = classQuery+'subtree [' + ParentNodeId + '] sort [published=>desc] limit ' + pageLimit + ' facets [' + facetQuery + ']';    

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
                var option = select.find('option[data-facet="'+index+'"]');
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
            var field = $(this).data('field');            
            if (field){
              if (field == 'published'){
              }else if (field == 'raw[subattr_date___year____dt]'){
                filters += field + ' range [' + value + '-01-01T00:00:00Z,' + value + '-12-31T00:00:00Z] and ';
              }else{
                if (!$.isArray(value)){
                  value = [value];
                }
                filters += field + ' in [' + value.join(',') + '] and ';
              }
            }else{
              var filter = $(this).data('filter');
              if (filter == 'published'){
                if (value == '1'){ //oggi
                  filters += 'published range [' + moment().startOf('day').toISOString() + ',' + moment().endOf('day').toISOString() + '] and ';
                }else if (value == '2'){ //settimana
                  filters += 'published range [' + moment().subtract(7, 'days').toISOString() + ',' + moment().endOf('day').toISOString() + '] and ';
                }else if (value == '3'){ //mese
                  filters += 'published range [' + moment().subtract(1, 'months').toISOString() + ',' + moment().endOf('day').toISOString() + '] and ';
                }
              }
            }
          }
        });
        var searchQuery = classQuery+'subtree [' + ParentNodeId + '] and ' + filters + ' sort [published=>desc] limit ' + pageLimit + ' facets [' + facetQuery + ']';    
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

{include uri='design:parts/load_website_toolbar.tpl'}