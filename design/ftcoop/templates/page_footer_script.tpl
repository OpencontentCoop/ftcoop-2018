<script src={'javascript/bootstrap/tab.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/dropdown.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/collapse.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/affix.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/alert.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/button.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/carousel.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/modal.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/tooltip.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/popover.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/scrollspy.js'|ezdesign()}></script>
<script src={'javascript/bootstrap/transition.js'|ezdesign()}></script>


<script src={'javascript/jquery.matchHeight.js'|ezdesign()}></script>
<script type="text/javascript">
  {literal}
$(document).ready(function() {
    $('.same-height').matchHeight();
});
{/literal}
 </script>

{*
<script type="text/javascript">
    {literal}
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-35281946-1', 'auto');
    ga('send', 'pageview');
    {/literal}
</script>
*}

{* Script per il tracking dei click sui banner *}
<script type="text/javascript">
    {literal}
    $(document).ready(function() {
        $(".banner a").each(function() {
            var href = $(this).attr("href");
            var target = $(this).attr("target");
            var text = $(this).attr("title");
            $(this).click(function(event) { // when someone clicks these links
                event.preventDefault(); // don't open the link yet
                //_gaq.push(["_trackEvent", "Banner", "Clicked", text, , false]); // create a custom event
                if (href.indexOf("{/literal}{'/'|ezurl( 'no', 'full' )}{literal}")==-1) {
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
