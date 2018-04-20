{if and(fetch(user, current_user).is_logged_in, fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) ))}
    <div id="toolbar" class="hidden-xs">
        <div id="ezwt">
            <div id="ezwt-content" class="float-break" style="height: 42px;line-height: 42px;">
                {include uri='design:parts/websitetoolbar/logo.tpl'}
                <span style="font-size: 1.3em;font-style: italic;color: #ccc;">Attendere il caricamento della toolbar...</span>
                {include uri='design:parts/websitetoolbar/help.tpl'}
            </div>
        </div>
        {include uri='design:parts/websitetoolbar/floating_toolbar.tpl'}
    </div>
    {ezscript_require(array('ezjsc::jquery', 'plugins/chosen.jquery.js'))}
    <script>{literal}
        $(document).ready(function(){
            $.get(UriPrefix+'ftc/loadwt/'+CurrentNode, function (data) {
                $('#toolbar').html(data).find("#ezwt-create").chosen({width:'300px'});
            });
        });
    {/literal}</script>
{/if}
