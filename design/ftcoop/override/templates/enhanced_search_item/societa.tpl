<div class="enhanced-search-item well">

	<h3>
		<a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
		{*<span class="search-result-meta">{$node.class_name}</span>*}
	</h3>

	<div class="row">
		<div class="col-md-6">
			<div class="box transparent">
				{include uri='design:parts/societa/main_info.tpl'}
			</div>
		</div>
		<div class="col-md-6">
			<div id="coop_map" style="width:100%;height:380px"></div>
			{*include uri="design:parts/societa/mappa_sedi.tpl" node=$node tipo_di_settore=$tipo_di_settore*}
		</div>
	</div>


	<div class="text-right">
		<a class="btn btn-primary" href={$node.url_alias|ezurl()}>Vai alla scheda</a>
	</div>

</div>

{ezscript_require(array(
'ezjsc::jquery',
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
      $.ftcSocieta.renderMapOnly({
          endpoint: "{/literal}{concat('ftc/data/coop/?id=',$node.contentobject_id)|ezurl(no)}{literal}",
          mapContainer: 'coop_map'
      });
  });
  {/literal}
</script>