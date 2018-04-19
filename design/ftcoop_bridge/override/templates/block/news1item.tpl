{def $block_root_node = fetch( 'content', 'node', hash( 'node_id', $block.custom_attributes.node_id ) )}
{def $items = fetch( 'content', 'list', hash( 'parent_node_id',$block_root_node.node_id,
											  'limit', 1,
											  'depth',3,
											  'sort_by',        array( 'published', false() ),
											  'class_filter_type',  'include',
											  'class_filter_array', array( 'comunicato' )  ) )}
{*
<div class="content-view-block news-container block-view-{$block.view}">
  {if $block.name}
    <h4 class="block-title">{$block.name|wash()}</h4>
  {/if}
 
  <div class="greybox">
    {foreach $items as $item max 1}

      <a href={$item.url_alias|ezurl()}} class="news-title">{$item.name|wash}</a>
      {if $item.data_map.abstract.has_content}
        <p class="news-abstract">{$item.data_map.abstract.content.output.output_text|oc_shorten(150,'...')}</p>
      {/if}

    {/foreach}

    <div class="goto">
      <a  href={$$block_root_node.url_alias|ezurl()}>vai a {$block.name|wash()}</a>
    </div>
  </div>
</div>
*}
  {if $items}
    <div class="content-view-block news-container block-view-{$block.view}">
      <div class="panel panel-primary">
        {if $block.name}
          <div class="panel-heading">{$block.name|wash()}</div>
        {/if}
        <div class="panel-body">
          {foreach $items as $item max 1}

            <a href={$item.url_alias|ezurl()}} class="news-title">{$item.name|wash}</a>
            {if $item.data_map.abstract.has_content}
              <p class="news-abstract">{$item.data_map.abstract.content.output.output_text|oc_shorten(150,'...')}</p>
            {/if}

          {/foreach}
          <p class="goto">
            <a  href={$block_root_node.url_alias|ezurl()}>vai a {$block.name|wash()}</a>
          </p>

        </div>
      </div>
    </div>
  {/if}