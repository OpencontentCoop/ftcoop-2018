<div class="sub-header bg-primary hidden-xs">
  <div class="container-fluid">

    <div class="col-md-11 col-md-offset-1 showcase">
      {if $subsite|has_attribute( 'header_image' )}
      	<div style="background-image: url({$subsite|attribute( 'header_image' ).content[concat('subheaderoverlay', appini('SiteSettings', 'StyleSuffix', ''))].url|ezroot(no)});background-size: cover;background-position: center center;height: 326px">
      {else}
      	<div style="background-image: url({"images/header-image.jpg"|ezdesign(no)});background-size: cover;background-position: center center;height: 326px">
      {/if}      
      {if and(is_set(ftcoop_pagedata().current_node_id), ftcoop_pagedata().current_node_id|gt(0), is_set(ftcoop_pagedata().path_array[1]))}
      <h1 style="margin: 0;color: #fff;padding: 135px 40px 0;font-size: 50px;">
      	{ftcoop_pagedata().path_array[1].text|wash}
      </h1>
      {elseif is_set(ftcoop_pagedata().path_array[0])}
      <h1 style="margin: 0;color: #fff;padding: 135px 40px 0;font-size: 50px;">
        {ftcoop_pagedata().path_array[0].text|wash}
      </h1>
      {/if}
	  </div>
    </div>

  </div>
</div>
