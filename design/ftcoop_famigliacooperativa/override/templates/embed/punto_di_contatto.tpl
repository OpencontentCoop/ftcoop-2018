{def $openpa_embed = object_handler($object)}
{if $openpa_embed.content_contacts.has_content}
    
	{run-once}
    <h2><i class="fa fa-info-circle"></i> {$openpa_embed.content_contacts.label}<span></span></h2>    
    {/run-once}

    {foreach $openpa_embed.content_contacts.attributes as $openpa_attribute}
        <div class="row">
            {if $openpa_attribute.full.show_label}
                <div class="col-md-2"><strong>{$openpa_attribute.label}: </strong></div>
            {/if}
            <div class="col-md-{if $openpa_attribute.full.show_label}10{else}12{/if}">
                {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.full.show_link|not, 'no-link', '')}
            </div>
        </div>
    {/foreach}
{/if}
{undef $openpa_embed}