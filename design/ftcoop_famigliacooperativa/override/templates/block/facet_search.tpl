{*ezscript_require( array(    
    'jquery.opendataSearchView.js',
    'jquery.opendataSearchViewFilterFactory.js',
    'jsrender.js'
))*}

{set_defaults(hash('show_title', true(), 'items_per_row', 1))}
<div class="openpa-widget {$block.view}">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title"><span>{$block.name|wash()}</span></h3>
    {/if}
    <div class="openpa-widget-content" id="facet-search-{$block.id}">
        <div class="row">
            <div class="col-sm-4">
                
                <h4 class="widget_title" style="margin: 20px 0">
                    <span>{'Allergeni'|i18n('facet_search_block')}</span>
                    <a class="pull-right" data-toggle="collapse" href="#allergen" aria-expanded="false" aria-controls="allergen"><i class="fa fa-plus"></i></a>
                </h4>
                <div class="widget collapse" id="allergen" style="margin-bottom: 30px">                    
                    <ul class="nav nav-pills nav-stacked" data-filter="allergen">
                      <li><a href="#" data-value="all">{'Tutti'|i18n('facet_search_block')}</a></li>
                    </ul>
                </div>
                
                
                <h4 class="widget_title" style="margin: 20px 0">
                    <span>{'Categoria'|i18n('facet_search_block')}</span>
                    <a class="pull-right" data-toggle="collapse" href="#category" aria-expanded="false" aria-controls="category"><i class="fa fa-plus"></i></a>
                </h4>
                <div class="widget collapse" id="category" style="margin-bottom: 30px">                    
                    <ul class="nav nav-pills nav-stacked" data-filter="category">
                      <li><a href="#" data-value="all">{'Tutte'|i18n('facet_search_block')}</a></li>
                    </ul>
                </div>
                                
                <h4 class="widget_title" style="margin: 20px 0">
                    <span>{'Marca'|i18n('facet_search_block')}</span>
                    <a class="pull-right" data-toggle="collapse" href="#brand" aria-expanded="false" aria-controls="brand"><i class="fa fa-plus"></i></a>
                </h4>
                <div class="widget collapse" id="brand" style="margin-bottom: 30px">                    
                    <ul class="nav nav-pills nav-stacked" data-filter="brand">
                      <li><a href="#" data-value="all">{'Tutte'|i18n('facet_search_block')}</a></li>
                    </ul>
                </div>

            </div>
            <div class="col-sm-8">
                <ul class="list-inline current-filter" style="display: none;margin: 20px 0"></ul>
                <div class="current-result row panels-container"></div>
            </div>
        </div>
    </div>
</div>
{unset_defaults(array('show_title','items_per_row'))}

{literal}
<script id="tpl-filter" type="text/x-jsrender">
    <h4 class="widget_title" style="margin: 20px 0">
        <span>{{:title}}</span>
        <a class="pull-right" data-toggle="collapse" href="#{{:identifier}}" aria-expanded="false" aria-controls="{{:identifier}}"><i class="fa fa-plus"></i></a>
    </h4>
    <div class="widget collapse" id="{{:identifier}}" style="margin-bottom: 30px">                    
        <ul class="nav nav-pills nav-stacked" data-filter="{{:identifier}}">
          <li><a href="#" data-value="all">{'Tutti'|i18n('facet_search_block')}</a></li>
        </ul>
    </div>
</script>

<script id="tpl-spinner" type="text/x-jsrender">
<div class="col-xs-12 spinner text-center">
    <i class="fa fa-circle-notch fa-spin fa-3x fa-fw"></i>
    <span class="sr-only">Loading...</span>
</div>
</script>

<script id="tpl-empty" type="text/x-jsrender">
<div class="col-xs-12 text-center">
    <i class="fa fa-times"></i> Nessun risultato trovato
</div>
</script>
<script id="tpl-item" type="text/x-jsrender">
<div class="col-md-6">    
    <div class="media-panel">      
      <figure style="background-image:url({{:~firstImageUrl(~i18n(data,'image'))}})"></figure>      
      <div class="media has-image">
        <div class="caption" style="min-height:210px">
          <h4>
              <a href="{{:~settings('accessPath')}}/content/view/full/{{:metadata.mainNodeId}}" title="{{:~i18n(data,'name')}}">{{:~i18n(data,'name')}}</a>
          </h4>
          {{if ~i18n(data,'abstract')}}
            {{:~i18n(data,'abstract')}}          
          {{/if}}
          <p class="link">
            <a href="{{:~settings('accessPath')}}/content/view/full/{{:metadata.mainNodeId}}" title="{{:~i18n(data,'name')}}">Dettaglio</a>
          </p>
        </div>
      </div>
    </div>
</div>
</script>
<script id="tpl-load-other" type="text/x-jsrender">
<div class="col-xs-12 text-center">
    <a href="#" class="btn btn-primary btn-lg">Carica altri risultati</a>
</div>
</script>
{/literal}

<script>{literal}
$(document).ready(function(){
    $.opendataTools.settings('accessPath', "{/literal}{''|ezurl(no,full)}{literal}");
    var FacetHelpers = $.extend({}, $.opendataTools.helpers, {
        'firstImageUrl': function (image) {                        
            if (image.length > 0) {
                return $.opendataTools.settings('accessPath') + '/image/view/' + image[0].id;
            }
            return null;
        }
    });

    $('.widget').on('hidden.bs.collapse', function () {      
      $(this).prev().find('i').removeClass('fa-minus').addClass('fa-plus');      
    }).on('show.bs.collapse', function () {
      $(this).prev().find('i').removeClass('fa-plus').addClass('fa-minus');
    });

    var spinner = $($.templates("#tpl-spinner").render({}));
    var empty = $.templates("#tpl-empty").render({});

    $('{/literal}#facet-search-{$block.id}{literal}').opendataSearchView({
        query: "classes ['prodotto'] limit 4",
        onInit: function (view) {
        },
        onBeforeSearch: function (query, view) {
            view.container.find('.current-result').html(spinner);
        },
        onLoadResults: function (response, query, appendResults, view) {
            var currentFilterContainer = view.container.find('.current-filter');
            var currentResultContainer = view.container.find('.current-result');

            currentFilterContainer.empty().hide();
            $('.widget').find('li.active a').each(function(){
                var data = $(this).data();
                if (data.value != 'all'){                    
                    var filterWidget = $('[data-filter="'+data.filter_identifier+'"]');
                    var name = filterWidget.parent().prev().find('span').html();
                    var item = $('<li><strong>'+ name +'</strong>: '+ data.name + '</li>');
                    var remove = $('<a href="#" style="padding-right:5px"><i class="fa fa-times"><i></a>').on('click', function(e){
                        filterWidget.find('a[data-value="all"]').trigger('click');
                        e.preventDefault();
                    }).prependTo(item);
                    currentFilterContainer.append(item)
                }
            });
            if (currentFilterContainer.find('li').length > 0){
                currentFilterContainer.show();
            }
            spinner.remove();
            if (response.totalCount > 0) {
                var template = $.templates("#tpl-item");
                $.views.helpers(FacetHelpers);
                var htmlOutput = template.render(response.searchHits);
                if (appendResults) currentResultContainer.append(htmlOutput);
                else currentResultContainer.html(htmlOutput);

                if (response.nextPageQuery) {
                    var loadMore = $($.templates("#tpl-load-other").render({}));
                    loadMore.find('a').bind('click', function (e) {
                        view.appendSearch(response.nextPageQuery);
                        loadMore.remove();
                        currentResultContainer.append(spinner);
                        e.preventDefault();
                    });
                    currentResultContainer.append(loadMore)
                }
            } else {
                currentResultContainer.html(empty);
            }
        },
        onLoadErrors: function (errorCode, errorMessage, jqXHR, view) {
            view.container.html('<div class="alert alert-danger">' + errorMessage + '</div>')
        }
    }).data('opendataSearchView')
        .addFilter(TagFilterFactory('category.tag_ids', 'ul[data-filter="category"]', 'Tipologie di prodotto', 'alpha', 100))
        .addFilter(TagFilterFactory('allergen.tag_ids', 'ul[data-filter="allergen"]', 'Allergie', 'alpha', 100))
        .addFilter(FilterFactory('brand', 'ul[data-filter="brand"]', 'alpha', 100))
        .init()
        .doSearch();
});
{/literal}</script>