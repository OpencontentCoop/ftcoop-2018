{set_defaults( hash(
  'item', false(),
  'caption', false()
))}

{if $item}
<div class="banner">  
  {def $target_url = $item.data_map.url.content
	   $is_internal = false()}

  {if gt($item.data_map.internal_link.content)}
    {def $obj = fetch('content','object',hash('object_id',$item.data_map.internal_link.content.id))}
    {set $target_url = $obj.main_node.url_alias|ezurl(no)
		 $is_internal = true()}
    {*set $target_url = fetch('content','object',hash('object_id',$item.data_map.internal_link.content.id)).main_node.url_alias|ezurl(no)*}
  {/if}

  {if gt($target_url|count(),0)}
    <a class="figcontainer" href="{$target_url}" title="{$item.name|wash()}"{if $is_internal|not()} target="_blank"{/if}>
      <img src={$item.data_map.image.content['imagefull'].url|ezroot} class="img-responsive">
      {*if $caption}<div class="legend" >{$item.name|oc_shorten(28,'...')}</div>{/if*}
      {if $item.data_map.caption.has_content}
        <div class="legend" >{$item.data_map.caption.content|oc_shorten(28,'...')}</div>
      {/if}
    </a>
  {else}
  <span class="figcontainer">
    <img src={$item.data_map.image.content['imagefull'].url|ezroot} >
    {*if $caption}<div class="legend" >{$item.name|oc_shorten(28,'...')}</div>{/if*}
    {if $item.data_map.caption.has_content}
      <div class="legend" >{$item.data_map.caption.content|oc_shorten(28,'...')}</div>
    {/if}
  </span>
  {/if}

  {undef $target_url}
</div>
{/if}