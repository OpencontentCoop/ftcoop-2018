;(function ($, window, document, undefined) {

    var FilterFactory = function(label, queryField, containerSelector, facetSort, facetLimit, cssClasses){
        return {

            cssClasses: cssClasses,

            label: label,

            showSpinner: false,
            
            showCount: false,
            
            multiple: true,

            current: ['all'],

            name: queryField,

            container: containerSelector,

            buildQueryFacet: function () {
                return queryField+'|'+facetSort+'|'+facetLimit;
            },

            buildQuery: function () {
                var currentValues = this.getCurrent();
                if (currentValues.length && jQuery.inArray('all', currentValues) == -1) {
                    return queryField+' in [\'' + $.map(currentValues, function (item) {
                        return item.toString()
                            .replace(/"/g, '\\\"')
                            .replace(/'/g, "\\'")
                            .replace(/\(/g, "\\(")
                            .replace(/\)/g, "\\)");
                    }).join("','") + '\']';
                }

                return null;
            },

            filterClickEvent: function (e, view) {
                var self = this;
                var selectedValue = [];
                var selected = $(e.currentTarget);
                if (selected.data('value') != 'all'){
                    var selectedWrapper = selected.parent();            
                    if (this.multiple){                                
                        if (selectedWrapper.hasClass(self.cssClasses.itemWrapperActive)){
                            selectedWrapper.removeClass(self.cssClasses.itemWrapperActive);   
                            selected.removeClass(self.cssClasses.itemActive);
                        }else{
                            selectedWrapper.addClass(self.cssClasses.itemWrapperActive);   
                            selected.addClass(self.cssClasses.itemActive);
                        }
                        $('li.active', $(this.container)).each(function(){
                            var value = $(this).find('a').data('value');
                            if (value != 'all'){
                                selectedValue.push(value);
                            }
                        });  
                    }else{
                        $('li', $(this.container)).removeClass(self.cssClasses.itemWrapperActive);
                        $('li a', $(this.container)).removeClass(self.cssClasses.itemActive);
                        selectedWrapper.addClass(self.cssClasses.itemWrapperActive);
                        selected.addClass(self.cssClasses.itemActive);
                        selectedValue = [selected.data('value')];
                    }                
                    if (this.showSpinner){
                        selected.parents('div.filter-wrapper').find('.widget_title a').append('<span class="loading pull-right"> <i class="fa fa-circle-notch fa-spin"></i></span>');
                    }
                }
                this.setCurrent(selectedValue);
                view.doSearch();
                e.preventDefault();
            },

            init: function (view, filter) {
                $(filter.container).find('a').on('click', function (e) {
                    filter.filterClickEvent(e, view)
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
                if (self.showSpinner){
                    $('span.loading').remove();
                }

                var current = self.getCurrent();
                $('li a', $(self.container)).each(function () {
                    if ($(this).data('value') !== 'all'){
                        var name = $(this).data('name');
                        $(this).html(name).data('count', 0).addClass(self.cssClasses.itemEmpty);
                    }
                });

                $.each(response.facets, function () {
                    var name = this.name;
                    if (this.name == self.name) {
                        $.each(this.data, function (value, count) {
                            if (value != '') {
                                var quotedValue = self.quoteValue(value);
                                
                                var item = $('li a[data-value="' + value + '"]', $(self.container));                                                    
                                if (item.length) {
                                    var nameText = item.data('name');
                                    if (self.showCount){
                                        nameText += ' (' + count + ')';
                                    }
                                    item.html(nameText)
                                        .removeClass(self.cssClasses.itemEmpty)
                                        .data('count', count);
                                } else {
                                    var li = $('<li></li>');
                                    var a = $('<a href="#" class="'+self.cssClasses.item+'" data-name="' + value + '" data-value="' + quotedValue + '"></a>')
                                        .data('count', count)                                    
                                        .on('click', function(e){self.filterClickEvent(e,view)});   
                                    var nameText = value;
                                    if (self.showCount){
                                        nameText += ' (' + count + ')';
                                    }
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

            quoteValue: function(value){
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

    var TagFilterFactory = function(label, queryField, containerSelector, tagRoot, facetSort, facetLimit, cssClasses){            
        queryField = queryField + '.tag_ids';
        return {
            
            cssClasses: cssClasses,

            label: label,

            showSpinner: false,
            
            showCount: false,
            
            multiple: true,
            
            name: queryField,
            
            container: containerSelector,
            
            current: ['all'],
            
            filterClickEvent: function (e, view) {            
                var self = this;
                var selectedValue = [];
                var selected = $(e.currentTarget);
                if (selected.data('value') != 'all'){
                    var selectedWrapper = selected.parent();            
                    if (this.multiple){                                
                        if (selectedWrapper.hasClass(self.cssClasses.itemWrapperActive)){
                            selectedWrapper.removeClass(self.cssClasses.itemWrapperActive);   
                            selected.removeClass(self.cssClasses.itemActive);
                        }else{
                            selectedWrapper.addClass(self.cssClasses.itemWrapperActive);   
                            selected.addClass(self.cssClasses.itemActive);
                        }
                        $('li.active', $(this.container)).each(function(){
                            var value = $(this).find('a').data('value');
                            if (value != 'all'){
                                selectedValue.push(value);
                            }
                        });  
                    }else{
                        $('li', $(this.container)).removeClass(self.cssClasses.itemWrapperActive);
                        $('li a', $(this.container)).removeClass(self.cssClasses.itemActive);
                        selectedWrapper.addClass(self.cssClasses.itemWrapperActive);
                        selected.addClass(self.cssClasses.itemActive);
                        selectedValue = [selected.data('value')];
                    }
                    if (this.showSpinner){
                        selected.parents('div.filter-wrapper').find('.widget_title a').append('<span class="loading pull-right"> <i class="fa fa-circle-notch fa-spin"></i></span>');
                    }
                }
                this.setCurrent(selectedValue);
                view.doSearch();
                e.preventDefault();
            },
            
            renderTagTree: function (tag, container, filter, view) {
                var mainContainer = $(filter.container);
                var li = $('<li></li>');
                $('<a href="#" class="'+filter.cssClasses.item+'" data-value="' + tag.id + '" data-name="' + tag.keyword + '">' + tag.keyword + '</a>')                
                    .on('click', function(e){filter.filterClickEvent(e,view)})
                    .appendTo(li);
                if (tag.hasChildren) {
                    var childContainer = $('<ul class="'+filter.cssClasses.listWrapper+'" style="padding-left:20px"></ul>');
                    $.each(tag.children, function() {
                        var childTag = this;
                        filter.renderTagTree(childTag, childContainer, filter, view);
                    });
                    li.append(childContainer);
                }
                container.append(li);
            },
            
            init: function (view, filter) {
                var container = $(filter.container);
                $.opendataTools.tagsTree(tagRoot, function (response) {
                    $.each(response.children, function () {
                        filter.renderTagTree(this, container, filter, view);
                    });                
                });
                $(filter.container).find('a[data-value="all"]').on('click', function(e){filter.filterClickEvent(e,view)});
            },
            
            setCurrent: function (value) {            
                this.current = value;
            },
            
            getCurrent: function () {
                return this.current;
            },
            
            buildQuery: function () {
                var currentValues = this.getCurrent();            
                if (currentValues.length && jQuery.inArray( 'all', currentValues ) == -1) {
                    return queryField + ' in [\'' + currentValues.join("','") + '\']';
                }

                return null;
            },
            
            buildQueryFacet: function(){
                return queryField+'|'+facetSort+'|'+facetLimit;
            },
            
            refresh: function (response, view) {
                var self = this;
                if (self.showSpinner){
                    $('span.loading').remove();
                }

                var current = self.getCurrent();
                $('li a', $(self.container)).each(function () {
                    if ($(this).data('value') !== 'all'){
                        var name = $(this).data('name');
                        $(this).html(name).data('count', 0).addClass(self.cssClasses.itemEmpty);
                    }
                });
                $.each(response.facets, function () {
                    var name = this.name;
                    if (this.name == self.name) {
                        $('li a', $(self.container)).each(function () {
                            var name = $(this).data('name');
                            $(this).html(name);
                        });
                        $.each(this.data, function (value, count) {
                            var item = $('li a[data-value="' + self.quoteValue(value) + '"]', $(self.container));                        
                            var nameText = item.data('name');
                            if (self.showCount){
                                nameText += ' (' + count + ')';
                            }
                            item.html(nameText)
                                .data('count', count)                            
                                .removeClass(self.cssClasses.itemEmpty);
                        });
                    }
                });
            },

            quoteValue: function(value){
                return value;
            },
            
            reset: function (view) {
                var self = this;
                $(self.container).find('li').removeClass(self.cssClasses.itemWrapperActive);
                var current = self.getCurrent();
                $.each(current, function(){
                    $(self.container).find('li a[data-value="'+this+'"]').parent().addClass(self.cssClasses.itemWrapperActive);
                });
            }
        }
    };

    $.initFacetViewEvent = function(){
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

        $('.open-xs-filter').on('click', function(){
            $(this).addClass('hidden-xs');
            $('.filters-wrapper').removeClass('hidden-xs').addClass('filters-wrapper-xs');
            $('.close-xs-filter').show();
            $('body').addClass('modal-open');
        });
        $('.close-xs-filter').on('click', function(){
            $(this).hide();
            $('.open-xs-filter').removeClass('hidden-xs');
            $('.filters-wrapper').removeClass('filters-wrapper-xs').addClass('hidden-xs');
            $('body').removeClass('modal-open');
        });
    };

    $.fn.facetSearchView = function (settings) {
        
        var that = $(this);

        var options = $.extend(true, {
            'query': "q = '*'",
            'filters': [],
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
        }, settings)


        var filterTpl = $.templates(options.filterTpl);
        var spinner = $($.templates(options.spinnerTpl).render({}));
        var empty = $.templates(options.emptyTpl).render({});
        var cssClasses = options.cssClasses;

        var searchView = that.opendataSearchView({
            query: options.query,  
            onBeforeSearch: function (query, view) {                
                view.container.find('.current-result').html(spinner);
            },
            onLoadResults: function (response, query, appendResults, view) {
                var currentFilterContainer = view.container.find('.current-filter');
                var currentResultContainer = view.container.find('.current-result');

                currentFilterContainer.empty();
                $.each(view.filters, function(){
                    var filter = this;
                    var currentValues = filter.getCurrent();
                    var filterContainer = $(filter.container);  
                    var currentXsFilterContainer = filterContainer.parents('div.filter-wrapper').find('.current-xs-filters');                
                    currentXsFilterContainer.empty();
                    if (currentValues.length && jQuery.inArray('all', currentValues) == -1) {
                        var item = $('<li><strong>'+ filter.label +'</strong>:</li>');                    
                        $.each(currentValues, function(){                        
                            var value = this;
                            var valueElement = $('a[data-value="'+filter.quoteValue(value)+'"]', filter.container);                        
                            var name = valueElement.data('name');
                            currentXsFilterContainer.append('<li>'+name+'</li>');                        
                            $('<a href="#" style="margin:0 5px"><i class="fa fa-times"></i> '+name+'</a>')                            
                                .on('click', function(e){
                                    valueElement.trigger('click');
                                    e.preventDefault();
                                })
                                .appendTo(item);
                        });
                        item.appendTo(currentFilterContainer);
                    }else{
                        filterContainer.find('li a[data-value="all"]').parent().addClass('active');
                    }
                });

                spinner.remove();

                if (response.totalCount > 0) {
                    var template = $.templates(options.itemTpl);
                    $.views.helpers(options.viewHelpers);
                    var htmlOutput = template.render(response.searchHits);
                    if (appendResults) currentResultContainer.append(htmlOutput);
                    else currentResultContainer.html(htmlOutput);

                    if (response.nextPageQuery) {
                        var loadMore = $($.templates(options.loadOtherTpl).render({}));
                        loadMore.find('a').bind('click', function (e) {
                            view.appendSearch(response.nextPageQuery);
                            loadMore.remove();
                            currentResultContainer.append(spinner);
                            e.preventDefault();
                        });
                        currentResultContainer.append(loadMore)
                    }
                } else {
                    currentResultContainer.html(empty);
                }
            },
            onLoadErrors: function (errorCode, errorMessage, jqXHR, view) {
                view.container.html('<div class="alert alert-danger">' + errorMessage + '</div>')
            }
        }).data('opendataSearchView');

        var template = $.templates(options.filterTpl);
        if (options.filters.length > 0){
            $.each(options.filters, function(){
                var filter = this;
                filter = $.extend({}, {
                    type: 'null', 
                    facetSort: 'alpha', 
                    facetLimit: 100,
                    containerSelector: '#'+that.attr('id')+' ul[data-filter="'+filter.queryField+'"]',
                    cssClasses: options.cssClasses
                }, filter);
                var filterWrapper = that.find('.filters-wrapper').append($(template.render(filter)));

                if (filter.type == 'standard'){
                    searchView.addFilter(FilterFactory(
                        filter.label,
                        filter.queryField, 
                        filter.containerSelector, 
                        filter.facetSort, 
                        filter.facetLimit, 
                        filter.cssClasses
                    ));
                }else if (filter.type == 'tag'){
                    searchView.addFilter(TagFilterFactory(
                        filter.label,
                        filter.queryField, 
                        filter.containerSelector, 
                        filter.rootTag, 
                        filter.facetSort, 
                        filter.facetLimit, 
                        filter.cssClasses
                    ));
                }
            });
            that.find('.filters-wrapper').append($($.templates(options.closeXsFilterTpl).render({id: that.attr('id')})));
        }
        searchView.init().doSearch();

        $.initFacetViewEvent();

        return this;
    };
})(jQuery, window, document);