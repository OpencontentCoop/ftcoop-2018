<style>@import url("https://fonts.googleapis.com/css?family=Lato:300,400,700,900");</style>
{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{def $app_style = concat('app', appini('SiteSettings', 'StyleSuffix', ''), '.css')}

{if $load_css_file_list}
    {ezcss_load( array(        
        'plugins/owl-carousel/owl.carousel.min.css',
        'plugins/owl-carousel/owl.theme.default.css',
        'plugins/blueimp/blueimp-gallery.css',
        'fontawesome/css/fontawesome-all.css',
        $app_style,
        ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
        ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ),
        'debug.css',
        'websitetoolbar.css'
    ) )}
{else}
    {ezcss_load( array(
        $app_style,
        'debug.css',
        'websitetoolbar.css'
    ) )}
{/if}
