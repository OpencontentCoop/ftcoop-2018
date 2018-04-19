{set_defaults(hash(
  'i_class','imagefull_cutwide'
))}

<div class="griditem">

  {if $node|has_attribute( 'immagini' )}
    {def $images = array()}
    {foreach $node.data_map.immagini.content.relation_list as $relation_item}
      {set $images = $images|append(fetch('content','node',hash('node_id',$relation_item.node_id)))}
    {/foreach}
    {if $images}
      {include uri='design:atoms/image.tpl' item=$images[0] image_class=$i_class href=$node.url_alias|ezurl(no)}
    {/if}
  {/if}

  {if $node.data_map.tags.has_content}
    <span class="griditem-tags tags">
      {attribute_view_gui attribute=$node.data_map.tags}
    </span>
  {/if}

  <span class="griditem-meta meta">
    {*$node.object.published|l10n('shortdate')*}
    <span class="date"><i class="fa fa-calendar-o"></i> {$node.object.published|l10n( 'shortdate' )} </span>
    {if $node|has_attribute( 'redattore' )}
      {include uri='design:atoms/redattore.tpl' attribute=$node.data_map.redattore show_contacts=false()}
    {/if}
  </span>

  <h3 class="griditem-title"><a href={$node.url_alias|ezurl()}>{$node.object.name|wash()}</a></h3>

  {if $node.data_map.intro.has_content}
    <div class="griditem-abstract abstract">
      {attribute_view_gui attribute=$node.data_map.intro}
    </div>
  {/if}


</div>