{ezpagedata_set('require_container', false())}
<div class="container">
    <div class="content-view-full class-{$node.class_identifier} row">

      {def $hideNavSectionNodes = appini( 'NavSectionSettings' , 'HideNavSectionNodes', array())
           $showSectionNav = $hideNavSectionNodes|contains($node.node_id)|not()}

      {if $showSectionNav}
        {include uri='design:nav/nav-section.tpl'}
      {/if}

      <div class="content-main{if $showSectionNav|not()} wide{/if}">

      {*TODO: verificare che il controllo funzioni correttamente *}
      {if $node|has_attribute( 'hide_title' )|not}
        <div class="page-header">
          <h1>{$node.name|wash()}</h1>
        </div>
      {/if}

      {if $node|has_attribute( 'short_description' )}
        <div class="abstract clearfix">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
        </div>
      {/if}

      {*if $node|has_attribute( 'tags' )}
      <div class="tags">
        {foreach $node.data_map.tags.content.keywords as $keyword}
      <span class="label label-primary">{$keyword}</span>
      {/foreach}
      </div>
      {/if*}

      {if $node|has_attribute( 'geo' )}
          <div class="attribute-geo">
              {attribute_view_gui attribute=$node.object.data_map.geo}
          </div>
      {/if}

      {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' )}

      {if $node|has_attribute( 'description' )}
        <div class="description clearfix">
          {attribute_view_gui attribute=$node|attribute( 'description' )}
        </div>
      {/if}

      {if $node.object.data_map.show_children.data_int}
        {include uri='design:parts/children.tpl' view='line'}
      {/if}

    </div>

  </div>
</div>
