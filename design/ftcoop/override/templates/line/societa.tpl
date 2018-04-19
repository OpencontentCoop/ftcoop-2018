<a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}" class="line-item alt class-{$node.class_identifier} settore-{$node|attribute( 'settore' ).content.relation_list[0].contentobject_remote_id}">
  
  {* if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if*}


  <div class="line-item-content">
    <h4 class="line-item-heading">
      {$node.name|wash()}
	    {if $node.data_map.responsabile.has_content}
				<small>Responsabile: {attribute_view_gui attribute=$node.data_map.responsabile}</small>
	    {/if}
		</h4>

		{if or($node|has_attribute( 'attivita_e_servizi'),
	         $node|has_attribute( 'sigla'))}
			<div class="line-item-abstract">
			{if $node|has_attribute( 'attivita_e_servizi')}
					{attribute_view_gui attribute=$node.data_map.attivita_e_servizi}
			{/if}
			{if $node|has_attribute( 'sigla')}
					<strong>Sigla:</strong> {attribute_view_gui attribute=$node.data_map.sigla}
			{/if}
			</div>
		{/if}

	    <i class="far fa-2x fa-plus-square"></i>

  </div>
</a>