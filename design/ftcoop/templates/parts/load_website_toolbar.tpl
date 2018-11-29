{if $current_user.is_logged_in}
    <script>{literal}
    $(document).ready(function(){
        $('#toolbar').load($.ez.url+'call/openpaajax::loadWebsiteToolbar::{/literal}{$node.node_id}{literal}', null, function(response){
            //load chosen in class list
            $("#ezwt-create").chosen({width:"250px"});
            //load editor tool button
            var $editorTools = $("#editor_tools");            
            var help = $("#ezwt-help");
            help.removeClass('hide');                
            if ( $editorTools.length > 0 ){                                
                if ( help.data('show-editor') == 0 ) $editorTools.addClass('hide');                
            }
            help.find('a').on( 'click', function(e){                                        
                if ($editorTools.hasClass('hide')){
                    $editorTools.removeClass('hide'); 
                    $editorTools.removeAttr('style');
                }else{
                    $editorTools.addClass('hide');
                }
                $.ez.setPreference( 'show_editor', $editorTools.is(':hidden') == false ? 1 : 0 );
                e.preventDefault();
            });
            //floating toolbar
            var body = document.body, ezwt = document.getElementById( 'ezwt-content' );
            if ( !ezwt ) return;
            if ( body.className.indexOf('ie6') !== -1 ) return;
            if ( body.className )
                body.className += ' floating-wt';
            else
                body.className = 'floating-wt';
            body.style.paddingTop = '50px'; //ezwt.offsetHeight/2 + 'px';
        });
    });
    {/literal}</script>
{/if}
