<style>@import url("https://fonts.googleapis.com/css?family=Lato:300,400,700,900");</style>
{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{def $app_style = concat('app', appini('SiteSettings', 'StyleSuffix', ''), '.css')}

{if $load_css_file_list}
{ezcss_load( array(
        'fontawesome/css/fontawesome-all.css',
        $app_style,
        'leaflet/leaflet.0.7.2.css',
        'debug.css',
        'websitetoolbar.css',
        "plugins/blueimp/blueimp-gallery.css",
        'plugins/table-calendar.css',
        'leaflet/leaflet.css',
        'leaflet/map.css',
        'leaflet/MarkerCluster.css',
        'leaflet/MarkerCluster.Default.css',
        'dataTables.bootstrap.css',
        'fuelux.css',
        ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
        ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ),
        'trasparenza.css'
    ),
    'all', 'text/css', 'stylesheet' )}
{else}
{ezcss_load( array(
        'fontawesome/css/fontawesome-all.css',
        $app_style,
        'leaflet/leaflet.0.7.2.css',
        'debug.css',
        'websitetoolbar.css',
        "plugins/blueimp/blueimp-gallery.css",
        'plugins/table-calendar.css',
        'leaflet/leaflet.css',
        'leaflet/map.css',
        'leaflet/MarkerCluster.css',
        'leaflet/MarkerCluster.Default.css',
        'dataTables.bootstrap.css',
        'fuelux.css',
        'trasparenza.css'
    ),
    'all', 'text/css', 'stylesheet' )}
{/if}