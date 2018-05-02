<div class="carousel-item">

	<a href={$node.url_alias|ezurl()}>
	  {attribute_view_gui attribute=$node|attribute('image') image_class=$image_class}
	</a>

	<div class="carousel-caption">

	  {def $title=$node.name|wash()}
	  {set $title = $title|oc_shorten(90,'...')}
	  <div>
	    <h3><a style="background-color: rgba(51,51,51,0.5);color: #fff;padding:0 5px; line-height: 1.2em" href={$node.url_alias|ezurl()}>{$title}</a></h3>
	  </div>

	</div>

</div>
