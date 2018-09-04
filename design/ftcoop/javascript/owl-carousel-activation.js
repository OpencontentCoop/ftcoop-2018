var activateOwlCarousel = function(context){

    $(".owl-carousel-single .owl-carousel", context).owlCarousel({
            'items': 1,
            'nav': true,
            'navText': ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
            'loop': true,
            'dots': false
            //onChanged: callback
        }
    );

    $(".owl-carousel-wide .owl-carousel", context).owlCarousel({
            'dots': true,
            'dotsEach': 1,
            responsive: {
                0: {
                    items: 1,
                },
                480: {
                    items: 2,
                    'slideBy': 2
                },
                768: {
                    items: 3,
                    'slideBy': 3
                },
                992: {
                    items: 4,
                    'slideBy': 4
                }

            }
        }
    );

    $(".owl-carousel-contained", context).each(function () {
        var dataItems = $(this).data('items');              
        var responsive = {
            0: {
                'items': 1,
            },
            480: {
                'items': 2,
                'slideBy': 2
            },
            768: {
                'items': 2,
                'slideBy': 2
            },
            992: {
                'items': 3,
                'slideBy': 3
            }
        }
        if (dataItems) {
            responsive = {
                0: {
                    'items': dataItems,
                }
            }
        }
        var navStyle = $(this).data('navstyle');  
        var dots = false;
        var nav = true;
        if(navStyle == 'dots'){
            dots = true;
            nav = false;
        }
        var autoHeight = false;
        if ($(this).data('autoheight')){
            autoHeight = true;
        }
        $(this).find('.owl-carousel').owlCarousel({
            'dots': dots,
            'nav': nav,
            'margin': 10,
            'navText': ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
            'responsive': responsive,
            'autoHeight': autoHeight
        });
    })

    $(".owl-carousel-slider-auto .owl-carousel", context).owlCarousel({
            'items': 1,
            'dots': true,
            'loop': true,
            'autoplay': true
            //onChanged: callback
        }
    );
}
$(document).ready(function () {
    activateOwlCarousel();
});