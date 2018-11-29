{if $openpa.content_main.has_content}
<div class="media">
    <div class="abstract">
      {if is_set( $openpa.content_main.parts.abstract )}
          {attribute_view_gui attribute=$openpa.content_main.parts.abstract.contentobject_attribute}
      {/if}
    </div>
    {if is_set( $openpa.content_main.parts.image )}
      <div style="margin-bottom: 30px">
        {include uri='design:atoms/image.tpl' item=$node image_class=imagefullwide css_classes="" image_css_class="center-block"}
      </div>
    {/if}    
    {if is_set( $openpa.content_main.parts.full_text )}
        {attribute_view_gui attribute=$openpa.content_main.parts.full_text.contentobject_attribute}
    {/if}

</div>
{/if}