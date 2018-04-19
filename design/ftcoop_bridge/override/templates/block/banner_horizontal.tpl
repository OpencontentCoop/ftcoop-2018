{def $valid_nodes = $block.valid_nodes}

{if $valid_nodes}
  <div class="content-view-block banner-view-block banner-view-{$block.view}">

    {if $block.view|eq( 'banner_horizontal_bg_title' )}
      <h3>{$block.name}</h3>
    {/if}

  {foreach $valid_nodes as $i => $valid_node}
      {include uri='design:atoms/banner.tpl' item=$valid_node}
  {/foreach}
  </div>
  <br />
{/if}
{undef $valid_nodes}
