{ezpagedata_set('require_container', false())}
{def $settore         = fetch( 'content', 'related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'societa/settore', 'sort_by', array('name', 'desc')  ) )}
{def $tipo_di_settore = 'non_specificato'}{if $settore|count()|gt(0)}{set $tipo_di_settore=$settore[0].name|downcase()|explode(" ")|implode("")|downcase()}{/if}
{def $map_name        = ezini('NomiTabSchedeSocieta', 'Settore', 'ftcoop.ini')}
{def $codice_societa  = $node.data_map.codice.content}
{def $codice_attivita = $node.data_map.codice_attivita.content}
{*def $showScheda      = ezini('VisualizzazioneSchede', 'Show', 'ftcoop.ini')*}
{def $fatturato_name  = ezini('NomiTabSchedeSocieta', 'Fatturato', 'ftcoop.ini')}
{*def $capitale_investimenti_name = ezini('NomiTabSchedeSocieta', 'CapitaleInvestimenti', 'ftcoop.ini')*}
{*def $capitale_umano_name = ezini('NomiTabSchedeSocieta', 'CapitaleUmano', 'ftcoop.ini')*}
{*def $cda_name        = ezini('NomiTabSchedeSocieta', 'CDA', 'ftcoop.ini')*}
{def $collegio_sindacale_name = ezini('NomiTabSchedeSocieta', 'CollegioSindacale', 'ftcoop.ini')}
{def $info_name       = ezini('NomiTabSchedeSocieta', 'Info', 'ftcoop.ini')}
{def $guida           = fetch( 'content', 'node', hash( 'node_id', ezini('NodiRilevanti', 'GuidaGrafici', 'ftcoop.ini' ) ) )}

<div id="societa-container" data-url="{$node.url_alias|ezurl(no)}">
<div class="container">
  <div class="content-view-full class-{$node.class_identifier} row">

      <div class="content-main wide">

        <div class="page-header">
          <h1>{$node.name|wash()}</h1>
        </div>

        {if $node|has_attribute( 'description' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'description' )}
            </div>
        {/if}


        <div class="row" id="coop_info">

          {include uri='design:parts/societa/main_info.tpl' container_class="col-sm-6"}

        </div>

      </div>
  </div>
</div>

<section class="alt2 padding-0">
  <div class="container-fluid sedi">
    <div class="row">

      <div class="col-sm-5 col-sm-offset-1">
          {*<h3 class="panel-title">{if is_set($map_name[$tipo_di_settore])}{$map_name[$tipo_di_settore]}{else}Sedi{/if}</h3>*}
          <div id="coop_map_list"></div>
      </div>

      <div class="col-sm-6 fluid">

          <div id="coop_map" style="width:100%;height:380px"></div>

      </div>
    </div>
  </div>
</section>


<section class="alt3">
  <div class="container">
    <div class="row">
      <div class="max-width">


        <ul class="nav nav-pills" id="societa-{$node.contentobject_id}">

          <li class="active"><a data-toggle="tab" href="#coop_bilancio">{$fatturato_name[$tipo_di_settore]}</a></li>

          {if or($codice_societa|eq('02050'), $codice_societa|eq('02060'), $codice_societa|eq('02090'))}
            <li><a data-toggle="tab" href="#coop_garanzie">Garanzie Rilasciate</a></li>
          {elseif or($codice_attivita|eq('200'), $codice_societa|eq('10638'), $codice_societa|eq('03599'))}
            <li><a data-toggle="tab" href="#coop_raccolta_prestiti">Raccolta e Prestiti</a></li>
          {/if}

          <li><a data-toggle="tab" href="#coop_soci">Soci</a></li>
          <li><a data-toggle="tab" href="#coop_lavoratori">Lavoratori</a></li>
          <li><a data-toggle="tab" href="#coop_cda">CdA</a></li>
          <li><a data-toggle="tab" href="#coop_sindacale">{$collegio_sindacale_name[$tipo_di_settore]}</a></li>
          <li><a data-toggle="tab" href="#info">{$info_name[$tipo_di_settore]}</a></li>

          {if fetch(user, current_user).is_logged_in}
            <li class="pull-right">
              <a data-toggle="tab" href="#contents" title="vedi tutti i dati collegati">
                <i class="fa fa-list"></i>
              </a>
            </li>
          {/if}

          <li class="pull-right">
            <a data-toggle="tab" href="#help" title="visualizza la spiegazione sull'utilizzo dei grafici">
              <i class="fa fa-question-circle"></i>
            </a>
          </li>
        </ul>

        <div class="tab-content">

          <div class="tab-pane active panel panel-default" id="coop_bilancio">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_bilancio_casse_rurali">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_garanzie">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_raccolta_prestiti">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_soci">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_lavoratori">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_cda">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="coop_sindacale">
            <div class="panel-body">
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="info">
            <div class="panel-body">
              <div class="row">
                <div class="col-md-6" id="coop_riferimenti"></div>
                <div class="col-md-6" id="coop_altridati"></div>
              </div>
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="help">
            <div class="panel-body">
              {if $guida.data_map.short_description.has_content}
                {attribute_view_gui attribute=$guida.data_map.short_description}
              {/if}
              {if $guida.data_map.description.has_content}
                {attribute_view_gui attribute=$guida.data_map.description}
              {/if}
            </div>
          </div>

          <div class="tab-pane panel panel-default" id="contents">
            <div class="panel-body" id="contents_data">
            </div>
          </div>

        </div>



      </div>
    </div>
  </div>

</section>




{* mostra comunicati e web tv legati alla società *}
{def $filtri_comunicati = array(concat(solr_meta_subfield('relazioni','id'),':',$node.contentobject_id))
     $filtri_web_tv = array(concat(solr_meta_subfield('cooperative','id'),':',$node.contentobject_id))
     $filtri_audio = array(concat(solr_meta_subfield('relazioni','id'),':',$node.contentobject_id))
     $filtri_pubblicazioni = array(concat(solr_meta_subfield('relazioni','id'),':',$node.contentobject_id))}

{def  $comunicati_rel = fetch('ezfind', 'search', hash('class_id', array( 'comunicato' ),
                                                      'sort_by', hash( 'published', 'desc' ),
                                                      'limit', 10,
                                                      'filter', $filtri_comunicati
                                                      ))
      $web_tv_rel = fetch('ezfind', 'search', hash('class_id', array( 'web_tv' ),
                                                  'sort_by', hash( 'published', 'desc' ),
                                                  'limit', 3,
                                                  'filter', $filtri_web_tv
                                                  ))
      $audio_rel = fetch('ezfind', 'search', hash('class_id', array( 'audio' ),
                                                  'sort_by', hash( 'published', 'desc' ),
                                                  'limit', 3,
                                                  'filter', $filtri_audio
                                                  ))
      $pubblicazioni_rel = fetch('ezfind', 'search', hash('class_id', array( 'pubblicazione' ),
                                                          'sort_by', hash( 'published', 'desc' ),
                                                          'limit', 3,
                                                          'filter', $filtri_pubblicazioni
                                                          ))
}


{if or($comunicati_rel.SearchCount,
       $web_tv_rel.SearchCount,
       $audio_rel.SearchCount,
       $pubblicazioni_rel.SearchCount
)}


<div class="container">
  <div class="row">

    <div class="max-width">

      {if $comunicati_rel.SearchCount}
          <h3>Comunicati stampa</h3>
          <div class="carousel-container owl-carousel-contained">
            {include uri='design:atoms/owl_carousel.tpl' items=$comunicati_rel.SearchResult i_view='grid_item'}
          </div>
      {/if}

      {if $web_tv_rel.SearchCount}
        <h3>Video</h3>
        <div class="carousel-container owl-carousel-contained">
          {include uri='design:atoms/owl_carousel.tpl' items=$web_tv_rel.SearchResult i_view='grid_item'}
        </div>
      {/if}

      {if $audio_rel.SearchCount}
        <h3>Audio</h3>
        <div class="carousel-container owl-carousel-contained">
          {include uri='design:atoms/owl_carousel.tpl' items=$audio_rel.SearchResult i_view='grid_item'}
        </div>
      {/if}

      {if $pubblicazioni_rel.SearchCount}
        <h3>Pubblicazioni</h3>
        <div class="carousel-container owl-carousel-contained">
          {include uri='design:atoms/owl_carousel.tpl' items=$pubblicazioni_rel.SearchResult i_view='grid_item'}
        </div>
      {/if}

    </div>
  </div>

</div>

{/if}


{*
        {def $n=0}
        {if or($comunicati_rel.SearchCount, $web_tv_rel.SearchCount, $audio_rel.SearchCount, $pubblicazioni_rel.SearchCount )}
            {if $comunicati_rel.SearchCount}{set $n=$n|inc()}{/if}
            {if or($web_tv_rel.SearchCount, $audio_rel.SearchCount)}{set $n=$n|inc()}{/if}
            {if $pubblicazioni_rel.SearchCount}{set $n=$n|inc()}{/if}

            <div class="row">
                {if $comunicati_rel.SearchCount}
                    <div class="col-md-{12|div($n)}">
                        <h4>Notizie</h4>
                        <ul class="media-list">
                            {foreach $comunicati_rel.SearchResult as $item}
                                {node_view_gui view='media-list_item' content_node=$item}
                            {/foreach}
                        </ul>
                    </div>
                    {if or($web_tv_rel.SearchCount, $audio_rel.SearchCount)}
                        <div class="col-md-{12|div($n)}">
                            {if $web_tv_rel.SearchCount}
                                <h4>Video</h4>
                                {foreach $web_tv_rel.SearchResult as $item}
                                    {node_view_gui view='line' content_node=$item hide_intro=true()}
                                {/foreach}
                            {/if}
                            {if $audio_rel.SearchCount}
                                <h4>Audio</h4>
                                {foreach $audio_rel.SearchResult as $item}
                                    {node_view_gui view='line' content_node=$item hide_description=true()}
                                {/foreach}
                            {/if}
                        </div>
                    {/if}
                    {if $pubblicazioni_rel.SearchCount}
                        <div class="col-md-{12|div($n)}">
                            <h4>Pubblicazioni</h4>
                            {foreach $pubblicazioni_rel.SearchResult as $item}
                                {node_view_gui view='line' content_node=$item hide_abstract=true()}
                            {/foreach}
                        </div>
                    {/if}
                {/if}
            </div>

        {/if}
*}

{ezscript_require(array(
  'ezjsc::jquery',
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


<script>
{literal}
$(document).ready(function(){
  L.Icon.Default.imagePath = '{/literal}{'javascript/images'|ezdesign(no)}/{literal}';
  $.ftcSocieta.render({
    endpoint: "{/literal}{concat('ftc/data/coop/?id=',$node.contentobject_id)|ezurl(no)}{literal}",
    mainInfoContainer: 'coop_info',
    leftInfoContainer: 'coop_riferimenti',
    rightInfoContainer: 'coop_altridati',
    infoAttributiGenerici:{/literal}['{ezini( 'Settings', 'Generici', 'societa.ini' )|implode("','")}']{literal},
    infoAttributiRiferimenti:{/literal}['{ezini( 'Settings', 'Riferimenti', 'societa.ini' )|implode("','")}']{literal},
    infoAttributiAltridati:{/literal}['{ezini( 'Settings', 'Altridati', 'societa.ini' )|implode("','")}']{literal},
    mapContainer: 'coop_map',
    bilancioContainer: 'coop_bilancio',
    sociContainer:'coop_soci',
    lavoratoriContainer: 'coop_lavoratori',
    cdaContainer: 'coop_cda',
    sindacaleContainer: 'coop_sindacale',
    contentContainer: 'contents_data',
    garanzieContainer: 'coop_garanzie',
    raccoltaContainer: 'coop_raccolta_prestiti'
  });  
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    $(window).trigger("resize");}
  );  
});
{/literal}
</script>
</div>
{include uri='design:parts/load_website_toolbar.tpl'}