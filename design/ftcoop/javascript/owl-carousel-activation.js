$(document).ready(function() {

    $(".owl-carousel-single .owl-carousel").owlCarousel({
            'items': 1,
            'nav': true,
            'navText': ['<i class="fa fa-angle-left"></i>','<i class="fa fa-angle-right"></i>'],
            'loop': true,
            'dots': false
            //onChanged: callback
        }
    );
    
    $(".owl-carousel-wide .owl-carousel").owlCarousel({
            'dots': true,
            'dotsEach': 1,
            responsive: {
                0: {
                    items: 1,
                },
                480: {
                    items: 2,
                    'slideBy' : 2
                },
                768: {
                    items: 3,
                    'slideBy' : 3
                },
                992: {
                    items: 4,
                    'slideBy' : 4
                }

            }
        }
    );

    $(".owl-carousel-contained .owl-carousel").owlCarousel({
            'dots' : false,
            'nav': true,
            'margin' : 10,
            'navText': ['<i class="fa fa-angle-left"></i>','<i class="fa fa-angle-right"></i>'],
            'responsive' : {
                0: {
                    'items' : 1,
                },
                480: {
                    'items' : 2,
                    'slideBy' : 2
                },
                768: {
                    'items' : 2,
                    'slideBy' : 2
                },
                992: {
                    'items' : 3,
                    'slideBy' : 3
                }

            }
        }
    );

    $(".owl-carousel-slider-auto .owl-carousel").owlCarousel({
            'items': 1,
            'dots': true,
            'loop': true,
            'autoplay': true
            //onChanged: callback
        }
    );


});