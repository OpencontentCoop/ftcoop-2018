{* Load JavaScript dependencys + JavaScriptList *}
{ezscript_load( array(
    'ezjsc::jquery',
    'jquery.cookie.js',
    'bootstrap/modal.js',
    'plugins/owl-carousel/owl.carousel.min.js',
    "plugins/blueimp/jquery.blueimp-gallery.min.js" ,
    "owl-carousel-activation.js",
    'plugins/chosen.jquery.js',
    ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ),
    ezini( 'JavaScriptSettings', 'FrontendJavaScriptList', 'design.ini' )
))}

<!--[if lt IE 9]>
<script type="text/javascript" src={"javascript/respond.js"|ezdesign()} ></script>
<![endif]-->
