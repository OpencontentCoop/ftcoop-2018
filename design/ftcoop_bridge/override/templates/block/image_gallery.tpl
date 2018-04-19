{if is_set( $block.custom_attributes.parent_node_id)}

{def $limit = cond( is_set( $block.custom_attributes.limit ), $block.custom_attributes.limit, 9 )
		 $hide_link = cond( is_set( $block.custom_attributes.hide_link ), $block.custom_attributes.hide_link, 0 )
		 $block_title = $block.name
}

	{def $gallery_node = fetch('content' , 'node' , hash('node_id' , $block.custom_attributes.parent_node_id))
			 $images = fetch('content' , 'list',
									hash('parent_node_id' , $gallery_node.node_id,
										   'class_filter_type' , 'include',
											 'class_filter_array' , array( 'image' ),
			                 'limit' , $limit,
		                   'sort_by' , $gallery_node.sort_array
	))}

	{if $images}
		{include uri='design:atoms/gallery.tpl' items=$images mode=$block.view title=$block_title}

		{if $hide_link|not()}
			<div class="goto">
				<a href={$gallery_node.url_alias|ezurl()}>vedi tutte le immagini</a>
			</div>
		{/if}

	{/if}


{/if}