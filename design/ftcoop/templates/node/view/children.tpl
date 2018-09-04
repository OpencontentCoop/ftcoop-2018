{if is_set($item_view)|not()}
	{def $item_view = 'line'}
{/if}
{if is_set($node.data_map.show_children)}
	{if $node.data_map.show_children.data_int}
		{if $node|has_attribute('children_view')}
			{foreach $node|attribute('children_view').class_content.options as $option}
				{if $node|attribute('children_view').content|contains($option.id)}
					{include uri=concat('design:parts/children/', $option.name|downcase|explode(' ')|implode('_'), '.tpl') view=$item_view view_parameters=$view_parameters}
					{break}
				{/if}
			{/foreach}
		{else}
			{include uri='design:parts/children.tpl' view=$item_view view_parameters=$view_parameters}
		{/if}
	{/if}
{else}
	{include uri='design:parts/children.tpl' view=$item_view view_parameters=$view_parameters}
{/if}