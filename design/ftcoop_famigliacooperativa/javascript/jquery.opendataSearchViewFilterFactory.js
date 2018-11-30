var FilterFactory = function(label, queryField, containerSelector, facetSort, facetLimit){
    return {

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
                return queryField+' in [\'' + currentValues.join("','") + '\']';
            }
        },

        filterClickEvent: function (e, view) {
            var selectedValue = [];
            var selected = $(e.currentTarget);
            if (selected.data('value') != 'all'){
                var selectedWrapper = selected.parent();            
                if (this.multiple){                                
                    if (selectedWrapper.hasClass('active')){
                        selectedWrapper.removeClass('active');   
                    }else{
                        selectedWrapper.addClass('active');   
                    }
                    $('li.active', $(this.container)).each(function(){
                        var value = $(this).find('a').data('value');
                        if (value != 'all'){
                            selectedValue.push(value);
                        }
                    });  
                }else{
                    $('li', $(this.container)).removeClass('active');
                    selectedWrapper.addClass('active');
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
            var currentLength = 0;
            $.each(current, function () {
                if (this != 'all') {
                    var item = $(self.container).find('a[data-value="' + this + '"]');
                    item.html(item.data('name')).data('count', 0);
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
                            var quotedValue = self.quoteValue(value);
                            
                            var item = $('li a[data-value="' + value + '"]', $(self.container));                                                    
                            if (item.length) {
                                var nameText = item.data('name');
                                if (self.showCount){
                                    nameText += ' (' + count + ')';
                                }
                                item.html(nameText)
                                    .data('count', count);
                            } else {
                                var li = $('<li></li>');
                                var a = $('<a href="#" data-name="' + value + '" data-value="' + quotedValue + '"></a>')
                                    .data('count', count)                                    
                                    .on('click', function(e){self.filterClickEvent(e,view)});   
                                var nameText = value;
                                if (self.showCount){
                                    nameText += ' (' + count + ')';
                                }
                                a.html(nameText).appendTo(li);
                                $(self.container).append(li);
                            }                            
                        }
                    });
                }
            })).then(function(){                
            });
        },

        quoteValue: function(value){
            return value;
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

var TagFilterFactory = function(label, queryField, containerSelector, tagRoot, facetSort, facetLimit){    
    return {
        
        label: label,

        showSpinner: false,
        
        showCount: false,
        
        multiple: true,
        
        name: queryField,
        
        container: containerSelector,
        
        current: ['all'],
        
        filterClickEvent: function (e, view) {            
            var selectedValue = [];
            var selected = $(e.currentTarget);
            if (selected.data('value') != 'all'){
                var selectedWrapper = selected.parent();            
                if (this.multiple){                                
                    if (selectedWrapper.hasClass('active')){
                        selectedWrapper.removeClass('active');   
                    }else{
                        selectedWrapper.addClass('active');   
                    }
                    $('li.active', $(this.container)).each(function(){
                        var value = $(this).find('a').data('value');
                        if (value != 'all'){
                            selectedValue.push(value);
                        }
                    });  
                }else{
                    $('li', $(this.container)).removeClass('active');
                    selectedWrapper.addClass('active');
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
            $('<a href="#" data-value="' + tag.id + '" data-name="' + tag.keyword + '">' + tag.keyword + '</a>')                
                .on('click', function(e){filter.filterClickEvent(e,view)})
                .appendTo(li);
            //li.hide();
            if (tag.hasChildren) {
                var childContainer = $('<ul class="nav nav-pills nav-stacked" style="padding-left:20px"></ul>');
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
            var currentLength = 0;
            $.each(current, function () {
                if (this != 'all') {
                    var item = $(self.container).find('a[data-value="' + this + '"]');
                    item.html(item.data('name')).data('count', 0);
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
                        var item = $('li a[data-value="' + self.quoteValue(value) + '"]', $(self.container));                        
                        var nameText = item.data('name');
                        if (self.showCount){
                            nameText += ' (' + count + ')';
                        }
                        item.html(nameText)
                            .data('count', count);
                    });
                }
            });
        },

        quoteValue: function(value){
            return value;
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