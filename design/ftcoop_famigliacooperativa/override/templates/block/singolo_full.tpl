{def $valid_node = $block.valid_nodes[0]}
{if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}
<div class="widget_title">
        <h3>{node_view_gui content_node=$valid_node view=text_linked text=$block.name}</h3>
    </div>
<div class="widget">
	<div class=" {$block.view}">
	    <div class="widget_content">	      
        {node_view_gui content_node=$valid_node view=accordion_content image_class=large}        
        <p class="link">
          <a href="{object_handler($valid_node).content_link.full_link}" title="{$valid_node.name|wash()}">Leggi</a>
        </p>
	    </div>
	</div>
</div>
{if is_set($block.custom_attributes.color_style)}</div>{/if}