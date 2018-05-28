<!-- Path content: START -->
<div>
    <ul class="breadcrumb">
        {foreach $pagedata.path_array as $path}
            {if and( is_set($path.node_id),
                     $path.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ),
                     $path.node_id|eq( ezini( 'SiteSettings', 'GlobalSiteRootNodeID', 'site.ini' ) )
            )}
                {if appini('SiteSettings','ShowGlobalSiteInBreadcrumb','disabled')|eq('enabled')}
                <li>
                    <a href="//{ezini('SiteSettings', 'GlobalSiteURL')}">
                        {ezini('SiteSettings', 'GlobalSiteName')}
                    </a>
                </li>
                {/if}
            {*
            {elseif and( is_set($path.node_id), $path.node_id|eq( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ))}
                <li>
                    <a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>Homepage</a>
                </li>
            *}
            {elseif $path.url}
                <li>
                    <a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a>
                </li>
            {else}
                <li class="active">
                    {$path.text|wash}
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
<!-- Path content: END -->
