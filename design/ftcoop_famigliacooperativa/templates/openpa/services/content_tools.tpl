<div id="editor_tools" class="panel panel-info editor_tools" style="display: none">
    <div class="panel-heading">
        <h4 class="panel-title"><i class="fa fa-info-circle"></i> Informazioni per l'editor</h4>
    </div>
    <div class="panel-body">
	  {*
    <ul class="nav nav-tabs" role="tablist">
		<li class="active"><a href="#info" role="tab" data-toggle="tab">Info</a></li>
		{include uri="design:openpa/services/tools/settings_tab.tpl"}		
	  </ul>
	  <div class="tab-content p_top_10">
		<div class="tab-pane active" id="info">
    *}
        {debug-accumulator id=editor_tools name=editor_tools}
        {include uri="design:openpa/services/tools/info.tpl"}
        {/debug-accumulator}
		{*
    </div>		
		<div class="tab-pane" id="settings">
		  {include uri="design:openpa/services/tools/settings.tpl"}
		</div>
	  </div>
    *}
    </div>
</div>