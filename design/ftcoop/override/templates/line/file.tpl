<div class="content-view-line class-{$node.class_identifier}">
  <h4 class="media-heading">
    {if is_set( $node.url_alias )}
        <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
    {else}
        {$node.name|wash()}
    {/if}
		<small>{$node.object.published|l10n( 'date' )}</small>
	</h4>
	{if $node|has_abstract()}
	  <p>{$node|abstract()|oc_shorten(500)}</p>
	{/if}
</div>
