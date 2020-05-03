/**
* mvgPick 控件
**/
!(function($){
	var mvgObj;
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
    
	var MvgPick = function (el, options) {
        this.options = options;
        this.$el = $(el);
        this.$el_ = this.$el.clone();
        this.timeoutId_ = 0;
        this.timeoutFooter_ = 0;
        this.init();
    };
    
    /**
     * 深度克隆对象
     * @param 被克隆的对象
	 * @return 返回一个新对象
     */
    function deepCloneObj(Object){
    	var newObject = JSON.parse(JSON.stringify(Object));
    	return newObject;
    }
    
    /**
     * 解析参数
     * @param paramArray 被解析的参数对象
     * @param thisRow 'THIS_ROW'的数据源
     * @param mvgRow 'MVG_ROW'的数据源
     * @returns 解析完成的参数对象
     */
    function parseParam(paramObj, thisRow, mvgRow) {
    	var result = {};
		//分解参数
		for(var str in paramObj){
			if((typeof paramObj[str] != 'string') || paramObj[str].constructor != String){//判断是否为字符串，如果不是则直接提取赋值
				result[str] = paramObj[str];
				continue;
			}
			var tempArray = paramObj[str].split(".");
			if(tempArray.length == 2 && (tempArray[0] == 'MVG_ROW' || tempArray[0] == 'THIS_ROW')){
				if(tempArray[0] == 'MVG_ROW'){
					result[str] = mvgRow[tempArray[1]];
				}
				else if(tempArray[0] == 'THIS_ROW'){
					if($.isEmptyObject(thisRow)){
						/*$.messager.alert('警告','获取到父对象行为空，请检查程序!提示 ：MVG的 tableId 和 datagrid 属性不能同时为空。');
						return null;*/
		    		} else {
		    			result[str] = thisRow[tempArray[1]];
		    		}
				}
			}
			else {
				result[str] = paramObj[str];
			}
    	}
		return result;
    }

    MvgPick.prototype.init = function () {
    	this.initContainer();
    };
    
    MvgPick.prototype.initContainer = function () {
    	var that = this;
    	$(this.$el).textbox({
    		editable:false,
    		prompt: '请选择...',
            iconWidth: 22,
            icons: [{
                iconCls:'icon-page-white-side-by-side',
                handler: function(e){
                	if(!that.options.onBeforeOpenDialog()){
                		return ;
                	}
					that.initDialog();
                }
            }]
    	});
    	
    	var $tr = $(that.$el).closest("tr.datagrid-row");
		var $datagrid = $(that.$el).closest("div.datagrid-view2").siblings("table.datagrid-f");
		var index = parseInt($tr.attr("datagrid-row-index"));
		that.options.baseGridIndex = index;
		that.options.baseGrid = $datagrid;
    };
    
    /**
     * 按照设定的规则来初始化MVG的默认参数
     */
    MvgPick.prototype.defaultsValueInit = function () {
    	var that = this;//mvg对象
    	/* ---------预处理开始-------- */
    	that.options.remoteDefaultId = 'noMatchId';//初始化主要ID(单选按钮)
    	if(true){//预处理左列表属性
    		that.options.optionsLeft.checkbox = true;
    	}
    	if(true){//预处理右列表属性
    		var tempOptionsRight = {};
    		tempOptionsRight.checkbox = false;
    		tempOptionsRight.tableUrl = that.options.optionsLeft.tableUrl;//默认取左列表
    		tempOptionsRight.initParam = that.options.optionsLeft.initParam;//默认取左列表的初始化参数
    		if(that.options.optionsRight.radio == undefined || that.options.optionsRight.radio == true){
    			that.options.optionsRight.radio = $.extend({}, {
    				field : 'isDefault',
    				title : '主要',
    				readOnly : false,
    				onClickAction : function(clickRow) {}
    			}, that.options.optionsRight.radio); // 右表中列的单选按钮
    		}
    		that.options.optionsRight = $.extend({},tempOptionsRight,that.options.optionsRight);
    	}
    	//预处理tableId属性
    	if(true){
    		if(that.options.tableId){
    			that.options.datagrid = $('#' + that.options.tableId);
    		}
    		that.options.parDatagridRow = that.getParDatagridRow();//获取父表选中行
    	}
    	//设置批量插入操作的参数
		if (that.options.insertOptions) {
			var insertOptionsDefault = {
				url : getRootPath() + '/action/portal/mvg/batchInsert',
				param : {
					mvgSubsetId : 'MVG_ROW.id',
					mvgParentId : that.options.mvgParentId,
					corpid : 'MVG_ROW.corpid'
					
				}
			};// param中的'MVG_ROW' 为mvg的选中行，'THIS_ROW'为当前编辑行
			if(that.checkOpenRadio(that.options.optionsRight.radio)){//如果开启了单选主要行，则设置必要的参数
				insertOptionsDefault.param['defField'] = that.options.optionsRight.radio.field;
				insertOptionsDefault.param['queryDefaultFlag'] = that.options.autoRadioSelect;
			}
			var insertOptions = that.options.insertOptions;
    		if(insertOptions.url){
    			//合并参数，如果param有设置值的话就直接清除默认的param参数。因为默认url被替换的话，默认的param也没有存在的必要
    			$.extend(insertOptionsDefault, insertOptions);
    		} else {
    			$.extend(insertOptionsDefault.param, insertOptions.param);//合并额外参数，不清除默认param参数(但可能被覆盖)
    		}
    		that.options.insertOptions = insertOptionsDefault;
    	}
    	//设置批量删除操作的参数
    	if(that.options.deleteOptions){
			var deleteOptionsDefault = {
				url : getRootPath() + '/action/portal/mvg/batchDelete',
				param : {
					mvgSubsetId : 'MVG_ROW.id',
					mvgParentId : that.options.mvgParentId
				}
			};// param中的'MVG_ROW' 为mvg的选中行，'THIS_ROW'为当前编辑行
			if(that.checkOpenRadio(that.options.optionsRight.radio)){//如果开启了单选主要行，则设置必要的参数
				deleteOptionsDefault.param['defField'] = that.options.optionsRight.radio.field;
				insertOptionsDefault.param['queryDefaultFlag'] = that.options.autoRadioSelect;
			}
			var deleteOptions = that.options.deleteOptions;
    		if(deleteOptions.url){
    			//合并参数，如果param有设置值的话就直接清除默认的param参数。因为默认url被替换的话，默认的param也没有存在的必要
    			$.extend(deleteOptionsDefault, deleteOptions);
    		} else {
    			$.extend(deleteOptionsDefault.param, deleteOptions.param);//合并额外参数，不清除默认param参数(但可能被覆盖)
    		}
    		that.options.deleteOptions = deleteOptionsDefault;
    	}
    	//设置删除全部操作的参数
    	if(that.options.deleteAllOptions){
			var deleteAllOptionsDefault = {
				url : getRootPath() + '/action/portal/mvg/deleteAll',
				param : {
					mvgParentId : that.options.mvgParentId
				}
			};// param中的'MVG_ROW' 为mvg的选中行，'THIS_ROW'为当前编辑行
			var deleteAllOptions = that.options.deleteAllOptions;
    		if(deleteAllOptions.url){
    			//合并参数，如果param有设置值的话就直接清除默认的param参数。因为默认url被替换的话，默认的param也没有存在的必要
    			$.extend(deleteAllOptionsDefault, deleteAllOptions);
    		} else {
    			$.extend(deleteAllOptionsDefault.param, deleteAllOptions.param);//合并额外参数，不清除默认param参数(但可能被覆盖)
    		}
    		that.options.deleteAllOptions = deleteAllOptionsDefault;
    	}
    	//设置【添加】监听事件方法为默认方法
    	if(!that.options.onInsertAction){
    		that.options.onInsertAction = that.onInsertActionDefault;
    	}
    	//设置【删除】监听事件方法为默认方法
    	if(!that.options.onDeleteAction){
    		that.options.onDeleteAction = that.onDeleteActionDefault;
    	}
    	//设置【删除所有】监听事件方法为默认方法
    	if(!that.options.onDeleteAllAction){
    		that.options.onDeleteAllAction = that.onDeleteAllActionDefault;
    	}
    	
    	/*
    	 * -----------------------------------------------------------
    	 * 设置只读模式的配置,该段代码放在该方法的最后面
    	 */
    	if(that.options.readOnly){
			that.options.insertOptions = false;
			that.options.deleteOptions = false;
			that.options.deleteAllOptions = false;
			if(that.checkOpenRadio(that.options.optionsRight.radio)){
				that.options.optionsRight.radio.readOnly = true;//设置单选按钮只读
			}
    	}
    	
    }
    
    MvgPick.prototype.initDialog = function () {
    	var that = this;
    	mvgObj = that;
    	that.defaultsValueInit();
    	that.$container = $('<div class="easyui-dialog mvgPick-dialog" style="clear:both;width:' + that.options.width + ';height:' + that.options.height + ';padding:0px;overflow-y=\"hidden\"">'+
				'<div id="mvgPickTableDiv_Left" style="width:47%;height:100%;float:left;"></div>'+
				'<div id="mvgPickTableDiv_Center" style="width:6%;height:100%;padding-top:0px;float:left;text-algin:center;">'+
					'<p style="margin-top:110px; ' + (that.options.insertOptions == false ? 'display:none;' : '') + '">'+
						'&nbsp;&nbsp;<input type="button" style="height:35px;width:70%;font-size:17px !important;" class="addMvgRow_Right btn" value=">" title="移动选择项到右侧"/>'+
					'</p><br/>'+
					'<p style=" ' + (that.options.deleteOptions == false ? 'display:none;' : '') + '">'+
						'&nbsp;&nbsp;<input type="button" style="height:35px;width:70%;font-size:17px !important;" class="deleteMvgRow_Right btn" value="<" title="移动选择项到左侧"/>'+
					'</p><br/>'+
					'<p style=" ' + (that.options.deleteAllOptions == false ? 'display:none;' : '') + '">'+
						'&nbsp;&nbsp;<input type="button" style="height:35px;width:70%;font-size:17px !important;" class="deleteAllMvgRow_Right btn" value="<<" title="全部移到左侧"/>'+
					'</p><br/>'+
				'</div>'+
				'<div id="mvgPickTableDiv_Right" style="width:47%;height:100%;float:left;"></div>'+
			'</div>');
			that.destroyOthers();
			that.$container_Left = that.$container.find("#mvgPickTableDiv_Left");
			that.$container_Right = that.$container.find("#mvgPickTableDiv_Right");
			that.$container.insertAfter(that.$el);
			that.refreshBaseGridOptions();
			$(that.$container).dialog({
	    		title:that.options.title,
	    		resizable:false,
	            iconCls : 'icon-search',
	            border:false,
	    		modal: true,
	    		closable:false,
	    		buttons : [{    
	                text : '确定',    
	                iconCls : 'icon-ok',
	                width: '100px',
	                handler : function() {
	                	that.onConfirmButton();
	                }    
	            }]  

	    	});
			//【添加】按钮
			that.$container.find(".addMvgRow_Right").click(function(){
				var resultRows = [];//返回的结果行
				var selectRows_Left = $('.mvgPickTable',that.$container_Left).datagrid("getSelections");//左列表的所有当前选中行
				if(selectRows_Left == null || selectRows_Left.length <= 0){
					 $.messager.alert('提示','请选中要添加的信息！'); 
					 return;
				}
				that.$container.find(".addMvgRow_Right").attr("disabled", "disabled");//锁定按钮，禁止点击，防止按钮被重复点击
				resultRows = selectRows_Left;
				that.radioButtonOnClickListener();//添加单选按钮监听事件
				that.options.onInsertAction(resultRows);
			});
			//【删除】按钮
			that.$container.find(".deleteMvgRow_Right").click(function(){
				var resultRows = [];//返回的结果行
				var selectRows_Right = $('.mvgPickTable',that.$container_Right).datagrid("getSelections");//右列表的所有当前选中行
				if(selectRows_Right == null || selectRows_Right.length <= 0){
					 $.messager.alert('提示','请选中要删除的信息！'); 
					 return;
				}
				that.$container.find(".deleteMvgRow_Right").attr("disabled", "disabled");//锁定按钮，禁止点击，防止按钮被重复点击
				//检查单选按钮选中行是否被选中删除
				if(that.checkOpenRadio(that.options.optionsRight.radio)){//判断单选按钮列是否被开启
					var checkedRow = that.options.optionsRight.radio.checkedRow;//获取单选按钮选中行
					for(var i = 0; selectRows_Right != null && i < selectRows_Right.length; i++){
						var selectRow_right = selectRows_Right[i];
						if(checkedRow.id == selectRow_right.id){
							for(var str in checkedRow){
								checkedRow[str] = ''; 
			            	}
							break;
						}
					}
				}
				resultRows = selectRows_Right;
				that.options.onDeleteAction(resultRows);
			});
			//【删除全部】按钮
			that.$container.find(".deleteAllMvgRow_Right").click(function(){
				var checkedRow = that.options.optionsRight.radio.checkedRow;
				for(var str in checkedRow){
					checkedRow[str] = '';
            	}
				$('.mvgPickTable',that.$container_Right).datagrid('loadData', { total: 0, rows: [], success:true});
				that.options.onDeleteAllAction();
			});
			//加载mvgPick页面
			that.loadTable();
    };
    
    MvgPick.prototype.initToolbar = function(){
    	var that = this;
    }
    /** 更新基础列表上参数 */
    MvgPick.prototype.refreshBaseGridOptions = function() {
		var that = this;
		if(that.options.baseGrid.length >0 ){
			that.options.baseGrid.datagrid("options").batchEditingIndex = that.options.baseGridIndex;
		}
	};
    MvgPick.prototype.loadTable = function (){
    	var that = this;
    	var optionsLeft = that.options.optionsLeft;//左列表的options属性
    	var optionsRight = that.options.optionsRight;//右列表的options属性
    	$(this.$container_Left).load(optionsLeft.tableUrl,function(response,status,xhr){
    		var mvgPickTable = $('.mvgPickTable',that.$container_Left);
    		$(mvgPickTable).datagrid({url:''});//实例化datagrid
    		/*if(optionsLeft.url == ''){//如果mvg中的datagrid的url属性为空，则取mvg的jsp页面的url
    			optionsLeft.url = $(mvgPickTable).datagrid('options').url;
    		}*/
    		var columns = $(mvgPickTable).datagrid('options').columns;
    		
    		/* ---------------------------------------------- */
    		//添加复选框列
    		if(that.options.optionsLeft.checkbox == true){
        		if(columns[0] && columns[0].length > 0){
					var column = {field : 'checkbox_field',checkbox : true, noSearch : true};
        			columns[0].unshift(column);
        		}
    		}
    		var datagridOpts = $.extend({},{
    			toolbarShow:true,
    			buttonSearch:true,
    			singleSelect:false,
    			url:getRootPath() + '/action/portal/mvg/queryLeftListPage',
				selectFirstRow:false,
				oauthFlag:false,
				columns:columns,
    			title:'未选择',
    			width:'100%',
    			height:'100%',
    			pageSize: 15,//每页显示的记录条数，默认为12 
    		    pageList: [15,30,50]
    		    
    		},optionsLeft,
    		{
    			onBeforeLoad:function(param){
    				if(optionsLeft.onBeforeLoad){
    					optionsLeft.onBeforeLoad(param);
    		    	}
    				var initParam = optionsLeft.initParam();
					if (initParam != null) {
						$.extend(param,initParam);
					}
    				param.mvgMapperName = that.options.mvgMapperName;
    			},
    		    onLoadSuccess:function(data){
    		    	if(data.success == 'false' || data.success == false   ){
    		    		$.messager.alert('警告',data.result);
    		    		data.rows=[];
    		    	}
    		    	that.$container.find(".addMvgRow_Right").removeAttr("disabled");//解除按钮的锁定
    		    	if(optionsLeft.onLoadSuccess){
    		    		optionsLeft.onLoadSuccess(data);
    		    	}
    		    }
    		});
    		$('.mvgPickTable',that.$container_Left).hdatagrid(datagridOpts);
    		that.options.datagridLeft = $('.mvgPickTable',that.$container_Left);
    	});

    	$(this.$container_Right).load(optionsRight.tableUrl,function(response,status,xhr){
    		var mvgPickTable = $('.mvgPickTable',that.$container_Right);
    		$(mvgPickTable).datagrid({url:''});//实例化datagrid
    		/*if(optionsRight.url == ''){//如果mvg中的datagrid的url属性为空，则取mvg的jsp页面的url
    			optionsRight.url = $(mvgPickTable).datagrid('options').url;
    		}*/
    		var columns = $(mvgPickTable).datagrid('options').columns;
    		/* ---------------------------------------------- */
    		//添加单选按钮列
    		if(that.checkOpenRadio(that.options.optionsRight.radio)){
    			var radio = that.options.optionsRight.radio;
        		if(columns[0] && columns[0].length > 0){
					var column = {
									field : radio.field,
									title : radio.title,
									noSearch : true,
									formatter : that.radioFormatter_mvg_Right
								};
        			columns[0].unshift(column);
        		}
        		var checkedRow = $(that.$el).textbox('options').checkedRow;//提取存放在单元格的单选按钮选中行
        		if(!checkedRow){
        			checkedRow = {id:'',radio_status:'not_change'};
        		}
        		radio.checkedRow = checkedRow;//构造被选中的行的默认值
        		for(var i = 0; i < columns[0].length; i++){
        			radio.checkedRow[columns[0][i]] = '';//构造行，初始化默认值
        		}
    		}
    		/* ---------------------------------------------- */
    		//添加复选框列
    		if(that.options.optionsRight.checkbox == true){
        		if(columns[0] && columns[0].length > 0){
					var column = {field : 'checkbox_field',checkbox : true, noSearch : true};
        			columns[0].unshift(column);
        		}
    		}
    		var datagridOpts = $.extend({},{
    			toolbarShow:true,
    			buttonSearch:true,
    			singleSelect:false,
    			url:getRootPath() + '/action/portal/mvg/queryRightListPage',
    			checkOnSelect:true,
				selectOnCheck:true,
				selectFirstRow:false,
				oauthFlag:false,
				columns:columns,
				title:'已选择',
    			width:'100%',
    			height:'100%',
    			resizable:'true',
    			pageSize: 15,//每页显示的记录条数，默认为12 
    		    pageList: [15,30,50]
    		},optionsRight,
    		{
    			onBeforeLoad:function(param){
    				if(optionsRight.onBeforeLoad){
    					optionsRight.onBeforeLoad(param);
    		    	}
    				var initParam = optionsRight.initParam();
					if (initParam != null) {
						$.extend(param,initParam);
					}
    				param.mvgMapperName = that.options.mvgMapperName;
    			},
    		    onLoadSuccess:function(data){
    		    	if(data.success == 'false' || data.success == false   ){
    		    		$.messager.alert('警告',data.result);
    		    		data.rows=[];
    		    	}
    		    	that.radioButtonOnClickListener();
    		    	that.$container.find(".deleteMvgRow_Right").removeAttr("disabled");//解除按钮的锁定
    		    	if(optionsRight.onLoadSuccess){
    		    		optionsRight.onLoadSuccess(data);
    		    	}
    		    }
    		});
    		$('.mvgPickTable',that.$container_Right).hdatagrid(datagridOpts);
    		that.options.datagridRight = $('.mvgPickTable',that.$container_Right);
    	});
    	
    };
    MvgPick.prototype.onConfirmButton = function(){
    	var that = this;
    	that.options.datagridRight.datagrid('acceptChanges');
		var mvgResult = '';
		if(!that.options.completeFun){//如果没有配置返回方法，则直接关闭窗口
			that.closeWindow();
			return;
		}
		//检查单选按钮是否被开启
    	if(that.checkOpenRadio(that.options.optionsRight.radio)){//如果开启了单选按钮，则【确定】按钮回调函数的参数为 '单选行'
    		var checkedRow = that.options.optionsRight.radio.checkedRow;
    		$(that.$el).textbox('options').checkedRow = checkedRow;//将单选按钮选中行备份在单元格中，用于若mvg窗口重新打开时读取选中行
    		//区分 单选按钮组 是否曾被操作(例如：点击、删除行)
        	if(checkedRow && checkedRow.radio_status == 'not_change'){//如果没有被操作
        		mvgResult = that.options.completeFun(null);//点击【确定】按钮后的回调函数
        	} 
        	else {
        		mvgResult = that.options.completeFun(checkedRow);
        	}
    	} 
    	else {//否则【确定】按钮回调函数的参数为 '右列表的当前页的所有行的数组'
    		var selectedRows = that.options.datagridRight.datagrid('getRows');
    		mvgResult = that.options.completeFun(selectedRows);
    	}
    	//判断给mvgPickBox的返回值是否合法
    	if(mvgResult != null && typeof mvgResult === 'string'){
			$(that.$el).textbox("setValue",mvgResult);//设置mvgPickBox编辑框的显示值
		} else {
			$(that.$el).textbox("setValue",'');
		}
		that.closeWindow();
    };
    
    MvgPick.DEFAULTS = {
		title:'请选择..',//mvg标题
		width:$(window).width() * 0.9 + 'px',
		height:$(window).height() * 0.9 + 'px',
		optionsLeft:{},//左列表的配置属性
		optionsRight:{},//右列表的配置属性
		mvgMapperName:'',//要启用的mapper实现类名称
		readOnly:false,//是否只读
		insertOptions:{url:'',param:{}},//param中的'MVG_ROW' 为mvg的选中行，'THIS_ROW'为当前编辑行
		deleteOptions:{url:'',param:{}},//param中的'MVG_ROW' 为mvg的选中行，'THIS_ROW'为当前编辑行
		deleteAllOptions:{url:'',param:{}},//param中的'MVG_ROW' 为mvg的选中行，'THIS_ROW'为当前编辑行
		/* 注意：tableId属性与datagrid属性只需选一个，优先使用tableId */
		tableId:'',//当前编辑行的datagrid对象对应的table标签的ID
		datagrid:null,//当前编辑行的datagrid对象
		tableType:'hdatagrid',//父列表类型,hdatagrid/datagrid
		mvgParentId:'THIS_ROW.id',
		autoRadioSelect:true,//是否开启默认选择主要行
		/* ------- */
		/** 【添加】按钮后，触发的事件 */
		onInsertAction:null,
		/** 【删除】按钮后，触发的事件 */
		onDeleteAction:null,
		/** 【删除所有】按钮后，触发的事件 */
		onDeleteAllAction:null,
		/** 【确定】按钮后，触发回调方法 */
		completeFun:null,
		/** mvg弹出框出现前触发的方法，返回true打开弹出框，否则不打开 */
		onBeforeOpenDialog:function(){
	    	return true;
	    },
    };
    
    MvgPick.prototype.closeWindow = function(){
    	$(this.$container).dialog("close");
    };
    
    MvgPick.prototype.resize = function(width){
    	this.$el.textbox("resize",width);
    };

    MvgPick.prototype.destroy = function(){
    	if(this.$container != null){
    		try{
    			this.$container.dialog("destroy");
    		}catch(err)
    		{}
    	}
    };
    MvgPick.prototype.destroyOthers = function(){
		$('.mvgPick-dialog').dialog("destroy");
    };
    
    MvgPick.prototype.setValue = function(value){
    	this.$el.textbox("setValue",value);
    };

    MvgPick.prototype.getValue = function(target){
    	return this.$el.textbox("getValue");
    };

    /** 右列表的单选按钮的formatter */
    MvgPick.prototype.radioFormatter_mvg_Right = function(value, row, rowIndex) {
    	if(!row.id){//ID不能为空
    		return value;
    	}
    	var radio_A = '<input type="radio" name="radio_mvg_group_right" value="' + row.id + '" ';
    		var radio_B = ' />';
    	var radio = '';
    	var checkedRow = mvgObj.options.optionsRight.radio.checkedRow;//获取存储在MVG对象属性中的单选行
    	if(rowIndex == 0 && mvgObj.options.autoRadioSelect && (!checkedRow || !checkedRow.id) && !mvgObj.options.remoteDefaultId){
			mvgObj.options.optionsRight.radio.checkedRow = deepCloneObj(row);
			checkedRow = mvgObj.options.optionsRight.radio.checkedRow;
    	}
		if(checkedRow && checkedRow.radio_status == 'not_change'){//判断单选按钮是否曾经被更改过
			if (value == 'Y' || value == 'y' || value == '是') {
	    		//设置为选中状态
	    		radio = radio + ' checked ';
	    		row[this.field] = 'Y';
	    		mvgObj.options.optionsRight.radio.checkedRow = deepCloneObj(row);
	    	} else {
	    		row[this.field] = 'N';
	    	}
		} else {
			if(checkedRow && checkedRow.id == row.id){//读取暂存在对象中的单选按钮选中行
				//设置为选中状态
	    		radio = radio + ' checked ';
	    		row[this.field] = 'Y';
	    		mvgObj.options.optionsRight.radio.checkedRow = deepCloneObj(row);
			} else {
				row[this.field] = 'N';
			}
		}
		if(mvgObj.options.optionsRight.radio.readOnly){//判断单选按钮是否只读
			radio += ' disabled ';
		}
    	return radio_A + radio + radio_B; //拼接成完整html标签后返回
    };
    /** 添加单选按钮监听事件 */
    MvgPick.prototype.radioButtonOnClickListener = function(){
    	if(mvgObj.checkOpenRadio(mvgObj.options.optionsRight.radio)){//检查单选按钮是否被开启
    		//(是否默认型号)单选按钮点击事件
			$("input[name='radio_mvg_group_right']", mvgObj.$container_Right).click(function() {
				var radio = mvgObj.options.optionsRight.radio;
				var rows = $('.mvgPickTable',mvgObj.$container_Right).datagrid('getData').rows;
				var rowId = $(this).val();
				for(var i = 0; i < rows.length; i++){
					if(rowId == rows[i].id){
						radio.checkedRow = deepCloneObj(rows[i]);//将'被选中的行'存储在对象属性中
						break;
					}
				}
				if(radio.onClickAction){
					radio.onClickAction(radio.checkedRow);//执行单选按钮事件方法
				}
			});
    	}
    };
    /** 检查单选按钮是否被打开 */
    MvgPick.prototype.checkOpenRadio = function(radio) {
    	if(radio && radio.title && radio.field){
    		return true;
    	} else {
    		return false;
    	}
    };
    
    /** 获取父datagrid的选中行 */
    MvgPick.prototype.getParDatagridRow = function() {
    	var that = this;
    	that.refreshBaseGridOptions();
    	if(that.options.datagrid == null){
    		return {};
    	}
    	var parDatagridRow = {};
    	if(that.options.tableType == 'hdatagrid'){
    		parDatagridRow = $(that.options.datagrid).hdatagrid('getCurrentRow');
    	}
    	else if(that.options.tableType == 'datagrid'){
    		parDatagridRow = $(that.options.datagrid).datagrid('getSelected');
    	}
    	return parDatagridRow;
    };
    
    /** 批量插入操作 */
    MvgPick.prototype.onInsertActionDefault = function(rows){
    	var that = this;
		if(this.insertOptions.url == ''){
			return;
		}
		var records = [];
		var record = {};
		for(var i = 0; rows != null && i < rows.length; i++){
			record = parseParam(this.insertOptions.param, that.parDatagridRow, rows[i]);
			record['mvgMapperName'] = this.mvgMapperName;
			records.push(record);
		}
		$.ajax({
			type: "POST",
            url: this.insertOptions.url,
            data: JSON.stringify(records),
            dataType: "json",	
            contentType: 'application/json', 
            success:function(data){
            	if(data.success){
            		that.remoteDefaultId = data.defMvgStId;
				} else {
					$.messager.alert("警告",data.result);
				}
            	that.datagridLeft.datagrid('reload');
            	that.datagridRight.datagrid('reload');
			}
		});
	};
    
    /** 批量删除操作 */
    MvgPick.prototype.onDeleteActionDefault = function(rows){
    	var that = this;
		if(this.deleteOptions.url == ''){
			return;
		}
		var records = [];
		var record = {};
		for(var i = 0; rows != null && i < rows.length; i++){
			record = parseParam(this.deleteOptions.param, that.parDatagridRow, rows[i]);
			record['mvgMapperName'] = this.mvgMapperName;
			records.push(record);
		}
		$.ajax({
			type: "POST",
            url: this.deleteOptions.url,
            data: JSON.stringify(records),
            dataType: "json",	
            contentType: 'application/json', 
            success:function(data){
            	if(data.success){
            		that.remoteDefaultId = data.defMvgStId;
				} else {
					$.messager.alert("警告",data.result);
				}
            	that.datagridLeft.datagrid('reload');
            	that.datagridRight.datagrid('reload');
			}
		});
	};
    
    /** 删除全部操作 */
    MvgPick.prototype.onDeleteAllActionDefault = function(){
    	var that = this;
		if(this.deleteAllOptions.url == ''){
			return;
		}
		var record = parseParam(this.deleteAllOptions.param, that.parDatagridRow, {});
		record['mvgMapperName'] = this.mvgMapperName;
		$.post(this.deleteAllOptions.url, record,function(data){
			if(data.success){
        		that.remoteDefaultId = null;
			} else {
				$.messager.alert("警告",data.result);
			}
			that.datagridLeft.datagrid('reload');
        	that.datagridRight.datagrid('reload');
		});
	};
    
    var allowedMethods = ['resize','destroy','setValue','getValue'];
    
    
    $.fn.mvgPick = function (option) {
    	var value = null,
    	args = Array.prototype.slice.call(arguments, 1);
    	this.each(function () {
    		var $this = $(this),
                data = $this.data('mvgPick'),
                options = $.extend({}, MvgPick.DEFAULTS, $.fn.mvgPick.parseOptions(this),
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
                $this.data('mvgPick', (data = new MvgPick(this, options)));
                value = $this;
            }
        });
    	return typeof value == null ? this : value;
    };
    

    $.fn.mvgPick.parseOptions = function (target) {   
        var t = $(target);   
        return $.extend(   
                //新空对象   
                {},
                //公用的属性转换器   
                $.parser.parseOptions(target, ['id', 'width', 'height', 'left', 'top',   
                    'title', 'iconCls', 'cls', 'headerCls', 'bodyCls', 'tools', 'href','unselectedTableUrl','selectedTableUrl','completeFun',   
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
/**
 * 
 * 扩展editors的mvgPickbox方法
*/
$.extend($.fn.datagrid.defaults.editors, {
	mvgPickbox: {
        init: function(container, options){
        	var input = $('<input class="easyui-mvgPick">').appendTo(container);
            return input.mvgPick(options);
        },
        destroy: function(target){
        	$(target).mvgPick('destroy');
        },
        getValue: function(target){
        	return $(target).mvgPick('getValue');
        },
        setValue: function(target, value){
            $(target).mvgPick('setValue',value);
        },
        resize: function(target, width){
            $(target).mvgPick('resize',width);
        }
    }
});
