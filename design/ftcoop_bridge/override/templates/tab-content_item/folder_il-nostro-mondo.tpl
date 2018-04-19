<div class="class-{$node.class_identifier} content-view-block-item">
	<div class="content-view-block-item-design float-break ">
        
        <div class="intro">
        
            {if $node|has_abstract}
                {$node|abstract()}
            {/if}
            
            <ul>
            {foreach fetch( 'content', 'list', hash( 'parent_node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                                      'class_filter_type', 'include',
                                                                      'class_filter_array', ezini( 'FederazioneSettings', 'TopmenuClassiSottositi', 'ftcoop.ini' ) ) ) as $child sequence array( 'column-left', 'column-right' ) as $style }
                
                {def $url = $child.url_alias|ezurl
                     $shorten = 100}
                {if and( $child.data_map.link, $child.data_map.link.has_content )}
                    {set $url = $child.data_map.link.content}
                {/if}
            
                {*if and( is_set( $child.data_map.image ), $child.data_map.image.has_content )}
                <div class="object-left">
                {attribute_view_gui attribute=$child.data_map.image image_class="preview" href=$url}
                </div>
                {set $shorten = 50}
                {/if*}
                
                <li>
                    <a href={$child.url_alias|ezurl()} title="{$child.name|wash}">{$child.name|wash}</a>
                    {if $child.data_map.slug.has_content}
                        <br /><small>{$child.data_map.slug.content|wash()}</small>
                    {/if}
                </li>
                
                {undef $url $shorten}
                
            {/foreach}
            </ul>
        
        </div>
    </div>
</div>