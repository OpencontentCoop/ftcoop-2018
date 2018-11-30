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
    <div class="openpa-widget-content facet-search" id="facet-search-{$block.id}">
        
        <a href="#" class="btn btn-primary btn-lg btn-block open-xs-filter visible-xs"><i class="fa fa-filter"></i> Filtri</a>
        
        <div class="row filters-wrapper hidden-xs">            
            <div class="col-xs-12 col-sm-4 filter-wrapper">
                <h4 class="widget_title">
                    <a data-toggle="collapse" href="#allergen" aria-expanded="false" aria-controls="allergen">
                        <i class="fa fa-plus"></i>
                        <span>{'Allergeni'|i18n('facet_search_block')}</span>                    
                    </a>
                </h4>
                <div class="widget collapse" id="allergen">                    
                    <ul class="nav nav-pills nav-stacked" data-filter="allergen">
                      <li class="remove-filter"><a href="#" data-value="all">Rimuovi filtri</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="col-xs-12 col-sm-4 filter-wrapper">   
                <h4 class="widget_title">
                    <a data-toggle="collapse" href="#category" aria-expanded="false" aria-controls="category">
                        <i class="fa fa-plus"></i>
                        <span>{'Categoria'|i18n('facet_search_block')}</span>                    
                    </a>
                </h4>
                <div class="widget collapse" id="category">                    
                    <ul class="nav nav-pills nav-stacked" data-filter="category">
                      <li class="remove-filter"><a href="#" data-value="all">Rimuovi filtri</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="col-xs-12 col-sm-4 filter-wrapper">                    
                <h4 class="widget_title">
                    <a data-toggle="collapse" href="#brand" aria-expanded="false" aria-controls="brand">
                        <i class="fa fa-plus"></i>
                        <span>{'Marca'|i18n('facet_search_block')}</span>                    
                    </a>
                </h4>
                <div class="widget collapse" id="brand">                    
                    <ul class="nav nav-pills nav-stacked" data-filter="brand">
                      <li class="remove-filter"><a href="#" data-value="all">Rimuovi filtri</a></li>
                    </ul>
                </div>
            </div>
        
            <a href="#facet-search-{$block.id}" class="btn btn-primary btn-lg btn-block close-xs-filter" style="display: none;"><i class="fa fa-times"></i> Chiudi</a>

        </div>

        <div class="row current-filters-wrapper">
            <div class="col-sm-12">
                <ul class="list-inline current-filter"></ul>
            </div>
        </div>
        <div class="current-result row panels-container"></div>
            
    </div>
</div>
{unset_defaults(array('show_title','items_per_row'))}

{literal}
<style>
@media (min-width: 768px) {
    .facet-search .widget{
        margin-bottom: 30px;        
        position: absolute;
        z-index: 10;
        background: #fff;
        right: 15px;
        left: 15px;
        padding: 0
    }
    .facet-search .widget > ul{
        max-height: 270px;
        overflow-y: auto;
    }
    /*.facet-search .widget li.remove-filter{
        position: absolute;
        width: 100%;
        bottom: -48px;
        left: 0
    }*/    
    .facet-search .open-xs-filter,
    .facet-search .close-xs-filter{
        display: none !important;
    }
    .facet-search .filters-wrapper{
        margin-bottom: 20px
    }
}

.facet-search .widget li a[data-value="all"]{
    display: block;
    background: #0DB5EB;
    color: #fff;
}
.facet-search .widget li.active a[data-value="all"]{
    display: none;        
}

.facet-search .widget_title{
    margin: 20px 0 0;
    padding-bottom: 10px;
    border-bottom: 1px solid #ccc
}
.facet-search .widget_title a{
    display: block;
    text-decoration: none;
}
.facet-search .widget_title a:focus{
    outline: none;
}
.facet-search .widget_title a i {
    padding-right: 10px
}

.facet-search .current-filters-wrapper{
    margin: 0 0 20px
}

@media (max-width: 767px) {
    .facet-search .filters-wrapper-xs{
        position: fixed;
        z-index: 10;
        background: #fff;
        padding: 10px 20px;
        top: 0;
        bottom: 40px;
        left: 0;
        right: 0;      
        opacity: .95;
    }
    .facet-search .filters-wrapper-xs .filter-wrapper.active h4.widget_title{
        position: fixed;
        width: 100%;
        left: 0;
        padding: 20px;
        background: #fff;
        z-index: 12;
        top: 0;
        margin: 0;
    }
    .facet-search .filters-wrapper-xs .filter-wrapper.active{
        height: 100%;
        overflow-y: hidden;
    }
    .facet-search .filters-wrapper-xs .filter-wrapper.active .widget{
        height: auto;
        position: absolute;
        top: 55px;
        width: 100%;
        left: 0;
        bottom: 0px;
        overflow-y: auto;    
    }
    .facet-search .filters-wrapper-xs.has-active .filter-wrapper.unactive{
        display: none;
    }
    .facet-search .open-xs-filter{
        margin-bottom: 20px;
        border-radius: 0;
    }
    .facet-search .close-xs-filter{
        position: fixed;
        bottom: 0;
        left: 0;
        border-radius: 0;
    }
}
</style>
<script id="tpl-filter" type="text/x-jsrender">

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
<div class="col-sm-6">    
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
      $(this).parents('.filters-wrapper').removeClass('has-active');
      $(this).parent().removeClass('active').addClass('unactive');
      $(this).prev().find('i').removeClass('fa-times').addClass('fa-plus');       
    }).on('show.bs.collapse', function () {
      $(this).parents('.filters-wrapper').find('div.filter-wrapper').removeClass('active').addClass('unactive');
      $(this).parent().removeClass('unactive').addClass('active').show();
      $(this).parents('.filters-wrapper').addClass('has-active');
      $(this).prev().find('i').removeClass('fa-plus').addClass('fa-times');
    });

    $('.open-xs-filter').on('click', function(){
        $(this).addClass('hidden-xs');
        $('.filters-wrapper').removeClass('hidden-xs').addClass('filters-wrapper-xs');
        $('.close-xs-filter').show();
    });
    $('.close-xs-filter').on('click', function(){
        $(this).hide();
        $('.open-xs-filter').removeClass('hidden-xs');
        $('.filters-wrapper').removeClass('filters-wrapper-xs').addClass('hidden-xs');
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

            // $('a[data-value]').removeClass('text-muted').each(function(){
            //     var item = $(this);
            //     if (item.data('value') !== 'all' && item.data('count') == 0){
            //         console.log(item);
            //         item.addClass('text-muted');
            //     }
            // });

            currentFilterContainer.empty();
            $.each(view.filters, function(){
                var filter = this;
                var currentValues = filter.getCurrent();
                if (currentValues.length && jQuery.inArray('all', currentValues) == -1) {
                    var item = $('<li><strong>'+ filter.label +'</strong>:</li>');                    
                    $.each(currentValues, function(){                        
                        var value = this;
                        var valueElement = $('a[data-value="'+filter.quoteValue(value)+'"]');
                        $('<a href="#" style="margin:0 5px"><i class="fa fa-times"></i> '+valueElement.data('name')+'</a>')                            
                            .on('click', function(e){
                                valueElement.trigger('click');
                                e.preventDefault();
                            })
                            .appendTo(item);
                    });
                    item.appendTo(currentFilterContainer);
                }
            });
            
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
        .addFilter(TagFilterFactory('Categoria', 'category.tag_ids', 'ul[data-filter="category"]', 'Tipologie di prodotto', 'alpha', 100))
        .addFilter(TagFilterFactory('Allergeni', 'allergen.tag_ids', 'ul[data-filter="allergen"]', 'Allergie', 'alpha', 100))
        .addFilter(FilterFactory('Marca', 'brand', 'ul[data-filter="brand"]', 'alpha', 100))
        .init()
        .doSearch();
});
{/literal}</script>