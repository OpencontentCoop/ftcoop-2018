{def $webtv_url = $node.url_alias|ezurl()
$external_url = false()
}

{foreach ezini('WebTvSettings','ShowDirectLinkFor','ftcoop.ini') as $video_url_pattern}

  {if $node.data_map.link.content|contains($video_url_pattern)}
    {set $webtv_url = $node.data_map.link.content
    $external_url = true()
    }
    {break}
  {/if}
{/foreach}


<div class="carousel-item" style="background-image: url({$node|attribute( 'image' ).content[$wide_class].url|ezroot(no)})">

  <a href={$webtv_url} title="{$node.name}" {if $external_url}target="_blank"{/if}>
    {attribute_view_gui attribute=$node|attribute( 'image' ) image_class=$image_class}
  </a>
  <div class="carousel-caption">
    {$node.name|wash()}
  </div>

	{undef}

</div>
