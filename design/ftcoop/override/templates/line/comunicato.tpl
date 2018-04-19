{def $files = array( 'pubblicazione', 'file_pdf', 'file' )}
<div class="content-view-line line-item class-{$node.class_identifier} row">

  
  {if $node|has_attribute( 'image' )}
	  <div class="col-md-4">
	  <a href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
		{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='imagefull' css_class="line-item-image"}
    </a>
	  </div>
	  {*else}
	{def $first_child_img = fetch( 'children', hash( 'parent_node_id', $node.node_id,
													'sort_by', $node.sort_array,
													'class_filter_type', 'include',
													'class_filter_array', array( 'image'),
													'limit', 1 ) )}
	{if and( $first_child_img|count()|gt(0), is_set($first_child_img[0].data_map.image), $first_child_img[0].data_map.file.has_content )}
	  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
		  {attribute_view_gui attribute=$first_child_img[0].data_map.image href=false() image_class='imagefull' css_class="media-object"}
	  </a>
	{/if*}
  {/if}
  
  <div class="line-item-content col-md-{if $node|has_attribute( 'image' )}8{else}12{/if}">
		<p class="date">{$node.object.published|l10n( date )}</p>
		<h4 class="line-item-title">
			{if and( $files|contains($node.object.class_identifier), is_set($node.data_map.file), $node.data_map.file.has_content )}
				{attribute_view_gui attribute=$node.data_map.file icon_size=normal}
			{elseif is_set( $node.url_alias )}
				<a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
			{else}
				{$node.name|wash()}
			{/if}
		</h4>

	{if $node|has_abstract()}
	  {$node|abstract()|oc_shorten(150)}
	{/if}

	{*if and( $files|contains($node.object.class_identifier)|not(), is_set($node.data_map.file), $node.data_map.file.has_content )}
	<p><strong>{attribute_view_gui attribute=$node.data_map.file}</strong></p>
	{/if*}

	{*if is_set($node.data_map.attivita_e_servizi)}
		{if $node.data_map.attivita_e_servizi.has_content}
		  <div class="attribute-intro">
			{attribute_view_gui attribute=$node.data_map.attivita_e_servizi}
		  </div>
		{/if}
	{/if}
	{if is_set($node.data_map.sigla)}
		{if $node.data_map.sigla.has_content}
		  <div class="attribute-intro">
			<strong>Sigla:</strong> {attribute_view_gui attribute=$node.data_map.sigla}
		  </div>
		{/if}
	{/if*}
    </div>
</div>
{undef}
