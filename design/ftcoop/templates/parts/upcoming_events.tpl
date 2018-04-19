{*
  events_node = the source event_calendar node
  number = the number of upcoming events to show
  title = the title to assign (if no title is provided, events_node.name is going to be used
*}

{set_defaults(hash(
  'show_title', true(),
  'number', 5
))}


{def
    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year =  $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')
    $today_ts = makedate( $curr_month, $curr_today, $curr_year )
    $upcoming_events = fetch( 'content', 'list',
                        hash( 'parent_node_id', $events_node.node_id,
                              'limit', $number,
                              'sort_by', array( 'attribute', true(), 'event/from_time'),
                              'main_node_only', true(),
                              'class_filter_type', 'include',
                              'class_filter_array', array( 'event' ),
                              'attribute_filter', array(
                              'or',
                              array( 'event/from_time', '>=', $today_ts ),
                              array( 'event/to_time', '>=', $today_ts ) ) ) ) }

{if $upcoming_events}

  <h3><a href={$events_node.url_alias|ezurl()}>{if $title}{$title}{else}{$events_node.name|wash()}{/if}</a> {*<a class="btn btn-default pull-right" href={$events_node.url_alias|ezurl()}>Vedi tutti gli eventi</a>*}</h3>
  <div class="carousel-container owl-carousel-contained">
    {include uri='design:atoms/owl_carousel.tpl' items=$upcoming_events i_view='grid_item'}
  </div>

{/if}

{undef}