{def $tipo_incarichi = fetch('content', 'list', hash('parent_node_id', ezini( 'NodiRilevanti', 'TipologiaRuoli', 'ftcoop.ini' ),
													  'sort_by', array('priority', 'asc')))
	 $incarichi = array()
	 $ruoli = fetch( 'content', 'reverse_related_objects', hash( 'object_id', $node.contentobject_id, 'attribute_identifier', 'ruolo/persona'))
	 $hidden_roles_array = array('267403')
}

{*
   hidden_roles_array
   mirko. richesta di Sara Perugini 01.10.2015: non visualizzare i ruoli di sindaco supplente
   267403 = SINDACO SUPPLENTE

*}

{if is_set( $societa_ids )|not}
  {def $societa_ids = array()}
{/if}

{def $show = false()}
{foreach $ruoli as $ruolo}
	{if not($hidden_roles_array|contains($ruolo.data_map.tipologia_di_ruolo.content.relation_list[0].contentobject_id))}
		{if $ruolo.can_read}
		    {set $show = true()}
		    {break}
		{/if}
	{/if}
{/foreach}

{if $show}
<div class="box">
{foreach $ruoli as $ruolo}
	{if not($hidden_roles_array|contains($ruolo.data_map.tipologia_di_ruolo.content.relation_list[0].contentobject_id))}
	{if $ruolo.can_read}
    <p>
	  <strong>{$ruolo.name}</strong>
	  {if $ruolo.data_map.nomina.has_content}
	  <small>Nomina del {attribute_view_gui attribute=$ruolo.data_map.nomina}</small>
	  {/if}
	  
	  {if is_set($ruolo.data_map.societa.content.relation_list)}
		  {foreach $ruolo.data_map.societa.content.relation_list as $item}
		  {if $item.in_trash|not()}
			  {if $item.contentobject_id|eq( ezini( 'OggettiRilevanti', 'Federazione', 'ftcoop.ini' )  )|not()}
				  {content_view_gui view=embed content_object=fetch( content, object, hash( object_id, $item.contentobject_id ) )}
			  {/if}
			  {set $societa_ids = $societa_ids|append($item.contentobject_id)}
		  {/if}
		  {/foreach}
	  {/if}
	</p>
	{/if}
{/if}
{/foreach}
</div>
{/if}
