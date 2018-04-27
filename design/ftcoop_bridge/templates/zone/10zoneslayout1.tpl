{def $add_max_width = true()}
{if is_set($has_navigation)}
	{set $add_max_width = cond($has_navigation|eq(true()), false(), true())}
{/if}

<div class="row">
  <div class="{if $add_max_width}max-width{/if}">
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

<div class="row">
  <div class="{if $add_max_width}max-width{/if}">	
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
	  <div class="col-md-4">
		{if and( is_set( $zones[4].blocks ), $zones[4].blocks|count() )}
		{foreach $zones[4].blocks as $block}
			{include uri='design:parts/zone_block.tpl' zone=$zones[4]}
		{/foreach}
		{/if}
	  </div>
  </div>
</div>


<div class="row">
  <div class="{if $add_max_width}max-width{/if}">	
	  <div class="col-md-6">
		{if and( is_set( $zones[5].blocks ), $zones[5].blocks|count() )}
		{foreach $zones[5].blocks as $block}
			{include uri='design:parts/zone_block.tpl' zone=$zones[5]}
		{/foreach}
		{/if}
	  </div>
	  <div class="col-md-6">
		{if and( is_set( $zones[6].blocks ), $zones[6].blocks|count() )}
		{foreach $zones[6].blocks as $block}
			{include uri='design:parts/zone_block.tpl' zone=$zones[6]}
		{/foreach}
		{/if}
	  </div>
  </div>
</div>

<div class="row">
  <div class="{if $add_max_width}max-width{/if}">		
	  <div class="col-md-4">
		{if and( is_set( $zones[7].blocks ), $zones[7].blocks|count() )}
		{foreach $zones[7].blocks as $block}
			{include uri='design:parts/zone_block.tpl' zone=$zones[7]}
		{/foreach}
		{/if}
	  </div>
	  <div class="col-md-4">
		{if and( is_set( $zones[8].blocks ), $zones[8].blocks|count() )}
		{foreach $zones[8].blocks as $block}
			{include uri='design:parts/zone_block.tpl' zone=$zones[8]}
		{/foreach}
		{/if}
	  </div>
	  <div class="col-md-4">
		{if and( is_set( $zones[9].blocks ), $zones[9].blocks|count() )}
		{foreach $zones[9].blocks as $block}
			{include uri='design:parts/zone_block.tpl' zone=$zones[9]}
		{/foreach}
		{/if}
	  </div>
  </div>
</div>

