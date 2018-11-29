{def $openpa = object_handler($block)
     $bg_class = 'u-background-grey-20'
     $count = $openpa.content|count()
     $size = 2}

{if and(is_set($block.custom_attributes.color_style), $block.custom_attributes.color_style|ne(''))}
    {set $bg_class = 'u-background-white'}
{/if}
{set_defaults(hash(
  'link_top_title', true(),
  'show_title', true()
))}

{for 4 to 2 as $counter}
    {if $count|mod($counter)|eq(0)}
        {set $size = $counter}
        {break}
    {/if}
{/for}

{if $items_per_row|le(6)}
  {set $size = $items_per_row}
{/if}

{def $col = 12|div($size)}

{if count($openpa.content)|gt(0)}
<div class="openpa-widget {$block.view} {if and(is_set($block.custom_attributes.color_style), $block.custom_attributes.color_style|ne(''))}color color-{$block.custom_attributes.color_style}{/if}">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title">{if and($openpa.root_node, $link_top_title)}<a href={$openpa.root_node.url_alias|ezurl()}>{else}<span>{/if}{$block.name|wash()}{if and($openpa.root_node, $link_top_title)}</a>{else}</span>{/if}</h3>
    {/if}
    <div class="openpa-widget-content">
        <div class="row">
            {foreach $openpa.content as $item}
                {def $openpa_item = object_handler($item)}
                <div class="col-md-{$col}">
                    <a class="{$bg_class} pull-left {if $item|has_attribute('image')|not} text-center{/if}" href="{$openpa_item.content_link.full_link}" style="height: 100px; overflow: hidden;margin-bottom: 30px;width: 100%">
                        {if $item|has_attribute('image')}
                            <img src="{$item|attribute('image').content['agid_square'].full_path|ezroot(no)}"
                                 alt="Immagine decorativa per il contenuto {$item.name|wash()}"
                                 class="pull-left" height="100" />
                        {/if}
                        <span class="lista_banner-text">{$item.name|oc_shorten(120)}</span>
                    </a>
                </div>
                {undef $openpa_item}
              {delimiter modulo=$size}</div><div class="row">{/delimiter}
            {/foreach}
        </div>
    </div>
    {if and($openpa.root_node, $link_top_title|not(), $block.type|eq('Lista'))}
      <p class="goto">
        <a href="{$openpa.root_node.url_alias|ezurl(no)}">Vedi tutto <span></span></a>
      </p>
    {/if}
</div>
{/if}
