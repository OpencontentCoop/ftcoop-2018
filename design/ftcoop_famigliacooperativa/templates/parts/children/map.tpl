{ezscript_require( array(
  'leaflet/leaflet.0.7.2.js',
  'ezjsc::jquery',
  'leaflet/leaflet.markercluster.js',
  'leaflet/Leaflet.MakiMarkers.js',
) )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'MarkerCluster.css', 'MarkerCluster.Default.css' ) )}

{set_defaults(hash(
  'height', 600,
  'map_type', 'osm',
  'class_identifiers', array(),
  'items_per_row', 1,
  'show_list', true()
))}

{set $height = $height|fix_dimension()}

<div class="row children-map">
  <div class="{if $show_list}{if $items_per_row|eq(1)}col-md-12{else}col-xs-12 col-sm-8{/if}{else}col-md-12{/if}">
	<div id="map-{$node.node_id}" style="height: {$height}px; width: 100%"></div>

	<script>	
	{run-once}
	{literal}
	var loadMap = function(mapId,markersId,geoJson){
	  //var tiles = L.tileLayer('//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
	  var tiles = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'});
	  var map = L.map(mapId).addLayer(tiles);
	  map.scrollWheelZoom.disable();
	  var markers = L.markerClusterGroup();
	  var markerMap = {};
	  $.getJSON(geoJson, function(data) {
		$.each(data.features, function(i,v){
		  var markerListItem = $("<li data-id='"+v.id+"'><a href='"+v.properties.url+"'><small>"+v.properties.className+"</small> "+v.properties.name+"</a></li>");
		  markerListItem.bind('click',markerListClick);
		  $('#'+markersId).append(markerListItem);
		});
		var geoJsonLayer = L.geoJson(data, { pointToLayer: function (feature, latlng) {
		  var customIcon = L.MakiMarkers.icon({icon: "star", color: "#f00", size: "l"});
		  var marker = L.marker(latlng, {icon: customIcon});
		  markerMap[feature.id] = marker;
		  return marker;
		} });
		markers.addLayer(geoJsonLayer);
		map.addLayer(markers);
		map.fitBounds(markers.getBounds());
	  });
	  markers.on('click', function (a) {
		$.getJSON("{/literal}{'/openpa/data/map_markers'|ezurl(no)}{literal}?contentType=marker&view=panel&id="+a.layer.feature.id, function(data) {
		  var popup = new L.Popup({maxHeight:360});
		  popup.setLatLng(a.layer.getLatLng());
		  popup.setContent(data.content);
		  map.openPopup(popup);
		});
	  });
	  markerListClick = function(e){
		var id = $(e.currentTarget).data('id');
		var m = markerMap[id];
		markers.zoomToShowLayer(m, function() { m.fire('click');});
		{/literal}{if $items_per_row|gt(1)}{literal}
		if ($('.visible-xs').first().is(':visible')){
    	  $(this).parents('.children-map-markers').hide();
    	}
    	{/literal}{/if}{literal}
		e.preventDefault();
	  }
	  $('.toggle-markers').on('click', function(){
    	$(this).next().show();
      });      
	};
	{/literal}
	{/run-once}
	$(document).ready(function(){ldelim}
		loadMap('map-{$node.node_id}', 'markers-{$node.node_id}', "{concat('/openpa/data/map_markers'|ezurl(no), '?parentNode=',$node.node_id, '&classIdentifiers=', $class_identifiers|implode(',') )}&contentType=geojson");	
	{rdelim});
	</script>	
  </div>

  {if $show_list}
  {if $items_per_row|gt(1)}<button class="toggle-markers btn btn-default btn-lg visible-xs"><i class="fa fa-map-marker"></i></button>{/if}
  <div class="children-map-markers {if $items_per_row|eq(1)}col-md-12{else}col-xs-12 col-sm-4{/if}">
    <ul id="markers-{$node.node_id}" class="list-markers-text list-unstyled {if $items_per_row|eq(1)}list-inline{/if}" {if $items_per_row|gt(1)} style="height: {$height}px;overflow-y: auto"{/if}></ul>
  </div>
  {/if}

</div>

