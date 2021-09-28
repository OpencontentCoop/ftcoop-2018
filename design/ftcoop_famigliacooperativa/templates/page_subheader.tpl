{def $header_css_style = cond(appini('SiteSettings', 'StyleSuffix', '')|eq(''),
    'margin: 0;color: #fff;padding: 135px 40px 0;font-size: 50px;',
    'margin: 0;color: #fff;padding: 135px 40px 0;font-size: 50px;text-shadow: 0px 4px 3px rgba(0,0,0,0.4), 0px 8px 13px rgba(0,0,0,0.1), 0px 18px 23px rgba(0,0,0,0.1);'
)}
<div class="sub-header bg-primary hidden-xs">
    <div class="container-fluid">
        <div class="col-md-11 col-md-offset-1 showcase">
            {if $subsite|has_attribute( 'header_image' )}
                <div style="background-image: url({$subsite|attribute( 'header_image' ).content[concat('subheaderoverlay', appini('SiteSettings', 'StyleSuffix', ''))].url|ezroot(no)});background-size: cover;background-position: center center;height: 326px">
            {else}
                <div style="background-image: url({concat("images/header-image", appini('SiteSettings', 'StyleSuffix', ''), ".jpg")|ezdesign(no)});background-size: cover;background-position: center center;height: 326px">
            {/if}
                {if and(is_set(ftcoop_pagedata().current_node_id), ftcoop_pagedata().current_node_id|gt(0), is_set(ftcoop_pagedata().path_array[1]))}
                    <h1 style="{$header_css_style}">
                        {ftcoop_pagedata().path_array[1].text|wash}
                    </h1>
                {elseif is_set(ftcoop_pagedata().path_array[0])}
                    <h1 style="{$header_css_style}">
                        {ftcoop_pagedata().path_array[0].text|wash}
                    </h1>
                {/if}
            </div>
        </div>

    </div>
</div>
