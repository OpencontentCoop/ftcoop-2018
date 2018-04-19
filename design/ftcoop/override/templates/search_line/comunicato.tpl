<a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}" class="search-result">
  <h4 class="search-result-title">
    {$node.name|wash()}
    <span class="search-result-meta">{$node.object.published|l10n(date)} [{$node.class_name|downcase()}]</span>
  </h4>
  {*<a class="search-result-path" href={$node.url_alias|ezurl()}><small>{$node.path_with_names}</small></a>*}
  <p class="search-result-highlights">{$node.highlight}</p>
</a>
