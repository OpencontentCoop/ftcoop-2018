{set_defaults(hash('show_title', true(), 'link_top_title', true()))}

{def $valid_node = cond( is_set( $block.valid_nodes[0] ), $block.valid_nodes[0], false() )
     $show_link = true()}

{if and( $valid_node|not(), is_set( $block.custom_attributes.source ) )}
    {set $valid_node = fetch( content, node, hash( node_id, $block.custom_attributes.source ) )}
{/if}

{if $valid_node|not()}
    {set $valid_node = fetch( content, node, hash( node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )
    $show_link = false()}
{/if}

{def $calendarDataDay = fetch( openpa, calendario_eventi, hash( 'calendar', $valid_node, 'params', hash( 'interval', 'PT1439M' ) ) )}
{if and(is_set($block.custom_attributes.tab_title),$block.custom_attributes.tab_title|ne(''))}
    {def $calendarDataOther = fetch( openpa, calendario_eventi, hash( 'calendar', $valid_node, 'params', $block.custom_attributes ) )}
{else}
    {def $calendarDataOther = false()}
{/if}
{*debug-log var=$calendarDataDay.fetch_parameters msg='Blocco eventi fetch oggi'*}

{def $day_events = $calendarDataDay.events
     $day_events_count = $calendarDataDay.search_count
     $prossimi = array()
     $prossimi_count = 0}

{if $calendarDataOther}
    {*debug-log var=$calendarDataOther.fetch_parameters msg='Blocco eventi fetch secondo tab'*}
    {set $prossimi = $calendarDataOther.events
         $prossimi_count = $calendarDataOther.search_count}
{/if}

{if and( $prossimi_count|eq(0), $day_events_count|eq(0) )}

    {if fetch( 'user', 'has_access_to', hash( 'module', 'openpa', 'function', 'editor_tools' ) )}
        {editor_warning( "Nessun evento in programma" )}
    {/if}

{else}

    <div id="{$block.id}" class="openpa-widget {$block.view} color">

      <div class="events_wide_wrapper">
          <div class="row" style="margin: 10px 0">

            {if and( $show_title, $block.name|ne('') )}
                <div class="col-xs-12 col-sm-4">
                  <h3 class="openpa-widget-title" style="margin: 0">{if and($valid_node, $link_top_title)}<a href={$valid_node.url_alias|ezurl()}>{/if}{$block.name|wash()}{if and($valid_node, $link_top_title)}</a>{/if}</h3>
                </div>
              {/if}

              <div class="col-xs-12 col-sm-8">
                  {if or( $day_events_count|gt(0), $prossimi_count|gt(0) )}
                      <ul role="tablist" class="list-inline text-right">
                          {if $day_events_count|ne(0)}
                              <li class="eventi-oggi">
                                  <a href="#oggi" data-toggle="tab">
                                      <i class="fa fa-clock"></i> <span class="hidden-xs">Oggi</span>
                                  </a>
                              </li>
                          {/if}
                          {if $prossimi_count|gt(0)}
                              <li class="eventi-futuri eventi-{$block.custom_attributes.tab_title|slugize}{if $day_events_count|eq(0)} hide{/if}">
                                  <a href="#{$block.custom_attributes.tab_title|slugize}" data-toggle="tab">
                                      <i class="fa fa-calendar"></i> <span class="hidden-xs">{$block.custom_attributes.tab_title}</span>
                                  </a>
                              </li>
                          {/if}

                          {if $show_link}
                              <li class="jump-to-calendar">
                                  <a href="{$valid_node.url_alias|ezurl(no)}" title="Vai al calendario">
                                      <i class="fa fa-calendar"></i> <span class="hidden-xs">Vai al calendario</span>
                                  </a>
                              </li>
                          {/if}
                      </ul>
                  {/if}
              </div>
          </div>
      </div>

      {def $col = 4 $modulo = 3}
      {if $block.view|ends_with('_wide')}
        {set $col = 3 $modulo = 4}
      {/if}

      <div class="events_wide_tabs_wrapper">
        {if $day_events_count|ne(0)}
            <div class="openpa-widget-content {if $block.view|ends_with('_wide')}container-fluid{/if}" id="oggi">
                <div class="row panels-container">
                    {foreach $day_events as $i => $child max 10}
                    <div class="col-sm-{$col}">
                        {node_view_gui content_node=$child.node view=panel image_class=agid_panel show_image=false() event=$child}
                    </div>
                    {delimiter modulo=$modulo}</div><div class="row panels-container {if $block.view|ends_with('_wide')}container-fluid{/if}">{/delimiter}
                    {/foreach}
                </div>
            </div>
        {/if}

        {if $prossimi_count|gt(0)}
            <div id="{$block.custom_attributes.tab_title|slugize}" class="lista_masonry openpa-widget-content u-layout-centerContent u-cf">
                <div class="row panels-container {if $block.view|ends_with('_wide')}container-fluid{/if}">
                    {foreach $prossimi as $i => $child max 10}
                    <div class="col-md-{$col}">
                        {node_view_gui content_node=$child.node view=panel image_class=agid_panel show_image=false() event=$child}
                    </div>
                    {delimiter modulo=$modulo}</div><div class="row panels-container {if $block.view|ends_with('_wide')}container-fluid{/if}">{/delimiter}
                    {/foreach}
                </div>
            </div>
        {/if}
      </div>
    </div>

    <script>
        {literal}
        $(document).ready(function() {
            $("#{/literal}{$block.id}{literal}").tabs({
                collapsible: true,
                beforeActivate: function( event, ui ) {
                    if (ui.newTab.hasClass('jump-to-calendar')){
                        window.location.href = ui.newTab.find('a').attr('href');
                        return false;
                    }
                }
            });
        });
        {/literal}
    </script>



{/if}

