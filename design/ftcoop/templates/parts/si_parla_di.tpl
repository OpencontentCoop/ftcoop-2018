{set_defaults( hash(
      'css_class', ''))}

{def $contentNode=null}

<div class="box box-small {$css_class} si_parla_di">
  <h3 class="box-title">Si parla di</h3>

  {if $relazioni|count()|gt(0)}

    {def $lista = array()}
    {foreach $relazioni as $rel}
      {set $lista = $lista|append(fetch('content', 'node', hash('node_id', $rel.node_id )))}
    {/foreach}

    {if $lista|count()|lt(4)}
      <ul class="list-inline">
      {foreach $lista as $item}
        <li>{node_view_gui view=listitem content_node=$item}</li>
      {/foreach}
      </ul>
    {else}
      {* slider *}
      <div class="carousel-container owl-carousel-slider-auto text-slider">
          {include uri='design:atoms/owl_carousel.tpl' items=$lista i_view="owl_carousel_text_item"}
      </div>
    {/if}

  {/if}




   {*Cooperative*}
    {*if $cooperative|count()|gt(0)}
      <h4>Imprese</h4>
      <ul class="list-inline">
        {foreach $cooperative as $coop}
          {set $contentNode = fetch('content', 'node', hash('node_id', $coop.node_id ))}
          <li>{node_view_gui view=listitem content_node=$contentNode}</li>
        {/foreach}
      </ul>
    {/if}

    {*Persone*}
    {*if $persone|count()|gt(0)}
      <h4>Persone</h4>
      <ul class="list-inline">
        {foreach $persone as $persona}
          {set $contentNode = fetch('content', 'node', hash('node_id', $persona.node_id ))}
          <li>{node_view_gui view=listitem content_node=$contentNode}</li>
        {/foreach}
      </ul>
    {/if}

    {*Associazioni*}
    {* if $associazioni|count()|gt(0)}
      <h4>Associazioni</h4>
      <ul class="list-inline">
        {foreach $associazioni as $associazione}
          {set $contentNode = fetch('content', 'node', hash('node_id', $associazione.node_id ))}
          <li>{node_view_gui view=listitem content_node=$contentNode}</li>
        {/foreach}
      </ul>
    {/if*}
</div>