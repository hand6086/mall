/**
* KeyFilter  - Hand LINK CRM GROUP
* @Copyright 2016 LINK CRM GROUP
 */
!function ($) {
    'use strict';
    // it only does '%s', and return '' when arguments are undefined
    var sprintf = function (str) {
        var args = arguments,
            flag = true,
            i = 1;

        str = str.replace(/%s/g, function () {
            var arg = args[i++];

            if (typeof arg === 'undefined') {
                flag = false;
                return '';
            }
            return arg;
        });
        return flag ? str : '';
    };

    /**
     * 格式化URL请求参数
     */
    var formatRequest = function(data){
    	for(var filed in data){
    		if ( typeof ( data[filed]) == "object" ){
    			data[filed] = JSON.stringify(data[filed]);
    		}else if(typeof ( data[filed]) == "Array"){
    			data[filed] = JSON.stringify(data[filed]);
    		}
    	}
    	return data;
    };
    
    	
    var KeyFilter = function (el, options) {
        this.options = options;
        this.$el = $(el);
        this.$el_ = this.$el.clone();
        this.timeoutId_ = 0;
        this.timeoutFooter_ = 0;
        this.init();
    };
    KeyFilter.prototype.init = function () {
    	this.initKeyFilterData();
        this.initContainer();
        if(this.options.remoteData == true){
        	this.initServerKeyFilter();
        }else{
        	this.initKeyFilter();
            this.initKeyFilterBody();
            this.initKeyMoreBody();
            $("#"+this.options.tableId).datagrid("resize");//防止多行时把datagrid挤下来
        }
       
    };
    KeyFilter.prototype.initKeyFilterData= function () {
    	if(this.options.id == null)
    		this.options.id = this.options.filterFiled;
    };
    
    KeyFilter.prototype.initContainer = function () {
    	this.$container = $([
    	                     '<div class="fixed-keyfilter">',
    	                     '<div class="fixed-keyfilter-title">'+this.options.title+':</div>',
    	                     '<div class="fixed-keyfilter-body">',
    	                     	'<div class="fixed-keyfilter-fileds"></div>',
    	                     	'<div class="fixed-keyfilter-select"></div>',
    	                     '</div>',
    	                     '<div class="fixed-keyfilter-more"></div>',
    	                     '</div>'].join(''));
        this.$container.insertAfter(this.$el);
        this.$keyfilterBody = this.$container.find('.fixed-keyfilter-fileds');
        this.$keyfilterBody.append(this.$el);
        this.$keyfilterMore = this.$container.find('.fixed-keyfilter-more');
        this.$keyfilterSelectBut = this.$container.find('.fixed-keyfilter-select');
    };
    
    KeyFilter.prototype.initKeyFilter = function(){
    	 var that = this,
         filterList = [],
         data = [];
    	 this.$el.find('li').each(function() {
             var filter = $.extend({}, {
                 name: $(this).html(),
                 'class': $(this).attr('class')
             }, $(this).data());
             filterList.push(filter);
         });
    	 this.options.filterList = $.extend(true, [], filterList, this.options.filterList);
    	  $.each(this.options.filterList, function (i, filter) {
              that.options.filterList[i] = $.extend({}, KeyFilter.FILTER_DEFAULTS,
                  {field: i}, filter);
          });
    	  this.$el.addClass('fixed-keyfilter-value-list');
    };
    
    KeyFilter.prototype.initServerKeyFilter = function(){
    	var that = this,
    	filterList = [],
    	data = [];
    	this.$el.find('li').remove();
    	//初始化客户月度任务信息
		$.post(that.options.remoteUrl, null, function(data) //回传函数
		{
			if (data != null) {
				for(var i=0;data != null && i<data.length;i++){
					var dataName = data[i][that.options.dataName];
					var dataValue = '';
					if(that.options.filterByValue){
						dataValue = data[i][that.options.dataValue];
					} else {
						dataValue = data[i][that.options.dataName];
					}
					filterList.push({
						name 	: dataName,
						value 	: dataValue
					});
				}
				that.options.filterList = $.extend(true, [], filterList);
				$.each(that.options.filterList, function (i, filter) {
					that.options.filterList[i] = $.extend({}, KeyFilter.FILTER_DEFAULTS,
							{field: i}, filter);
				});
				that.$el.addClass('fixed-keyfilter-value-list');
				//渲染操作
				that.initKeyFilterBody();
				that.initKeyMoreBody();
				$("#"+that.options.tableId).datagrid("resize");
			}
		});
   };
    
    KeyFilter.prototype.initKeyFilterBody = function(){
    	var that = this,
    	filedSeleted = false,
        html = [];
    	$.each(this.options.filterList, function (i, filter) {
    		if(filter.selected == true){
    			filedSeleted = true;
    		}
    	});
    	html.push(sprintf('<li class="value-filter %s"',!filedSeleted ?
				'filter-selected' : ''),
				sprintf(' data-value="-ALL"><a>'),
				sprintf('全部'),
				sprintf('</a></li>'));
    	$.each(this.options.filterList, function (i, filter) {
    		html.push(sprintf('<li class="value-filter %s"',filter.selected ?
    				'filter-selected' : ''),
    				sprintf(' data-value="%s"><a>',filter.value),
    				sprintf(filter.name),
    				sprintf('</a></li>'));
    	});
    	
    	this.$keyfilterBody.find('ul').html(html.join(''));
    	this.$selectItem = this.$container.find('li');
    	this.$container.off('click', 'li').on('click', 'li', function (event) {
            that.onFilterClick(event);
        });
    	
    	if(this.options.showMore && this.options.moreFold){
    		//如果支持更多、且默认为收起状态;=将展开变为收起状态操作
    		this.options.moreFold = !this.options.moreFold;
    		this.showMore();
    	}
    };
    
    KeyFilter.prototype.initKeyMoreBody = function(){
    	var that = this,
    	btnHtml = [],
    	html = [];
		if(this.options.moreFold){
			html.push(sprintf('<span class="showMore">'),
					sprintf('<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span> 更多'),
					sprintf('</span>'));
		}else{
			html.push(sprintf('<span class="showMore">'),
					sprintf('<span class="glyphicon glyphicon-menu-up" aria-hidden="true"></span> 收起'),
					sprintf('</span>'));
		}
		html.push(sprintf('<span class="selectMore">'),
				sprintf('<i class="glyphicon glyphicon-plus"></i> 多选'),
				sprintf('</span>'));
		this.$keyfilterMore.html(html.join(''));
    	
		this.$keyfilterShowMore = this.$container.find('.showMore');
		if(!this.options.showMore){
			this.$keyfilterShowMore.prop("hidden","hidden");
			this.$keyfilterShowMore.attr("hidden","hidden");
		}
		this.$keyfilterSelectMore = this.$container.find('.selectMore');
		if(!this.options.selectMore){
			this.$keyfilterSelectMore.prop("hidden","hidden");
			this.$keyfilterSelectMore.attr("hidden","hidden");
		}
		 
    	if (this.options.showMore) {
    		this.$container.find('.showMore')
    		.off('click').on('click', function(event){
    			that.showMore();
    		});
    	}
    	
    	if (this.options.selectMore) {
    		this.$container.find('.selectMore')
    		.off('click').on('click', function(event){
    			that.updateSelectMoreFilterBody(event);
    		});
    	}
    	
    	btnHtml.push(sprintf('<button class="confirmSelect btn  btn-xs btn-primary">确 定</button>'),
    			sprintf('<button type="button" class="cacelSelect btn btn-xs btn-warning">取 消</button>'));
    	this.$keyfilterSelectBut.html(btnHtml.join(''));
    	this.$keyfilterSelectBut.prop("hidden","hidden");
    	this.$keyfilterSelectBut.attr("hidden","hidden");
    	this.$container.find('.confirmSelect')
    	.off('click').on('click', function(event){
    		that.confirmSelect();
    	});
    	this.$container.find('.cacelSelect')
    	.off('click').on('click', function(event){
    		that.cacelSelect();
    	});
    };
    
    /**
     * 多选确定事件
     */
    KeyFilter.prototype.confirmSelect = function () {
    	var valueList = [],
    	itemList = [];
    	this.$selectItem.each(function (i,item) {
    		var checkBox = $('.fixed-keyfilter-checkBox',item);
    		if(checkBox != null && checkBox.length != 0){
				if(checkBox[0].checked){
					valueList.push($(item).data('value'));
					itemList.push($(item));
				}
    		}
        });
    	this.options.filterValueList = valueList;

        var filter = {id:this.options.id,operator:'in',property:this.options.filterFiled,value:this.options.filterValueList};
        $('#'+this.options.tableId).bootstrapTable('addFilter', filter);
    	$('#'+this.options.tableId).bootstrapTable('searchMethod');
    	if(this.options.reloadData){
        	this.trigger('reload');
    	}else{
    		this.onSelectedChange(itemList);
    		this.cacelSelect();
    	}
    };
    

    KeyFilter.prototype.addGridFilter = function(tableId,filter){
    	var options = $('#' + tableId).datagrid('options');
    	var filterList = options.filterList;
    	if(filterList == null){
    		filterList = new Array();
    	}
    	this.addFilter(filter,filterList);
    	options.filterList = filterList;
    	/*$('#'+tableId).datagrid('load',
			formatRequest({
				filtersRaw:filterList
			})
    	);*/
    	var searchQuery = $('#' + tableId).datagrid('getPanel').find('.easyui-query-list-table').click();//查询按钮
    	/*var dpanel = $('#' + tableId).datagrid('getPanel');
    	if(dpanel != null){
        	var toolbar = dpanel.children("div.datagrid-toolbar");
        	if(toolbar != null){
        		var searchValue = $(toolbar).find('.easyui-searchbox-list-table').searchbox('setValue', '');
				var lovVal = $(toolbar).find(".easyui-lov-searchbox-list-table").combobox('setValue', '');
				
            	var inputText = $('#'+toolbar.attr("id")).find("input[name='searchValue']");
            	if(inputText != null){
                	inputText.val('');	
            	}
        	}
    	}*/
    };
    

    KeyFilter.prototype.addFilter = function (filters,filtersRaw) {
    	if(filters.operator == 'in' && filters.value instanceof Array){
    		var value = '[';
			for(var i=0;i<filters.value.length;i++){
				if(i == filters.value.length-1){
					value = value + filters.value[i]+']';
				}else{
					value = value + filters.value[i]+',';
				}
			};
			if(filters.value.length == 0){
				value = value +']';
			}
			filters.value = value;
		}
    	for(var i = 0; i < filtersRaw.length; i++){
    		var filter = filtersRaw[i];
    		if(filter.id == filters.id){
    			if(filters.value =='-ALL' || filters.value == null){
    				filtersRaw.splice(i,1);
    			}else{
    				filtersRaw[i] = filters;
    			}
    			return;	
    		}
    	}
    	if(filters.value !='-ALL'){
        	filtersRaw.push(filters);
    	}
    };
    
    /**
     * 多选取消事件
     */
    KeyFilter.prototype.cacelSelect = function () {
    	var that = this;
    	this.$selectItem.each(function (i,item) {
    		if(i==0){
    			$(item).removeAttr("hidden");
    		}else{
        		$(item).html(sprintf('<a>%s</a>',that.options.filterList[i-1].name));
    		}
        });
    	this.$keyfilterSelectBut.prop("hidden","hidden");
    	this.$keyfilterSelectBut.attr("hidden","hidden");
    	this.options.sigleSelect = true;
    };
    
    /**
     * 显示更多事件
     * @param event
     */
    KeyFilter.prototype.showMore = function (event) {
    	//判断如果为多选情况下，收缩按钮失效
    	if(!this.options.sigleSelect)
    		return;
    	this.options.moreFold = !this.options.moreFold;
    	var moreHtml = [];
		if(this.options.moreFold){
			moreHtml.push(sprintf('<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span> 更多'));
		}else{
			moreHtml.push(sprintf('<span class="glyphicon glyphicon-menu-up" aria-hidden="true"></span> 收起'));
		}
		$('.showMore',this.$keyfilterMore).html(moreHtml.join(''));
		this.updateMoreFilterBody(this.options.moreFold);
    };
    
    /**
     * 前端更多显示
     * @param isFold
     */
    KeyFilter.prototype.updateMoreFilterBody = function(isFold){
    	var that = this;
    	this.$selectItem.each(function (i,item) {
    		if(isFold & i> that.options.filedNumber){
    			$(item).prop("hidden","hidden");
    			$(item).attr("hidden","hidden");
    		}else{
    			$(item).removeAttr("hidden");
    		}
        });
    };
    
    /**
     * 多选事件
     * @param isFold
     */
    KeyFilter.prototype.updateSelectMoreFilterBody = function(event){
    	if(this.options.sigleSelect){
    		if(this.options.moreFold){
        		this.showMore();
    		}
        	this.$selectItem.each(function (i,item) {
        		if(i == 0){
        			$(item).prop("hidden","hidden");
        			$(item).attr("hidden","hidden");
        		}else{
        			if($(item).data('selected')){
                		$(item).html(sprintf('<input type="checkbox" checked="checked" class="fixed-keyfilter-checkBox"/><a>%s</a>',$(item).html()));
        			}else{
                		$(item).html(sprintf('<input type="checkbox" class="fixed-keyfilter-checkBox"/><a>%s</a>',$(item).html()));
        			}
        		}
            });
        	
        	this.$keyfilterSelectBut.removeAttr("hidden");
        	this.options.sigleSelect = false;
    	}
    };
    
    /**
     * filter 点击事件
     * @param event
     */
    KeyFilter.prototype.onFilterClick = function (event) {
    	var that = this;
    	// 添加是否数据分析标志，默认为true代表是
    	if(this.options.dataReport){
    		// 新逻辑	
    		var $filterFiled = $(event.currentTarget);
            var itemList =[];
            this.options.filterValue = $filterFiled.data('value');
            
        	this.trigger('clickField',this.options.filterFiled,this.options.filterValue);
           
        	itemList.push($filterFiled);
            this.onSelectedChange(itemList);
        	
            var filed = this.options.filterFiled;
            var value = this.options.filterValue;
            
            var reportFilterFiled = this.options.reportFilterFiled;
            var reportFilterValue = this.options.reportFilterValue;
            
            
            var j = -1;
            for(var i = 0; i < reportFilterFiled.length; i++){
            	if(filed == reportFilterFiled[i]){
            		j = i;
            		break;
            	}
            }
            if(j > -1){
            	reportFilterValue[j] = value;
            }else{
            	 reportFilterFiled.push(filed);
            	 reportFilterValue.push(value);
            }
            
            var filtersRaw = [];
            for(var i = 0; i < reportFilterFiled.length; i++){
            	var property = reportFilterFiled[i];
            	var value = reportFilterValue[i];
            	var filter = {id:property,property:property,value:value};
            	if(value != '-ALL'){
            		filtersRaw.push(filter);
            	}
            }
    		
            var tableId = this.options.tableId;
            var data1 = formatRequest(this.options.data);
            var data2 = formatRequest({filtersRaw:filtersRaw});
            var data = $.extend({}, data1, data2);
            if(this.options.userDefined){//调用自定义函数
            	/*$.each(filtersRaw, function(index, item){
            		console.log(item.value);
            	});*/
            	
            	$.post(this.options.dataReportUrl, data, 
        			function(data){
                		that.trigger('userDefined',data);
        			}
            	);
            }else{
            	$.post(this.options.dataReportUrl, data, 
        			function(data){
                		$('#' + tableId).html(data.html);
        			}
            	);
            }
        	
        	
    	}else{
    		//不是多选状态下操作
        	if(this.options.sigleSelect){
                var $filterFiled = $(event.currentTarget);
                var itemList =[];
                this.options.filterValue = $filterFiled.data('value');
                
                var filter = {id:this.options.id,property:this.options.filterFiled,value:this.options.filterValue};
            	this.trigger('clickField',this.options.filterFiled,this.options.filterValue);
                this.addGridFilter(this.options.tableId, filter);
            	if(this.options.reloadData){
                	this.trigger('reload');
            	}else{
            		itemList.push($filterFiled);
                    this.onSelectedChange(itemList);
            	}
        	}
    	}
    	
    };
    
    /**
     * 更新选中状态
     * @param itemList
     */
    KeyFilter.prototype.onSelectedChange = function (itemList) {
    	this.$selectItem.each(function (i,item) {
    		$(item).data('selected',false);
    	});
    	for(var i=0;i<itemList.length;i++){
    		$(itemList[i]).data('selected',true);
    	}
    	this.updateSelected();
    };
    
    KeyFilter.prototype.updateSelected = function () {
    	 this.$selectItem.each(function () {
             $(this)[$(this).data('selected') ? 'addClass' : 'removeClass']('filter-selected');
         });
    };
    
    /**
     * 重新从服务器加载数据
     * @param url
     */
    KeyFilter.prototype.reloadRemoteData = function(url){
    	var that = this;
    	that.options.remoteUrl = url;
    	that.initServerKeyFilter();
    };
    
    KeyFilter.prototype.trigger = function (name) {
        var args = Array.prototype.slice.call(arguments, 1);

        name += '.bs.keyfilter';
        this.options[KeyFilter.EVENTS[name]].apply(this.options, args);
        this.$el.trigger($.Event(name), args);

        this.options.onAll(name, args);
        this.$el.trigger($.Event('all.bs.keyfilter'), [name, args]);
    };
    
    KeyFilter.EVENTS = {
    		'all.bs.keyfilter': 'onAll',
    		'reload.bs.keyfilter':'onReloadKeyFilter',
    		'clickField.bs.keyfilter':'onClickKeyFilter',
    		'userDefined.bs.keyfilter':'userDefinedFunction'
    };
    
    KeyFilter.DEFAULTS = {
    	title:'title',
    	tableId:'',
    	showMore : false,
    	moreFold: false,//默认展开的
    	remoteData:false,//是否从服务器取数据
    	remoteUrl:'',
    	filterByValue:true,//是否启用独立源代码进行筛选
    	loadMsg:'正在加载信息中...',
    	selectMore:false,
    	sigleSelect:true,
    	dataReport:false,//是否异步请求
    	dataReportUrl:'',//异步请求地址
    	data:{},//异步请求传值
    	reportFilterFiled : [],
    	reportFilterValue : [],
    	reloadData:false,
    	filedNumber:7,
    	filterFiled : '',
    	filterValue : '',
    	filterList :[],
    	filterValueList :[],
    	dataName:'name',//默认显示值
    	dataValue:'val',//默认筛选值
    	id:null,
    	userDefined:false,//是否异步请求返回数据前端处理
    	userDefinedFunction:function(data){//异步请求返回数据前端处理
    		return false;
    	},
        onAll: function (name, args) {
            return false;
        },
    	onReloadKeyFilter:function(){
        	return false;
        },
        onClickKeyFilter:function(filedName,filedValue){
        	return false;
        }
    };
    
    KeyFilter.FILTER_DEFAULTS ={
    	selected : false
    };

    var allowedMethods = ['onFilterClick',
                          'reloadRemoteData',
                          'getSelections',
                          'addFilter'];
    
    $.fn.keyFilter = function (option) {
    	var value,
    	args = Array.prototype.slice.call(arguments, 1);
    	this.each(function () {
    		var $this = $(this),
                data = $this.data('keyfilter'),
                options = $.extend({}, KeyFilter.DEFAULTS, $this.data(),
                    typeof option === 'object' && option);
    		
            if (typeof option === 'string') {
                if ($.inArray(option, allowedMethods) < 0) {
                    throw new Error("Unknown method: " + option);
                }

                if (!data) {
                    return;
                }

                value = data[option].apply(data, args);
            }

            if (!data) {
                $this.data('keyfilter', (data = new KeyFilter(this, options)));
            }
        });
        return typeof value === 'undefined' ? this : value;
    };
    $.fn.keyFilter.constructor = KeyFilter;
    $.fn.keyFilter.defaults = KeyFilter.DEFAULTS;
    $.fn.keyFilter.columnDefaults = KeyFilter.COLUMN_DEFAULTS;
    $.fn.keyFilter.methods = allowedMethods;
    
    $.fn.remoteFilters = function (options) {
    	this.each(function () {
    		var $this = $(this),
    		html = [];
    		$.get(options.url,
    				options.param,
    				function(data){
    			for(var i =0;i<data.result.length;i++) {
    				var item = data.result[i];
    				var innerHtml = [];
    				for(var j=0;j < item.keyFilterList.length;j++){
    					var liItem = item.keyFilterList[j];
    					if(liItem.selected){
    						innerHtml.push(sprintf('<li data-value="%s" data-selected="true">%s</li>',liItem.value,liItem.name));
    					}else{
    						innerHtml.push(sprintf('<li data-value="%s">%s</li>',liItem.value,liItem.name));
    					}
    				}
    	    		html.push(sprintf('<div class="row keyfilter-border">'),
    	    				sprintf('<ul class="fixed-keyfilter-ul2" data-title="%s" data-reload-data="true" data-filter-filed="%s" data-show-More="true" data-select-More="true" data-filed-Number="5" data-table-Id="orderTable">',item.title,item.filterField),
	    					innerHtml.join(''),
    	    				sprintf('</ul>'),
    	    				sprintf('</div>'));
    			}
        		$this.html(html.join(''));
            	$('.fixed-keyfilter-ul2').keyFilter({
            		onReloadKeyFilter:function(){
            			options.param = $('#'+this.options.tableId).bootstrapTable('getFilters');
            			$('.remoteFilters').remoteFilters(options);
                    }
            	});
    		});
        });
    };
    
    $(function () {
        $('[data-toggle="keyfilter"]').keyFilter();
    });
}(jQuery);