{set_defaults( hash('items_per_row', 1))}
{if or( $block.valid_nodes|count(),
    and( is_set( $block.custom_attributes), $block.custom_attributes|count() ),
    and( eq( ezini( $block.type, 'ManualAddingOfItems', 'block.ini' ), 'disabled' ), ezini_hasvariable( $block.type, 'FetchClass', 'block.ini' )|not ) )}
    {block_view_gui block=$block items_per_row=$items_per_row}
{/if}
