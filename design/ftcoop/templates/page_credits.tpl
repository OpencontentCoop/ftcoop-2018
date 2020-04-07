<div class="credits">
    <div class="container">
        <div class="row">
            <div class="max-width">
                <p>
                    Copyright {currentdate()|datetime( 'custom', '%Y' )}  <a href="http://www.cooperazionetrentina" title="visita il sito della Cooperazione Trentina">Cooperazione Trentina</a>
                    &middot; Powered by <a class="text-decoration-none" href="http://www.opencontent.it" title="OpenContent">OpenContent</a>
                    {if openpaini('CreditsSettings', 'CodeVersion', false())}<small class="text-muted pull-right">{openpaini('CreditsSettings', 'CodeVersion', false())}</small>{/if}
                </p>
            </div>
        </div>
    </div>
</div>
<div class="nav-supp">
    <div class="container">
        <ul class="nav navbar-nav navbar-right">
            {if $current_user.is_logged_in}
                <li id="myprofile"><a href={"/user/edit/"|ezurl} title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">{'My profile'|i18n('design/ocbootstrap/pagelayout')}</a></li>
                <li id="logout"><a href={"/user/logout"|ezurl} title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}">{'Logout'|i18n('design/ocbootstrap/pagelayout')} ( {$current_user.email|wash} )</a></li>
            {else}
                {if ezmodule( 'user/register' )}
                    <li id="registeruser"><a href={"/user/register"|ezurl} title="{'Register'|i18n('design/ocbootstrap/pagelayout')}">{'Register'|i18n('design/ocbootstrap/pagelayout')}</a></li>
                {/if}
                <li id="login" class="dropdown">
                    <a href={'/user/login'|ezurl()}>Accedi</a>
                </li>
            {/if}
        </ul>
    </div>
</div>
