{def $ruoli = ftcoop_incarici_persona($node.object)}

{if count($ruoli)|gt(0)}
<div class="box">
	Attualmente ricopre la carica di:
<ul class="list-unstyled">
{foreach $ruoli as $ruolo}	
	  <li>

	  	<strong>{attribute_view_gui attribute=$ruolo|attribute('tipologia_di_ruolo')}</strong>
		
		{if $ruolo|has_attribute('societa')}	
		  di {foreach $ruolo.data_map.societa.content.relation_list as $item}
		  {if $item.in_trash|not()}
			  {def $content_object=fetch( content, object, hash( object_id, $item.contentobject_id ) )
			  	   $name = ''}
			  {if $content_object|has_attribute('sigla')}
			  	{set $name = $content_object|attribute('sigla').content}
			  {else}
			  	{set $name = $content_object.name}
			  {/if}
			  	<a href="{$content_object.main_node.url_alias|ezurl('no')}">{$name|wash()}</a>
			  {undef $content_object $name}
		  {/if}
		  {/foreach}
		{/if}

		{if $ruolo|has_attribute('nomina')}
			<small>Nomina del {attribute_view_gui attribute=$ruolo|attribute('nomina')}</small>
		{/if}	 

	</li>
{/foreach}
</ul>
</div>
{/if}
