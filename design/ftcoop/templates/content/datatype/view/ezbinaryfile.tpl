{set_defaults( hash(
     'css_class' , '',
     'show_icon' , false(),
     'icon_download' , 'fa fa-download',
     'file_name' , $attribute.content.original_filename
))}

{if is_set( $show_flip )|not()}
  {def $show_flip = false()}
{/if}

{if $attribute.has_content}
	{if $attribute.content}
    <a class="file {$css_class}" href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
      <span class="file-name">{$file_name}</span>
      <span class="file-meta">({$attribute.content.filesize|si( byte )})</span>
      {if $show_icon}
      <span class="file-download">
        <i class="{$icon_download}"></i>
      </span>
      {/if}
    </a>

	{*switch match=$icon}
		{case match='no'}
			<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
                {$attribute.content.original_filename} ({$attribute.content.filesize|si( byte )})
            </a>
		{/case}
		{case}
			<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
                {$attribute.content.mime_type|mimetype_icon( $icon_size, $icon_title )}
                {$attribute.content.original_filename} ({$attribute.content.filesize|si( byte )})               
            </a>
		{/case}
	{/switch*}
	{else}
    <div class="alert alert-warning">{'The file could not be found.'|i18n( 'design/ezwebin/view/ezbinaryfile' )}</div>
	{/if}
{/if}

{*if and( $show_flip, flip_exists( $attribute.contentobject_id ) )}

    {def $pageDim = get_page_dimensions( $attribute.contentobject_id, 'small' )
         $heigth = $pageDim[1]}
    
    {ezscript_require( array( 'megazine.js', 'swfaddress.js', 'swfobject.js' ) )}
    {ezcss_require( array('flip.css') )}
    
    <script type="text/javascript">
    {literal}
    swfobject.embedSWF(
        {/literal}{concat( 'flash/megazine/megazine.swf')|ezdesign}{literal},
        "megazine-{/literal}{$attribute.contentobject_id}{literal}",
        "100%",
        "{/literal}{$heigth}{literal}",
        "9.0.115",
        {/literal}{concat( 'flash/swfobject/expressInstall.swf')|ezdesign}{literal}, 
        {
            {/literal}xmlFile : "{concat( symlink_flip_dir(),'/',$attribute.contentobject_id,'/magazine_small.xml')}"{literal},  
            minScale : 1.0,
            maxScale : 1.0,
            top: "20"
        },
        {
        bgcolor : "#fff", 
        wmode : "transparent", 
        allowFullscreen : "true" 
        },
        {id : "megazine-{/literal}{$attribute.contentobject_id}{literal}"}
    );
    {/literal}
    </script>
    <div id="megazine-{$attribute.contentobject_id}"></div>
    {undef $pageDim $heigth}
{/if*}
