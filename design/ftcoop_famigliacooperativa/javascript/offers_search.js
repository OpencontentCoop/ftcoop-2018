;(function ($, window, document, undefined) {

  var FilterFactory = function (label, queryField, containerSelector, offerSort, offerLimit, cssClasses) {
    return {

      cssClasses: cssClasses,

      label: label,

      showSpinner: false,

      showCount: false,

      multiple: true,

      current: ['all'],

      name: queryField,

      container: containerSelector,

      filterClickEvent: function (e, view) {
        e.preventDefault();
        var self = this;
        var selectedValue = [];
        var selected = $(e.currentTarget);

        if (selected.data('value') != 'all') {

         $(this.container).find('a[data-value="all"]').parent().removeClass('active');

          var selectedWrapper = selected.parent();
          if (this.multiple) {
            if (selectedWrapper.hasClass(self.cssClasses.itemWrapperActive)) {
              selectedWrapper.removeClass(self.cssClasses.itemWrapperActive);
              selected.removeClass(self.cssClasses.itemActive);
            } else {
              selectedWrapper.addClass(self.cssClasses.itemWrapperActive);
              selected.addClass(self.cssClasses.itemActive);
            }
            $('li.active', $(this.container)).each(function () {
              var value = $(this).find('a').data('value');
              if (value != 'all') {
                selectedValue.push(value);
              }
            });
          } else {
            $('li', $(this.container)).removeClass(self.cssClasses.itemWrapperActive);
            $('li a', $(this.container)).removeClass(self.cssClasses.itemActive);
            selectedWrapper.addClass(self.cssClasses.itemWrapperActive);
            selected.addClass(self.cssClasses.itemActive);
            selectedValue = [selected.data('value')];
          }

          if (this.showSpinner) {
            selected.parents('div.filter-wrapper').find('.widget_title a').append('<span class="loading pull-right"> <i class="fa fa-circle-notch fa-spin"></i></span>');
          }
        } else {
          $('li', $(this.container)).removeClass(self.cssClasses.itemWrapperActive);
          $('li a', $(this.container)).removeClass(self.cssClasses.itemActive);
          selectedValue = ['all'];
          view.options.activeFilters = ['all']
        }
        this.setCurrent(selectedValue);
        view.doSearch();

      },

      init: function (view) {
        var self = this;
        $(self.container).find('a').on('click', function (e) {
          self.filterClickEvent(e, view)
        });
      },

      setCurrent: function (value) {
        this.current = value;
      },

      getCurrent: function () {
        return this.current;
      },

      refresh: function (response, view) {
        var self = this;
        if (self.showSpinner) {
          $('span.loading').remove();
        }

        var current = self.getCurrent();
        $(this.container).find('a[data-value="all"]').off( "click").on('click', function (e) {
          self.filterClickEvent(e, view)
        });;

        $.each(response.filters, function () {
          var name = this.name;
          if (this.name == self.name) {
            $.each(this.data, function (id, el) {
              if (id != '') {

                var item = $('li a[data-value="' + id + '"]', $(self.container));
                if (item.length) {
                  item.removeClass(self.cssClasses.itemEmpty);
                } else {
                  var li = $('<li></li>');
                  var a = $('<a href="#" class="' + self.cssClasses.item + '" data-name="' + id + '" data-value="' + id + '"></a>')
                  .on('click', function (e) {
                    self.filterClickEvent(e, view)
                  });
                  var nameText = el;
                  a.html(nameText)
                  .removeClass(self.cssClasses.itemEmpty)
                  .appendTo(li);
                  $(self.container).append(li);
                }
              }
            });
          }
        });
      },

      quoteValue: function (value) {
        return value;
      },

      reset: function (view) {
        var self = this;
        $('li', $(self.container)).removeClass(self.cssClasses.itemWrapperActive);
        var currentValues = this.getCurrent();
        $.each(currentValues, function () {
          $('li a[data-value="' + this + '"]', $(self.container)).parent().addClass(self.cssClasses.itemWrapperActive);
        });
      }
    }
  };

  $.initOfferViewEvent = function () {
    $('.widget').on('hidden.bs.collapse', function () {
      $(this).parents('.filters-wrapper').removeClass('has-active');
      $(this).parent().removeClass('active').addClass('unactive');
      $(this).prev().find('i').removeClass('fa-times').addClass('fa-plus');
    }).on('show.bs.collapse', function () {
      $(this).parents('.filters-wrapper').find('div.filter-wrapper').removeClass('active').addClass('unactive');
      $(this).parent().removeClass('unactive').addClass('active').show();
      $(this).parents('.filters-wrapper').addClass('has-active');
      $(this).prev().find('i').removeClass('fa-plus').addClass('fa-times');
    });

    $('.open-xs-filter').on('click', function () {
      $(this).addClass('hidden-xs');
      $('.filters-wrapper').removeClass('hidden-xs').addClass('filters-wrapper-xs');
      $('.close-xs-filter').show();
      $('body').addClass('modal-open');
    });
    $('.close-xs-filter').on('click', function () {
      $(this).hide();
      $('.open-xs-filter').removeClass('hidden-xs');
      $('.filters-wrapper').removeClass('filters-wrapper-xs').addClass('hidden-xs');
      $('body').removeClass('modal-open');
    });
  };

  $.fn.offerSearchView = function (settings) {

    var that = $(this);
    var options = $.extend(true, {
      'query': "",
      'offset': 0,
      'filters': [],
      'activeFilters': [],
      'currentHtml': '',
      'filterTpl': '#tpl-filter',
      'spinnerTpl': '#tpl-spinner',
      'emptyTpl': '#tpl-empty',
      'itemTpl': '#tpl-item',
      'loadOtherTpl': '#tpl-load-other',
      'closeXsFilterTpl': '#tpl-close-xs-filter',
      'cssClasses': {
        'item': '',
        'itemActive': '',
        'itemEmpty': 'text-muted',
        'itemWrapper': '',
        'itemWrapperActive': 'active',
        'listWrapper': 'nav nav-pills nav-stacked'
      },
      'viewHelpers': $.opendataTools.helpers
    }, settings);


    var filterTpl = $.templates(options.filterTpl);
    var spinner = $($.templates(options.spinnerTpl).render({}));
    var empty = $.templates(options.emptyTpl).render({});
    var other = $.templates(options.loadOtherTpl).render({});
    var cssClasses = options.cssClasses;

    var searchView = that.opendataSearchView({
      query: options.query,
      onBeforeSearch: function (query, view) {
        view.container.find('.current-result').html(spinner);
      },
      onLoadResults: function (response, query, appendResults, view) {
      },
      onLoadErrors: function (errorCode, errorMessage, jqXHR, view) {
        view.container.html('<div class="alert alert-danger">' + errorMessage + '</div>')
      }
    }).data('opendataSearchView');

    searchView.doSearch = function () {
      var container = that.find('.offers-result');

      var activeFilters = [];
      $.each(searchView.filters, function () {
        activeFilters.push({name: this.name, filters: this.getCurrent()})
      });

      if (JSON.stringify(options.activeFilters) !== JSON.stringify(activeFilters)) {
        options.offset = 0;
      }
      options.activeFilters = activeFilters;

      $.ajax({
        url: "https://www.laspesainfamiglia.coop/offerte/search",
        dataType: 'json',
        type: 'get',
        data: {
          'FcIva': options.query,
          'filters': activeFilters,
          'Offset': options.offset,
        },
        beforeSend: function () {
          $('#load-more').html('<i class="fa fa-circle-notch fa-spin fa-fw"></i>');
          options.currentHtml = container.html();
          //container.html(spinner);
        },
        success(response) {

          var currentFilterContainer = container.find('.current-filter');

          currentFilterContainer.empty();
          $.each(searchView.filters, function () {
            var filter = this;

            filter.refresh(response, searchView);
            var currentValues = filter.getCurrent();
            var filterContainer = $(filter.container);
            var currentXsFilterContainer = filterContainer.parents('div.filter-wrapper').find('.current-xs-filters');

            currentXsFilterContainer.empty();
            if (currentValues.length && jQuery.inArray('all', currentValues) === -1) {
              var item = $('<li><strong>' + filter.label + '</strong>:</li>');
              $.each(currentValues, function () {
                var value = this;
                var valueElement = $('a[data-value="' + filter.quoteValue(value) + '"]', filter.container);
                var name = valueElement.data('name');
                currentXsFilterContainer.append('<li>' + name + '</li>');
                $('<a href="#" style="margin:0 5px"><i class="fa fa-times"></i> ' + name + '</a>')
                .on('click', function (e) {
                  valueElement.trigger('click');
                  e.preventDefault();
                })
                .appendTo(item);
              });
              item.appendTo(currentFilterContainer);
            } else {
              filterContainer.find('li a[data-value="all"]').parent().addClass('active');
            }
          });

          if (response.count > 0) {
            if (response.offset === 0) {
              options.offset = response.offset;
              container.html('');
            } else {
              that.find('.offers-more').html('');
              container.html(options.currentHtml);
            }

            var template = $.templates(options.itemTpl);
            $(response.offers).each((id, el) => {
              container.append(template.render(el));
            });

            var otherTemplate = $.templates(options.loadOtherTpl);
            that.find('.offers-more').html(otherTemplate.render({offset: Number(response.offset) + Number(response.limit)}));
            options.offset = Number(response.offset) + Number(response.limit);
            loadMore();
          } else {
            container.html(empty);
          }
        },
      });
    };

    var loadMore = function () {
      $('#load-more').on('click', function (e) {
        e.preventDefault();
        searchView.doSearch();
      });
    };


    var template = $.templates(options.filterTpl);
    if (options.filters.length > 0) {
      $.each(options.filters, function () {
        var filter = this;
        filter = $.extend({}, {
          type: 'null',
          offerSort: 'alpha',
          offerLimit: 100,
          containerSelector: '#' + that.attr('id') + ' ul[data-filter="' + filter.queryField + '"]',
          cssClasses: options.cssClasses
        }, filter);
        var filterWrapper = that.find('.filters-wrapper').append($(template.render(filter)));
        var vFilter = FilterFactory(filter.label, filter.queryField, filter.containerSelector, filter.offerSort, filter.offerLimit, filter.cssClasses);
        //$(vFilter.container).find('a[data-value="all"]').on('click', function(e){vFilter.filterClickEvent(e,searchView)});
        searchView.addFilter(vFilter);
      });
      that.find('.filters-wrapper').append($($.templates(options.closeXsFilterTpl).render({id: that.attr('id')})));
    }
    searchView.doSearch();

    $.initOfferViewEvent();

    return this;
  };
})(jQuery, window, document);