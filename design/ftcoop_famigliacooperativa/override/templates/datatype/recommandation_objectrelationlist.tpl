{set_defaults( hash(
  'col-width', 6,
  'modulo', 2
))}

{if $attribute.has_content}
<h2><i class="fa fa-heart"></i> {$attribute.contentclass_attribute_name|wash()}</h2>    
  <div class="content-view-children">  
    <div class="row panels-container"> 
    {foreach $attribute.content.relation_list as $related_item }
      {def $child = fetch(content, node, hash(node_id, $related_item.node_id))}
      <div class="col-md-{$col-width}">
        {node_view_gui content_node=$child view=panel image_class=widemedium}
      </div>
      {undef $child}
      {delimiter modulo=$modulo}</div><div class="row panels-container">{/delimiter}  	  
    {/foreach}
    </div>
  </div>
{/if}
