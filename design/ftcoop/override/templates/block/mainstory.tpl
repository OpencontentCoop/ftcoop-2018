{def $validnode = $block.valid_nodes[0]}
{if $validnode}

  {switch match=$block.view}

    {case match="title_image_abstract"}

      {node_view_gui view="mainstory_item"
                         content_node=$validnode
                         title=$block.name
                         show_image=true()
      }

    {/case}

    {case match="title_image"}

      {node_view_gui view="mainstory_item"
                         content_node=$validnode
                         title=$block.name
                         show_image=true()
                         show_abstract=false()
      }

    {/case}

    {case match="highlight"}
      {node_view_gui view="mainstory_item"
                         content_node=$validnode
                         title=$block.name
                         highlight=true()
      }

    {/case}

    {case}

      {node_view_gui view="mainstory_item"
                         content_node=$validnode
                         title=$block.name
      }

    {/case}

  {/switch}
{/if}


{*def $image = false()}
{if $validnode|has_attribute( 'image' ) }
    {set $image =  $validnode|attribute( 'image' )}
{else}
    {def $related = fetch( 'content', 'related_objects', hash( 'object_id', $validnode.contentobject_id ))}
    {foreach $related as $rel}
    {if $rel.class_identifier|eq( 'image' )}
        {set $image = $rel|attribute( 'image' )}
    {/if}
    {/foreach}
{/if}

{*<div class="content-view-block block-view-{$block.view} carousel-inner carousel">*}
{*
<div class="content-view-block block-view-{$block.view}">
  <h2><a href="{$validnode.url_alias|ezurl(no)}">{$validnode.name|wash()}</a></h2>
  {if $image}
	  {attribute_view_gui attribute=$image image_class=appini( 'ContentViewBlock', 'DefaultImageClass', 'wide' ) fluid=true() href=$validnode.url_alias}	  
  {/if}
  {if $valid_node|has_abstract()}
    {$valid_node|abstract()}
    <p class="text-right"><a href="{$valid_node.url_alias|ezurl(no)}">Leggi tutto &raquo;</a></p>
  {/if}

  {*
  {if $image}
	  {attribute_view_gui attribute=$image image_class=appini( 'ContentViewBlock', 'DefaultImageClass', 'wide' ) fluid=true() href=$validnode.url_alias}
  {/if}
    <div class="carousel-caption">
        <h3><a href="{$validnode.url_alias|ezurl(no)}">{$validnode.name|wash()}</a></h3>
    </div>
  *}{*
</div>

{undef*}