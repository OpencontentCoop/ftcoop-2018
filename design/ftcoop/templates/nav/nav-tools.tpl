{if $subsite|has_attribute('tools')}
    {def $nav_tools_items = array()}
    {foreach $subsite|attribute('tools').content.relation_list as $item}
        {set $nav_tools_items = $nav_tools_items|append(fetch(content, node, hash('node_id', $item.node_id)))}
    {/foreach}
{elseif $root_node|has_attribute('tools')}
    {def $nav_tools_items = array()}
    {foreach $root_node|attribute('tools').content.relation_list as $item}
        {set $nav_tools_items = $nav_tools_items|append(fetch(content, node, hash('node_id', $item.node_id)))}
    {/foreach}
{/if}

<div class="collapse navbar-collapse nav-tools">
  <ul class="nav navbar-nav navbar-right">

    <li class="search">
      {include uri='design:page_header_searchbox.tpl'}
    </li>

    {if count($nav_tools_items)}
    {foreach $nav_tools_items as $item}
      <li {if $item.remote_id|begins_with('alt_')}class="alt"{/if}>
        <a href={$item.url_alias|ezurl()} title="vai alla sezione '{$item.name|wash()}'">{$item.name|wash()}</a>
      </li>
    {/foreach}
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
