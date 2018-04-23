<div id="toolbar" class="hidden-xs" style="display: none">
    <div id="ezwt">
        <div id="ezwt-content" class="float-break" style="height: 42px;line-height: 42px;">
            {include uri='design:parts/websitetoolbar/logo.tpl'}
            <span style="font-size: 1.3em;font-style: italic;color: #ccc;">Attendere il caricamento della toolbar...</span>
            {include uri='design:parts/websitetoolbar/help.tpl'}
        </div>
    </div>    
</div>
{ezscript_require(array('ezjsc::jquery', 'plugins/chosen.jquery.js'))}
<script>{literal}
    $(document).ready(function(){
        $.get(UriPrefix+'ftc/loadwt/'+CurrentNode, function (data) {
            if (data.length > 0){
                $('#toolbar').show().html(data).find("#ezwt-create").chosen({width:'300px'});
                var body = document.body, ezwt = document.getElementById( 'ezwt' );
                if ( !ezwt ) return;
                if ( body.className.indexOf('ie6') !== -1 ) return;

                if ( body.className )
                    body.className += ' floating-wt';
                else
                    body.className = 'floating-wt';

                // Set padding on header / body based on height of toolbar
                var page = document.getElementById( 'page' )
                if ( page )
                    page.getElementsByTagName('div')[0].style.paddingTop = ezwt.offsetHeight + 'px';
                else
                    body.style.paddingTop = ezwt.offsetHeight + 'px';
            }
        });
    });
{/literal}</script>
