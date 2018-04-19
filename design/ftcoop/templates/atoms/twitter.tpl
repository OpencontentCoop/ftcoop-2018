{ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js' ) )}

{ezscript_require( array( 'ezjsc::jquery', 'plugins/twitterFetcher_min.js' ) )}


<div id="tweets" class="bx-1">

    <div class="owl-carousel owl-theme">

    </div>

</div>

<script>
    {literal}

    var configProfile = {
        "profile": {"screenName": 'coopertrentina'},
        "maxTweets": 4,
        "enableLinks": true,
        "showUser": true,
        "showTime": true,
        "lang": 'it',
        "customCallback": handleTweets,
        "showRetweets": false,
        "showInteraction": false,
        "dataOnly": true
    };

    function handleTweets(tweets) {
        //console.log(tweets);
        /*
        var x = tweets.length;
        var n = 0;
        var element = document.getElementById('tweets');
        var html = '<div class="">';
        //var html = '';
        while(n < x) {
            html += '<div class="carousel-item">' + tweets[n] + '</div>';
            n++;
        }
        html += '</div>';
        element.innerHTML = html;
        */

        $("#tweets > .owl-carousel").owlCarousel({
            'items': 1,
            'nav': false,
            'dots': false,
            'autoplay': true,
            'autoplaySpeed': 1000,
            'loop': true
            //onChanged: callback
        });

        var carousel = $('#tweets > .owl-carousel');

        //console.log(tweets);

        $.each(tweets, function (index, value) {
            carousel
                .owlCarousel('add', '<div class="carousel-item">' + value.tweet + '<div><a href="' + value.author_data.profile_url + '">' + value.author_data.screen_name + '</a></div></div>')
            //console.log(value);
        });

        carousel.owlCarousel('update')

    };

    twitterFetcher.fetch(configProfile);


    /*
    var config5 = {
        "id": '345690956013633536',
        "domId": '',
        "maxTweets": 3,
        "enableLinks": true,
        "showUser": true,
        "showTime": true,
        "dateFunction": '',
        "showRetweet": false,
        "customCallback": handleTweets,
        "showRetweets" : false,
        "showInteraction": false
    };




    twitterFetcher.fetch(config5);
  */

    {/literal}
</script>
