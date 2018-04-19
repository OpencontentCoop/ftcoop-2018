{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}
  <div class="content-view-block banner-view-block banner-view-{$block.view}">
    <div class="row">
    {foreach $valid_nodes as $i => $valid_node max 2}
      <div class="col-xs-6">		
		{include uri='design:atoms/banner.tpl' item=$valid_node caption=true()}		
	  </div>
    {/foreach}
    </div>
  </div>
{/if}
{undef $valid_nodes}