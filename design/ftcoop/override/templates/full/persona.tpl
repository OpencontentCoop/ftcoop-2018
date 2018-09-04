{ezpagedata_set('require_container', false())}
{* Persona - Full view *}

<div class="container">
  <div class="content-view-full class-{$node.class_identifier} row">

    {*include uri='design:nav/nav-section.tpl'*}

    <div class="content-main wide">

      <div class="page-header">
        <h1> {attribute_view_gui attribute=$node.data_map.nome} {attribute_view_gui attribute=$node.data_map.cognome}</h1>
      </div>

      {if $node|has_attribute( 'abstract' )}
        <div class="abstract">
          {attribute_view_gui attribute=$node|attribute( 'abstract' )}
        </div>
      {/if}
    
      <div class="row">
	  
	  {if $node|has_attribute( 'image' )}


	  <div class="col-sm-3">
		  {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='large' css_class="media-object"}
	  </div>
	  {/if}
	
	  <div class="col-sm-{if $node|has_attribute( 'image' )}9{else}12{/if}">
		
		<dl class="dl-horizontal">		
		{if $node.object.parent_nodes|contains(ezini( 'NodiRilevanti', 'Dipendenti', 'ftcoop.ini' ))}
            {* la persona e' dipendente della federazione *}

          {if and(
              $node.object.parent_nodes|contains( ezini( 'NodiRilevanti', 'ConsiglioAmministrazione', 'ftcoop.ini' ) )|not(),
              $node.object.parent_nodes|contains( ezini( 'NodiRilevanti', 'Presidenza', 'ftcoop.ini' ) )|not(),
              $node.object.parent_nodes|contains( ezini( 'NodiRilevanti', 'Direzione', 'ftcoop.ini' ) )|not()
              )}
            {if $node.object.data_map.email.has_content}
                <dt>{$node.data_map.email.contentclass_attribute_name}</dt>
                <dd>{attribute_view_gui attribute=$node.data_map.email}</dd>
            {/if}
            {*if $node.object.data_map.telefono.has_content}
                <dt>{$node.data_map.telefono.contentclass_attribute_name}</dt>
                <dd>{attribute_view_gui attribute=$node.data_map.telefono}</dd>
            {/if*}
          {/if}
        {/if}

        {if $node.object.data_map.interno.has_content}
              <dt>{$node.data_map.interno.contentclass_attribute_name}</dt>
              <dd>{attribute_view_gui attribute=$node.data_map.interno}</dd>
        {/if}
        {if $node.object.data_map.fax.has_content}
              <dt>{$node.data_map.fax.contentclass_attribute_name}</dt>
              <dd>{attribute_view_gui attribute=$node.data_map.fax}</dd>
        {/if}
        {if $node.object.data_map.servizio.has_content}
              <dt>{$node.data_map.servizio.contentclass_attribute_name}</dt>
              <dd>{attribute_view_gui attribute=$node.data_map.servizio}</dd>
        {/if}
        {if $node.object.data_map.ufficio.has_content}
              <dt>{$node.data_map.ufficio.contentclass_attribute_name}</dt>
              <dd>{attribute_view_gui attribute=$node.data_map.ufficio}</dd>
        {/if}
        {if $node.object.data_map.ruolo.has_content}
              <dt>{$node.data_map.ruolo.contentclass_attribute_name}</dt>
              <dd>{attribute_view_gui attribute=$node.data_map.ruolo}</dd>
        {/if}
		
		</dl>
        {if $node.object.data_map.competenze.has_content}
            <div class="description">                
              {attribute_view_gui attribute=$node.data_map.competenze}
            </div>
        {/if}        

        {include uri="design:parts/persona/incarichi.tpl" node=$node}
		
	  </div>
	</div>

    </div>
  </div>
</div>


{def $filtri_comunicati = array(concat(solr_meta_subfield('relazioni','id'),':',$node.contentobject_id))
     $filtri_web_tv = array(concat(solr_meta_subfield('persone','id'),':',$node.contentobject_id))
     $filtri_audio = array(concat(solr_meta_subfield('relazioni','id'),':',$node.contentobject_id))
     $filtri_pubblicazioni = array(concat(solr_meta_subfield('relazioni','id'),':',$node.contentobject_id))}

{def $comunicati_rel = fetch('ezfind', 'search', hash('class_id', array( 'comunicato' ),
      'sort_by', hash( 'published', 'desc' ),
      'limit', 10,
      'filter', $filtri_comunicati
      ))
     $web_tv_rel = fetch('ezfind', 'search', hash('class_id', array( 'web_tv' ),
      'sort_by', hash( 'published', 'desc' ),
      'limit', 3,
      'filter', $filtri_web_tv
      ))
     $audio_rel = fetch('ezfind', 'search', hash('class_id', array( 'audio' ),
      'sort_by', hash( 'published', 'desc' ),
      'limit', 3,
      'filter', $filtri_audio
      ))
     $pubblicazioni_rel = fetch('ezfind', 'search', hash('class_id', array( 'pubblicazione' ),
      'sort_by', hash( 'published', 'desc' ),
      'limit', 3,
      'filter', $filtri_pubblicazioni
      ))}

{if or($comunicati_rel.SearchCount,
       $web_tv_rel.SearchCount,
       $audio_rel.SearchCount,
       $pubblicazioni_rel.SearchCount
)}


  <div class="container">
    <div class="row">

      <div class="max-width">

        {if $comunicati_rel.SearchCount}
          <h3>Comunicati stampa</h3>
          <div class="carousel-container owl-carousel-contained">
            {include uri='design:atoms/owl_carousel.tpl' items=$comunicati_rel.SearchResult i_view='grid_item'}
          </div>
        {/if}

        {if $web_tv_rel.SearchCount}
          <h3>Video</h3>
          <div class="carousel-container owl-carousel-contained">
            {include uri='design:atoms/owl_carousel.tpl' items=$web_tv_rel.SearchResult i_view='grid_item'}
          </div>
        {/if}

        {if $audio_rel.SearchCount}
          <h3>Audio</h3>
          <div class="carousel-container owl-carousel-contained">
            {include uri='design:atoms/owl_carousel.tpl' items=$audio_rel.SearchResult i_view='grid_item'}
          </div>
        {/if}

        {if $pubblicazioni_rel.SearchCount}
          <h3>Pubblicazioni</h3>
          <div class="carousel-container owl-carousel-contained">
            {include uri='design:atoms/owl_carousel.tpl' items=$pubblicazioni_rel.SearchResult i_view='grid_item'}
          </div>
        {/if}

      </div>
    </div>

  </div>

{/if}


{undef}


