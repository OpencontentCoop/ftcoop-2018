{set_defaults(hash('show_title', true(), 'items_per_row', 1))}
<div class="openpa-widget {$block.view}">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title"><span>{$block.name|wash()}</span></h3>
    {/if}
    <div class="openpa-widget-content facet-search" id="facet-search-{$block.id}">
        <a href="#" class="btn btn-primary btn-lg btn-block open-xs-filter visible-xs"><i class="fa fa-filter"></i> Filtri</a>
        <div class="row filters-wrapper hidden-xs"></div>
        <div class="row current-filters-wrapper">
            <div class="col-sm-12">
                <ul class="list-inline current-filter"></ul>
            </div>
        </div>
        <div class="current-result row panels-container"></div>
    </div>
</div>


{def $classes = $block.custom_attributes.classes|explode(',')}
{def $attributes = $block.custom_attributes.attributes|explode(',')}
{def $content_classes = fetch(class, list, hash('class_filter', $classes))}

{def $filters = array()}
{def $added_filters = array()}

{foreach $content_classes as $content_class}
    {foreach $content_class.data_map as $class_attribute}
        {if and($attributes|contains($class_attribute.identifier), $added_filters|contains($class_attribute.identifier)|not())}            
            {if $class_attribute.data_type_string|eq('eztags')}
                {def $filter = hash(
                    'type', 'tag',
                    'queryField', $class_attribute.identifier,
                    'label', $class_attribute.name,
                    'rootTag', $class_attribute.data_int1
                )}
            {else}
                {def $filter = hash(
                    'type', 'standard',
                    'queryField', $class_attribute.identifier,
                    'label', $class_attribute.name
                )}
            {/if}
            {set $added_filters = $added_filters|append($class_attribute.identifier)}
            {set $filters = $filters|append($filter)}
            {undef $filter}
        {/if}
    {/foreach}
{/foreach}

{unset_defaults(array('show_title','items_per_row'))}

{run-once}
{literal}
<script id="tpl-filter" type="text/x-jsrender">
<div class="col-xs-12 col-sm-4 filter-wrapper">
    <h4 class="widget_title">
        <a data-toggle="collapse" href="#{{:queryField}}" aria-expanded="false" aria-controls="{{:queryField}}">
            <i class="fa fa-plus"></i>
            <span>{{:label}}</span>                             
        </a>
        <ul class="list-inline current-xs-filters"></ul>
    </h4>
    <div class="widget collapse" id="{{:queryField}}">                    
        <ul class="nav nav-pills nav-stacked" data-filter="{{:queryField}}">
          <li class="remove-filter"><a href="#" data-value="all">Rimuovi filtri</a></li>
        </ul>
    </div>
</div>    
</script>

<script id="tpl-close-xs-filter" type="text/x-jsrender">
    <a href="#{{:id}}" class="btn btn-primary btn-lg btn-block close-xs-filter" style="display: none;"><i class="fa fa-times"></i> Chiudi</a>
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
{/run-once}
<script>{literal}
$(document).ready(function(){
    $.opendataTools.settings('accessPath', "{/literal}{''|ezurl(no,full)}{literal}");

    $('{/literal}#facet-search-{$block.id}{literal}').facetSearchView({
        'query': "classes [{/literal}{$classes|implode(',')}{literal}] limit 6",
        'viewHelpers': $.extend({}, $.opendataTools.helpers, {
            'firstImageUrl': function (image) {                        
                if (image.length > 0 && typeof image[0].id == 'number') {
                    return $.opendataTools.settings('accessPath') + '/image/view/' + image[0].id + '/agid_panel';
                }
                return image.url;
            }
        }),
        'filters':[{/literal}
{foreach $filters as $filter}{ldelim}type: '{$filter.type}'{if is_set($filter.rootTag)}, rootTag: '{$filter.rootTag}'{/if},label: '{$filter.label}', queryField: '{$filter.queryField}'{rdelim}{delimiter},{/delimiter}{/foreach}
        {literal}]
    });   
});
{/literal}</script>