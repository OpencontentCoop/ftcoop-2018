{ezscript_require(array(
    'bootstrap/tab.js',
    'bootstrap/dropdown.js',
    'bootstrap/collapse.js',
    'bootstrap/affix.js',
    'bootstrap/alert.js',
    'bootstrap/button.js',
    'bootstrap/carousel.js',
    'bootstrap/modal.js',
    'bootstrap/tooltip.js',
    'bootstrap/popover.js',
    'bootstrap/scrollspy.js',
    'bootstrap/transition.js',
    'jquery.matchHeight.js'
))}


<script type="text/javascript">
    {literal}
    $(document).ready(function() {
        $('.same-height').matchHeight();
        $(".banner a").each(function() {
            var href = $(this).attr("href");
            var target = $(this).attr("target");
            var text = $(this).attr("title");
            $(this).click(function(event) { // when someone clicks these links
                event.preventDefault(); // don't open the link yet
                if (typeof ga !== "undefined" && href.indexOf("{/literal}{'/'|ezurl( 'no', 'full' )}{literal}")==-1) {
                    ga('send', 'event', 'Banner', 'click', text);
                }
                setTimeout(function() { // now wait 300 milliseconds...
                    window.open(href,(!target?"_self":target)); // ...and open the link as usual
                },300);
            });
        });
    });
    {/literal}
</script>
