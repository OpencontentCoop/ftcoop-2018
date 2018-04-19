{ezpagedata_set( show_path, false() )}
{ezpagedata_set( hide_header_searchbox, false() )}
{ezpagedata_set('require_container', false())}

{ezscript_require( array('ezjsc::jquery', 'moment.js', 'daterangepicker.js') )}
{ezcss_require( array('daterangepicker-bs3.css') )}
{literal}
<style>
.daterangepicker{width: auto !important;max-width: 252px !important;}
.daterangepicker .ranges { width: auto !important;}
.applyBtn, .cancelBtn{float: right;}
</style>
<script type="text/javascript">
$(document).ready(function() {
   $('#date_search').daterangepicker({
      format: 'DD/MM/YYYY',
      parentEl: '#date_search_container',
      showDropdowns: true,
      opens: 'left',
      ranges: {
        'Oggi': [moment().subtract(1, 'days'), moment()],
        'Ieri': [moment().subtract(2, 'days'), moment().subtract(1, 'days')],
        'Ultimi 7 giorni': [moment().subtract(6, 'days'), moment()],
        'Ultimi 30 giorni': [moment().subtract(29, 'days'), moment()],
        'Questo mese': [moment().startOf('month'), moment().endOf('month')],
        'Ultimo mese': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      },
      separator: '-',
      locale: {
        applyLabel: 'Applica',
        cancelLabel: 'Annulla',
        fromLabel: 'Da',
        toLabel: 'A',
        customRangeLabel: 'Personalizza',
        daysOfWeek: ['Do', 'Lu', 'Ma', 'Me', 'Gi', 'Ve','Sa'],
        monthNames: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno', 'Luglio', 'Agosto', 'Settembre', 'Ottobre', 'Novembre', 'Dicembre'],
        firstDay: 1
      }
    }, function(start, end, label) {
      $('form.search-plus').submit();
   });
});
</script>
{/literal}

{def $search=false()
	 $use_url_translation=false()}
{if $use_template_search}
    {set $page_limit=20}

    {def $activeFacetParameters = array()}
    {if ezhttp_hasvariable( 'activeFacets', 'get' )}
        {set $activeFacetParameters = ezhttp( 'activeFacets', 'get' )}
    {/if}

    {def $dateFilter=array()}
    {if ezhttp_hasvariable( 'date_search', 'get' )}
        {def $date_params = ezhttp( 'date_search', 'get' )|explode( '-' )}
        {if count($date_params)|gt(1)}
          {def $from_date = $date_params[0]|explode('/')}
          {def $to_date = $date_params[1]|explode('/')}
          {set $dateFilter=array( concat( 'meta_published_dt:[', makedate( $from_date[1], $from_date[0], $from_date[2] )|datetime( 'custom', '%Y-%m-%dT%H:%m:%s.000Z' ), ' TO ', makedate( $to_date[1], $to_date[0], $to_date[2] )|datetime( 'custom', '%Y-%m-%dT%H:%m:%s.000Z' ), ']' ) )}
        {/if}
    {/if}

    {def $filterParameters = fetch( 'ezfind', 'filterParameters' )
	       $search_classes_array = ezini('SearchSettings' , 'Classes' , 'ftcoop.ini')
         $defaultSearchFacets = array( hash( 'field', 'class', 'name', 'Content type'|i18n("extension/ezfind/facets"), 'limit', 50, 'sort', 'alpha' ) )}
        
    {set $search=fetch( ezfind,search,
                        hash( 'query', $search_text,
                              'offset', $view_parameters.offset,
                              'limit', $page_limit,
                              'sort_by', hash( 'score', 'desc' ),
                              'class_id', $search_classes_array,
                              'facet', $defaultSearchFacets,
                              'filter', $filterParameters|merge($dateFilter),
                              'spell_check', array( false() ),
                              'search_result_clustering', hash( 'clustering', false() ) )
                             )}
    {set $search_result=$search['SearchResult']}
    {set $search_count=$search['SearchCount']}
    {def $search_extras=$search['SearchExtras']}
    {set $stop_word_array=$search['StopWordArray']}
    {set $search_data=$search}

    {def $facetSearch=fetch( ezfind,search,
                        hash( 'query', $search_text,
                              'offset', 0,
                              'limit', 1,
                              'class_id', $search_classes_array,
                              'facet', $defaultSearchFacets,
                              'filter', $dateFilter
                             ) )}
    {def $facetSearch_extras=$facetSearch['SearchExtras']}

{/if}

{def $baseURI=concat( '/content/advancedsearch?SearchText=', $search_text )}

{* Build the URI suffix, used throughout all URL generations in this page *}
{def $uriSuffix = ''}
{foreach $activeFacetParameters as $facetField => $facetValue}
    {set $uriSuffix = concat( $uriSuffix, '&activeFacets[', $facetField, ']=', $facetValue )}
{/foreach}

{foreach $filterParameters as $name => $value}
    {set $uriSuffix = concat( $uriSuffix, '&filter[]=', $name, ':', $value )}
{/foreach}

{if count( $dateFilter )|gt( 0 )}
    {set $uriSuffix = concat( $uriSuffix, '&date_search=', ezhttp( 'date_search', 'get' ) )}
{/if}

<form action="{"/content/search/"|ezurl(no)}" method="get" class="search-plus">

<div class="container">
  <div class="content-view-full class-{$node.class_identifier} row">
    <div class="max-width">

      <div class="row">
        <div class="col-lg-8">

          <h1>
            <span>{"Search"|i18n("design/ezwebin/content/search")}</span>
            {if $search_text|ne('')}<small>{$search_text|wash}</small>{/if}
          </h1>

          <div class="input-group">
            <input type="text" name="SearchText" class="form-control input-lg" value="{$search_text|wash}" />
            <span class="input-group-btn">
              <button type="submit" name="SearchButton" class="btn btn-primary btn-lg" title="{'Search'|i18n('design/ezwebin/content/search')}">
              <span class="fa fa-search"></span>
              </button>
            </span>
          </div>

          {if $search_extras.spellcheck_collation}
             {def $spell_url=concat('/content/search/',$search_text|count_chars()
                |gt(0)
                |choose('',concat('?SearchText=',$search_extras.spellcheck_collation|urlencode)))
                |ezurl}
          <p class="help-block">
            {'Spell check suggestion: did you mean'|i18n('design/ezfind/search')}
            <strong>{concat("<a href=",$spell_url,">")}{$search_extras.spellcheck_collation}</a></strong>?
          </p>
          {/if}

          {if $stop_word_array}
            <p class="help-block">
            {"The following words were excluded from the search"|i18n("design/base")}:
            {foreach $stop_word_array as $stopWord}
              {$stopWord.word|wash}
              {delimiter}, {/delimiter}
            {/foreach}
            </p>
          {/if}

          {switch name=Sw match=$search_count}
          {case match=0}
          <h4 class="text-danger">
            {'No results were found when searching for "%1".'|i18n("design/ezwebin/content/search",,array($search_text|wash))}
            {if $search_extras.hasError}
              {$search_extras.error|wash}
            {/if}
          </h4>
          {/case}
          {case}
          <p class="text-success">
            {if $search_text|ne('')}
            {'Search for "%1" returned %2 matches'|i18n("design/ezwebin/content/search",,array($search_text|wash,$search_count))}
            {else}
            {$search_count} {"Results"|i18n("design/base")|downcase()}
            {/if}
          </p>
            {/case}
          {/switch}
        </div>
      </div>


	    <div class="row" style="margin-bottom: 20px;">
			  <div id="facet-list" class="col-sm-8">
        {foreach $defaultSearchFacets as $key => $defaultFacet}
          {def $facetData=$facetSearch_extras.facet_fields.$key}
          {def $realFacetData=$search_extras.facet_fields.$key}
            <h5>{$defaultFacet['name']}</h5>
            <ul class="list-unstyled list-inline">
              {foreach $facetData.nameList as $key2 => $facetName}
                {if ne( $key2, '' )}
                  {if eq( $activeFacetParameters[concat( $defaultFacet['field'], ':', $defaultFacet['name'] )], $facetName )}
                    {def $suffix=$uriSuffix|explode( concat( '&filter[]=', $facetData.queryLimit[$key2] ) )|implode( '' )|explode( concat( '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=', $facetName ) )|implode( '' )}
                    <li class="label label-success">
                      <a style="color: #fff" href={concat( $baseURI, $suffix )|ezurl} title="{'Remove filter on '|i18n( 'design/ezwebin/content/search' )}'{$facetName|trim('"')|wash}'">
                        <span class="remover">&times</span>
                        {$facetName|shorten(20)|wash}
                      </a>
                      <span class="badge facet-count">{$facetData.countList[$key2]}</span>
                    </li>
                    {undef $suffix}
                  {else}
                  <li class="label label-default">
                    {if array_keys( $activeFacetParameters )|contains( concat( $defaultFacet['field'], ':', $defaultFacet['name']  ) )}
                      <a href={concat( $baseURI, '&filter[]=', $facetData.queryLimit[$key2], '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=', $facetName|rawurlencode )|ezurl}>
                    {else}
                      <a href={concat( $baseURI, '&filter[]=', $facetData.queryLimit[$key2], '&activeFacets[', $defaultFacet['field'], ':', $defaultFacet['name'], ']=', $facetName|rawurlencode, $uriSuffix )|ezurl}>
                    {/if}
                      {$facetName|shorten(20)|wash}
                    </a>
                    <span class="badge facet-count">{$facetData.countList[$key2]}</span>
                  </li>
                  {/if}
                {/if}
              {/foreach}
            </ul>
          {undef $facetData $realFacetData}
        {/foreach}
      </div>
        <div class="col-sm-4">
        <h5>{'Creation time'|i18n( 'extension/ezfind/facets' )}</h5>
        <div class="control-group">
          <div class="controls" id="date_search_container" style="position: relative">
           <div class="input-prepend input-group">
             <span class="add-on input-group-addon"><i class="far fa-calendar-alt"></i></span>
             <input type="text" style="width: 200px" name="date_search" id="date_search" class="form-control" value="{ezhttp( 'date_search', 'get' )}" />
           </div>
          </div>
        </div>
      </div>
      </div>

      {def $enhanced_search_classes = ezini('SearchSettings' , 'EnhancedSearchClasses' , 'ftcoop.ini')}

      {foreach $search_result as $k => $result}
        <!--{$result.score_percent}&#37;-->
        {if and($k|eq(0),$view_parameters.offset|eq(0),$enhanced_search_classes|contains($result.object.class_identifier))}
          {node_view_gui view='enhanced_search_item' use_url_translation=$use_url_translation content_node=$result.object.main_node}
        {else}
          {node_view_gui view='search_line' use_url_translation=$use_url_translation content_node=$result}
        {/if}
      {/foreach}

      {include name=Navigator
               uri='design:navigator/google.tpl'
               page_uri='/content/search'
               page_uri_suffix=concat('?SearchText=',$search_text|urlencode,$search_timestamp|gt(0)|choose('',concat('&SearchTimestamp=',$search_timestamp)), $uriSuffix )
               item_count=$search_count
               view_parameters=$view_parameters
               item_limit=$page_limit}
    </div>
  </div>
</div>
</form>
