<style>@import url("https://fonts.googleapis.com/css?family=Lato:300,400,700,900");</style>
{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{if $load_css_file_list}
    {ezcss_load( array(        
        'plugins/owl-carousel/owl.carousel.min.css',
        'plugins/owl-carousel/owl.theme.default.css',
        'fontawesome/css/fontawesome-all.css',
        'app.css',
        ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
        ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' ),
        'debug.css',
        'websitetoolbar.css'
    ) )}
{else}
    {ezcss_load( array(
        'app.css',
        'debug.css',
        'websitetoolbar.css'
    ) )}
{/if}
