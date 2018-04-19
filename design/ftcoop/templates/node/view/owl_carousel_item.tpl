<div class="carousel-item">

  <a href={$node|attribute('image').content[$wide_class].url|ezroot} data-gallery>
    {attribute_view_gui attribute=$node|attribute('image') image_class=$image_class}
  </a>

  <div class="carousel-item-actions">
    <a href="{$node.data_map.image.content.original.url|ezroot(no)}" class="download" title="Download">
      <i class="fa fa-download"></i> <span class="sr-only">Download</span>
    </a>
  </div>
</div>
