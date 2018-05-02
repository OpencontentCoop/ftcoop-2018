<div class="content-view-block upcoming-events box">
  {def
    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year =  $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')
    $today_ts = makedate( $curr_month, $curr_today, $curr_year )
    $upcoming_events = fetch( 'content', 'list',
                        hash( 'parent_node_id', $node.node_id,
                              'limit', 3,
                              'sort_by', array( 'attribute', true(), 'event/from_time'),
                              'main_node_only', true(),
                              'class_filter_type', 'include',
                              'class_filter_array', array( 'event' ),
                              'attribute_filter', array(
                              'or',
                              array( 'event/from_time', '>=', $today_ts ),
                              array( 'event/to_time', '>=', $today_ts ) ) ) ) }

{if $upcoming_events} 
  <div class="carousel-container owl-carousel-contained" data-items={$items_per_row} data-navstyle="dots" data-autoheight="true">
    {include uri='design:atoms/owl_carousel.tpl' items=$upcoming_events i_view='grid_item'}
  </div>

{/if}
</div>
