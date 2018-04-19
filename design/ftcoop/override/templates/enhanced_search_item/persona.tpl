<div class="enhanced-search-item well">

	<h3>
		<a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
		{*<span class="search-result-meta">{$node.class_name}</span>*}
	</h3>

	<div class="row">
		{if $node|has_attribute( 'image' )}
			<div class="col-xs-3">
				{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='large' css_class="media-object"}
			</div>
		{/if}
		<div class="col-xs-{if $node|has_attribute( 'image' )}9{else}12{/if}">

			{def $societa_ids = array()} {* variabile calcolata dal tpl incluso incarichi.tpl*}
			{include uri="design:parts/persona/incarichi.tpl" node=$node}

			<dl class="dl-horizontal">
				{if $node.object.parent_nodes|contains(ezini( 'NodiRilevanti', 'Dipendenti', 'ftcoop.ini' ))}
					{* la persona e' dipendente della federazione *}

					{if and(
					$node.object.parent_nodes|contains( ezini( 'NodiRilevanti', 'ConsiglioAmministrazione', 'ftcoop.ini' ) )|not(),
					$node.object.parent_nodes|contains( ezini( 'NodiRilevanti', 'Presidenza', 'ftcoop.ini' ) )|not(),
					$node.object.parent_nodes|contains( ezini( 'NodiRilevanti', 'Direzione', 'ftcoop.ini' ) )|not()
					)}
						{if $node.object.data_map.email.has_content}
							<dt>{$node.data_map.email.contentclass_attribute_name}</dt>
							<dd>{attribute_view_gui attribute=$node.data_map.email}</dd>
						{/if}
						{*if $node.object.data_map.telefono.has_content}
							<dt>{$node.data_map.telefono.contentclass_attribute_name}</dt>
							<dd>{attribute_view_gui attribute=$node.data_map.telefono}</dd>
						{/if*}
					{/if}
				{/if}

				{if $node.object.data_map.interno.has_content}
					<dt>{$node.data_map.interno.contentclass_attribute_name}</dt>
					<dd>{attribute_view_gui attribute=$node.data_map.interno}</dd>
				{/if}
				{if $node.object.data_map.fax.has_content}
					<dt>{$node.data_map.fax.contentclass_attribute_name}</dt>
					<dd>{attribute_view_gui attribute=$node.data_map.fax}</dd>
				{/if}
				{if $node.object.data_map.servizio.has_content}
					<dt>{$node.data_map.servizio.contentclass_attribute_name}</dt>
					<dd>{attribute_view_gui attribute=$node.data_map.servizio}</dd>
				{/if}
				{if $node.object.data_map.ufficio.has_content}
					<dt>{$node.data_map.ufficio.contentclass_attribute_name}</dt>
					<dd>{attribute_view_gui attribute=$node.data_map.ufficio}</dd>
				{/if}
				{if $node.object.data_map.ruolo.has_content}
					<dt>{$node.data_map.ruolo.contentclass_attribute_name}</dt>
					<dd>{attribute_view_gui attribute=$node.data_map.ruolo}</dd>
				{/if}

			</dl>


		</div>

	</div>

	<div class="text-right">
		<a class="btn btn-primary" href={$node.url_alias|ezurl()}>Vai alla scheda</a>
	</div>

</div>