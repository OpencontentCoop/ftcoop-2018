{def $add_max_width = true()}
{if is_set($has_navigation)}
  {set $add_max_width = cond($has_navigation|eq(true()), false(), true())}
{/if}
{if $add_max_width}<section>{/if}
  <div class="{if $add_max_width}max-width{/if}">

<div class="row">
  <div class="col-md-12">    
    {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
    {foreach $zones[0].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[0] items_per_row=3}
    {/foreach}
    {/if}    
  </div>
</div>

<div class="row">    
  <div class="col-md-4">    
    {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
    {foreach $zones[1].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[1] items_per_row=1}
    {/foreach}
    {/if}
  </div>
  <div class="col-md-4">        
    {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
    {foreach $zones[2].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[2] items_per_row=1}
    {/foreach}
    {/if}
  </div>
  <div class="col-md-4">            
    {if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
    {foreach $zones[3].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[3] items_per_row=1}
    {/foreach}
    {/if}
  </div>
</div>

<div class="row">
  <div class="col-md-6">    
    {if and( is_set( $zones[4].blocks ), $zones[4].blocks|count() )}
    {foreach $zones[4].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[4] items_per_row=1}
    {/foreach}
    {/if}
  </div>  
  
  <div class="col-md-6">        
    {if and( is_set( $zones[5].blocks ), $zones[5].blocks|count() )}
    {foreach $zones[5].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[5] items_per_row=1}
    {/foreach}
    {/if}
  </div>
</div>

</div>
{if $add_max_width}</section>{/if}
