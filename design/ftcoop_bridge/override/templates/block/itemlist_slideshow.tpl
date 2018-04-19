{def $zones = $#node.data_map.page.content.zones
$this_zone = false()
$append_zone_name = ''
$ratio = 2}

{foreach $zones as $zone}
  {foreach $zone.blocks as $b}
    {if $b.id|eq( $block.id )}
      {set $this_zone = $zone}
      {break}
    {/if}
  {/foreach}
{/foreach}

{if $this_zone.zone_identifier|eq( 'top' )}
  {set $append_zone_name = '_top'
  $ratio = 3}
{/if}

{def $valid_nodes = $block.valid_nodes}

<!-- BLOCK: START -->
<div class="block-type-rotate slideshow">
{ezscript_require( array( 'ezjsc::jquery', 'jquery.randomize.js', 'jquery.newsticker.js' ) )}
  <script type="text/javascript">{literal}
  $(function() { $('.rotate ul').newsticker( 4000 );});
  {/literal}</script>
  <div class="rotate">
    <ul>
    {foreach $valid_nodes as $item}

      {node_view_gui view=block_itemlist_slideshow_item content_node=$item}

    {/foreach}
    </ul>
  </div>
  <ul class="indicator{cond( count($valid_nodes)|eq(1), ' disabled', '' )}">
  {for 1 to $valid_nodes|count as $i}
    <li{cond( $i|eq( 1 ), ' class="selected"', '' )}><span class="hide">{$i}</span></li>
  {/for}
  </ul>
</div>
<!-- BLOCK: END -->

{undef $valid_nodes}