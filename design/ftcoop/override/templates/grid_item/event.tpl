{set_defaults(hash(
	'i_class','imagefull'
))}

{def $curr_ts = currentdate()
 		 $curr_today = $curr_ts|datetime( custom, '%j')
		 $curr_year =  $curr_ts|datetime( custom, '%Y')
		 $curr_month = $curr_ts|datetime( custom, '%n')
		 $today_ts = makedate( $curr_month, $curr_today, $curr_year )
		 $old_event = false()
}

{if $node|attribute( 'from_time').content.timestamp|lt($today_ts)}
	{set $old_event = true()}
{/if}

<div class="grid-item {*if $node|has_attribute( 'image' )|not}text-only{/if*}" {if $old_event}style="opacity:0.5"{/if}>

  {* if $node|has_attribute( 'image' )}
		<div class="grid-item-image">
      {attribute_view_gui attribute=$node|attribute( 'image' ) image_class=$i_class href=$node.url_alias|ezurl(no)}
		</div>
  {/if*}

	<div class="grid-item-content">

		<span class="grid-item-date">
			{include uri='design:parts/event/dates.tpl' item=$node}
		</span>

    {if $node|has_attribute( 'luogo' )}
      {def $luogo = fetch('content', 'object', hash( 'object_id', $node|attribute( 'luogo' ).content.relation_list[0].contentobject_id))}
			<i class="fa fa-map-marker"></i> <a href={concat($node.parent.url_alias, '/(attribute', $node|attribute( 'luogo').contentclassattribute_id , ')/', $luogo.name|wash() , '/(class_id)/', $node.object.contentclass_id )|ezurl()}>{$luogo.name|wash()}</a>
    {/if}

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