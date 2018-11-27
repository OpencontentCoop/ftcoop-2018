<div class="sub-header bg-primary hidden-xs">
  <div class="container-fluid">

    <div class="col-md-12 col-md-offset-1 showcase">
      {if $subsite|has_attribute( 'header_image' )}
      	<div style="background-image: url({$subsite|attribute( 'header_image' ).content[concat('subheaderoverlay', appini('SiteSettings', 'StyleSuffix', ''))].url|ezroot(no)});background-size: cover;background-position: center center;height: 326px"></div>
      {else}
      	<div style="background-image: url({"images/header-image.jpg"|ezdesign(no)});background-size: cover;background-position: center center;height: 326px"></div>      	
      {/if}
    </div>

  </div>
</div>
