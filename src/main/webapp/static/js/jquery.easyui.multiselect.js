/**
* multiSelected  - Hand LINK CRM GROUP
* @author ashen
* @Copyright 2016 LINK CRM GROUP
**/
!(function($){
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
    
	var MultiSelect = function (el, options) {
        this.options = options;
        this.$el = $(el);
        this.$el_ = this.$el.clone();
        this.timeoutId_ = 0;
        this.timeoutFooter_ = 0;
        this.init();
    };
    

    MultiSelect.prototype.init = function () {
    	this.initDialog();
    };
    
    MultiSelect.prototype.initDialog = function () {
    	var that = this;
    	that.$container = $('<div class="easyui-dialog multiSelect-dialog" style="width:650px;height:100%;padding:0px;overflow-y="hidden">'+
				'<div class="multiSelectTableDiv" style="width:100%;height:100%"></div>'+
			'</div>');
			that.$toolbar = $('<div class="multiSelect-toolbar">搜索条件: <input class="easyui-combobox searchParam" style="width: 100px" name="searchParam"/> '
					+ '<input style="width: 200px;" type="text" name="searchValue" class="easyui-textbox" />'
					+ '<a class="easyui-query-list-table" iconCls="icon-search" plain="true" >查询</a>'
					+ '</div>')
			that.destroyOthers();
			that.$container.insertAfter(that.$el);
			that.$toolbar.insertAfter(that.$container);
			$(that.$container).dialog({
	    		title:that.options.title,
	    		resizable:false,
	            iconCls : 'icon-search',   
	    		modal: true,
	    		toolbar:'.multiSelect-toolbar',
	    		onClose:function(){
	    			this.dialog("destroy");
	    		},
	    		onBeforeLoad:function(){
					param = options.param
				},
	    		draggable:false ,
	    		buttons : [{    
	                text : '确定',    
	                iconCls : 'icon-ok',
	                width: '100px',
	                handler : function() {
	                	that.onConfirmButton();
	                }    
	            },{    
	                text : '取消',    
	                iconCls : 'icon-cancel',
	                width: '100px',
	                handler : function() {    
	                	that.onCancelButton();
	                }
	            }]  

	    	});
			//加载multiSelect页面
			that.loadTable();
    };
    
    MultiSelect.prototype.initToolbar = function(){
    	var that = this;
    }
    
    MultiSelect.prototype.loadTable = function (){
    	var that = this;
    	$('.multiSelectTableDiv',this.$container).load(this.options.tableUrl,function(response,status,xhr){
    		var multiSelectTable = $('.multiSelectTable',that.$container);
    		var fieldList = $('thead > tr > th',multiSelectTable);
    		var comboxData = [];
    		var noDefaultSelected = false;
    		for(var i=0;i<fieldList.length;i++){
    			if($(fieldList[i]).attr('checkbox') == "true")
    				continue;
    			if($(fieldList[i]).attr('defaltSearch') == "true"){
    				comboxData.push({
    					selected:true,
        				field:$(fieldList[i]).attr('field'),
        				title:$(fieldList[i]).html()
        			});
    				noDefaultSelected = true;
    			}else{
        			comboxData.push({
        				field:$(fieldList[i]).attr('field'),
        				title:$(fieldList[i]).html()
        			});
    			}
    		}
    		if(noDefaultSelected != true){
    			comboxData[0].selected = true;
    		}
    		$('.multiSelectTable',that.$container).hdatagrid({
    			striped:false,
    			nowrap:true,
    			border:false,
    			rownumbers:true,
    			singleSelect:false,
				checkOnSelect:true,
				selectOnCheck:true,
				pagination:true,
				selectFirstRow:false,
				oauthFlag:that.options.oauthFlag,
				height:'100%',
				width:'100%',
    		    pageSize: 50,//每页显示的记录条数，默认为10 
    		    pageList: [50,200,1000],
    		    onLoadError:function(){
    		    	$.messager.alert('警告',data.result);
    		    },
    		    onBeforeLoad:function(param){
    		    	var initParam = that.options.initParam();
    		    	if(initParam != null){
        				$.extend(param,initParam);
    		    	}
    			},
    		    onLoadSuccess:function(data){
    		    	if(data.success == 'false' || data.success == false   ){
    		    		$.messager.alert('警告',data.result);
    		    		data.rows=[];
    		    	}
    		    }
    		});
    		
    		
    		$('.easyui-query-list-table',that.$toolbar).linkbutton({
    			onClick:function(){
					var searchParam = $(that.$toolbar).find("input[name='searchParam']");
					var searchValue = $(that.$toolbar).find("input[name='searchValue']");
					var options =$('.multiSelectTable',that.$container).datagrid('options');
					var filterList = options.filterList;
					$('.multiSelectTable',that.$container).datagrid("load", formatRequest({
						"searchParam" : searchParam.val(),
						"searchValue" : searchValue.val(),
						filtersRaw:options.filterList
				    }));
				}
    		}
    		);
    		$('.easyui-textbox', that.$toolbar).textbox({
				prompt : '请输入查询内容...',
				iconWidth: 0,
			});
    		
    		$('.easyui-textbox', that.$toolbar).textbox('textbox').bind('keydown', function(e){
    			if (e.keyCode == 13){
    				var searchParam = $(that.$toolbar).find("input[name='searchParam']");
					var searchValue = $(that.$toolbar).find("input[name='searchValue']");
					var options =$('.multiSelectTable',that.$container).datagrid('options');
					var filterList = options.filterList;
					$('.multiSelectTable',that.$container).datagrid("load", formatRequest({
						"searchParam" : searchParam.val(),
						"searchValue" : searchValue.val(),
						filtersRaw:options.filterList
				    }));
    			}
    		});
        	$('.searchParam',that.$toolbar).combobox({
        		valueField:'field',
        		textField:'title',
        		data:comboxData
        	});
    	});
    };
    
    MultiSelect.prototype.onConfirmButton = function(){
    	var that = this;
    	var selectedRows = $(".multiSelectTable",that.$container).datagrid('getSelections');
    	if(selectedRows == null || selectedRows.length <1){
    		$.messager.alert('提示','至少请选择一条数据!');
    		return false;
    	}
		var result = that.options.completeFun(selectedRows);
		that.closeWindow();
    };
    
    MultiSelect.prototype.onCancelButton = function () {
    	var that = this;
		that.options.cancelFun();
		that.closeWindow();
    };
    
    MultiSelect.DEFAULTS = {
		title:'请选择..',
		tableUrl:'/multiSelect/noMatch.jsp',
		oauthFlag:true,
		initParam:function(){
			//默认参数为空
			return null;
		},completeFun:function(selectRow){
			//如果返回一个字符串，则赋值给输入框
			return null;
		},cancelFun:function(){
			
		}
    };
    
    MultiSelect.prototype.closeWindow = function(){
    	$(this.$container).dialog("destroy");
    };
    
    MultiSelect.prototype.destroy = function(){
    	if(this.$container != null){
    		try{
    			this.$container.dialog("destroy");
    		}catch(err)
    		{}
    	}
    };
    MultiSelect.prototype.destroyOthers = function(){
		$('.multiSelect-dialog').dialog("destroy");
    };
    
    var allowedMethods = ['resize','destroy','setValue','getValue','disable','enable','clear'];
    
    
    $.fn.multiSelect = function (option) {
    	var value = null,
    	args = Array.prototype.slice.call(arguments, 1);
    	this.each(function () {
    		var $this = $(this),
                data = $this.data('multiSelect'),
                options = $.extend({}, MultiSelect.DEFAULTS, $.fn.multiSelect.parseOptions(this),
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

            $this.data('multiSelect', (data = new MultiSelect(this, options)));
            value = $this;
        });
    	return typeof value == null ? this : value;
    };
    

    $.fn.multiSelect.parseOptions = function (target) {   
        var t = $(target);   
        return $.extend(   
            //新空对象   
        	$.fn.textbox.defaults,
            //公用的属性转换器   
            $.parser.parseOptions(target, ['id', 'width', 'height', 'left', 'top',  
                'title', 'iconCls', 'cls', 'headerCls', 'bodyCls', 'tools', 'href','tableUrl','completeFun','initParam',
                {cache: 'boolean', fit: 'boolean', border: 'boolean', noheader: 'boolean'},   
                {collapsible: 'boolean', minimizable: 'boolean', maximizable: 'boolean'},   
                {closable: 'boolean', collapsed: 'boolean', minimized: 'boolean', maximized: 'boolean', closed: 'boolean'}   
            ]),   
            //loadingMessage属性有什么特别之处，为什么要单独作为一个参数？   
            {   
                loadingMessage: (t.attr('loadingMessage') != undefined ? t.attr('loadingMessage') : undefined)   
            }   
        );   
    }; 
})(jQuery);