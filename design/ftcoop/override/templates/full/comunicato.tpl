{ezpagedata_set('require_container', false())}
{* Comunicato - Full view *}

{* estrae video e immagini collegate al comunicato: figli e relazioni *}
{def $images = array()
     $videos = array()
     $videos_classes = appini( 'ClassesSettings', 'VideoClasses', array() )
}
{if $node.data_map.image.has_content}
  {set $images = $images|append( $node )}
{/if}
{if $node.data_map.related_media.has_content}
  {foreach $node.data_map.related_media.content.relation_list as $related}
    {if $related.contentclass_identifier|eq('image')}
      {set $images = $images|append( fetch( 'content', 'node', hash( 'node_id', $related.node_id ) ) )}
    {elseif $related.contentclass_identifier|eq('web_tv')}
      {set $videos = $images|append( fetch( 'content', 'node', hash( 'node_id', $related.node_id ) ) )}
    {/if}
  {/foreach}
{/if}
{def $children_media = fetch( 'content', 'list',  hash( 'parent_node_id', $node.object.main_node.node_id,
                                                        'class_filter_type', 'include',
                                                        'class_filter_array', array('image', 'web_tv'),
                                                        'sort_by', $node.object.main_node.sort_array,
                                                        'limit', 20 ) )}
{foreach $children_media as $m}

  {if $videos_classes|contains($m.object.class_identifier)}
    {set $videos = $videos|append($m)}
  {elseif $m.object.class_identifier|eq('image')}
    {set $images = $images|append($m)}
  {/if}

{/foreach}


{include uri="design:parts/opengraph_set_persistent.tpl"}

<div class="container">
  <div class="content-view-full class-{$node.class_identifier} row">

    {*include uri='design:nav/nav-section.tpl'*}

      <div class="content-main wide">

      <div class="page-header">
        <span class="date">{$node.object.published|l10n(date)}</span>
        <h1>{$node.name|wash()}</h1>
      </div>

      {if $node|has_attribute( 'abstract' )}
        <div class="abstract">
          {attribute_view_gui attribute=$node|attribute( 'abstract' )}
        </div>
      {/if}

      {if or($images|count()|gt(0),$node|has_attribute("relazioni"))}

      <div class="row">
        {if $images|count()|gt(0)}
          <div class="col-md-8">

            <div class="carousel-container owl-carousel-single same-height">
              {include uri='design:atoms/owl_carousel.tpl' items=$images images_only=true()}
            </div>
          </div>
        {/if}
        {if $node|attribute("relazioni")}

          {def $relazioni=array()}
          {def $cooperative=array()
               $persone = array()
               $associazioni = array()
          }

          {foreach $node.data_map.relazioni.content.relation_list as $relazione }
            {if $relazione.contentclass_identifier|eq('societa')}
              {set $cooperative = $cooperative|append($relazione)}
              {set $relazioni = $relazioni|append($relazione)}
            {elseif $relazione.contentclass_identifier|eq('personale')}
              {set $persone = $persone|append($relazione)}
              {set $relazioni = $relazioni|append($relazione)}
            {elseif $relazione.contentclass_identifier|eq('associazione')}
              {set $associazioni = $associazioni|append($relazione)}
              {set $relazioni = $relazioni|append($relazione)}
            {else}
              {* non dovrebbe mai passare di qui *}
              {debug-log var=$node msg="Le relazioni con cooperative, persone e associazioni contengono altri oggetti, per favore controlla!"}
            {/if}
          {/foreach}
          
          <div class="col-md-{if $images|count()|gt(0)}4{else}12{/if}">
            {include uri='design:parts/si_parla_di.tpl' css_class='same-height' items=$relazioni}
          </div>
        {/if}
      </div>


      {if $node|has_attribute( 'body' )}
        <div class="description">
          {attribute_view_gui attribute=$node|attribute( 'body' )}
        </div>
      {/if}

      {if $node.data_map.file.has_content}

        {attribute_view_gui attribute=$node.data_map.file show_icon=true() css_class="file-box" icon_download="fa fa-2x fa-download"}

        {*
        <div class="panel panel-primary">
          <div class="panel-heading">
            <h3 class="panel-title">{$node.data_map.file.contentclass_attribute_name}</h3>
          </div>
          <div class="panel-body">
            {attribute_view_gui attribute=$node.data_map.file}
          </div>
        </div>
        *}
      {/if}


      {* nessun attributo tags nel comunicato *}
      {*if $node|has_attribute( 'tags' )}
        <div class="tags">
          {attribute_view_gui attribute=$node|attribute( 'tags' )}
        </div>
      {/if*}

      {*if $node|has_attribute( 'star_rating' )}
        <div class="rating">
          {attribute_view_gui attribute=$node|attribute( 'star_rating' )}
        </div>
      {/if*}

      <div class="content-bottom">
        {include uri='design:parts/social_buttons.tpl'}
      </div>

    </div>
  </div>
</div>

{def   $related_object_ids = array()
$organizzazioni_object_ids = array()
$filtri_comunicati = array()
$filtri_web_tv = array()
$comunicati_rel = array()
$web_tv_rel = array()}

{* crea un array con gli object_ids delle organizzazioni correlate al nodo corrente *}
{foreach $cooperative as $c}
  {set $related_object_ids = $related_object_ids|append($c.contentobject_id)}
{/foreach}

{foreach $associazioni as $a}
  {set $related_object_ids = $related_object_ids|append($a.contentobject_id)}
{/foreach}

{foreach $related_object_ids as $kk => $rel_id}
  {set $filtri_web_tv = $filtri_web_tv|append(concat(solr_meta_subfield('cooperative','id'),':',$rel_id))}
{/foreach}

{* se non ci sono organizzazioni, prende le persone *}
{if eq($related_object_ids|count(),0)}
  {* crea un array con gli object_ids delle persone correlate al nodo corrente*}
  {foreach $persone as $p}
    {set $related_object_ids = $related_object_ids|append($p.contentobject_id)}
    {set $filtri_web_tv = $filtri_web_tv|append(array(concat(solr_meta_subfield('persone','id'),':',$p.contentobject_id)))}
  {/foreach}
{/if}

{* prende tutti i comunicati associati a organizzazioni e persone associate al nodo corrente *}

{foreach $related_object_ids as $kk => $rel_id}
  {set $filtri_comunicati = $filtri_comunicati|append(concat(solr_meta_subfield('relazioni','id'),':',$rel_id))}
{/foreach}

{* se c'è più di una condizione, mette in or le condizioni *}
{if gt($related_object_ids|count,1)}
  {set $filtri_comunicati = $filtri_comunicati|prepend('or')}
  {set $filtri_web_tv = $filtri_web_tv|prepend('or')}
{/if}

{* aggiunge la condizione per escludere il comunicato corrente ($node) dalla fetch *}
{if gt($filtri_comunicati|count(),0)}
  {set $filtri_comunicati = array(concat('NOT ', solr_meta_field('id'),':',$node.contentobject_id),$filtri_comunicati)}
{/if}
{*
  $filtri comunicati è:
  una condizione:
  array('NOT solr_meta_field('id'):<$node.contentobject_id>',array(solr_meta_subfield('relazioni','id'),':YYYY'))

  più condizioni
  array('NOT solr_meta_field('id'):<$node.contentobject_id>',array('solr_meta_subfield('relazioni','id'):YYYY','solr_meta_subfield('relazioni','id'):ZZZZ',...))
*}


{if gt($filtri_comunicati|count(),0)}
  {set $comunicati_rel = fetch('ezfind', 'search', hash('class_id', array( 'comunicato' ),
  'sort_by', hash( 'published', 'desc' ),
  'limit', 10,
  'filter', $filtri_comunicati,
  'subtree_array', array(147)
  ))}
{/if}
{if gt($filtri_web_tv|count(),0)}
  {set $web_tv_rel = fetch('ezfind', 'search', hash('class_id', array( 'web_tv' ),
  'sort_by', hash( 'published', 'desc' ),
  'limit', 10,
  'filter', $filtri_web_tv
  ))}
{/if}


{if or($comunicati_rel.SearchCount,$web_tv_rel.SearchCount)}
<section>
  <div class="section-header alt">

    <div class="container">
      <div class="row">
        <div class="max-width">
          <h2>Ti può interessare anche...</h2>
        </div>
      </div>
    </div>

  </div>



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
      </div>
    </div>
  </div>
</section>
{/if}




{include uri="design:parts/more_like_this.tpl"
comunicati=$comunicati_rel.SearchResult
web_tv=$web_tv_rel.SearchResult
title="Ti può interessare anche..."}
	

    {*if $node|has_attribute( 'comments' )}
      <div class="comments">
        {attribute_view_gui attribute=$node|attribute( 'comments' )}
      </div>
    {/if*}
{include uri='design:parts/load_website_toolbar.tpl'}