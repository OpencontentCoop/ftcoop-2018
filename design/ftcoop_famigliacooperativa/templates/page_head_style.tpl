<style>@import url("https://fonts.googleapis.com/css?family=Lato:300,400,700,900");</style>
{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{def $style_suffix = appini('SiteSettings', 'StyleSuffix', '')}
{def $app_style = concat('app', $style_suffix, '.css')}

{if $load_css_file_list}
{ezcss_load( array(
        'fontawesome/css/fontawesome-all.css',
        'leaflet/leaflet.0.7.2.css',
        'debug.css',
        'websitetoolbar.css',
        'owl.carousel.min.css',
        "plugins/blueimp/blueimp-gallery.css",
        'plugins/table-calendar.css',
        'leaflet/leaflet.css',
        'leaflet/map.css',
        'leaflet/MarkerCluster.css',
        'leaflet/MarkerCluster.Default.css',
        'controls-audio.css',
        'dataTables.bootstrap.css',
        'fuelux.css',
        ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
        ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ),
        'facet_search.css',
        $app_style
    ),
    'all', 'text/css', 'stylesheet' )}
{else}
{ezcss_load( array(
        'fontawesome/css/fontawesome-all.css',
        'leaflet/leaflet.0.7.2.css',
        'debug.css',
        'websitetoolbar.css',
        'owl.carousel.min.css',
        "plugins/blueimp/blueimp-gallery.css",
        'plugins/table-calendar.css',
        'leaflet/leaflet.css',
        'leaflet/map.css',
        'leaflet/MarkerCluster.css',
        'leaflet/MarkerCluster.Default.css',
        'controls-audio.css',
        'dataTables.bootstrap.css',
        'fuelux.css',
        'facet_search.css',
        $app_style
    ),
    'all', 'text/css', 'stylesheet' )}
{/if}
