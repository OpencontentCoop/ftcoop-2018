{if is_set($pagedata)|not()}{def $pagedata = openpapagedata()}{else}{set $pagedata = openpapagedata()}{/if}
<footer class="hidden-print" style="background:none;padding:0 0 60px">
  
  <div class="container">
    <div class="row">
      <div class="col-md-{if ftcoop_pagedata().require_container}6{else}4 col-md-offset-1{/if}">
        <img class="footer-logo" src={"images/logo-blu.png"|ezdesign()} class="img-responsive"  alt="" title="" />
        {def $footer_notes = fetch( 'openpa', 'footer_notes' )}
        {if $footer_notes}
            {attribute_view_gui attribute=$footer_notes}
        {/if}

        <ul class="list-unstyled" style="margin-bottom: 30px">
          {if is_set( $pagedata.contacts.indirizzo )}
          <li><a href="http://maps.google.com/maps?q={$pagedata.contacts.indirizzo}"><i class="fa fa-building"></i> {$pagedata.contacts.indirizzo}</a></li>
          {/if}
          {if is_set( $pagedata.contacts.email )}
          <li><a href="mailto:{$pagedata.contacts.email}"><i class="fa fa-envelope"></i> {$pagedata.contacts.email}</a></li>
          {/if}
          {if is_set( $pagedata.contacts.pec )}
          <li><a href="mailto:{$pagedata.contacts.pec}"><i class="fa fa-envelope"></i> {$pagedata.contacts.pec}</a></li>
          {/if}
          {if is_set( $pagedata.contacts.telefono )}
          <li><a href="tel:{$pagedata.contacts.telefono}"><i class="fa fa-phone-square"></i> {$pagedata.contacts.telefono}</a></li>
          {/if}
          {if is_set( $pagedata.contacts.fax )}
          <li><a href="tel:{$pagedata.contacts.fax}"><i class="fa fa-fax"></i> {$pagedata.contacts.fax}</a></li>
          {/if}
        </ul>


        <div class="social-buttons">

          {if is_set( $pagedata.contacts.facebook )}
          <a href="{$pagedata.contacts.facebook}" title="Vai alla pagina Facebook">
            <span class="fa-stack fa-2x">
              <i class="far fa-circle fa-stack-2x"></i>
              <i class="fab fa-facebook-square fa-stack-1x" ></i>
            </span>
          </a>
          {/if}

          {if is_set( $pagedata.contacts.twitter )}
          <a href="{$pagedata.contacts.twitter}" title="Vai al profilo Twitter">
           <span class="fa-stack fa-2x">
              <i class="far fa-circle fa-stack-2x"></i>
              <i class="fab fa-twitter fa-stack-1x" ></i>
           </span>
          </a>
          {/if}

          {if is_set( $pagedata.contacts.google )}
          <a href="{$pagedata.contacts.google}" title="Vai alla pagina Google plus">
            <span class="fa-stack fa-2x">
                <i class="far fa-circle fa-stack-2x"></i>
                <i class="fab fa-google-plus-g fa-stack-1x" ></i>
            </span>
          </a>
          {/if}

          {if is_set( $pagedata.contacts.instagram )}
          <a href="{$pagedata.contacts.instagram}" title="Vai al profilo Twitter">
           <span class="fa-stack fa-2x">
              <i class="far fa-circle fa-stack-2x"></i>
              <i class="fab fa-instagram fa-stack-1x" ></i>
           </span>
          </a>
          {/if}

        </div>

      </div>

      <div class="col-md-6">
        <div id="footer-map" 
             data-geo="{'/openpa/data/map_markers'|ezurl(no)}?parentNode=2&classIdentifiers=punto_vendita&contentType=geojson" 
             style="width: 100%; height: 450px; box-shadow: 0 5px 60px -5px rgba(0, 0, 0, 0.8);">          
        </div>
      <script>
        {literal}        
        var map = L.map('footer-map').addLayer(
          L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'})
        );
        map.scrollWheelZoom.disable();
        var featureGroup = L.featureGroup().addTo(map);
        $.getJSON($('#footer-map').data('geo'), function(json) {
          var geoJSONLayer = L.geoJson(json, {
              pointToLayer: function(feature, latlng) {
                var customIcon = L.MakiMarkers.icon({icon: "grocery", color: '#003C86'});
                return new L.Marker(latlng,  {icon: customIcon});
              },
              onEachFeature: function(feature, layer) {
                var popupDefault = '<h4><a href="' + feature.properties.url + '" target="_blank">';
                popupDefault += feature.properties.name;
                popupDefault += '</a></h4>';
                var popup = new L.Popup({maxHeight: 360});
                popup.setContent(popupDefault);
                layer.bindPopup(popup);
              }
          });
          geoJSONLayer.eachLayer(function(l){            
              featureGroup.addLayer(l);
          });
          if (featureGroup.getLayers().length > 0) {
              map.fitBounds(featureGroup.getBounds());
          }
        });
        {/literal}
        {if and($pagedata.contacts.latitudine|ne(''), $pagedata.contacts.longitudine|ne('') )}
          featureGroup.addLayer(new L.Marker([{$pagedata.contacts.latitudine}, {$pagedata.contacts.longitudine}], {ldelim}icon: L.MakiMarkers.icon({ldelim}icon: "commercial", size: "l", color: '#FF0000'{rdelim}){rdelim}));
          map.fitBounds(featureGroup.getBounds());
        {/if}        
      </script>

      </div>
    </div>
  </div>  
</footer>

