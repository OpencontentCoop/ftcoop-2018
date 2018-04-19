{ezpagedata_set('require_container', false())}
{if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}

  <section>
  <div class="container">
    <div class="row">
      <div class="max-width">
        {foreach $zones[0].blocks as $block}
          {if or( $block.valid_nodes|count(),
          and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
          and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
            {block_view_gui block=$block}
          {else}
            {skip}
          {/if}
        {/foreach}
        {*<img class="img-responsive" src={"images/header-image.jpg"|ezdesign()} alt="" />*}
      </div>

    </div>
  </div>
  </section>

{/if}

{if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
  <section class="alt3">
  <div class="container">

  {foreach $zones[1].blocks as $block}
    {if or( $block.valid_nodes|count(),
    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}


          <div class="row">
            <div class="max-width">
              {block_view_gui block=$block}
            </div>
          </div>


    {else}
      {skip}
    {/if}
  {/foreach}
  </div>
  </section>
{/if}



{if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
  <section>
  <div class="container">
  {foreach $zones[2].blocks as $block}
    {if or( $block.valid_nodes|count(),
    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}


          <div class="row">
            <div class="max-width">
                {block_view_gui block=$block}
            </div>
          </div>


    {else}
      {skip}
    {/if}
  {/foreach}
  </div>
  </section>
{/if}

