<div class="item text-center">

  <a href={$node|attribute('image').content[$wide_class].url|ezroot} title="{$node.name}" data-gallery>
    {attribute_view_gui attribute=$node|attribute( 'image' ) image_class=$image_class}
  </a>

</div>