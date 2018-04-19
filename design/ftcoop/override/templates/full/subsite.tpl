{if and( $node.object.data_map.page.has_content, or( $node.data_map.show_submenu.content|eq(1), $node.node_id|eq( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) ) )}
    {attribute_view_gui attribute=$node.object.data_map.page}
{else}
    <div class="content-view-full class-folder row">

        {include uri='design:nav/nav-section.tpl'}

        <div class="content-main">

            <h1>{$node.name|wash()}</h1>

            {if $node.object.data_map.page.has_content}
                {attribute_view_gui attribute=$node.object.data_map.page}
            {else}
                {*if $node|has_attribute( 'short_description' )}
                  <div class="abstract">
                  {attribute_view_gui attribute=$node|attribute( 'short_description' )}
                  </div>
                {/if*}

                {*if $node|has_attribute( 'tags' )}
                <div class="tags">
                  {foreach $node.data_map.tags.content.keywords as $keyword}
                    <span class="label label-primary">{$keyword}</span>
                {/foreach}
                </div>
                {/if*}

                {*include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' )*}

                {*if $node|has_attribute( 'description' )}
                  <div class="description">
                    {attribute_view_gui attribute=$node|attribute( 'description' )}
                  </div>
                {/if*}

                {include uri='design:parts/children.tpl' view='line'}
            {/if}

        </div>


    </div>
{/if}
