
<div class="collapse navbar-collapse nav-tools">
  <ul class="nav navbar-nav navbar-right">

    <li class="search">
      {include uri='design:page_header_searchbox.tpl'}
    </li>
    <li class="ftcoop-link">
      <a href="https://www.cooperazionetrentina.it/">Cooperazione Trentina</a>
    </li>    

    {if $current_user.is_logged_in}
        <li><a href="{'/content/dashboard'|ezurl( 'no' )}" class="teaser-link">Pannello strumenti </a></li>
        <li><a href="{'/datamonitor/dashboard'|ezurl( 'no' )}" class="teaser-link">Datamonitor </a></li>
    {/if}

    {if ftcoop_pagedata().show_login}
    <li id="login" class="dropdown">
      <a href="#" title="hide login form" class="dropdown-toggle" data-toggle="dropdown">Accedi</a>
      <div class="panel dropdown-menu" style="min-width: 250px;padding: 10px;">
        <form class="login-form" action={"/user/login"|ezurl()} method="post">
          <fieldset>
            <div class="form-group">
              <label for="login-username" class="sr-only">Nome utente</label>
              <input class="form-control" type="text" name="Login" id="login-username" placeholder="Username">
            </div>
            <div class="form-group">
              <label for="login-password" class="sr-only">Password</label>
              <input class="form-control" type="password" name="Password" id="login-password" placeholder="Password">
            </div>
            <button class="btn btn-primary pull-right" type="submit">
              Accedi
            </button>
            <p class="small"><a href={"/user/forgotpassword"|ezurl()} class="forgot-password">Hai dimenticato la password?</a></p>
          </fieldset>
          <input type="hidden" name="RedirectURI" value="" />
        </form>
      </div>
    </li>
    {/if}

  </ul>
</div>
