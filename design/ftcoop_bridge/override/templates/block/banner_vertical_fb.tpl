{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}
  <div class="content-view-block banner-view-block block-view-{$block.view} row">
    {foreach $valid_nodes as $i => $valid_node max 1}
      <div class="col-xs-6">
        {include uri='design:atoms/banner.tpl' item=$valid_node caption=true()}
      </div>
    {/foreach}
      <div class="col-xs-6">
        <div class="banner">
          <div class="bannerfb">
            <a href="#" id="fb"></a>
            <a href="#" id="tw"></a>
          </div>
        </div>
      </div>
  </div>
{/if}
{undef $valid_nodes}