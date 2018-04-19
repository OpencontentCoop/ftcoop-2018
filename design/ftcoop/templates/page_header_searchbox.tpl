<form role="form"
      class="form form-search"
      method="get"
      action="{"/content/search"|ezurl(no)}"
      id="site-wide-search"
      {if is_set( $pagedata.persistent_variable.hide_header_searchbox )}style="visibility: hidden"{/if}>
    <div class="form-group">
        <label for="site-wide-search-field" class="control-label sr-only">Cerca</label>

        <div class="input-group">
            <span class="input-group-btn">
                <button type="submit" class="btn" style="background: none">
                    <span class="fa fa-search"></span>
                </button>
            </span>
            <input class="form-control"
                   type="search" name="SearchText"
                   id="site-wide-search-field" placeholder="Cerca" {if $pagedata.is_edit}disabled="disabled"{/if}>

            {if and($pagedata.is_edit|not, eq( $ui_context, 'browse' ))}
                <input name="Mode" type="hidden" value="browse"/>
            {/if}
        </div>
    </div>
</form>
