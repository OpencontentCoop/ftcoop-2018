{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}
  <div class="content-view-block banner-view-block block-view-{$block.view} row">
    {foreach $valid_nodes as $i => $valid_node max 4}
      <div class="col-xs-3">
		{include uri='design:atoms/banner.tpl' item=$valid_node caption=true()}		
	  </div>
    {/foreach}
  </div>
{/if}
{undef $valid_nodes}