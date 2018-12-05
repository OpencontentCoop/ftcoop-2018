<div class="modal fade" id="orari-di-apertura-modal" tabindex="-1" role="dialog" aria-labelledby="OrariDiAperturaModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title" id="OrariDiAperturaModalLabel">Orari di apertura</h3>
      </div>
      <div class="modal-body">
        {def $markets = fetch( 'content', 'tree', hash( 'parent_node_id', 2, 'class_filter_array', array( 'punto_vendita' ), 'class_filter_type', 'include', 'sort_by', array( 'name', true() ) ) )}
          <div class="row">    
          {foreach $markets as $market}
            <div class="col-md-6">
              <h3 class="text-center"><a href="{$market.url_alias|ezurl(no)}"><i class="fa fa-shopping-cart"></i> {$market.name|wash()}</a></h3>
              <ul class="list-unstyled">
              <li class="text-center" style="line-height: 1;margin-bottom: 10px;text-transform: uppercase;"><a href="http://maps.google.com/maps?q={$market|attribute('geo').content.address|wash()}"><small>{$market|attribute('geo').content.address}</small></a></li>
              <li class="text-center" style="line-height: 1.2">
                {if $market|has_attribute('orario')}
                  <span data-market="{$market.contentobject_id}"></span>
                  <div style="display: none">{attribute_view_gui attribute=$market|attribute('orario')}</div>
                {elseif $market|has_attribute('note_orario')}
                  {attribute_view_gui attribute=$market|attribute('note_orario')}
                {else}
                  <em><i class='fa fa-clock'></i> n.p.</em>
                {/if}
              </li>
            </ul>              
            </div>
          {delimiter modulo=2}</div><div class="row">{/delimiter}
          {/foreach}
          </div>
        {undef $markets}
      </div>      
    </div>
  </div>
</div>