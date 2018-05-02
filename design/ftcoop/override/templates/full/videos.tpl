{ezpagedata_set('require_container', false())}
<div id="facetcontainer" class="content-view-full class-{$node.class_identifier} pubblicazioni">

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

  <section>
    <div class="section-header alt2">

      <div class="container">
        <div class="row">
          <div class="max-width">
            <form class="form-facets" role="search" action="">

              <h3>Cerca</h3>
              <div class="btn-group" style="width: 100%; margin-bottom: 20px;">
                <input id="searchfacet" data-content="Premi invio per cercare" type="text" class="form-control" placeholder="Cerca" name="query" value="" style="width:100%;">
                <span id="searchfacetclear" class="fa fa-times-circle" style="display:none;position: absolute;right: 5px;top: 0;bottom: 0;height: 30px;margin: auto;font-size: 30px;cursor: pointer;color: #ccc;"></span>
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
  <div class="content-view-children">
  {{for searchHits ~uriPrefix=uriPrefix}}
    <a href="{{:~uriPrefix}}/content/view/full/{{:metadata.mainNodeId}}" class="line-item alt class-{{:metadata.classIdentifier}} settore-MS_20 row">
      {{if ~i18n(data, 'image')}}
      <div class="col-sm-2">
        <img src="{{:~i18n(data, 'image').url}}" style="max-width: 100%;" />
      </div>
      {{/if}}
      <div class="line-item-content col-sm-{{if ~i18n(data, 'image')}}10{{else}}12{{/if}}" style="min-height:50px">
        <h4 class="line-item-title">{{:~i18n(metadata.name)}}</h4>
        {{if ~i18n(data, 'body')}}
          {{:~i18n(data, 'body')}}
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

    var pageLimit = 20;
    var template = $.templates('#tpl-results');
    var $container = $('#facetcontainer .facet-content');

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

    var classQuery = 'classes [web_tv] ';

    var mainQuery = classQuery+'subtree [' + ParentNodeId + '] sort [published=>desc] limit ' + pageLimit;

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
          filters += 'q = "' + name + '" and ';
          $('#searchfacetclear').show();
        }
        $('select.facet-select').each(function(){
          var value = $(this).val();
          if(value){
            var field = $(this).data('field');
            if (field = 'published'){
              filters += field + ' range [' + value + '-01-01,' + value + '-12-31] and ';
            }else{
              if (!$.isArray(value)){
                value = [value];
              }
              filters += field + ' in [' + value.join(',') + '] and ';
            }
          }
        });
        var searchQuery = classQuery+'subtree [' + ParentNodeId + '] and ' + filters + ' sort [published=>desc] limit ' + pageLimit;
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


