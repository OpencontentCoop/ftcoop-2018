{set_defaults(hash('show_title', true(), 'items_per_row', 1))}
<div class="openpa-widget {$block.view}">
    {if and( $show_title, $block.name|ne('') )}
        <h3 class="openpa-widget-title"><span>{$block.name|wash()}</span></h3>
    {/if}
    <div class="openpa-widget-content sait-offers facet-search" id="sait-offers-{$block.id}">
        <a href="#" class="btn btn-primary btn-lg btn-block open-xs-filter visible-xs"><i class="fa fa-filter"></i> Filtri</a>
        <div class="row filters-wrapper hidden-xs"></div>
        <div class="row current-filters-wrapper">
            <div class="col-sm-12">
                <ul class="list-inline current-filter"></ul>
            </div>
        </div>
        <div class="offers-result row panels-container"></div>
        <div class="offers-more row"></div>
    </div>
</div>

{def $fc_iva = $block.custom_attributes.fc_iva}

{run-once}
{ezcss_require(array('offers.css'))}

{literal}

    <script id="tpl-offer-filter" type="text/x-jsrender">
        <div class="col-xs-12 col-sm-4 filter-wrapper">
            <h4 class="widget_title">
                <a data-toggle="collapse" href="#{{:queryField}}" aria-expanded="false" aria-controls="{{:queryField}}">
                    <i class="fa fa-plus"></i>
                    <span>{{:label}}</span>
                </a>
                <ul class="list-inline current-xs-filters"></ul>
            </h4>
            <div class="widget collapse" id="{{:queryField}}">
                <ul class="nav nav-pills nav-stacked" data-filter="{{:queryField}}">
                  <li class="remove-filter"><a href="#" data-value="all">Rimuovi filtri</a></li>
                </ul>
            </div>
        </div>
    </script>

    <script id="tpl-offer-close-xs-filter" type="text/x-jsrender">
        <a href="#{{:id}}" class="btn btn-primary btn-lg btn-block close-xs-filter" style="display: none;"><i class="fa fa-times"></i> Chiudi</a>
    </script>

    <script id="tpl-offer-spinner" type="text/x-jsrender">
        <div class="col-xs-12 spinner text-center">
            <i class="fa fa-circle-notch fa-spin fa-3x fa-fw"></i>
            <span class="sr-only">Loading...</span>
        </div>
    </script>

    <script id="tpl-offer-empty" type="text/x-jsrender">
        <div class="col-xs-12 text-center">
          <div class="alert alert-warning">Nessun risultato trovato</div>
        </div>
    </script>

    <script id="tpl-offer-item" type="text/x-jsrender">
        <div class="col-sm-6 col-md-4 offer">
            <div class="media-panel">
              {{if image}}
                <div class="offer-img">
                  <img src="{{:image}}" class="img-responsive" alt="{{:title}}" title="{{:title}}">
                </div>
              {{/if}}
              <div class="media{{if image}} has-image{{/if}}" style="min-height:230px">
                <div class="caption">
                  <h4>{{:title}}</h4>
                </div>
                <div class="offer-info">
                {{if meccanica == "MeccanicheKg"}}
                <div class="price-tag">
                    <div class="price-tag-value">{{:prezzo_offerta}}</div>
                    <div class="price-tag-footer">{{:unita_vendita}}</div>
                </div>
                {{else meccanica == "MeccanicheScontato"}}
                <div class="price-tag">
                    <div class="price-tag-header">Anzichè {{:prezzo_base}}</div>
                    <div class="price-tag-value">{{:prezzo_offerta}}</div>
                    <div class="price-tag-footer">{{:unita_vendita}}</div>
                </div>
                {{else meccanica == "MeccanicheDuePerUno"}}
                  <div class="price-tag">
                    <div class="price-tag-header">al pezzo</div>
                    <div class="price-tag-value">{{:prezzo_offerta}}</div>
                    {{if prezzo_offerta_kg_lt != 0 }}
                      <div class="price-tag-footer">{{:prezzo_offerta_kg_lt}} {{:unita_vendita}}</div>
                    {{/if}}
                  </div>
                {{else}}
                  <div class="price-tag">
                    <div class="price-tag-value">{{:prezzo_offerta}}</div>
                    {{if prezzo_offerta_kg_lt != 0 }}
                      <div class="price-tag-footer">{{:prezzo_offerta_kg_lt}} {{:unita_vendita}}</div>
                    {{else}}
                      {{if unita_vendita }}
                        {{:unita_vendita}}
                      {{/if}}
                    {{/if}}

                    {{if meccanica == "MeccanicheSottocosto" }}
                      {{if pezzi_disponibili && pezzi_disponibili != "?" }}
                        <div class="price-tag-footer">
                          PEZZI DISPONIBILI: <strong>{{:pezzi_disponibili}}</strong>
                        </div>
                      {{/if}}
                    {{/if}}

                  </div>
                {{/if}}
                </div>

                {{if meccanica == "MeccanicheSoci" }}
                  <div class="sconto-soci">
                    <p>solo per i soci ulteriore</p>
                    <strong>sconto 10%</strong>
                  </div>
                {{/if}}

                {{if meccanica == "MeccanicheDuePerUno" }}
                  <div class="ribbon ribbon-yellow">
                    <div class="banner">
                      <div class="text">2 x 1</div>
                    </div>
                  </div>
                {{/if}}

                {{if meccanica == "MeccanicheScontato" }}
                    <div class="ribbon ribbon-red">
                      <div class="banner">
                        <div class="text">sconto {{:sconto}}</div>
                      </div>
                    </div>
                {{/if}}

                {{if meccanica == "MeccanicheSottocosto" }}
                  <div class="ribbon ribbon-yellow">
                    <div class="banner">
                      <div class="text">Sotto costo</div>
                    </div>
                  </div>
                {{/if}}

                <div class="offer-date">
                    dal {{:data_inizio}} al {{:data_fine}}
                </div>

              </div>
            </div>
        </div>

    </script>
    <script id="tpl-load-more" type="text/x-jsrender">
    <div class="col-xs-12 text-center">
        <a href="#" id="load-more" data-offset="{{:offset}}" class="btn btn-primary btn-lg">Carica altre offerte</a>
    </div>
    </script>
{/literal}
{/run-once}

{ezscript_require(array('offers_search.js'))}


<script>
{literal}
  $(document).ready(function () {

    $('{/literal}#sait-offers-{$block.id}{literal}').offerSearchView({
      'query': '{/literal}{$fc_iva}{literal}',
      'filters':[{label: 'Punti Vendita', queryField: 'puntivendita'}],
      'filterTpl': '#tpl-offer-filter',
      'spinnerTpl': '#tpl-offer-spinner',
      'emptyTpl': '#tpl-offer-empty',
      'itemTpl': '#tpl-offer-item',
      'loadOtherTpl': '#tpl-load-more'
    });

  });
{/literal}
</script>