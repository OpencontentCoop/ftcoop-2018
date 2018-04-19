{* subsribe_success_ez_user - if ez user has successfully subscribe to a newsletter

    $newsletter_user
    $mail_send_result
    $user_email_already_exists
    $subscription_result_array
    $back_url_input
*}


<div class="container">

    <div class="content-view-full newsletter newsletter-subscribe_success_ez_user row">

        <div class="content-main wide">

                <h1>{'Newsletter - subscribe success'|i18n( 'cjw_newsletter/subscribe_success' )}</h1>

                <p  class="newsletter-maintext">
                    {'You are registered for our newsletter.'|i18n( 'cjw_newsletter/subscribe_success' )}
                </p>

                <p>
                    <a class="btn btn-info" href="{$back_url_input}">{'back'|i18n( 'cjw_newsletter/subscribe_success' )}</a>
                </p>

        </div>
    </div>

</div>

