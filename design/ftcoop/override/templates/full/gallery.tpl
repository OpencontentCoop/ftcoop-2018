{* Gallery - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">

    {include uri='design:nav/nav-section.tpl'}

    <div class="content-main">

        <h1>{$node.name|wash()}</h1>

        {if $node|has_attribute( 'short_description' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'short_description' )}
            </div>
        {/if}

        {if $node|has_attribute( 'description' )}
            <div class="abstract">
                {attribute_view_gui attribute=$node|attribute( 'description' )}
            </div>
        {/if}

        {if fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
                    'class_filter_type', 'include',
                    'class_filter_array', array( 'image' ) ) )}

            {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
                                                                'class_filter_type', 'include',
                                                                'class_filter_array', array( 'image' ),
                                                                'sort_by', $node.sort_array ) )}

            {include uri='design:atoms/gallery.tpl' items=$children}
        {/if}

        {if fetch( 'content', 'list_count', hash( 'parent_node_id', $node.node_id,
        'class_filter_type', 'include',
        'class_filter_array', array( 'video', 'web_tv' ) ) )}

            {def $children = fetch( 'content', 'list', hash( 'parent_node_id', $node.node_id,
            'class_filter_type', 'include',
            'class_filter_array', array( 'video', 'web_tv' ),
            'sort_by', $node.sort_array ) )}

            {include uri='design:atoms/video_gallery.tpl' items=$children}
        {/if}

    </div>

    {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
    {*include uri='design:parts/content-related.tpl'*}

</div>

{include uri='design:parts/load_website_toolbar.tpl'}