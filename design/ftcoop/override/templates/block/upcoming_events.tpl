{def $object_node = fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}
{def $limit = $block.custom_attributes.number}

{if $object_node}
  {include uri='design:parts/upcoming_events.tpl' events_node=$object_node number=$limit title=$block.name}
{/if}