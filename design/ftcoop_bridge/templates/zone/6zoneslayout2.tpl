<div class="zone-layout-{$zone_layout|downcase()} norightcol">
    <div class="row">
        <div class="max-width">
            <div class="content-columns float-break">

                <div class="leftcol-position">
                    <div class="leftcol">

                        {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
                            <div class="top-left">
                                {foreach $zones[0].blocks as $block}
                                    {include uri='design:parts/zone_block.tpl' zone=$zones[0]}
                                {/foreach}
                            </div>
                        {/if}

                        <div class="columns-two">
                            <div class="col-1">
                                <div class="col-content">
                                    {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
                                        {foreach $zones[1].blocks as $block}
                                            {include uri='design:parts/zone_block.tpl' zone=$zones[1]}
                                        {/foreach}
                                    {/if}
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="col-content">
                                    {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
                                        {foreach $zones[2].blocks as $block}
                                            {include uri='design:parts/zone_block.tpl' zone=$zones[2]}
                                        {/foreach}
                                    {else}
                                        <ul class="banner-cooperative">
                                            <li class="banner-cooperative-1-1"><a
                                                        href='/Cooperative/(Settore)/"25916"/(sort)/name-asc/(forceSort)/0'
                                                        title="Cooperative Agricole">Cooperative Agricole</a></li>
                                            <li class="banner-cooperative-1-2"><a
                                                        href='/Cooperative/(Settore)/"25917"/(sort)/name-asc/(forceSort)/0'
                                                        title="Cooperative di Consumo">Cooperative di Consumo</a></li>
                                            <li class="banner-cooperative-2-1"><a
                                                        href='/Cooperative/(Settore)/"25915"/(sort)/name-asc/(forceSort)/0'
                                                        title="Cooperative di Credito">Cooperative di Credito</a></li>
                                            <li class="banner-cooperative-2-2"><a
                                                        href='/Cooperative/(Settore)/"25918"/(sort)/name-asc/(forceSort)/0'
                                                        title="Cooperative di Lavoro, sociale, servizio e abitazione (LSSA)">Cooperative
                                                    di Lavoro, sociale, servizio e abitazione (LSSA)</a></li>
                                        </ul>
                                    {/if}
                                </div>
                            </div>
                        </div>

                        <div class="">
                            {if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
                                {foreach $zones[3].blocks as $block}
                                    {include uri='design:parts/zone_block.tpl' zone=$zones[3]}
                                {/foreach}
                            {/if}
                        </div>

                    </div>
                </div>

                <div class="maincol-position">
                    <div class="maincol rightcol">
                        {if and( is_set( $zones[4].blocks ), $zones[4].blocks|count() )}
                            {foreach $zones[4].blocks as $block}
                                {include uri='design:parts/zone_block.tpl' zone=$zones[4]}
                            {/foreach}
                        {/if}
                    </div>
                </div>

                <hr class="float-break"/>

                <div class="bottomcol-position float-break">
                    <div class="bottomcol wide">
                        {if and( is_set( $zones[5].blocks ), $zones[5].blocks|count() )}
                            {foreach $zones[5].blocks as $block}
                                {include uri='design:parts/zone_block.tpl' zone=$zones[5]}
                            {/foreach}
                        {/if}
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

{*
    <div class="zone-layout-{$zone_layout|downcase()}">

    <div class="top-zone">
      <div class="top">

      {if and( is_set( $zones[0].blocks ), $zones[0].blocks|count() )}
      {foreach $zones[0].blocks as $block}
          {include uri='design:parts/zone_block.tpl' zone=$zones[0]}
      {/foreach}
      {/if}

      </div>
    </div>

    
    <div class="columns-three center-zone">
    
    <div class="col-1-2">
    <div class="col-1">
    <div class="col-content">
    
    {if and( is_set( $zones[1].blocks ), $zones[1].blocks|count() )}
    {foreach $zones[1].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[1]}
    {/foreach}
    {/if}
    
    </div>
    </div>
    <div class="col-2">
    <div class="col-content">
    
    {if and( is_set( $zones[2].blocks ), $zones[2].blocks|count() )}
    {foreach $zones[2].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[2]}
    {/foreach}
    {/if}
    
    </div>
    </div>
    </div>
    <div class="col-3">
    <div class="col-content">
    
    {if and( is_set( $zones[3].blocks ), $zones[3].blocks|count() )}
    {foreach $zones[3].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[3]}
    {/foreach}
    {/if}
    
    </div>
    </div>
    
    </div>


    <div class="columns-two bottom-zone">
    
    <div class="col-1">
    <div class="col-content">
    
    {if and( is_set( $zones[4].blocks ), $zones[4].blocks|count() )}
    {foreach $zones[4].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[4]}
    {/foreach}
    {/if}
    
    </div>
    </div>
    <div class="col-2">
    <div class="col-content">
    
    {if and( is_set( $zones[5].blocks ), $zones[5].blocks|count() )}
    {foreach $zones[5].blocks as $block}
        {include uri='design:parts/zone_block.tpl' zone=$zones[5]}
    {/foreach}
    {/if}
    
    </div>
    </div>
    
    </div>


</div>
*}
