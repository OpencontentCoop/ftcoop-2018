{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}
{if is_set($pagedata)|not()}{def $pagedata = openpapagedata()}{else}{set $pagedata = openpapagedata()}{/if}
<header>

    <p class="visible-xs logo-xs bg-primary">
        <a href={"/"|ezurl()} title="vai alla home page">                      
            <img src={"images/logo-xs.png"|ezdesign()} alt="{$root_node.name|wash()}"/>
            <span>{$root_node.name|wash()}</span>
        </a>
    </p>
    <div class="container-fluid">
        <div class="row">
            <div class="bg-primary col-md-3 same-height header-branding">                
                <div class="branding">                    
                    <a href={"/"|ezurl()} title="vai alla home page">
                        <img class="logo hidden-xs" src={"images/logo-bianco.png"|ezdesign()} alt="{$root_node.name|wash()}"/>
                        <small class="hidden-xs">{$root_node.name|wash()}</small>
                    </a>

                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar" style="margin:0">
                        <i style="font-size: 42px;vertical-align: middle;padding: 0 0 0 20px;color: #fff" class="fa fa-bars"></i>
                    </button>

                    <div class="mobile-contacts hidden-md hidden-lg">
                        {if is_set( $pagedata.contacts.telefono )}
                            <a href="tel:{$pagedata.contacts.telefono|wash()}">
                                <i class="fa fa-phone"></i>
                            </a>
                        {/if}
                        {if is_set( $pagedata.contacts.indirizzo )}
                            <a target="_blank" href="http://maps.google.com/maps?q={$pagedata.contacts.indirizzo|wash()}">
                                <i class="fa fa-map-marker"></i>
                            </a>
                        {/if}
                        <a href="#" class="button-orari-di-apertura" data-toggle="modal" data-target="#orari-di-apertura-modal">
                            <i class="fa fa-clock"></i>
                        </a>
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
