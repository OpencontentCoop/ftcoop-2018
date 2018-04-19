{* subsribe_success_no.tpl is shown after subscribtion to a newsletter list is failed

    $newsletter_user
    $mail_send_result
    $user_email_already_exists
    $subscription_result_array
    $back_url_input
*}

<div class="container">

    <div class="content-view-full newsletter newsletter-subscribe_success_not row">

        <div class="content-main wide">

            <h1>{'Newsletter - subscribe unsuccessfull'|i18n( 'cjw_newsletter/subscribe_success_not' )}</h1>
            <p  class="newsletter-maintext">
                {'Please contact the system administrator'|i18n( 'cjw_newsletter/subscribe_success_not' )}
            </p>
            <p><a class="btn-info" href="{$back_url_input}">{'back'|i18n( 'cjw_newsletter/subscribe_success_not' )}</a></p>

        </div>
    </div>
</div>

