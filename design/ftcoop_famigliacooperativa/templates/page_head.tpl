{default enable_help=true() enable_link=true() canonical_link=true()}

{if is_set($module_result.content_info.persistent_variable.site_title)}
    {set scope=root site_title=$module_result.content_info.persistent_variable.site_title}
{else}
{let name=Path
     path=$module_result.path
     reverse_path=array()}
  {if is_set($pagedata.path_array)}
    {set path=$pagedata.path_array}
  {elseif is_set($module_result.title_path)}
    {set path=$module_result.title_path}
  {/if}
  {section loop=$:path}
    {set reverse_path=$:reverse_path|array_prepend($:item)}
  {/section}

{set-block scope=root variable=site_title}
{section loop=$Path:reverse_path}{$:item.text|wash}{delimiter} / {/delimiter}{/section} - {$site.title|wash}
{/set-block}

{/let}
{/if}
    <title>{$site_title}</title>

    {if and(is_set($#Header:extra_data),is_array($#Header:extra_data))}
      {section name=ExtraData loop=$#Header:extra_data}
      {$:item}
      {/section}
    {/if}

    {* check if we need a http-equiv refresh *}
    {if $site.redirect}
    <meta http-equiv="Refresh" content="{$site.redirect.timer}; URL={$site.redirect.location}" />

    {/if}
    {foreach $site.http_equiv as $key => $item}
        <meta name="{$key|wash}" content="{$item|wash}" />

    {/foreach}
    {foreach $site.meta as $key => $item}
    {if is_set( $module_result.content_info.persistent_variable[$key] )}
        <meta name="{$key|wash}" content="{$module_result.content_info.persistent_variable[$key]|wash}" />
    {else}
        {switch match=$key}
          {case match='author'}
            <meta name="author" content="Opencontent SCARL, Federazione Trentina della Cooperazione" />
          {/case}
          {case match='copyright'}
            <meta name="copyright" content="{ezini( 'SiteSettings', 'SiteName' )}" />
          {/case}
          {case match='description'}
            <meta name="description" content="Vieni a fare la spesa nel punto vendita più vicino a te, la tua Famiglia Cooperativa ti offre i prodotti più convenienti e di miglior qualità" />
          {/case}
          {case match='keywords'}
            <meta name="keywords" content="prodotti sani, prodotti locali, e-shop, punto vendita, negozio alimentari" />
          {/case}
          {case}
            <meta name="{$key|wash}" content="{$item|wash}" />
          {/case}
        {/switch}        
    {/if}

    {/foreach}

    {if is_set($module_result.content_info.persistent_variable.opengraph)}
        {foreach $module_result.content_info.persistent_variable.opengraph as $key => $value}
            {if is_array($value)}
                {foreach $value as $v}
                    <meta property="{$key}" content="{$v|wash()}" />
                {/foreach}
            {else}
                <meta property="{$key}" content="{$value|wash()}" />
            {/if}
        {/foreach}
    {/if}

    <meta name="MSSmartTagsPreventParsing" content="TRUE" />

{if $canonical_link}
    {include uri="design:canonical_link.tpl" pagedata=$pagedata}
{/if}

{if $enable_link}
    {include uri="design:link.tpl" enable_help=$enable_help enable_link=$enable_link}
{/if}

{/default}
