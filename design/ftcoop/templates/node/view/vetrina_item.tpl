<div class="vetrina-item">
  <h2 class="vetrina-item-title">{$node.name|wash()}</h2>

  {if $node|has_attribute( 'description' )}
    <div class="vetrina-item-body">
      {attribute_view_gui attribute=$node|attribute( 'description' )}
    </div>
  {/if}

  <p class="goto"><a href="{$node.url_alias|ezurl(no)}">Scopri di +</a></p>

</div>