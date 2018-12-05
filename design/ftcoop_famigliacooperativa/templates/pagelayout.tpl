<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!--[if lt IE 9 ]><html class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>
    {def $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}

    {if is_set( $extra_cache_key )|not}
        {def $extra_cache_key = ''}
    {/if}

    {set $extra_cache_key = concat($extra_cache_key, ftcoop_pagedata().subsite_id)}
    {set $extra_cache_key = concat($extra_cache_key, ftcoop_pagedata().topmenu_template_uri)}
    {set $extra_cache_key = concat($extra_cache_key, ftcoop_pagedata().has_subheader)}
    {set $extra_cache_key = concat($extra_cache_key, ftcoop_pagedata().is_view)}

    {if and(is_set(ftcoop_pagedata().current_node_id), ftcoop_pagedata().current_node_id|gt(0), is_set(ftcoop_pagedata().path_array[1]))}
      {set $extra_cache_key = concat($extra_cache_key, ftcoop_pagedata().path_array[1].text)}
    {elseif is_set(ftcoop_pagedata().path_array[0])}
      {set $extra_cache_key = concat($extra_cache_key, ftcoop_pagedata().path_array[0].text)}
    {/if}
    
    {debug-log var=$extra_cache_key msg='extra_cache_key'}

    <!-- Site: {ezsys( 'hostname' )} -->
    {if ezsys( 'hostname' )|contains( 'opencontent' )}
        <META name="robots" content="NOINDEX,NOFOLLOW" />
    {/if}
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    {debug-accumulator id=page_head name=page_head}
    {include uri='design:page_head.tpl' pagedata=ftcoop_pagedata()}
    {/debug-accumulator}

    {debug-accumulator id=page_head_include name=page_head_include}
    {include uri='design:page_head_style.tpl'}
    {include uri='design:page_head_script.tpl'}
    {/debug-accumulator}

    {include uri='design:page_head_tag_manager.tpl'}

</head>
<body>
{include uri='design:page_body_tag_manager.tpl'}
{include uri='design:page_browser_alert.tpl'}

<div id="page">

{debug-accumulator id=page_toolbar name=page_toolbar}
    {include uri='design:page_toolbar.tpl'}
{/debug-accumulator}

{cache-block ignore_content_expiry keys=array( $access_type.name, $extra_cache_key )}
    {def $pagedata = ezpagedata()}
    {def $subsite = subsite()}
    {def $current_node_id = $pagedata.node_id}

    {include uri='design:page_header.tpl'}

    {if and(ftcoop_pagedata().is_view,ftcoop_pagedata().has_subheader|not())}
        {include uri='design:page_subheader.tpl'}
    {/if}
{/cache-block}
    
    {if ftcoop_pagedata().has_breadcrumb|not()}
    <div class="breadcrumb-container container-fluid hidden-xs">
        <div class="row">
            <div class="bg-primary col-md-3 same-height">
            </div>
            <div class="col-md-9 same-height" style="min-height: 53px;">
                {if ftcoop_pagedata().show_breadcrumb}
                    {include uri='design:breadcrumb.tpl' pagedata=ftcoop_pagedata()}
                {/if}
            </div>
        </div>
    </div>
    {/if}

    {if ftcoop_pagedata().require_container}
    <div class="container">
      {$module_result.content}
    </div>
  {else}
    {$module_result.content}
  {/if}
</div>

{if ftcoop_pagedata().is_view}
{cache-block ignore_content_expiry keys=array( $access_type.name, $extra_cache_key )}
    {include uri='design:page_footer.tpl'}
{/cache-block}

    {include uri='design:page_credits.tpl'}
{/if}

{include uri='design:page_footer_script.tpl'}

{* Codice extra usato da plugin javascript *}
{include uri='design:page_extra.tpl'}

{cache-block ignore_content_expiry keys=array( $access_type.name, 'orari-di-apertura' )}
{include uri='design:modal_orari_di_apertura.tpl'}
{/cache-block}

<script type="text/javascript">//<![CDATA[
    var UiContext = "{$ui_context}",
        UriPrefix = "{ftcoop_pagedata().uri_prefix}",
        PathArray = [{ftcoop_pagedata().reverse_path_id_array|implode(',')}];
        CurrentUserIsLoggedIn = {if $current_user.is_logged_in}true{else}false{/if};
        CurrentNode = {if is_set(ftcoop_pagedata().reverse_path_id_array[0])}{ftcoop_pagedata().reverse_path_id_array[0]}{else}false{/if};
//]]></script>

<!--DEBUG_REPORT-->
</body>
</html>
