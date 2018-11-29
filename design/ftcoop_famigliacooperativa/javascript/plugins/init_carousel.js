(function ($, window, document, undefined) {
    "use strict";
    var pluginName = "initOwlCarousel";

    function InitOwlCarousel(container, options, showPreview, widePreview, controlButtons) {
        var owl = $(container);
        owl.owlCarousel(options);
        if (showPreview) {
            owl.on('changed.owl.carousel', function (e) {
                $(e.target).find('[data-index]').removeClass('active').find('a').removeClass('focus');
                $(e.target).find('[data-index="' + e.item.index + '"]').addClass('active').find('a').addClass('focus');
            });

            var previewContainer = $('<div class="owl-preview-container hidden-xs hidden-sm" />');
            var preview = $('<ul class="owl-preview list-inline" />');
            var itemsCount = owl.find('.carousel-item-title').length;
            owl.find('.carousel-item-title').each(function (index) {
                var item = $('<li style="width:25%;padding:0" data-index="' + index + '" />');                
                var link = $('<div class="carousel-preview" style="'+$(this).parents('.carousel-item').attr('style')+';"><div class="preview-overlay"></div><div class="preview-text">'+$(this).html()+'</div></div>');
                link.bind('click', function (event) {
                    owl.trigger('to.owl.carousel', [index, 250, true]);
                    event.preventDefault();
                });
                if (index == 0) {
                    item.addClass('active');
                    link.addClass('focus');
                }
                preview.append(item.append(link));
            });

            if (widePreview) {
                var wideContainer = $('<div class="wide-preview hidden-xs hidden-sm" />');
                wideContainer.css({                    
                    width: $('#page').width(),
                    left: '-'+owl.offset().left+'px'
                });
                $( window ).resize(function() {
                    wideContainer.css({                        
                        width: $('#page').width(),
                        left: '-'+owl.offset().left+'px'
                    });
                });
                previewContainer.css('height', '150px');
                preview.appendTo(wideContainer);
                wideContainer.appendTo(previewContainer);                                
            } else {
                preview.appendTo(previewContainer);
            }
            previewContainer.appendTo(owl);
        }

        if ( controlButtons )
        {
          var contolContainer = $('<div class="control-buttons"></div>');
          var pauseButton = $('<a href="#" title="Ferma"><i class="fa fa-pause"></i></a>');
          var playButton = $(' <a href="#" title="Avvia" class="u-hidden"><i class="fa fa-play"></i></a>');

          contolContainer.append(pauseButton);
          contolContainer.append(playButton);
          owl.append(contolContainer);

          pauseButton.bind('click', function (event) {
            event.preventDefault();
            owl.trigger('stop.owl.autoplay');
            playButton.removeClass('u-hidden');
            pauseButton.addClass('u-hidden');
          });

          playButton.bind('click', function (event) {
            event.preventDefault();
            owl.trigger('play.owl.autoplay',[1000]);
            pauseButton.removeClass('u-hidden');
            playButton.addClass('u-hidden');
          });


        }

    }

    $.fn[pluginName] = function (options, showPreview, widePreview, controlButtons) {
        return this.each(function () {
            if (!$.data(this, pluginName)) {
                $.data(this, pluginName, new InitOwlCarousel(this, options, showPreview, widePreview, controlButtons));
            }
        });
    };

})(jQuery, window, document);
