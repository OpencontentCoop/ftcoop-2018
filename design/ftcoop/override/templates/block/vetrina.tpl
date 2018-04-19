{def $valid_nodes = $block.valid_nodes}
{if $valid_nodes}

{set_defaults( hash(
  'wide_class', 'imagefullwide'
))}


  <div class="row">

    {foreach $valid_nodes as $k => $vn}
      <div class="col-sm-6" style="
          background: transparent url({$vn|attribute('image').content[$wide_class].url|ezroot(no)});
          background-position: 40% 40%;
          background-attachment:fixed;
          ">
        <div class="same-height vetrina">
          <div class="col-sm-10 col-md-8{if $k|eq(0)} col-sm-offset-2 col-md-offset-4{/if}">
          {node_view_gui content_node=$vn view=vetrina_item css_class=$css_class}
          </div>
        </div>
      </div>
    {/foreach}
  </div>

{/if}

{undef $valid_nodes}