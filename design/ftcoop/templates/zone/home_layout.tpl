{ezpagedata_set('has_subheader', true())}
{ezpagedata_set('require_container', false())}
{if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}

  <div class="sub-header bg-primary">
    <div class="container-fluid">

      <div class="col-md-11 col-md-offset-1 col-xs-offset-0 col-sm-offset-0 showcase">
        {foreach $zones[0].blocks as $block}
          {if or( $block.valid_nodes|count(),
          and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
          and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
            {block_view_gui block=$block is_subheader=true()}
          {else}
            {skip}
          {/if}
        {/foreach}        
      </div>

    </div>
  </div>

{else}

  {include uri='design:page_subheader.tpl'}

{/if}

<div class="breadcrumb-container container-fluid hidden-xs">
  <div class="row">
    <div class="bg-primary col-md-3 same-height">
    </div>
    <div class="col-md-9 same-height" style="min-height: 53px;">
      {* if and($pagedata.show_path, $pagedata.is_edit|not)}
        {if ne($current_node_id,2)}
          {include uri='design:breadcrumb.tpl'}
        {/if}
      {/if*}
    </div>
  </div>
</div>


{if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
  {foreach $zones[1].blocks as $block}
    {if or( $block.valid_nodes|count(),
    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}

    <section>
      <div class="container">
        <div class="row">
          <div class="max-width">

          {block_view_gui block=$block}
          </div>
        </div>
      </div>
    </section>

    {else}
      {skip}
    {/if}
  {/foreach}
{/if}



{if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
  {foreach $zones[2].blocks as $block}
    {if or( $block.valid_nodes|count(),
    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}

      <section style="margin-bottom: 0;padding-bottom: 0;">
        <div class="container-fluid">

              {block_view_gui block=$block}

        </div>
      </section>

    {else}
      {skip}
    {/if}
  {/foreach}
{/if}

{include uri='design:parts/cooperative-widget.tpl'}

{if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
  {foreach $zones[3].blocks as $block}
    {if or( $block.valid_nodes|count(),
    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}

      <section>
        <div class="container">
          <div class="row">
            <div class="max-width">

              {block_view_gui block=$block}
            </div>
          </div>
        </div>
      </section>

    {else}
      {skip}
    {/if}
  {/foreach}
{/if}
