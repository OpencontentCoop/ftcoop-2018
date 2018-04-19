{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

{if $load_css_file_list}
    {ezcss_load( array(
        'debug.css',
        'websitetoolbar.css',
        'plugins/owl-carousel/owl.carousel.min.css',
        'plugins/owl-carousel/owl.theme.default.css',
        'fontawesome/css/fontawesome-all.css',
        'app.css',
        ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ),
        ezini( 'StylesheetSettings', 'FrontendCSSFileList', 'design.ini' )
    ) )}
{else}
    {ezcss_load( array(
        'app.css',
        'debug.css',
        'websitetoolbar.css'
    ) )}
{/if}

{*todo chiedere a Mirko i sorgenti*}
<style>
    @media (min-width: 1570px) {ldelim} .container {ldelim} width: 1500px; {rdelim} {rdelim}
</style>
