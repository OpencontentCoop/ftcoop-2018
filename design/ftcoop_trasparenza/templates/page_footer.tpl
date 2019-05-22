{if is_set($pagedata)|not()}{def $pagedata = openpapagedata()}{else}{set $pagedata = openpapagedata()}{/if}
<footer class="hidden-print" style="background:none;padding:0 0 60px">
  
  <div class="container">
    <div class="row">
      <div class="col-md-{if ftcoop_pagedata().require_container}6{else}4 col-md-offset-1{/if}">
        <img class="footer-logo" src="{footerlogo()}" class="img-responsive"  alt="" title="" />
        {footercontacts()}
      </div>
    </div>
  </div>  
</footer>

