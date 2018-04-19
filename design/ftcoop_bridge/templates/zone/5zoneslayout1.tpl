<section>
<div class="zone-layout-{$zone_layout|downcase()}">

  <div class="row">
    <div class="max-width">



    <div class="row">
      <div class="col-md-12">

      {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
      {foreach $zones[0].blocks as $block}
          {include uri='design:parts/zone_block.tpl' zone=$zones[0]}
      {/foreach}
      {/if}

      </div>
    </div>

    
    <div class="row">
    

      <div class="col-md-4">

        {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
        {foreach $zones[1].blocks as $block}
            {include uri='design:parts/zone_block.tpl' zone=$zones[1]}
        {/foreach}
        {/if}

      </div>

      <div class="col-md-4">

        {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
        {foreach $zones[2].blocks as $block}
            {include uri='design:parts/zone_block.tpl' zone=$zones[2]}
        {/foreach}
        {/if}

      </div>


      <div class="col-md-4">


          {if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
          {foreach $zones[3].blocks as $block}
              {include uri='design:parts/zone_block.tpl' zone=$zones[3]}
          {/foreach}
          {/if}

      </div>
    
    </div>

    <div class="bottom-zone row">
    
      <div class="bottom col-md-12">

      {if and( is_set( $zones[4].blocks ), $zones[4].blocks|count() )}
      {foreach $zones[4].blocks as $block}
          {include uri='design:parts/zone_block.tpl' zone=$zones[4]}
      {/foreach}
      {/if}

      </div>
    </div>

    </div>
  </div>
</div>
</section>
