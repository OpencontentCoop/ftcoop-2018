{* twitter, youtube, rss*}

<div class="content-view-block social-bar block-view-{$block.view}">
  {if $block.name}
    <h4 class="block-title">{$block.name|wash()}</h4>
  {/if}

  {def $root = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
  {def $channels = array( 'twitter_channel', 'facebook_channel', 'flickr_channel' )}
  {foreach $channels as $channel }
  {if and( is_set( $root.data_map.$channel ), $root.data_map.$channel.has_content )}
    {def $channel_link = cond( $root.data_map.$channel.content|begins_with( 'http' ), $root.data_map.$channel.content, concat( 'http://', $root.data_map.$channel.content ) )}
    <a target="_blank" href="{$channel_link}" class="{$root.data_map.$channel.contentclass_attribute_identifier}" title="{$root.data_map.$channel.contentclass_attribute_name}">
      <span class="fa  fa-3x fa-{$root.data_map.$channel.contentclass_attribute_identifier|explode('_channel')|implode('')}"></span>
    </a>
    {undef $channel_link}
  {/if}
  {/foreach}
  <a target="_blank" class="rss" href={"rss/feed/notizie"|ezurl()}><span class="fa  fa-3x fa-rss"></span></a>

</div>
