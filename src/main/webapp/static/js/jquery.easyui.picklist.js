/**
 * pickList - Hand LINK CRM GROUP
 * 
 * @Copyright 2016 LINK CRM GROUP
 */
!(function($) {
	var sprintf = function(str) {
		var args = arguments, flag = true, i = 1;

		str = str.replace(/%s/g, function() {
			var arg = args[i++];

			if (typeof arg === 'undefined') {
				flag = false;
				return '';
			}
			return arg;
		});
		return flag ? str : '';
	};

	var PickList = function(el, options) {
		this.options = options;
		this.$el = $(el);
		this.$el_ = this.$el.clone();
		this.timeoutId_ = 0;
		this.timeoutFooter_ = 0;
		this.init();
	};

	PickList.prototype.init = function() {
		this.initContainer();
	};

	PickList.prototype.initDialog = function() {
		var that = this;
		that.$container = $('<div class="easyui-dialog pickList-dialog" style="width:650px;height:100%;padding:0px;overflow-y="hidden">'
				+ '<div class="pickListTableDiv" style="width:100%;height:100%"></div>'
				+ '</div>');
		that.destroyOthers();
		that.$container.insertAfter(that.$el);
		$(that.$container).dialog({
			title : that.options.title,
			resizable : false,
			iconCls : 'icon-search',
			modal : true,
			toolbar : '.pickList-toolbar',
			onClose : function() {
				this.dialog("destroy");
			},
			onBeforeLoad : function() {
				param = options.param
			},
			draggable : true,
			buttons : [ {
				text : '确定',
				iconCls : 'icon-ok',
				width : '100px',
				handler : function() {
					that.onConfirmButton();
				}
			}, {
				text : '取消',
				iconCls : 'icon-cancel',
				width : '100px',
				handler : function() {
					that.onCancelButton();
				}
			} ]

		});
		// 加载pickList页面
		that.loadTable();
	};

	PickList.prototype.initContainer = function() {
		var that = this;
		$(this.$el).searchbox({
			required : that.options.required,
			editable : false,
			searcher : function(value, name) {
				if(!that.options.onBeforeOpenDialog()){
            		return ;
            	}
				that.initDialog();
			}
		});
		$(this.$el).next().find("input").on('keyup', function(event) {
			event.preventDefault();
			if (event.keyCode == 8 || event.keyCode == 46) {
				// that.lastValue = $(that.$el).searchbox('getValue');
				$(that.$el).searchbox('setValue', '');
				that.options.completeFun({});
			} 
		});
		
		var $tr = $(that.$el).closest("tr.datagrid-row");
		var $datagrid = $(that.$el).closest("div.datagrid-view2").siblings("table.datagrid-f");
		var index = parseInt($tr.attr("datagrid-row-index"));
		that.options.baseGridIndex = index;
		that.options.baseGrid = $datagrid;
	};

	PickList.prototype.initToolbar = function() {
		var that = this;
	}

	PickList.prototype.loadTable = function() {
		var that = this;
		$('.pickListTableDiv', this.$container).load(this.options.tableUrl,function(response, status, xhr) {
				var $pickListTable = $('.pickListTable', that.$container);
				that.options.fstLoadFlag = true;//首次加载标记
				$('.pickListTable', that.$container).hdatagrid({
					striped : false,
					nowrap : false,
					border : false,
					rownumbers : true,
					singleSelect : true,
					toolbarShow:true,
	    			buttonSearch:true,
	    			buttonMenu:false,
					checkOnSelect : true,
					selectOnCheck : true,
					pagination : true,
					oauthFlag:that.options.oauthFlag,
					pageSize : that.options.pageSize,// 每页显示的记录条数，默认为10
					pageList : that.options.pageList,
					height : '100%',
					width : '100%',
					onBeforeLoad : function(param) {
						that.refreshBaseGridOptions();
						var initParam = that.options.initParam();
						if (initParam != null) {
							$.extend(param,initParam);
						}
						if(that.options.fstLoadFlag && that.options.searchParam){//是否初始化时触发条件查询
							that.options.fstLoadFlag = false;
							var searchParam = that.options.searchParam;
							var searchValue = '';
							if(that.options.searchValue == null){
								searchValue = $(that.$el).searchbox("getValue");
							} else {
								searchValue = that.options.searchValue;
							}
							
							$.extend(param,{
								"searchParam" : searchParam,
								"searchValue" : searchValue
							});
						}
						if(!param.stayFields){
							
							param.stayFields = $pickListTable.datagrid("options").fields;
						}
					    	
					},
					onLoadSuccess:function(data){
						that.options.onLoadSuccess(data);
					},
					onDblClickCell : function(
							index, field, value) {
						that.onConfirmButton();
					}
				});
			});
	};

	PickList.prototype.onConfirmButton = function() {
		var that = this;
		if(that.options.mustSelect == false){
			that.closeWindow();
			return;
		};
		var selectedRows = $(".pickListTable", that.$container).datagrid(
				'getSelections');
		if (selectedRows == null || selectedRows.length < 1) {
			$.messager.alert('提示', '请选择一条数据!');
			return false;
		}
		if (selectedRows == null || selectedRows.length > 2) {
			$.messager.alert('提示', '只能选择一条数据!');
			return false;
		}
		
		that.refreshBaseGridOptions();
		
		var result = that.options.completeFun(selectedRows[0]);
		if (result != null && typeof result === 'string') {
			$(that.$el).searchbox("setValue", result);
		}
		if(result != null && result == false){
		}else{
			that.closeWindow();
		}
	};

	PickList.prototype.onCancelButton = function() {
		var that = this;
		that.refreshBaseGridOptions();
		that.options.cancelFun();
		that.closeWindow();
	};
	
	/** 更新基础列表上参数 */
	PickList.prototype.refreshBaseGridOptions = function() {
		var that = this;
		if(that.options.baseGrid.length >0 ){
			that.options.baseGrid.datagrid("options").batchEditingIndex = that.options.baseGridIndex;
		}
	};
	PickList.DEFAULTS = {
		title : '请选择..',
		tableUrl : '/pickList/noMatch.jsp',
		mustSelect:true,
		searchParam : null,//初始化时触发的查询条件
		searchValue : null,//初始化时触发的查询内容，如果值为null，则取输入框的值
		oauthFlag:true,
		initParam : function() {
			// 默认参数为空
			return null;
		},
		completeFun : function(selectRow) {
			// 如果返回一个字符串，则赋值给输入框
			return null;
		},
		cancelFun : function() {

		},
		onLoadSuccess : function(data) {
			
		},
		onBeforeOpenDialog:function(){
	    	return true;
	    },
		pageSize : 20,// 每页显示的记录条数，默认为10
		pageList : [ 20, 50, 100 ],
		searchPrompt : '请输入查询内容...'
		
	};

	PickList.prototype.closeWindow = function() {
		$(this.$container).dialog("destroy");
	};
	
	PickList.prototype.showWindow = function() {
		this.initDialog();
	};

	PickList.prototype.resize = function(width) {
		this.$el.searchbox("resize", width);
	};

	PickList.prototype.disable = function() {
		this.$el.searchbox("disable");
	};

	PickList.prototype.enable = function() {
		this.$el.searchbox("enable");
	};

	PickList.prototype.clear = function() {
		this.$el.searchbox("clear");
	};

	PickList.prototype.destroy = function() {
		if (this.$container != null) {
			try {
				this.$container.dialog("destroy");
			} catch (err) {
			}
		}
	};
	PickList.prototype.destroyOthers = function() {
		$('.pickList-dialog').dialog("destroy");
	};

	PickList.prototype.setValue = function(value) {
		this.$el.searchbox("setValue", value);
	};

	PickList.prototype.getValue = function(target) {
		return this.$el.searchbox("getValue");
	};

	var allowedMethods = [ 'resize', 'destroy', 'setValue', 'getValue','showWindow','closeWindow',
			'disable', 'enable', 'clear' ];

	$.fn.picklist = function(option) {
		var value = null, args = Array.prototype.slice.call(arguments, 1);
		this.each(function() {
			var $this = $(this), data = $this.data('picklist'), options = $
					.extend({}, PickList.DEFAULTS, $.fn.picklist
							.parseOptions(this), typeof option === 'object'
							&& option);
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
				$this.data('picklist', (data = new PickList(this, options)));
				value = $this;
			}
		});
		return typeof value == null ? this : value;
	};

	$.fn.picklist.parseOptions = function(target) {
		var t = $(target);
		return $.extend(
		// 新空对象
		$.fn.textbox.defaults,
		// 公用的属性转换器
		$.parser.parseOptions(target, [ 'id', 'width', 'height', 'left', 'top',
				'title', 'iconCls', 'cls', 'headerCls', 'bodyCls', 'tools',
				'href', 'tableUrl', 'completeFun', 'initParam', {
					cache : 'boolean',
					fit : 'boolean',
					border : 'boolean',
					noheader : 'boolean'
				}, {
					collapsible : 'boolean',
					minimizable : 'boolean',
					maximizable : 'boolean'
				}, {
					closable : 'boolean',
					collapsed : 'boolean',
					minimized : 'boolean',
					maximized : 'boolean',
					closed : 'boolean'
				} ]),
		// loadingMessage属性有什么特别之处，为什么要单独作为一个参数？
		{
			loadingMessage : (t.attr('loadingMessage') != undefined ? t
					.attr('loadingMessage') : undefined)
		});
	};
})(jQuery);
/**
 * 
 * 扩展editors的picklistbox方法
 */
$.extend($.fn.datagrid.defaults.editors, {
	picklistbox : {
		init : function(container, options) {
			var input = $('<input class="easyui-picklist">')
					.appendTo(container);
			return input.picklist(options);
		},
		destroy : function(target) {
			$(target).picklist('destroy');
		},
		getValue : function(target) {
			return $(target).picklist('getValue');
		},
		setValue : function(target, value) {
			$(target).picklist('setValue', value);
		},
		resize : function(target, width) {
			$(target).picklist('resize', width);
		}
	}
});