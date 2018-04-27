<div class="carousel-item">

  {if $show_images_only}

    <a href={$node|attribute('image').content[$wide_class].url|ezroot} data-gallery>
      {attribute_view_gui attribute=$node|attribute('image') image_class=$image_class}
    </a>

    <div class="carousel-item-actions">
      <a href="{$node.data_map.image.content.original.url|ezroot(no)}" class="download" title="Download">
        <i class="fa fa-download"></i> <span class="sr-only">Download</span>
      </a>
    </div>

  {else}

    <a href={$node.url_alias|ezurl()}>
      {attribute_view_gui attribute=$node|attribute('image') image_class=$image_class}
    </a>

    <div class="carousel-caption">

      {def $title=$node.name|wash()}
      {set $title = $title|oc_shorten(90,'...')}
      <div>
        <p class="date">{$node.object.published|l10n(date)}</p>
        <h4><a style="background-color: rgba(51,51,51,0.5);color: #fff" href={$node.url_alias|ezurl()}>{$title}</a></h4>
      </div>

    </div>

  {/if}

</div>