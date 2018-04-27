{def $object_node = fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}

<div class="content-view-block news-container block-view-{$block.view}">
  {if $block.name}
    <h4 class="block-title">{$block.name|wash()}</h4>
  {/if}

  {def $items = fetch( 'content', 'list',
      hash( 'parent_node_id',    $block.custom_attributes.node_id,
      'limit', 10,
      'depth',3,
      'sort_by',        array( 'published', false() ),
      'class_filter_type',  'include',
      'class_filter_array', array( 'comunicato' )  )
    )}
  <ul class="list-unstyled">
  {foreach $items as $item}
    <li class="news-item">
      <small class="news-item-meta">{$item.object.published|l10n(date)}</small><br/>
      <a href={$item.url_alias|ezurl()}}>{$item.name|wash}</a>
    </li>
  {/foreach}
  </ul>
  <div class="goto">
    <a  href={$object_node.url_alias|ezurl()}>vai a {$block.name|wash()}</a>
  </div>


</div>
