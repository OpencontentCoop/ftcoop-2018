{ezpagedata_set('require_container', false())}
<div class="content-view-full class-{$node.class_identifier} row">
  
  <div class="content-main wide">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}
    
    {include uri='design:atoms/image.tpl' image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )}
	
    {if $node|has_attribute( 'description' )}
	  <div class="description">
		
		{if $node|has_attribute( 'geo' )}
		  <div class="geo col-md-5 pull-right hidden-xs hidden-sm">
			<div class="panel panel-default">
			  {attribute_view_gui attribute=$node|attribute( 'geo' )}
			</div>
		  </div>		
		{/if} 
		
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}  
	
    {if $node.object.data_map.show_children.data_int}

      {*include uri='design:parts/children-infinitescroll.tpl'
			   parent_node = fetch( content, node, hash( node_id, ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )
			   type='include'
			   include_classes=ezini( 'FederazioneSettings', 'TopmenuClassiSottositi', 'ftcoop.ini' )
			   view='panel'*}

      {def $root_node = fetch( 'content' , 'node' , hash( 'node_id' , ezini( 'NodeSettings', 'RootNode', 'content.ini' )))
           $subsite_menuhidden = ezini( 'FederazioneSettings', 'TopmenuSottositiNascosti', 'ftcoop.ini' )
           $sottositi_t = fetch( 'content', 'list', hash( 'parent_node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ),
                                                        'sort_by', $root_node.sort_array,
                                                        'limitation', array(),
                                                        'attribute_filter', array( array( 'section', 'in', array( 1, 10 ) ) ),
                                                        'class_filter_type', 'include',
                                                        'class_filter_array', ezini( 'FederazioneSettings', 'TopmenuClassiSottositi', 'ftcoop.ini' )
      ))}


      {def $sottositi = array()}
      {foreach $sottositi_t as $it}
        {if $subsite_menuhidden|contains($it.node_id)|not()}
          {set $sottositi=$sottositi|append($it)}
        {/if}
      {/foreach}



      {foreach $sottositi as $i => $child }

        {def $url = $child.url_alias|ezurl}
        {if and( $child.data_map.link, $child.data_map.link.has_content )}
          {set $url = $child.data_map.link.content}
        {/if}


        {if $i|eq(0)}
          <div class="row">
        {/if}

          <div class="sottosito">

            <div class="thumbnail">
              {*
                {if and( $child.data_map.image, $child.data_map.image.has_content )}
                  {attribute_view_gui attribute=$child.data_map.image image_class=large href=$url}
                {else}
                  <div style="opacity:0.5">{attribute_view_gui attribute=$node.data_map.image image_class=large href=$url}</div>
                {/if}
              *}
              <div class="caption">
                <h3><a href={$url}>{$child.name|wash()}</a></h3>
                {*if and( $child.data_map.slug, $child.data_map.slug.has_content )}
                  {attribute_view_gui attribute=$child.data_map.slug}
                {/if*}
              </div>

            </div>
          </div>

        {undef $url}

        {if eq(sum($i,1)|mod(3),0)}
          </div>
          <div class="row">
        {/if}
        {if $i|eq($sottositi|count()|sub(1))}
          </div>
        {/if}

      {/foreach}


    {/if}

  </div>


</div>
