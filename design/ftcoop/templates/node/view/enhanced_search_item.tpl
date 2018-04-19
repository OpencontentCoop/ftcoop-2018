<div class="search-result well">
	<h3>
    <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
    {*<span class="search-result-meta">{$node.class_name}</span>*}
  </h3>

	<div class="text-right">
		<a class="btn btn-primary" href={$node.url_alias|ezurl()}>Vai alla scheda</a>
	</div>

</div>
