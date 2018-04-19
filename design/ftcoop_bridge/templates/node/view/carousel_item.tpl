{if $node.data_map.image.content[$image_class]}
  {def $image = $node.data_map.image.content[$image_class]}
  <img src={$image.url|ezroot} width="{$image.width}" height="{$image.height}" alt="{$node.name|wash}" />
  {undef $image}
{/if}
<div class="carousel-caption">

  {def $title=$node.name|wash()}
  {set $title = $title|oc_shorten(60)}

  <h3><a href={$node.url_alias|ezurl()}>{$title}</a></h3>
  {*if $node.data_map.abstract.has_content}
    {def $xml_content=$node.data_map.abstract.data_text}
    {def $text_content=$xml_content|strip_tags()}
    {set $text_content = $text_content|shorten(90)}
    {$text_content}
    {undef $text_content}
  {/if*}
  {*attribute_view_gui attribute=$node.data_map.abstract*}
</div>