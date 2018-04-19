{*calcola l'url*}
{def $url = ''}
{def $url_found = false()}

{def $siteList=ezini('WebTvSettings', 'ShowDirectLinkFor', 'ftcoop.ini')}

{if $node|has_attribute('link')}
  {set $url = $node.object.data_map.link.content}
  {foreach $siteList as $site}
    {if $url|contains( $site )}
      {set $url_found = true()}
    {/if}
  {/foreach}
{/if}

{if or($url_found|not(), eq($node.can_edit, 1))}
  {if is_set( $node.url_alias )}
    {set $url = $node.url_alias|ezurl('no')}
  {else}
    {set $url = '#'}
  {/if}
{/if}


  <div class="content-view-line class-{$node.class_identifier}">
      {if and($node|has_attribute( 'image' ), $hide_image|not())}
      <div class="col-md-4">
        <a href="{$url}">
          {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
        </a>
      </div>
      {/if}

      <div class="line-item-content col-md-{if $node|has_attribute( 'image' )}8{else}12{/if}">
        <p class="date">{$node.object.published|l10n( date )}</p>
        <h4 class="line-item-title">
          <a href="{$url}" title="{$node.name|wash()}">{$node.name|wash()}</a>
        </h4>
        {if not($hide_intro)}
          {if $node.object.data_map.intro.has_content}
            <p>{$node.object.data_map.intro.data_text|oc_shorten(500)}</p>
          {/if}
        {/if}
      </div>

  </div>