<div class="content-view-line line-item class-{$node.class_identifier} row">
  {if $node|has_attribute( 'image' )}
  <div class="col-sm-2">
      {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='large' css_class="line-item-image"}
  </div>
  {/if}
  <div class="line-item-content col-sm-{if $node|has_attribute( 'image' )}10{else}12{/if}">
    <h4 class="line-item-title">{$node.name|wash()}</h4>
    {if $node|has_attribute( 'file' ) or $node|has_attribute( 'issuu' )}
    <p class="text-right">
      {if $node|has_attribute( 'issuu' )}
      <a href="{$node|attribute( 'issuu' ).content}" class="btn btn-info" target="_blank">
        Visualizza su ISSUU
      </a>
      {/if}
      {if $node|has_attribute( 'file' )}
        <a class="btn btn-info" href={concat("content/download/",$node|attribute( 'file' ).contentobject_id,"/",$node|attribute( 'file' ).id,"/file/",$node|attribute( 'file' ).content.original_filename)|ezurl} title="Scarica il file {$node|attribute( 'file' ).content.original_filename|wash( xhtml )}">
          <i class="fa fa-download"></i> Scarica il file
        </a>
      {/if}
    </p>
    {/if}
  </div>
</div>