{def $limit = 18}


    <h1>{$tag.keyword|wash}</h1>



    {def $nodes_count = fetch( content, tree_count, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                          extended_attribute_filter,
                                                          hash( id, TagsAttributeFilter,
                                                                params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                                          main_node_only, true() ) )}

    {if $nodes_count}
        {def $nodes = fetch( content, tree, hash( parent_node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                          extended_attribute_filter,
                                          hash( id, TagsAttributeFilter,
                                                params, hash( tag_id, $tag.id, include_synonyms, true() ) ),
                                          offset, first_set( $view_parameters.offset, 0 ), limit, $limit,
                                          main_node_only, true(),
                                          sort_by, array( modified, false() ) ) )}

        {def $size = 3}
        {def $col = 12|div($size)}

        
        <div class="row panels-container"> 
          {foreach $nodes as $child }
            <div class="col-md-{$col}">
              {node_view_gui content_node=$child view=panel image_class=widemedium}
            </div>
            {delimiter modulo=$size}</div><div class="row panels-container">{/delimiter}
          {/foreach}
        </div>          
        
    {/if}
    


    {include uri='design:navigator/google.tpl'
             page_uri=concat( '/tags/view/', $tag.url )
             item_count=$nodes_count
             view_parameters=$view_parameters
             item_limit=$limit}

   
{undef $limit $nodes $nodes_count}