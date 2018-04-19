{if $pagedata.node_id|eq(2)}

    {def $now = currentdate()|datetime( 'custom' , '%cZ' )
         $search_popup = fetch(ezfind, search, hash(
            'subtree_array', array(appini( 'NodeSettings' , 'PopupNodeId')),
            'class_id', array( 'popup' ),
            'limit', 1 ,
            'sort_by', hash('published', 'asc' ),
            'filter', array('and',
                concat(solr_field('from_time', 'date'),':[* TO ', $now , ']'),
                concat(solr_field('to_time', 'date'),':[', $now , ' TO *]')
            )
         ))}

    {if $search_popup.SearchResult}

        {def $popup = $search_popup.SearchResult[0]}
        {def $popup_link = ''}

        {if $popup|has_attribute( 'internal_link' )}
            {def $ext = fetch( 'content' , 'node' , hash( 'node_id' , $popup|attribute( 'internal_link' ).content.relation_list[0].node_id))}
            {set $popup_link = $ext.url_alias|ezurl(no)}
        {elseif $popup|has_attribute( 'external_link' )}
            {set $popup_link = $popup|attribute( 'external_link' ).content}
        {/if}


        {ezscript_require(array( 'ezjsc::jquery', 'jquery.cookie.js' , 'bootstrap/modal.js') )}
        <div id="popup">
            <div>
                <img src="{$popup|attribute('image').content[original].url|ezroot(no)}" alt=""/>
            </div>
        </div>
        <style>
            {literal}

            #popup {
                display: none;
                height: 100%;
                width: 100%;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.7);
                z-index: 20000;
            }

            #popup div {
                display: block;
                height: 90%;
                margin: 2% auto;
                width: 90%
            }

            #popup a {
                diplay: inline-block;
            }

            #popup img {
                cursor: pointer;
                display: block;
                height: auto;
                margin: 0 auto;
                max-height: 100%;
                max-width: 100%
            }

            #popup div:after {
                content: 'CHIUDI';
                color: #777;
                cursor: pointer;
                display: block;
                margin: 4px auto;
                text-align: center;
            }

            {/literal}

        </style>
        <script type="text/javascript">

            var maxShow = {$popup|attribute( 'display_mode' ).data_text} ||
            0;
            //var maxShow= 0; /* con 0 mostra sempre il popup */
            var link = "{$popup_link}";

            {literal}
            $(document).ready(function () {

                var visits = jQuery.cookie('visits') || 0;
                visits++;

                var today = new Date();
                var midnight = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 23, 59, 59);
                jQuery.cookie('visits', visits, {expires: midnight, path: '/'});

                //console.debug(jQuery.cookie('visits'));


                if ((maxShow == 0) || (jQuery.cookie('visits') <= maxShow)) {
                    //$('#welcome-popup').modal();

                    $('#popup').css('height', $(document).outerWidth() + 'px');
                    $('#popup').fadeIn();

                    if (link != '') {
                        $('#popup img').click(function () {
                            window.location.href = link;
                        });
                    }

                    $('#popup').click(function () {
                        $(this).fadeOut(); //this will hide the fullscreen div if you click away from the image.
                    });
                }
            });
            {/literal}
        </script>
    {/if}
{/if}
