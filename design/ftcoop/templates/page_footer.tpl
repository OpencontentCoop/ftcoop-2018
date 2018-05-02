{def $root_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
{def $info = false()}
{if $subsite|has_attribute('info')}
  {set $info = $subsite|attribute('info')}
{elseif $root_node|has_attribute('info')}
  {set $info = $root_node|attribute('info')}
{/if}

{def $twitter_channel = false()}
{if $subsite|has_attribute('twitter_channel')}
  {set $twitter_channel = $subsite|attribute('twitter_channel')}
{elseif $root_node|has_attribute('twitter_channel')}
  {set $twitter_channel = $root_node|attribute('twitter_channel')}
{/if}

{def $facebook_channel = false()}
{if $subsite|has_attribute('facebook_channel')}
  {set $facebook_channel = $subsite|attribute('facebook_channel')}
{elseif $root_node|has_attribute('facebook_channel')}
  {set $facebook_channel = $root_node|attribute('facebook_channel')}
{/if}

{def $google_channel = false()}
{if $subsite|has_attribute('google_channel')}
  {set $google_channel = $subsite|attribute('google_channel')}
{elseif $root_node|has_attribute('google_channel')}
  {set $google_channel = $root_node|attribute('google_channel')}
{/if}

{if ftcoop_pagedata().is_global_root}
<section class="alt">
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        {include uri='design:atoms/twitter.tpl'}
      </div>
      <div class="col-md-6">
        <a class="banner-rivista">
          <h3>Approfondisci le nostre notizie!</h3>
          <p>ABBONATI ALLA RIVISTA IN COOPERAZIONE!</p>
        </a>
      </div>
    </div>
  </div>
</section>
{/if}

<footer class="hidden-print">
  {if ftcoop_pagedata().is_global_root}
  <div class="container">
    <div class="row">
      <div class="col-md-4">
        <img class="footer-logo" src={"images/logo-blu.png"|ezdesign()} class="img-responsive"  alt="" title="" />
        {if $info}
          {attribute_view_gui attribute=$info}
        {/if}


        <div class="social-buttons">

          {if $facebook_channel}
          <a href="{$facebook_channel.content|wash()}" title="Vai alla pagina Facebook">
            <span class="fa-stack fa-2x">
              <i class="far fa-circle fa-stack-2x"></i>
              <i class="fab fa-facebook-square fa-stack-1x" ></i>
            </span>
          </a>
          {/if}

          {if $twitter_channel}
          <a href="{$twitter_channel.content|wash()}" title="Vai al profilo Twitter">
           <span class="fa-stack fa-2x">
              <i class="far fa-circle fa-stack-2x"></i>
              <i class="fab fa-twitter fa-stack-1x" ></i>
           </span>
          </a>
          {/if}

          {if $google_channel}
          <a href="{$google_channel.content|wash()}" title="Vai alla pagina Google plus">
            <span class="fa-stack fa-2x">
                <i class="far fa-circle fa-stack-2x"></i>
                <i class="fab fa-google-plus-g fa-stack-1x" ></i>
            </span>
          </a>
          {/if}

        </div>

      </div>

      <div class="col-md-8">
        <div class="newsletter-box">
          <h2>Iscriviti alla newsletter!</h2>
          <p>Ricevi la nostra newsletter per rimanere sempre aggiornato sulle novità del mondo cooperativo trentino.</p>
          <form action={'/newsletter/subscribe'|ezurl()} method="post" role="form">
            <input type="email" class="form-control" id="Subscription_Email" name="Subscription_Email" placeholder="Il tuo indirizzo Email">
            <button type="submit" class="btn btn-info">Invia</button>
          </form>
        </div>

      </div>
    </div>
  </div>
  {/if}
</footer>

