{set_defaults(hash(
	'i_class','imagefull'
))}

<div class="grid-item {if $node|has_attribute( 'image' )|not}text-only{/if}">

  {if $node|has_attribute( 'image' )}
		<div class="grid-item-image">
      {attribute_view_gui attribute=$node|attribute( 'image' ) image_class=$i_class href=$node.url_alias|ezurl(no)}
		</div>
  {/if}

	<div class="grid-item-content">
		<h3 class="grid-item-title"><a href={$node.url_alias|ezurl()}>{$node.object.name|wash()}</a></h3>

    {if $node|has_abstract()}
			<div class="grid-item-abstract">
        {$node|abstract()|oc_shorten(150)}
			</div>
    {/if}

		<p class="goto"><a href="{$node.url_alias|ezurl(no)}">Scopri di +</a></p>

	</div>

</div>

{unset_defaults(array('i_class'))}