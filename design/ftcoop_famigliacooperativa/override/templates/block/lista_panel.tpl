{def $openpa= object_handler($block)}
{set_defaults( hash(
	'show_title', true(),	
  	'size', 2,
  	'link_top_title', true()
) )}

{if $items_per_row|le(6)}
  {set $size = $items_per_row}
{/if}

{def $col = 12|div($size)}

<div class="openpa-widget {$block.view} {if and(is_set($block.custom_attributes.color_style), $block.custom_attributes.color_style|ne(''))}color color-{$block.custom_attributes.color_style}{/if}">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title"><span>{$block.name|wash()}</span></h3>
    {/if}
    <div class="openpa-widget-content">
        <div class="row panels-container"> 
	    {foreach $openpa.content as $child }
	      <div class="col-md-{$col}">
	        {node_view_gui content_node=$child view=panel image_class=widemedium}
	      </div>
	      {delimiter modulo=$size}</div><div class="row panels-container">{/delimiter}
	    {/foreach}
	    </div>

	    {if and($openpa.root_node, $link_top_title|not(), $block.type|eq('Lista'))}
	      <p class="goto">
	        <a href="{$openpa.root_node.url_alias|ezurl(no)}">Vedi tutto <span></span></a>
	      </p>
	    {/if}
    </div>
</div>
