{def $webtv_url = $node.url_alias|ezurl()
     $external_url = false()}

{foreach ezini('WebTvSettings','ShowDirectLinkFor','ftcoop.ini') as $video_url_pattern}
  {if $node.data_map.link.content|contains($video_url_pattern)}
    {set $webtv_url = $node.data_map.link.content
    $external_url = true()
    }
    {break}
  {/if}
{/foreach}


<div class="carousel-item" style="min-height: 200px; background: #eee">

  {if $node|has_attribute('image')}
  <a href={$node.url_alias|ezurl()}>
    {attribute_view_gui attribute=$node|attribute('image') image_class=$image_class}
  </a>
  {/if}

  <div class="carousel-caption">

    {def $title=$node.name|wash()}
    {set $title = $title|oc_shorten(80,'...')}
    <div>
      <h3><a style="background-color: rgba(51,51,51,0.5);color: #fff;padding: 0 5px; line-height: 1.2em" href={$webtv_url}>{$title}</a></h3>
    </div>

  </div>

</div>
