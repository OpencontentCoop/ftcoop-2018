{def $reverse_related_objects_count = fetch(content, reverse_related_objects_count, hash(object_id, $node.contentobject_id, all_relations, true()))}
{if $reverse_related_objects_count|gt(0)}
	{def $col-width = 4 $modulo = 3}
	{if $reverse_related_objects_count|lt(3)}
		{def $col-width = 6 $modulo = 2}
	{/if}
	{def $page_limit = 12
		 $reverse_related_objects = fetch(content, reverse_related_objects, hash(object_id, $node.contentobject_id, all_relations, true(), limit, $page_limit, offset, $view_parameters.offset))}
	<section class="page-section-wide u-background-grey-20"> 
	  <div class="container">
        <div class="row">
		  <h2><i class="fa fa-star"></i> Ti potrebbe interessare</h2>    
		  <div class="content-view-children">  
		    <div class="row panels-container"> 
		    {foreach $reverse_related_objects as $child }
		      <div class="col-md-{$col-width}">
		        {node_view_gui content_node=$child.main_node view=panel image_class=widemedium}
		      </div>
		      {delimiter modulo=$modulo}</div><div class="row panels-container">{/delimiter}
		    {/foreach}
		    </div>
		  </div>
		</div>
	  </div>
	</section>

	  {include name=navigator
			   uri='design:navigator/google.tpl'
			   page_uri=$node.url_alias
			   item_count=$reverse_related_objects_count
			   view_parameters=$view_parameters
			   item_limit=$page_limit}

	{undef $reverse_related_objects $page_limit $col-width $modulo}
{/if}
{undef $reverse_related_objects_count}