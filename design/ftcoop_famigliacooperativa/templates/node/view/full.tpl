{def $openpa = object_handler($node)
     $current_user = fetch(user, current_user)}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}
     
<div class="container">
  <div class="content-view-full class-{$node.class_identifier} row">
  
  {* Per il menu di sinistra scommenta e togli "wide" dal content-main *}
  {*include uri='design:nav/nav-section.tpl'*}

  <div class="content-main wide">

    <div class="page-header">
      <h1>{$node.name|wash()}</h1>
    </div>

    {include uri=$openpa.content_main.template}

    {include uri=$openpa.content_contacts.template}

    {include uri=$openpa.content_detail.template}

    {include uri=$openpa.content_infocollection.template}

    {include uri=$openpa.control_children.template}
	
	
  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}
  
</div>
</div>

{ezpagedata_set('require_container', false())}
{include uri='design:parts/load_website_toolbar.tpl'}