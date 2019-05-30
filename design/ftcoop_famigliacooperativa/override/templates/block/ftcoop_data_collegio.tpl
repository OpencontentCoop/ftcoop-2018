{def $openpa= object_handler($block)}
{set_defaults(hash('show_title', true(), 'items_per_row', 1))}

<div class="openpa-widget {$block.view} {if and(is_set($block.custom_attributes.color_style), $block.custom_attributes.color_style|ne(''))}color color-{$block.custom_attributes.color_style}{/if}">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title"><span>{$block.name|wash()}</span></h3>
    {/if}
    <div class="openpa-widget-content">
        <div data-ftcoop="{$block.view}"></div>
    </div>
</div>

{unset_defaults(array('show_title','items_per_row'))}
