var FilterFactory = function(queryField, containerSelector, facetSort, facetLimit){
    return {

        current: ['all'],

        name: queryField,

        container: containerSelector,

        buildQueryFacet: function () {
            return queryField+'|'+facetSort+'|'+facetLimit;
        },

        buildQuery: function () {
            var currentValues = this.getCurrent();
            if (currentValues.length && jQuery.inArray('all', currentValues) == -1) {
                return queryField+' in [\'' + currentValues.join("','") + '\']';
            }
        },

        filterClickEvent: function (e, view) {
            var current = $(e.currentTarget);
            this.setCurrent(current.data('value'));
            view.doSearch();
            e.preventDefault();
        },

        init: function (view, filter) {
            $(filter.container).find('a').on('click', function (e) {
                filter.filterClickEvent(e, view)
            });
        },

        setCurrent: function (value) {
            $('li', $(this.container)).removeClass('active');
            $('li a[data-value="' + value + '"]', $(this.container))
                .parent().addClass('active')
                .parents('div.widget').prev().append('<span class="loading"> <i class="fa fa-circle-o-notch fa-spin"></i></span>');
            this.current = [value];
        },

        getCurrent: function () {
            return this.current;
        },

        refresh: function (response, view) {
            var self = this;
            $('span.loading').remove();
            //$('li', $(self.container)).hide();
            //$('li a[data-value="all"]', $(self.container)).parent().show();

            var current = self.getCurrent();
            var currentLength = 0;
            $.each(current, function () {
                if (this != 'all') {
                    var item = $('a[data-value="' + this + '"]', $(self.container));
                    item.html(this).parent().addClass('active');//.show();
                    currentLength++;
                }
            });

            $('li a', $(self.container)).each(function () {
                var name = $(this).data('name');
                $(this).html(name).data('count', 0);
            });

            $.when($.each(response.facets, function () {
                var name = this.name;
                if (this.name == self.name) {
                    $.each(this.data, function (value, count) {
                        if (value != '') {
                            var quotedValue = value;
                            if ($('li a[data-value="' + quotedValue + '"]', $(self.container)).length) {
                                $('li a[data-value="' + quotedValue + '"]', $(self.container)).html(value + ' (' + count + ')');//.parent().show();
                            } else {
                                var li = $('<li><a href="#" data-filter_identifier="' + $(self.container).data('filter') + '" data-count="' + count + '" data-name="' + value + '" data-value="' + quotedValue + '">' + value + ' (' + count + ')' + '</a></li>');
                                li.find('a').on('click', function (e) {
                                    self.filterClickEvent(e, view);
                                });
                                $(self.container).append(li);
                            }
                            //$(self.container).parent().show();
                        }
                    });
                }
            })).then(function(){
                if( $(self.container).find('li:visible').length < 2 && currentLength == 0){
                    //$(self.container).parent().hide();
                }
            });
        },

        reset: function (view) {
            var self = this;
            $('li', $(self.container)).removeClass('active');
            var currentValues = this.getCurrent();
            $.each(currentValues, function () {
                $('li a[data-value="' + this + '"]', $(self.container)).parent().addClass('active');
            });
        }
    }
};

var TagFilterFactory = function(queryField, containerSelector, tagRoot, facetSort, facetLimit){
    return {
        name: queryField,
        container: containerSelector,
        current: ['all'],
        filterClickEvent: function (e, view) {
            var current = $(e.currentTarget);
            this.setCurrent(current.data('value'));
            view.doSearch();
            e.preventDefault();
        },
        renderTagTree: function (tag, container, filter) {
            var li = $('<li><a href="#" data-value="' + tag.id + '" data-name="' + tag.keyword + '">' + tag.keyword + '</a></li>');
            //li.hide();
            if (tag.hasChildren) {
                var childContainer = $('<ul class="nav nav-pills nav-stacked" style="padding-left:20px"></ul>');
                $.each(tag.children, function() {
                    var childTag = this;
                    filter.renderTagTree(childTag, childContainer, filter);
                });
                li.append(childContainer);
            }
            container.append(li);
        },
        init: function (view, filter) {
            var container = $(filter.container);
            $.opendataTools.tagsTree(tagRoot, function (response) {
                $.each(response.children, function () {
                    filter.renderTagTree(this, container, filter);
                });
                $(filter.container).find('a').on('click', function(e){filter.filterClickEvent(e,view)});
            });
        },
        setCurrent: function (value) {
            $('li', $(this.container)).removeClass('active');
            $('li a[data-value="'+value+'"]', $(this.container))
                .parent().addClass('active')
                .parents('div.widget').prev().append('<span class="loading"> <i class="fa fa-circle-o-notch fa-spin"></i></span>');
            this.current = [value];
        },
        getCurrent: function () {
            return this.current;
        },
        buildQuery: function () {
            var currentValues = this.getCurrent();
            if (currentValues.length && jQuery.inArray( 'all', currentValues ) == -1) {
                return queryField + ' in [\'' + currentValues.join("','") + '\']';
            }
        },
        buildQueryFacet: function(){
            return queryField+'|'+facetSort+'|'+facetLimit;
        },
        refresh: function (response, view) {
            var self = this;
            $('span.loading').remove();

            //$(self.container).find('li').hide();
            //$(self.container).find('li a[data-value="all"]').parent().show();

            var current = self.getCurrent();
            var currentLength = 0;
            $.each(current, function () {
                if (this != 'all') {
                    var item = $(self.container).find('a[data-value="' + this + '"]');
                    item.html(item.data('name')).data('count', 0).parent().addClass('active'); //.show().parents('li').show();
                    currentLength++;
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
                        var item = $('li a[data-value="' + value + '"]', $(self.container));
                        var name = item.data('name');
                        item.html(name + ' (' + count + ')').data('count', count).data('filter_identifier', $(self.container).data('filter'));//.parent().show();                            
                        //$(self.container).parent().show();
                    });
                }
            });
            if( $(self.container).find('li:visible').length < 2 && currentLength == 0){
                //$(self.container).parent().hide();
            }

        },
        reset: function (view) {
            var self = this;
            $(self.container).find('li').removeClass('active');
            var current = self.getCurrent();
            $.each(current, function(){
                $(self.container).find('li a[data-value="'+this+'"]').parent().addClass('active');
            });
        }
    }
};