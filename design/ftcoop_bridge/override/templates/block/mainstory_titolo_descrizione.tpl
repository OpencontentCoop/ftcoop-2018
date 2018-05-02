{def $valid_node = $block.valid_nodes[0]}

<div class="content-view-block block-type-mainstory block-view-{$block.view}">
    <h2><a href="{$valid_node.url_alias|ezurl(no)}">{$valid_node.name|wash()}</a></h2>

    {if $valid_node|has_attribute('description')}
        {attribute_view_gui attribute=$valid_node.data_map.description}
    {elseif $valid_node|has_attribute('intro')}
        {attribute_view_gui attribute=$valid_node.data_map.intro}
    {/if}
</div>

{undef $valid_node}
