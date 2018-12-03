{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}
<header>

    <div class="container-fluid">
        <div class="row">
            <div class="bg-primary col-md-3 same-height header-branding">
                <div class="branding">
                    
                    <a href={"/"|ezurl()} title="vai alla home page">
                        <img class="logo" src={"images/logo-bianco.png"|ezdesign()} alt="{$root_node.name|wash()}"/>
                        <small>{$root_node.name|explode('Famiglia Cooperativa')|implode('')|explode('Famiglia cooperativa')|implode('')|wash()}</small>
                    </a>

                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
                        <span class="sr-only">Menù di navigazione</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>

                    <div class="mobile-contacts hidden-md hidden-lg">
                        {def $telefono = false()}
                        {if $subsite|has_attribute( 'telefono' )}
                            {set $telefono = $subsite|attribute( 'telefono' )}
                        {elseif $root_node|has_attribute( 'telefono' )}
                            {set $telefono = $root_node|attribute( 'telefono' )}
                        {/if}
                        {def $geo = false()}
                        {if $subsite|has_attribute( 'geo' )}
                            {set $geo = $subsite|attribute( 'geo' )}
                        {elseif $root_node|has_attribute( 'geo' )}
                            {set $geo = $root_node|attribute( 'geo' )}
                        {/if}
                        {if $telefono}
                            <a href="tel:{attribute_view_gui attribute=$telefono}">
                                <img src={'images/i-phone.png'|ezdesign()} alt="{attribute_view_gui attribute=$telefono}"/>
                            </a>
                        {/if}
                        {if $geo}
                            <a target="_blank"
                               href="https://www.google.com/maps/dir//'{$geo.content.latitude},{$geo.content.longitude}'/@{$geo.content.latitude},{$geo.content.longitude},15z?hl=it">
                                <img src={'images/i-map-pin.png'|ezdesign()} alt="Come arrivare" />
                            </a>
                        {/if}
                    </div>

                </div>
            </div>
            <div class="col-md-9 same-height header-nav" style="min-height: 0;">

                {if $pagedata.is_edit|not}
                    {include uri='design:nav/nav-tools.tpl'}

                    {if is_set( $pagedata.persistent_variable.topmenu_template_uri )}
                        {include uri=$pagedata.persistent_variable.topmenu_template_uri}
                    {else}
                        {include uri='design:nav/nav-main.tpl'}
                    {/if}
                {/if}

            </div>
        </div>
    </div>

</header>
