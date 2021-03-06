{def $add_max_width = true()}
{if is_set($has_navigation)}
    {set $add_max_width = cond($has_navigation|eq(true()), false(), true())}
{/if}
{if $add_max_width}<section>{/if}
<div class="{if $add_max_width}max-width{/if}">

    <div class="row">
        <div class="col-md-8">

            {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
                {foreach $zones[0].blocks as $block}
                    {if or( $block.valid_nodes|count(),
                    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
                    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
                        {block_view_gui block=$block items_per_row=2}
                    {else}
                        {skip}
                    {/if}
                {/foreach}
            {/if}

            <div class="row">
                <div class="col-md-6">
                    {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
                        {foreach $zones[2].blocks as $block}
                            {if or( $block.valid_nodes|count(),
                            and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
                            and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
                                {block_view_gui block=$block items_per_row=1}
                            {else}
                                {skip}
                            {/if}
                        {/foreach}
                    {/if}
                </div>
                <div class="col-md-6">
                    {if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
                        {foreach $zones[3].blocks as $block}
                            {if or( $block.valid_nodes|count(),
                            and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
                            and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
                                {block_view_gui block=$block items_per_row=1}
                            {else}
                                {skip}
                            {/if}
                        {/foreach}
                    {/if}
                </div>
            </div>

        </div>

        <div class="col-md-4">

            {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
                {foreach $zones[1].blocks as $block}
                    {if or( $block.valid_nodes|count(),
                    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
                    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
                        {block_view_gui block=$block items_per_row=1}
                    {else}
                        {skip}
                    {/if}
                {/foreach}
            {/if}
        </div>

    </div>
</div>
{if $add_max_width}</section>{/if}
