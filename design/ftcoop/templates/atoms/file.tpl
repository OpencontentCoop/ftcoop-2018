{set_defaults( hash(  
  'icon', '',
  'css_class', '',
	'label' , ''
))}

{if $file.contentobject_id}

<a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="{$css_class}">
  {if $icon}
    <i class="{$icon}"></i>
  {/if}
  {if $label}{$label}{else}{$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}{/if}
</a>

{/if}
