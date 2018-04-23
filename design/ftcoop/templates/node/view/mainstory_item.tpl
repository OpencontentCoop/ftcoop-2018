{set_defaults(hash(
  'show_image' , false(),
  'show_abstract' , true(),
  'highlights', false(),
  'image_class', 'imagefull'
))}


<div class="mainstory-item {if $highlights}jumbotron{/if}">

  <h2 class="mainstory-item-title">
    <a href={$node.url_alias|ezurl()}>
      {if $title}{$title}{else}{$node.name|wash}{/if}
    </a>
  </h2>

  {if $show_image}
    {if $node|has_attribute( 'image' ) }
      <div class="mainstory-item-image">
        {attribute_view_gui attribute=$node|attribute('image') image_class=$image_class}
      </div>
    {/if}
  {/if}

  {if $show_abstract}
    {if $node|has_abstract()}
      <div class="mainstory-item-abstract abstract">
      {$node|abstract()}
      </div>
    {/if}
  {/if}

  <p class="goto"><a href="{$node.url_alias|ezurl(no)}">Scopri di +</a></p>


</div>