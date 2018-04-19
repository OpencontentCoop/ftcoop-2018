{set_defaults( hash(
    'container_class' , ''
))}





{if $node|has_attribute( 'sigla' )}
  <div class="{$container_class}">
    <div class="icon-box same-height">
                <span class="icon-box-icon fa-stack fa-lg">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fa fa-star fa-stack-1x fa-inverse"></i>
                </span>
      <div class="icon-box-content">
        <strong>{$node|attribute( 'sigla' ).contentclass_attribute.name}:</strong>
        {attribute_view_gui attribute=$node|attribute( 'sigla' )}
      </div>
    </div>
  </div>
{/if}

{if $node|has_attribute('e_mail')}
  <div class="{$container_class}">
    <div class="icon-box same-height">
                <span class="icon-box-icon fa-stack fa-lg">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fas fa-envelope fa-stack-1x fa-inverse"></i>
                </span>
      <div class="icon-box-content">
        <strong>{$node|attribute( 'e_mail' ).contentclass_attribute.name}:</strong>
        {attribute_view_gui attribute=$node|attribute( 'e_mail' )}
      </div>
    </div>

  </div>
{/if}

{if $node|has_attribute( 'telefono' )}
  <div class="{$container_class}">
    <div class="icon-box same-height">
                <span class="icon-box-icon fa-stack fa-lg">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="fa fa-phone fa-stack-1x fa-inverse"></i>
                </span>
      <div class="icon-box-content">
        <strong>{$node|attribute( 'telefono' ).contentclass_attribute.name}:</strong>
        {attribute_view_gui attribute=$node|attribute( 'telefono' )}
      </div>
    </div>

  </div>
{/if}

{if $node|has_attribute('pec')}
  <div class="{$container_class}">
    <div class="icon-box same-height">
                <span class="icon-box-icon fa-stack fa-lg">
                  <i class="fa fa-square fa-stack-2x"></i>
                  <i class="far fa-envelope fa-stack-1x fa-inverse"></i>
                </span>
      <div class="icon-box-content">
        <strong>{$node|attribute( 'pec' ).contentclass_attribute.name}:</strong>
        {attribute_view_gui attribute=$node|attribute( 'pec' )}
      </div>
    </div>

  </div>
{/if}