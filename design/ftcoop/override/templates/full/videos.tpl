{def $data = facet_navigation(  
  hash(
	'subtree_array', array( $node.node_id ),  
	'class_id', array( 'web_tv ' ),  
	'offset', $view_parameters.offset,  
	'sort_by', hash( 'published', 'desc' ),	
	'facet', array(
        hash( 'field', solr_field('categorie', 'lckeyword'), 'name', 'Categoria', 300 ),
        hash( 'field', solr_subfield('data_registrazione', 'year', 'date'), 'name', 'Anno', 300, 'sort', 'alpha' )
	 ),	
	'limit', 10
  ),
  $view_parameters,
  $node.url_alias,
)}



{ezscript_require( array( 'ezjsc::jquery', 'ezjsc::jqueryio', 'plugins/chosen.jquery.js', 'jquery.facetnavigation.js' ) )}
<script>
{literal}
$(document).ready(function(){
  $('#facetcontainer').facetnavigation({
        useForm: true,
        navigationContainer: ".nav-facets-horizontal",
        json:'{/literal}{$data.json_params}{/literal}',
        token:'{/literal}{$data.token}{/literal}',
        template:{
          content: {
                name: "parts/children-facet.tpl",
                view: "line",
                page_limit: 10
          },
          navigation: "nav/nav-section-facet-horizontal.tpl",          
        },
        chosen: {
          allow_single_deselect:true          
        }
  });
});
{/literal}
</script>

<div id="facetcontainer" class="content-view-full class-folder row">
  
  {*include uri='design:nav/nav-section.tpl'*}

  <div class="container">
    <div class="row">
      <div class="content-main wide">

        <div class="page-header">
          <h1>{$node.name|wash()}</h1>
        </div>

        {if $node|has_attribute( 'short_description' )}
          <div class="abstract">
            {attribute_view_gui attribute=$node|attribute( 'short_description' )}
          </div>
        {/if}


      </div>
    </div>
  </div>


  <section>
    <div class="section-header alt2">

      <div class="container">
        <div class="row">
          <div class="max-width">

            {include uri='design:nav/nav-section-facet-horizontal.tpl' data=$data}

          </div>
        </div>
      </div>
    </div>
  </section>

  <div class="container">
    <div class="row">
      <div class="max-width">
        {include uri='design:parts/children-facet.tpl' view='line' data=$data page_limit=10}
      </div>
    </div>
  </div>

</div>
