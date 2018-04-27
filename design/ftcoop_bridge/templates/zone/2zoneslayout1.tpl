{def $add_max_width = true()}
{if is_set($has_navigation)}
    {set $add_max_width = cond($has_navigation|eq(true()), false(), true())}
{/if}

<div class="{if $add_max_width}max-width{/if}">

  <div class="row">
    <div class="col-md-8">
      {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
      {foreach $zones[0].blocks as $block}
          {include uri='design:parts/zone_block.tpl' zone=$zones[0]}
      {/foreach}
      {/if}
    </div>

    <div class="col-md-4">
      {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
      {foreach $zones[1].blocks as $block}
          {include uri='design:parts/zone_block.tpl' zone=$zones[1]}
      {/foreach}
      {/if}
    </div>
  </div>

</div>

