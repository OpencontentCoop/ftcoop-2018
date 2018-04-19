{def $nl_archive_node_id=ezini('NodeSettings','NewsletterNodeId','app.ini')}

{def $number_of_items = 3
		$status='archive'
		$children=fetch( 'content', 'list', hash( 'parent_node_id', $nl_archive_node_id,
			'sort_by', $node.sort_array,
			'limit', $number_of_items,
			'offset', $view_parameters.offset,
			'sort_by', array( 'modified', false() ),
			'objectname_filter', $view_parameters.namefilter,
			'extended_attribute_filter',
			hash( 'id', 'CjwNewsletterEditionFilter',
			'params', hash( 'status', $status ) )
		))}

{if $children|count()}
		{def $issue = null}
		<ul class="list-unstyled list-newsletter">
			{foreach $children as $child}
				{set $issue = $child.data_map.newsletter_edition.content.edition_send_current}
				<li class="newsletter-item">
					<a target="_blank" href="{concat('/newsletter/archive/',$issue.hash)}">{$child.name|wash}</a>
					<span class="newsletter-item-date text-muted"> (inviata il {$issue.mailqueue_process_finished|l10n(shortdate)})</span>
				</li>
			{/foreach}
		</ul>

{/if}

{undef}