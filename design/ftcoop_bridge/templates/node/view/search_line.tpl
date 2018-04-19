<div class="search-result">
  <h4 class="search-result-title">
    <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
    <span class="search-result-meta">{*{$node.object.published|l10n(date)} - *}{$node.class_name}</span>
  </h4>
  <a class="search-result-path" href={$node.url_alias|ezurl()}><small>{$node.path_with_names}</small></a>
  <p class="search-result-highlights">{$node.highlight}</p>
</div>
