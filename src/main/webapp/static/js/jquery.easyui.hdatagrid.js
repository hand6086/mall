/**
* hdatagrid - Hand LINK CRM GROUP
* @version v1.1.11 2017/12/07 21:56
* @Copyright 2016 LINK CRM GROUP
* @author Ashen
* 说明：	完善，改造datagrid的功能为hdatagrid；
* 		hdatagrid 继承大部分的datagrid功能。新增，改造，隐藏部分datagrid功能。
* 		
**/
(function($){
	$.fn.hdatagrid = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.hdatagrid.methods[options];
			if (method){
				return method(this, param);
			} else {
				return this.datagrid(options, param);
			}
		}
		
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'hdatagrid');
			if (state){
				$.extend(state.options, options);
			} else {
					options = $.extend({}, HDataGrid.DEFAULTS, $.fn.hdatagrid.parseOptions(this), options);
			}
            $(this).data('hdatagrid', (data = new HDataGrid(this, options)));
            $(this).addClass("link-crm-hdatagrid");
		});
	};
	
	var HDataGrid = function(el, options){
        this.options = options;
        this.el = el;
        this.initHDataGrid();
	};

    /**
     * 格式化URL请求参数
     */
	function formatRequest(data){
    	for(var filed in data){
    		if ( typeof ( data[filed]) == "object" ){
    			data[filed] = JSON.stringify(data[filed]);
    		}else if(typeof ( data[filed]) == "Array"){
    			data[filed] = JSON.stringify(data[filed]);
    		}
    	}
    	return data;
    };
    
    /*
     * 校验必填字段是否为空
     */
    function checkFstRequired(that,options){
    	var fields = that.datagrid('getColumnFields');//datagrid列集合
    	var sTitle = "";
    	var value = "notMatch";
		for(var i=0;i < fields.length;i++){
			var opts =that.datagrid('getColumnOption', fields[i]);//列属性集合
			if(!opts.editor) continue;
			if(!opts.editor.options) continue;
			var atrr = opts.editor.options.required;
			if(atrr == true){//必填字段
				var rSelected = that.hdatagrid('getCurrentRow');
				var nIndex = options.editIndex;
				var arr=that.datagrid('getEditor',{index:nIndex,field:fields[i]});
				var sType = opts.editor.type;//控件类型
				if(sType =="combobox"){
					  var value = $(arr.target).combobox('getValue');
				}
				if(sType =="textbox"){
					  var value = $(arr.target).textbox('getValue');
				}
				if(sType =="datebox"){
					  var value = $(arr.target).datebox('getValue');
				}
				if(sType =="datetimebox"){
					  var value = $(arr.target).datetimebox('getValue');
				}
				if(sType =="text"){
					  var value = $(arr.target).text('getValue');
				}
				if(sType =="validatebox"){
					  var value = $(arr.target).val();
				}
				if(sType =="picklistbox"){
					  var value = $(arr.target).picklist('getValue');
				}
				if(sType =="checkbox"){
					
				}
				if(sType =="numberbox"){
					  var value = $(arr.target).numberbox('getValue');
				}
				if(sType =="combotree"){
					  var value = $(arr.target).combotree('getValue');
				}
				if(sType =="flag"){
					
				}
			    if(value == null||value==""){
				  sTitle = opts.title;//列title
				  return sTitle;
			    }
			}
			
		}
		return sTitle;
    };
    
    /**
     * 添加filter
     * @param filters
     * @param filtersRaw
     */
    function addFilter(filters,filtersRaw) {
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
     * 判断两个对象是否相等
     * @param objA
     * @param objB
     */
    function equalsObj(objA,objB) {
    	return JSON.stringify(objA) === JSON.stringify(objB);
    }
    
    /**
     * 深度克隆对象
     * @param 被克隆的对象
	 * @return 返回一个新对象
     */
    function deepCloneObj(Object){
    	var newObject = JSON.parse(JSON.stringify(Object));
    	return newObject;
    }
    
    HDataGrid.prototype.reInitHDataGridData = function(){
    	this.options.insertOneFlag = false;		//重置新增标志 为 false
    	if(this.options.editIndex != null){
    	}
    	this.options.editIndex = null;			//重置当前编辑行Index为null
    	this.options.status = "Query";
    	this.changeToolBarStatus();
    };
    
    //内遮罩延时
    $.fn.datagrid.methods.loading=function(jq){
    	return jq.each(function(){
    		var opts=$.data(this,"datagrid").options;
    		opts.loadingDataFlag = true;
    		$(this).datagrid("getPager").pagination("loading");
    		if(opts.loadMsg){
    		var _767=$(this).datagrid("getPanel");
			setTimeout(function(){
				if(!_767.children("div.datagrid-mask").length && opts.loadingDataFlag){
    				$("<div class=\"datagrid-mask\" style=\"display:block\"></div>").appendTo(_767);
    	    		var msg=$("<div class=\"datagrid-mask-msg\" style=\"display:block;left:50%\"></div>").html(opts.loadMsg).appendTo(_767);
    	    		msg._outerHeight(40);
    	    		msg.css({marginLeft:(-msg.outerWidth()/2),lineHeight:(msg.height()+"px")});
    		
    			}
			},1000);
    		}
    		});
    };
    
  //内遮罩延时
    $.fn.datagrid.methods.loading_2=function(jq){
    	return jq.each(function(){
    		var opts=$.data(this,"datagrid").options;
    		opts.loadingDataFlag = true;
    		$(this).datagrid("getPager").pagination("loading");
    		if(opts.loadMsg){
    		var _767=$(this).datagrid("getPanel");
			if(!_767.children("div.datagrid-mask").length && opts.loadingDataFlag){
				$("<div class=\"datagrid-mask\" style=\"display:block\"></div>").appendTo(_767);
	    		var msg=$("<div class=\"datagrid-mask-msg\" style=\"display:block;left:50%\"></div>").html(opts.loadMsg).appendTo(_767);
	    		msg._outerHeight(40);
	    		msg.css({marginLeft:(-msg.outerWidth()/2),lineHeight:(msg.height()+"px")});
		
			}	
    		}
    		});
    };
    
    $.fn.datagrid.methods.loaded = function(jq){
    	return jq.each(function(){
		var opts=$.data(this,"datagrid").options;
		opts.loadingDataFlag = false;
    	$(this).datagrid("getPager").pagination("loaded");
    	var _768=$(this).datagrid("getPanel");
    	_768.children("div.datagrid-mask-msg").remove();
    	_768.children("div.datagrid-mask").remove();
    	});
    };
    HDataGrid.prototype.getAllColumns = function(){
    	var that = this;
    	var columns = $(that.el).datagrid("options").columns[0];
    	var forzenColumns = $(that.el).datagrid('options').frozenColumns[0];
    	if(forzenColumns && forzenColumns.length>0){
    		return forzenColumns.concat(columns);
    	}else{
    		return columns;
    	}
    }
    
    HDataGrid.prototype.setTip = function(message){
    	//var that = this;
    	if(!message)
    		return;
    	if($(this.el).datagrid("getRows").length){
    		return;
    	}
    	
    	var body = $(this.el).data().datagrid.dc.body2;
    	var width = body.width();
    	var left = (width - message.length * 15) /2;
		var colCount = $(this.el).data().datagrid.options.columns[0].length;
		if(!body.find('table tbody tr').find(".link-datagrid-null-tip").length){
			body.find('table tbody').append('<tr><td colspan="'+colCount+'" style="text-align: left;color:#8590a6;padding-top:10px"><h3 class="link-datagrid-null-tip" style="position:absolute;left:'+left+'px">'+message+'<h3></td></tr>');
		}else{
			body.find('table tbody').find(".link-datagrid-null-tip").text(message);
		}
    }
    HDataGrid.prototype.hdatagridEditRow = function(index, row){
    	
    	var options = $(this.el).datagrid('options');
    	if( (!index && index !=0) || !row){
    		row = $(this.el).datagrid("getSelected");
    		index = $(this.el).datagrid("getRowIndex", row);
    	}
    	if(!options.hdatagrid.options.status == "Query"){
    		return;
    	}
    	if(!options.hdatagrid.options.updateable || top.editFlag != "Y")
    		return;
    	//批量修改状态时不可双击编辑
    	if(options.hdatagrid.options.batchEditFlag === true){
    		return;
    	}
    	if(options.hdatagrid.options.readOnlyCondition(row) === true){
    		//$.messager.alert('提示','你不能修改此条数据...', 'warning');
    		return;
    	}
    	//父表为批量修改状态时不可双击编辑
    	if(options.hdatagrid.options.parentGridId){
    		var parentGridId = options.hdatagrid.options.parentGridId;
    		if($("#"+parentGridId).length>0 && $("#"+parentGridId).hasClass("datagrid-f")){
    			if($("#"+parentGridId).datagrid("options").hdatagrid.options.batchEditFlag === true){
    				return;
    			} 
    		}
    	}
    	
    	if(options.hdatagrid.options.editIndex != null){
    		//$.messager.alert('提示','还存在数据没有保存,请稍后...');
    	}else{
    		options.hdatagrid.options.editIndex = index;
			//$(this).datagrid('selectRow', options.hdatagrid.options.editIndex).datagrid('beginEdit', options.hdatagrid.options.editIndex);
			options.hdatagrid.options.status = "Edit";
    		$(this.el).datagrid('beginEdit', options.hdatagrid.options.editIndex);
			$(this.el).datagrid('getSelected').row_status = 'UPDATE';//添加了行状态为 更新 操作
			options.hdatagrid.changeToolBarStatus();
			//获取焦点
			var editor = $(this.el).datagrid('getEditor', {index:index,field:options.clickField});
			if(!editor || !editor.target){
				editor = $(this.el).datagrid('getEditor', {index:index,field:options.firstEditFieldName});
			}
			if(editor.target.css("display") == "none"){
				editor.target.next().find(".textbox-text").focus();
			}else{
				editor.target.focus();
			}
		    
    	}
    }
    HDataGrid.prototype.initHDataGrid = function(){
    	var that = this;
		var toolbarHtml = this.initToolBar();
		$(that.el).datagrid({url:''});//实例化datagrid
		
		var options_1 = $(that.el).datagrid('options');
		var datagridOpts = $.extend({},this.options,{
			toolbar:toolbarHtml,
			onBeforeLoad:function(param){
				
				
			    if((top.defaultNoQueryFlag == "Y" || that.options.defaultNoQueryFlag == true) && that.options.queryFlag != true){ //初始化后默认不查询
				    //body.find('table tbody').append('<tr><td colspan="'+1+'"width="' + body.width() + '" text-align: center;"><h1>暂无数据</h1></td></tr>');
			    	that.setTip("默认未查询数据，请根据条件进行查询");
			    	return false;
				}
				var loadFlag = that.options.onBeforeLoad(param);
				if(loadFlag === false){
					return false;
				}
				//批量修改时不查询
				if(that.options.batchEditFlag === true){
		    		//that.reInitHDataGridData();
		    		return false;
		    	}
				param.pageFlag=that.options.pagination;//设置后台是否执行分页查询
				param.totalFlag=that.options.pagination && that.options.total;//设置是否统计总记录
				param.oauthFlag=that.options.oauthFlag;//设置菜单安全性
				param.oauth = top.oauth;//设置安全性
				if(that.options.parentGridId){//存在父表
					var flag = false;
					var parentGridId = that.options.parentGridId;
					var parentGridField = that.options.parentGridField;
					var linkGridField = that.options.linkGridField;
					
					if(that.options.filterList){
						for(var i=0; i<that.options.filterList.length; i++){
							var filter = that.options.filterList[i];
							if(filter.property && filter.property == that.options.linkGridField){//存在父子关联的子表field要作为查询参数
								if(filter.value || filter.value == 0){//值也不为空
									flag = true;
									break;
								}else{
									$.messager.alert("错误", "获取父表关联字段失败, 请检查数据是否正确！", "error");
								}
							}
						}
						//异步加载时有filterList，但还没加到param里面
						if(!param.filtersRaw){
							param.filtersRaw = formatRequest({filtersRaw:that.options.filterList}).filtersRaw;
						}
					}else{
						//异步加载页面时父表已经选中数据而子表尚未加载
						var $parentGrid = $("#"+parentGridId);
						if($parentGrid.length >0 && $parentGrid.hasClass("link-crm-hdatagrid")){
							var row = $parentGrid.datagrid("getSelected");
							if(row == null || row.row_status === 'NEW'){
								//$(that.el).datagrid()
								flag = false;
								return false;
							}
							if(that.options.filterList == null){
					    		that.options.filterList = new Array();
					    	}
							var filter = {id:linkGridField,property:linkGridField,value:row[parentGridField]};
							addFilter(filter,that.options.filterList);
							flag = true;
							param.filtersRaw = formatRequest({filtersRaw:that.options.filterList}).filtersRaw;
						}
					}
					if(!flag){
						//console.log('not Load!'+"sub of "+that.options.parentGridId);
						return false;//视为父表未加载完毕，子表暂不加载数据
					}
				}
				if(options_1.filterList){
					var filtersRaw = [];
					if(that.options.filterList){
						filtersRaw = that.options.filterList.concat(options_1.filterList);
					}
					else{
						filtersRaw = filtersRaw.concat(options_1.filterList);
					}
					if(param.filtersRaw){//已有过滤参数
						filtersRaw = filtersRaw.concat( eval(param.filtersRaw) );
					}
					param.filtersRaw = formatRequest({filtersRaw:filtersRaw}).filtersRaw;
				}
				that.options.param = param;
				
			},
			onLoadError:function(){
				$.messager.alert("警告","加载数据失败，请稍后重试！");
			},
			onLoadSuccess:function(data){
				//批量修改状态时刷新工具栏
		    	if(!that.options.batchEditFlag === true){
		    		that.reInitHDataGridData();
		    		//return;
		    	}
				
				if(!data.success){
					if(data.result){
						//$.messager.alert("警告",data.result);
						detailAlert("错误", "error", data);
					}
				}
		    	var options = $(this).datagrid('options');
		    	if(data.rows.length > 0){
		    		that.mvgReadOnlyInit();
		    	}
				if(data.rows.length > 0 && that.options.selectFirstRow){
					$(this).datagrid('selectRow', 0);
					options.hdatagrid.options.onChangeSelectedItem(data.rows[0]);
				}else{
					options.hdatagrid.options.onChangeSelectedItem({});
				}
				
				if(that.options.parentGridId){//存在父表
					var parentGridId = that.options.parentGridId;
					var parentRow = $('#'+parentGridId).datagrid('getSelected');
					if( parentRow == null || parentRow.row_status === 'NEW' ){//父表选中新建行时隐藏子表按钮
						that.options.status = "Query_Only"
						that.changeToolBarStatus();
					}
					if($('#'+parentGridId).datagrid("options").hdatagrid.options.batchEditFlag === true ){
						that.options.status = "Query_Only"
						that.changeToolBarStatus();
					}
				}
				if(data.rows.length == 0 || $(this).datagrid('getSelected') == null){//父表没有数据或没选中数据时清空子表
					var subGridIds = that.options.subGridIds;
					if( subGridIds.length > 0 ){
						for(var i=0; i< subGridIds.length; i++){
							$('#'+subGridIds[i]).datagrid("loadData", {rows:[], total:0, success:true});
						}
					}
				}
				if(data.rows.length == 0){
					that.setTip("当前没有记录可显示~");
				}
				that.options.onLoadSuccess(data);
		    },
		    onClickRow:function(index,row){
		    	var jq = this;
		        var clickRow = function (that){
		        	//console.log("clickRow");
			    	var options = $(that).datagrid('options');
			    	
			    	options.hdatagrid.options.continueNewFlag = false;
			    	options.hdatagrid.options.continueCopyFlag = false;
			    	if(index != options.hdatagrid.options.editIndex && options.hdatagrid.options.editIndex != null){
			    		options.hdatagrid.saveOneRecord();
			    	}
			    	if(/*options.hdatagrid.options.batchEditFlag == true && */options.hdatagrid.options.shiftKey == true){
			    		var index_1 = index;
			    		var row = $(that).datagrid('getSelected');
			    		if(row){
			    			var index_1 = $(that).datagrid('getRowIndex', row);
			    		}
			    		//console.log("lastIndex: "+index_1);
			    		if(index_1 >index){
			    			index_2 = index_1;
			    			index_1 = index;
			    		}else{
			    			index_2 = index;
			    		}
			    		//console.log("index_1:"+index_1+"; index_2: "+index_2);
			    		if(options.hdatagrid.options.status == "Edit_Rows"){
			    			var rows = $(that).datagrid('getSelections');
			    			for(var i=0; rows && i<rows.length; i++){
			    				var indexSelected = $(that).datagrid('getRowIndex', rows[i]);
			    				if(indexSelected < index_1 || indexSelected >index_2){
			    					$(that).datagrid("unselectRow", indexSelected);
			    				}
			    			}
			    		}else{
			    			$(that).datagrid("unselectAll");
			    		}
			    		$(that).datagrid('getSelected');
			    		for(var i=index_1; i<= index_2; i++){
			    			$(that).datagrid("selectRow", i);
			    		}
			    	}
		        }
		    	if(!that.options.TimeFn){
		    		that.options.TimeFn = null;
		    	}
		    	// 取消上次延时未执行的方法
		        clearTimeout(that.options.TimeFn);
		        //执行延时
		        that.options.TimeFn =  setTimeout(function(){clickRow(jq)},300);
		        //clickRow(jq);
		        
		        if(that.options.onClickRow){
		        	that.options.onClickRow(index,row);
		        }
		    },onClickCell : function(index, field, value){
		    	//console.log("clickCell");
		    	
		    	var options = $(this).datagrid('options');
		    	options.clickField = field;
		    	
		    	if(that.options.onClickCell){
		        	that.options.onClickCell(index, field, value);
		        }
			},
		    onDblClickRow:function(index,row){
		    	clearTimeout(that.options.TimeFn);
		    	
		    	var dbClickRow = function(that){
		    		//console.log("dbclick");
		    		that.hdatagridEditRow(index, row);
		    	}
		    	//setTimeout(function(){dbClickRow(that)},300);
		    	dbClickRow(that);
		    	
		    	if(that.options.onDblClickRow){
		        	that.options.onDblClickRow(index,row);
		        }
		    },onBeforeSortColumn:function(sort,order){
		    	var options = $(this).datagrid('options');
		    	if(!(options.hdatagrid.options.editIndex == null || options.hdatagrid.options.editIndex == undefined || options.batchEditFlag == true)){
		    		$.messager.alert('警告','存在数据未保存：请保存或撤销操作后，再进行排序操作！');
		    		return false;
		    	}
		    },onBeforeEdit:function(index, row){//开始编辑请判断每列的只读性
		    	var options = $(this).datagrid('options');
		    	//var fields1 = $(this).datagrid('getColumnFields');//datagrid列集合
		    	var fields = that.getAllColumns();
		    	var firstFieldName = "";
				for(var i=0;i < fields.length;i++){
					//var opts =$(this).datagrid('getColumnOption', fields[i]);//列属性集合
					var opts = fields[i];
					var fieldName = fields[i].field;
					if(!opts.editor) continue;//只读
					if(!opts.readOnlyCol){
						if(!firstFieldName){
							//firstFieldName = fields[i];
							firstFieldName = fieldName
						}
						//开始编辑时聚焦字段
						continue;
					}
					var val = row[ fieldName ];
					if(opts.readOnlyCol(val,row, index)){
						if(!opts.editor2){
							opts.editor2 = opts.editor;//$.extend(opts.editor2, opts.editor);
						}
						opts.editor = {};
					}else{
						if(opts.editor2){
							opts.editor = opts.editor2; //$.extend(opts.editor, opts.editor2);
						}
						if(!firstFieldName){
							//firstFieldName = fields[i];
							firstFieldName = fieldName;
						}
					}
					//if(!opts.editor.options) continue;
				}
				options.firstEditFieldName = firstFieldName;
				options.batchEditingIndex = index;
		    },
		    
		    /**
			 * 切换行，或加载数据成功后，触发选中行信息
			 */
		    onSelect:function(index,row){
		    	if(!row){
		    		return;
		    	}
		    	var timeStamp = $.now();
		    	//防止双击时触发两次选中操作
		    	if(that.options.lastSelectIndex == index && that.options.lastSelectTime){
		    		if(that.options.lastSelectTime + 300 >timeStamp){
		    			return;
		    		}
		    	}
		    	that.options.lastSelectTime = timeStamp;
		    	that.options.lastSelectIndex = index;
		    	//console.log("select");
		    	that.options.onSelect(index, row);
				var options= $(that.el).datagrid('options');
				
				//本表在批量修改状态，不刷新子表
				if(that.options.status == "Edit_Rows"){
					//该行只读
					if(that.options.readOnlyCondition(row) != true ){
						$(that.el).datagrid("beginEdit", index);
					}else{
						$(that.el).datagrid("unselectRow", index);
					}
					return;
				}else if(that.options.status == "Edit_Rows_Uniform"){
					return;
				}else if(that.options.status != "Query" || that.options.shiftKey == true){
					var subGridIds = options.hdatagrid.options.subGridIds;
					if( subGridIds.length > 0 ){
						if(row.row_status === 'NEW'){
							for(var i=0; i<subGridIds.length; i++){//给子表构造查询参数
								var subGridId = subGridIds[i];
								if($('#'+subGridId).length && $('#'+subGridId).hasClass("link-crm-hdatagrid")){
									$('#'+subGridId).datagrid('loadData', {rows:[], total:0, success:true});//隐藏子表按钮
								}
							}
						}
					}
					return;
				}
				var subGridIds = options.hdatagrid.options.subGridIds;
				if( subGridIds.length > 0 ){
					/*if(row.row_status === 'NEW'){
						for(var i=0; i<subGridIds.length; i++){//给子表构造查询参数
							var subGridId = subGridIds[i];
							if($('#'+subGridId).length && $('#'+subGridId).hasClass("link-crm-hdatagrid")){
								$('#'+subGridId).datagrid('loadData', {rows:[], total:0, success:true});//隐藏子表按钮
							}
						}
					}*/
					
					for(var i=0; i<subGridIds.length; i++){//给子表构造查询参数
						var subGridId = subGridIds[i];
						if($('#'+subGridId).length && $('#'+subGridId).hasClass("link-crm-hdatagrid")){
							var options = $('#'+subGridId).datagrid('options').hdatagrid.options;
							var linkGridField = options.linkGridField;
							var parentGridField = options.parentGridField;
							if(options.filterList == null){
					    		options.filterList = new Array();
					    	}
							var filter = {id:linkGridField,property:linkGridField,value:row[parentGridField]};
							addFilter(filter,options.filterList);
						}
					}
				}
				that.options.onChangeSelectedItem(row);//使可通过onChangeSelectedItem来覆盖默认查询参数
				
				if( subGridIds.length > 0 && row.row_status !== 'NEW'){
					for(var i=0; i<subGridIds.length; i++){
						var subGridId = subGridIds[i];
						if($('#'+subGridId).length >0 && $('#'+subGridId).hasClass("link-crm-hdatagrid")){
							var options = $('#'+subGridId).datagrid('options').hdatagrid.options;
							$('#'+subGridId).datagrid('load', formatRequest({
								filtersRaw:options.filterList
							}));
						}
					}
				}
				
				if(that.options.onSelect){
		        	that.options.onSelect(index,row);
		        }
			},
			onUnselect: function(index, row){
				//本表在批量修改状态，不刷新子表
				/*if(that.options.batchEditFlag === true){
					$(that.el).datagrid("cancelEdit", index);
					return;
				}*/
				if(that.options.status === "Edit_Rows"){
					$(that.el).datagrid("cancelEdit", index);
					return;
				}
				
				if(that.options.onUnselect){
		        	that.options.onUnselect(index, row);
		        }
			},
		});
		var dataUrl = datagridOpts.url;
		datagridOpts.url = null;
		$(this.el).datagrid(datagridOpts);
		$(this.el).datagrid("options").hdatagrid=this;
		this.formatterColumn(that.getAllColumns());//修改列属性
		
		if(this.options.sortable){
			//var fields = $(this.el).datagrid('getColumnFields');
			var fieldOpts = that.getAllColumns();
			for(var i=0;i< fieldOpts.length;i++){
				//var col =$(this.el).datagrid('getColumnOption', fields[i]);
				var col = fieldOpts[i];
				var atrr = col.sortable;
				if(atrr == false || atrr == true){
				}
				else{
					  col.sortable = 'true';
				}
			}
		}
		this.bindButton();
		this.dealEventAndMethod();
		this.bindKeyEvent();
		$(this.el).datagrid("options").url = dataUrl;
		//设置初始化时的是否自动查询
		if(that.options.autoSearchParam != null && that.options.autoSearchValue != null){
			$($($(that.el).datagrid("getPanel")).find('.easyui-query-list-table')).trigger("click");//模拟点击查询
		} else {
			$(that.el).datagrid("reload");
		}
		
		if(that.options.columnMovingFlag){
			$(that.el).hdatagrid("columnMoving");
		}
	};
	HDataGrid.prototype.bindKeyEvent = function(){
        var that = this;
        that.options.keyCodeMap = {a:65, A:65, b:66, B:66, d:68, D:68, e:69, E:69, n:78, N:78, s:83, S:83, N:78, u:85, U:85, };
        
        function checkKeyCode(code){
        	for(var field in that.options.keyCodeMap){
        		if(that.options.keyCodeMap[field] == code){
        			return true;
        		}
        	}
        	return false;
        }
        $(that.el).datagrid("options").singleSelectTemp = $(that.el).datagrid("options").singleSelect;
        $(that.el).datagrid("getPanel").attr('tabindex', 1).unbind(".datagrid").bind("keydown.datagrid",function(e){
        	if(e.shiftKey == true){
        		that.options.shiftKey = true;
        		$(that.el).datagrid("options").singleSelect = false;
        	}
        	if(e.ctrlKey == true){
        		if(checkKeyCode(e.keyCode)){
        			e.preventDefault();
        			 if(window.event){
        		            window.event.keyCode = false;
        		      }
        			//return false; // 防止与浏览器快捷键冲突
        		}
        	}
        	}).bind("keyup.datagrid",function(e){
        		if(e.keyCode == 16){ //shift
        			that.options.shiftKey = false;
        			$(that.el).datagrid("options").singleSelect = $(that.el).datagrid("options").singleSelectTemp;
            	}
        		var keyCode = e.keyCode;
            	if(e.ctrlKey == true){
            		if(keyCode == 83){ // s ctrl+s 保存
            			if(that.options.status == "Edit"){
            				that.options.$buttonSave.trigger("click");
            			}else if(that.options.status == "Edit_Rows"){
            				that.options.$buttonBatchEditSave.trigger("click");
            			}
            			e.preventDefault();
            			//return false;
            		}else if(keyCode == 65){ // a
            			if(that.options.status == "Edit_Rows"){
            				that.options.$buttonBatchEditSelectAll.trigger("click");
            			}else if(that.options.status == "Edit_Rows_Uniform"){
            				that.options.$buttonBatchEditSelectAll.trigger("click");
            			}
            			e.preventDefault();
            			//return false;
            		}else if(keyCode == 66){ // b ctrl+b
            			if(that.options.status == "Query"){
            				that.options.$buttonCopy.trigger("click");
            			}
            			e.preventDefault();
            			//return false;
            		}else if(keyCode == 78){ // n  ctrl+n 无法使用

            		}else if(keyCode == 68){ // d ctrl+d 删除
            			if(that.options.status == "Query"){
            				that.options.$buttonDelete.trigger("click");
            			}
            			e.preventDefault();
            			//return false;
            		}else if(keyCode == 69){ // e ctrl+e 编辑一行
            			if(that.options.status == "Query"){
            				that.hdatagridEditRow();
            			}
            			e.preventDefault();
            		}else if(keyCode == 85){ // u ctrl+u 撤销
            			if(that.options.status == "Edit"){
            				that.options.$buttonUndo.trigger("click");
            			}else if(that.options.status == "Edit_Rows"){
            				that.options.$buttonBatchEditUndo.trigger("click");
            			}else if(that.options.status == "Edit_Rows_Uniform"){
            				that.options.$buttonBatchEditUndo.trigger("click");
            			}
            			e.preventDefault();
            			//return false;
            		}
            	}
            	if(e.altKey == true){
            		if(keyCode == 78){ // alt+n 新建
            			if(that.options.status == "Query"){
            				that.options.$buttonNew.trigger("click");
            			}
            			e.preventDefault();
            			return false;
            		}
            	}
        	}).bind("focus", function(e){
        		$(this).parent().css("border", "1px solid #469ce7");
        		$(that.el).datagrid("resize");
        		$(that.el).datagrid("resize");//picklist必须要写两句才行
        	}).bind("blur", function(e){
        		$(this).parent().css("border", "");
        		$(that.el).datagrid("resize");
        		//失去焦点后取消shift键效果
        		that.options.shiftKey = false;
    			$(that.el).datagrid("options").singleSelect = $(that.el).datagrid("options").singleSelectTemp;
        	})
	}
	HDataGrid.prototype.bindButton = function(){
		var options = this.options;
		var datagridPanel = $(this.el).datagrid("getPanel");
		options.$buttonSearch = $(datagridPanel).find('.easyui-query-list-table');//查询按钮
		options.$buttonCombineSearch = $(datagridPanel).find('.easyui-linkbutton-combine-query-list-table');//查询助手
		options.$buttonNew = $(datagridPanel).find('.easyui-linkbutton-add-list-table');//新建
		options.$buttonDelete = $(datagridPanel).find('.easyui-linkbutton-delete-list-table');//删除
		options.$buttonCopy = $(datagridPanel).find('.easyui-linkbutton-copy-list-table');//复制
		options.$buttonExport = $(datagridPanel).find('.easyui-linkbutton-export-list-table');//导出
		options.$buttonImport = $(datagridPanel).find('.easyui-linkbutton-import-list-table');//导入
		options.$buttonXmlExport = $(datagridPanel).find('.easyui-linkbutton-xml-export-list-table');//xml导出
		options.$buttonSave = $(datagridPanel).find('.easyui-linkbutton-save-list-table');//保存
		options.$buttonUndo = $(datagridPanel).find('.easyui-linkbutton-undo-list-table');//撤销
		options.$buttonContinueNew = $(datagridPanel).find('.easyui-linkbutton-continue-add-list-table');
		options.$buttonContinueCopy = $(datagridPanel).find('.easyui-linkbutton-continue-copy-list-table');//继续添加
		options.$buttonEditMulRows = $(datagridPanel).find('.easyui-hdatagrid-splitbutton-menu-editMulRows-'+options.id);//批量修改-编辑多行
		options.$buttonEditMulRowsUniform = $(datagridPanel).find('.easyui-hdatagrid-splitbutton-menu-editMulRows-uniform-'+options.id);//批量修改-统一修改
		options.$buttonBatchEditUndo = $(datagridPanel).find('.easyui-linkbutton-batchEdit-undo-list-table');//批量修改-撤销
		options.$buttonBatchEditSave = $(datagridPanel).find('.easyui-linkbutton-batchEdit-save-list-table');//批量修改-保存
		options.$buttonBatchEditSelectAll= $(datagridPanel).find('.easyui-linkbutton-batchEdit-select-all-list-table');//批量修改-全选
		options.$buttonBatchEditSelectAllUniformEdit= $(datagridPanel).find('.easyui-linkbutton-batchEdit-uniform-selected-list-table');//批量修改-统一修改（弹出框）
		options.$buttonHelp = $('.easyui-hdatagrid-splitbutton-menu-help'+options.id);//查看明细按钮 下拉菜单生成的html元素不在datagrid的Panel上
		options.$buttonCount = $('.easyui-hdatagrid-splitbutton-menu-count'+options.id);//记录计数 下拉菜单生成的html元素不在datagrid的Panel上
	}
	HDataGrid.prototype.initToolBar = function(){
		var toolbarHtml = [];
		this.options.toolbarTags = [];//初始化工具栏的html标签数组
		this.options.toolbarPullDownTags = [];//初始化工具栏中下拉菜单的html标签数组
		if(this.options.keyFilterDiv){
			var keyHtml = $("#"+this.options.keyFilterDiv);
			var html = ('<div id="table-'+this.options.keyFilterDiv+'" style="border:0px;">'
					+'<fieldset class="x-fieldset" >'
					+keyHtml.html()
					+'</fieldset>'
					+'</div>')
			toolbarHtml.push(html);
			keyHtml.replaceWith('');
		}
		if(!this.options.toolbarShow) return toolbarHtml.join('');
		toolbarHtml.push('<div style="padding-top:5px;padding-left:20px;">');
		if(this.options.buttonSearch){
			this.addToolbarTag(-30, '搜索：<input class="easyui-combobox-list-table moreToolbar_notHideFlag" style="width:100px"/>', this);
			this.addToolbarTag(-20, '<div id="textSearchBoxDiv" style="display:inline"><input style="width: 200px;height:22px" type="text" name="searchValue" class="easyui-searchbox-list-table moreToolbar_notHideFlag" /></div>', this);
			this.addToolbarTag(-20, '<div id="lovSearchBoxDiv" style="display:none"><input style="width: 200px; height:22px" id="lovSearch"  name="searchValue" class="easyui-lov-searchbox-list-table moreToolbar_notHideFlag" /></div>', this);
			this.addToolbarTag(-20, '<div id="dateSearchBoxDiv" style="display:none"><input style="width: 200px; height:22px" id="dateSearch"  name="searchValue" class="easyui-date-searchbox-list-table moreToolbar_notHideFlag" /></div>', this);
			this.addToolbarTag(-10, '<a href="###" class="easyui-query-list-table moreToolbar_notHideFlag" iconCls="icon-search" plain="true" >查询</a>', this);
		}
		if(this.options.buttonCombineSearch){
			this.addToolbarTag(10, '<a href="javascript:void(0)" class="easyui-linkbutton-combine-query-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-combine-search" plain="true" >组合查询</a>', this);
		}
		if(this.options.buttonNew && top.addFlag == "Y"){
			this.addToolbarTag(20, '<a href="javascript:void(0)" class="easyui-linkbutton-add-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-add" plain="true" title="Alt+N">新建</a>', this);
		}
		if(this.options.buttonCopy && top.addFlag == "Y"){
			this.addToolbarTag(30, '<a href="javascript:void(0)" class="easyui-linkbutton-copy-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-copy" plain="true" title="Ctrl+B">复制</a>', this);
		}
		if(this.options.buttonDelete && top.deleteFlag == "Y"){
			this.addToolbarTag(40, '<a href="javascript:void(0)" class="easyui-linkbutton-delete-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-remove" plain="true" title="Ctrl+D">删除</a>', this);
		}
		if(this.options.buttonExport && top.exportFlag == "Y"){
			this.addToolbarTag(50, '<a href="javascript:void(0)" class="easyui-linkbutton-export-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-page-excel" plain="true">导出</a>', this);
		}

		if(this.options.buttonImport && top.addFlag == "Y"){
			var str1 = '<form method="post" class="importForm" enctype="multipart/form-data" style = "display:inline-block">';
			var str2 = '<a href="javascript:void(0)" class="file easyui-linkbutton-import-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-table-add" plain="true">导入</a>';
			var str3 = '<input type="file" hidden style="width: 0px;position: absolute;right:0;top:0;opacity: 0;" class="importButton" name="importFile"/>';
			var str4 = '</form>';
			this.addToolbarTag(60, str1 + str2 + str3 + str4, this);
		}
		
		if(this.options.buttonXmlExport){
			this.addToolbarTag(70, '<a href="javascript:void(0)" class="easyui-linkbutton-xml-export-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-page-xml" plain="true">导出</a>', this);
		}
		
		if(this.options.buttonXmlImport){
			var str1 = '<form method="post" class="importXmlForm" enctype="multipart/form-data" style = "display:inline-block">';
			var str2 = '<a href="javascript:void(0)" class="file easyui-linkbutton-xml-import-list-table moreToolbar_notHideFlag standard-query-toolbar" iconCls="icon-page-xml" plain="true">导入</a>';
			var str3 = '<input type="file" hidden style="width: 0px;position: absolute;right:0;top:0;opacity: 0;" class="importXmlButton" name="importXmlFile"/>';
			var str4 = '</form>';
			this.addToolbarTag(80, str1 + str2 + str3 + str4, this);
		}
		
		this.addToolbarTag(90, '<a href="javascript:void(0)" class="easyui-linkbutton-save-list-table moreToolbar_notHideFlag standard-edit-toolbar" style="display:none" iconCls="icon-save" plain="true" title="Ctrl+S">保存</a>', this);
		this.addToolbarTag(100, '<a href="javascript:void(0)" class="easyui-linkbutton-undo-list-table moreToolbar_notHideFlag standard-edit-toolbar" style="display:none" iconCls="icon-undo" plain="true" title="Ctrl+U">撤销</a>', this);
		if(this.options.buttonNew && this.options.buttonContinueNew && top.addFlag == "Y"){
			this.addToolbarTag(101, '<a href="javascript:void(0)" class="easyui-linkbutton-continue-add-list-table moreToolbar_notHideFlag standard-edit-toolbar" style="display:none" iconCls="icon-add" plain="true" >继续添加</a>', this);
		}
		if(this.options.buttonCopy && this.options.buttonContinueCopy && top.addFlag == "Y"){
			this.addToolbarTag(102, '<a href="javascript:void(0)" class="easyui-linkbutton-continue-copy-list-table moreToolbar_notHideFlag standard-edit-toolbar" style="display:none" iconCls="icon-copy" plain="true" >保存并复制</a>', this);
		}
		
		/** 批量修改按钮 */
		if(this.options.buttonBatchEdit && top.editFlag == "Y" && this.options.updateable){
			
			this.addToolbarTag(114, '<a href="javascript:void(0)" class="easyui-linkbutton-batchEdit-select-all-list-table moreToolbar_notHideFlag batch-edit-toolbar" style="display:none" iconCls="icon-selectAll" plain="true" title="Ctrl+A">全选</a>', this);
			
			//this.addToolbarTag(117, '<a href="javascript:void(0)" class="easyui-linkbutton-batchEdit-uniform-all-list-table moreToolbar_notHideFlag batch-edit-toolbar" style="display:none" iconCls="icon-edit" plain="true" >统一值修改(全部)</a>', this);
			this.addToolbarTag(118, '<a href="javascript:void(0)" class="easyui-linkbutton-batchEdit-uniform-selected-list-table moreToolbar_notHideFlag batch-edit-toolbar" style="display:none" iconCls="icon-edit" plain="true" >统一修改(修改选中)</a>', this);

			this.addToolbarTag(119, '<a href="javascript:void(0)" class="easyui-linkbutton-batchEdit-save-list-table moreToolbar_notHideFlag batch-edit-toolbar" style="display:none" iconCls="icon-save" plain="true" title="Ctrl+S">保存</a>', this);
			this.addToolbarTag(120, '<a href="javascript:void(0)" class="easyui-linkbutton-batchEdit-undo-list-table moreToolbar_notHideFlag batch-edit-toolbar" style="display:none" iconCls="icon-undo" plain="true" title="Ctrl+U">撤销</a>', this);
		}
		
		this.trigger('onAddMoreButton',this,this.addToolbarTag);
		toolbarHtml.push(this.joinTag(this.options.toolbarTags));//加入工具栏标签
		
		/**更多信息下拉按钮 */
		if(this.options.buttonMenu){
			if(this.options.buttonBatchEdit && top.editFlag == "Y" && this.options.updateable){
				/*var str = '<div><span>批量修改</span>'
					+'<div style="width:150px;">'
					+'<div iconCls="icon-edit" class="easyui-hdatagrid-splitbutton-menu-editMulRows-'+this.options.id+'">编辑多行</div>'
					+'<div iconCls="icon-edit" class="easyui-hdatagrid-splitbutton-menu-editMulRows-uniform-'+this.options.id+'">统一修改</div>'
					+'</div></div>'
					+'<div class="menu-sep"></div>'*/
				
				this.addToolbarTag(9999, '<div iconCls="icon-edit" class="easyui-hdatagrid-splitbutton-menu-editMulRows-'+this.options.id+'">编辑多行</div>', this,true);
				this.addToolbarTag(9999, '<div iconCls="icon-edit" class="easyui-hdatagrid-splitbutton-menu-editMulRows-uniform-'+this.options.id+'">统一修改</div>', this,true);
			}
			
			
			this.addToolbarTag(9999, '<div iconCls="icon-detail" class="easyui-hdatagrid-splitbutton-menu-help'+this.options.id+'">记录明细</div>', this,true);
			
			if(this.options.menuButtonCount){
				this.addToolbarTag(9999, '<div iconCls="icon-sum" class="easyui-hdatagrid-splitbutton-menu-count'+this.options.id+'">记录计数</div>', this,true);
				
			}
			var str1= '<a href="javascript:void(0)" class="easyui-splitbutton toolbar-menu-more standard-query-toolbar" iconCls="icon-cog">更多</a>' +
			  '<div class="toolbar-pull-down-menu" >';
			var str2= '</div>';
			toolbarHtml.push(str1 + this.joinTag(this.options.toolbarPullDownTags) + str2);//加入下拉菜单标签
		}
		toolbarHtml.push('</div>');
		return toolbarHtml.join('');
	};

	HDataGrid.prototype.dealEventAndMethod = function(){
		var that = this;
		var options = this.options;
		var datagridPanel = $(that.el).datagrid("getPanel");
		//datagrid 列
		var columns = that.getAllColumns();
		//搜索功能实现
		if(options.buttonSearch){
			var searchList = [];
			var existDefaultSearch = false;
			for(var i=0;i<columns.length; i++){
				var column = columns[i];
				var columnType = column.editor && column.editor.type ? column.editor.type : "";
			/*}
			columns.forEach(function(column) {*/
				if(column.noSearch){
					//如果非搜索字段，不处理
					//return;
					continue;
				}
				if (existDefaultSearch == false && ((options.autoSearchParam == null && column.defaultSearch)
						|| (options.autoSearchParam != null && options.autoSearchParam == column.field))) {
					searchList.push({
						'id':column.field, 
						'text': column.title,
						'selected':true,
						'type':'text',
						'lov':column.lov,
						'mark':column.mark,
						'columnType' : columnType,
						'extFlag':column.extFlag
					});
					existDefaultSearch = true;
					//return;
					continue;
				}
				searchList.push({
					'id':column.field, 
					'text': column.title,
					'type':'text',
					'lov':column.lov,
					'mark':column.mark,
					'columnType' : columnType,
					'extFlag':column.extFlag
				});
			//});
			}
			if(!existDefaultSearch && searchList[0]){
				searchList[0].selected = true;
			}
			//搜索文本框，下拉框
			var searchInput = $(datagridPanel).find('.easyui-searchbox-list-table');//文本搜索输入框
			var searchInputDiv = $(datagridPanel).find("#textSearchBoxDiv");//文本搜索输入框外层div块
			var searchCombobox = $(datagridPanel).find('.easyui-combobox-list-table');//列选择框
			var searchQuery = $(datagridPanel).find('.easyui-query-list-table');//查询按钮
			var lovSearchInput = $(datagridPanel).find(".easyui-lov-searchbox-list-table");//值列表搜索输入框
			var lovSearchInputDiv = $(datagridPanel).find("#lovSearchBoxDiv");//值列表搜索输入框外层div块
			var dateSearchInput = $(datagridPanel).find(".easyui-date-searchbox-list-table");//日期搜索输入框
			var dateSearchInputDiv = $(datagridPanel).find("#dateSearchBoxDiv");//日期搜索输入框外层div块
				
			$(searchInput).combobox({
		    	prompt:'请输入或选择查询内容...',
		    	valueField: 'val',
		    	textField: 'name',
		    	groupField: 'group',
			    searcher:function(value,name){
					var searchParam = $(datagridPanel).find('.easyui-combobox-list-table').combobox('getValue');
					var searchValue = $(datagridPanel).find('.easyui-searchbox-list-table').combobox('getValue');
					
			    	$(that.el).datagrid('load',formatRequest({
						searchParam: searchParam,
						searchValue:searchValue,
						filtersRaw:options.filterList
					}));
			    },
			    inputEvents: $.extend({},$.fn.textbox.defaults.inputEvents,{
					keyup: function(event){
						 if(event.keyCode == 13){
							 $(searchQuery).trigger("click");
						 }
					}})
			});
			
			//$(searchInput).combobox('loadData', [{val:'IS NULL', name: '空值', group:'辅助查询', searchCondition: "IS NULL"}, {val: 'NOT NULL', name: '非空',group:'辅助查询', searchCondition: "NOT NULL"}]);
			
			
			$(lovSearchInput).combobox({
				prompt:'请选择查询内容...',
				valueField: 'val',
				textField: 'name', 
				groupField: 'group',
				editable:false,
				inputEvents: $.extend({},$.fn.textbox.defaults.inputEvents,{
					keydown: function(event){
						 if (event.keyCode == 8 || event.keyCode == 46) {
								$(lovSearchInput).combobox('setValue', '');
							}
						 else if(event.keyCode == 13){
							 $(searchQuery).trigger("click");
						 }
					}})
			});
			//日期选择框按钮
			var buttons = $.extend([], $.fn.datebox.defaults.buttons);
				buttons.splice(1, 1, {
					text: '空值',
					handler: function(target){
						$(target).datebox('setValue', '');
						$(target).datebox('setText', '空值');
						$(target).combo("hidePanel");
					}
				},
				{
					text: '非空',
					handler: function(target){
						$(target).datebox('setValue', '');
						$(target).datebox('setText', '非空');
						$(target).combo("hidePanel");
					}
				});
			$(dateSearchInput).datebox({
				prompt:'请选择查询日期...',
				editable:false,
				buttons: buttons,
				inputEvents: $.extend({},$.fn.textbox.defaults.inputEvents,{
					keyup: function(event){
						 if (event.keyCode == 8 || event.keyCode == 46) {
								$(dateSearchInput).datebox('setValue', '');
							}
					}})
			})
			
			$(searchCombobox).combobox({
				valueField:'id',
				textField:'text',
				data:searchList,
				onLoadSuccess:function(){
					var items = $(searchCombobox).combobox("getData");
					for(var i=0; i<items.length; i++){
						var item = items[i];
						if(item.selected){
							if(item.lov){
								$(lovSearchInputDiv).css("display", "inline");
								$(searchInputDiv).css("display", "none");
								$(dateSearchInputDiv).css("display", "none");
								$(lovSearchInput).combobox("clear");
								var comboData = deepCloneObj(getLovArray(item.lov));
								for(var i=0; comboData && i<comboData.length; i++){
									comboData[i].group = "值列表查询"
								}
								//comboData.unshift({type:item.lov, val:"*", name:"*", selected:true});
								if(!item.extFlag)
								comboData.push({type:'searchCondition', val:"IS NULL", name:"空值", group: '辅助查询'});
								comboData.push({type:'searchCondition', val:"NOT NULL", name:"非空", group: '辅助查询'});
								$(lovSearchInput).combobox("loadData", comboData);
								$(lovSearchInput).combobox('setValue', that.options.autoSearchValue);
							}else if(item.mark == "DATE"){
								$(dateSearchInputDiv).css("display", "inline");
								$(searchInputDiv).css("display", "none");
								$(lovSearchInputDiv).css("display", "none");
								$(dateSearchInput).datebox("clear");
								$(dateSearchInput).datebox('setValue', that.options.autoSearchValue);
							}else{
								var comboData = [];
								//单选框类型
								if(item.columnType == "checkbox"){
									comboData.push({val:'Y', name:'Y', searchCondition: ""});
									comboData.push({val:'N', name:'N', searchCondition: ""});
								}
								if(!item.extFlag){
									comboData.push({val:"IS NULL", name:"空值", group: '辅助查询', searchCondition : "IS NULL"});
								}
								comboData.push({val:"NOT NULL", name:"非空", group: '辅助查询', searchCondition: "NOT NULL"});
								
								$(searchInput).combobox('loadData', comboData);
								$(searchInput).combobox('setValue', that.options.autoSearchValue);
							}
							break;
						}
					}
				},
				onSelect: function(item){
					if(item.lov){
						$(lovSearchInputDiv).css("display", "inline");
						$(searchInputDiv).css("display", "none");
						$(dateSearchInputDiv).css("display", "none");
						$(lovSearchInput).combobox("clear");
						$(searchInput).combobox("clear");
						var comboData = deepCloneObj(getLovArray(item.lov));
						for(var i=0; comboData && i<comboData.length; i++){
							comboData[i].group = "值列表查询"
						}
						//扩展列不支持空查询
						if(!item.extFlag){
							comboData.push({type:'searchCondition', val:"IS NULL", name:"空值", group: '辅助查询'});
						}
						comboData.push({type:'searchCondition', val:"NOT NULL", name:"非空", group: '辅助查询'});
						$(lovSearchInput).combobox("loadData", comboData);
					}else if(item.mark == "DATE"){
						$(dateSearchInputDiv).css("display", "inline");
						$(searchInputDiv).css("display", "none");
						$(lovSearchInputDiv).css("display", "none");
						$(dateSearchInput).datebox("clear");
						$(searchInput).combobox('clear');
					}else{
						$(lovSearchInputDiv).css("display", "none");
						$(dateSearchInputDiv).css("display", "none");
						$(searchInputDiv).css("display", "inline");
						$(lovSearchInput).combobox("clear");
						$(dateSearchInput).datebox("clear");
						var comboData = [];
						//单选框类型
						if(item.columnType == "checkbox"){
							comboData.push({val:'Y', name:'Y', searchCondition: ""});
							comboData.push({val:'N', name:'N', searchCondition: ""});
						}
						if(!item.extFlag){
							comboData.push({val:"IS NULL", name:"空值", group: '辅助查询', searchCondition : "IS NULL"});
						}
						comboData.push({val:"NOT NULL", name:"非空", group: '辅助查询', searchCondition: "NOT NULL"});
						
						$(searchInput).combobox('loadData', comboData);
					}
				}
			});
			
			$(searchQuery).linkbutton({
				onClick:function(){
					options.queryFlag = true; //查询

					var searchParam = $(searchCombobox).combobox('getValue');
					var searchValue = $(searchInput).combobox('getText');
					var lovVal = $(lovSearchInput).combobox('getValue');//值列表查询条件为等于
					var dateVal = $(dateSearchInput).datebox('getText');
					var searchCondition = "";
					if(lovVal){
						var items = $(lovSearchInput).combobox('getData');
						for(var i=0; i<items.length; i++){
							var item = items[i];
							if(item.val == lovVal){
								if(item.type == 'searchCondition'){
									searchCondition = item.val;
								}else{
									searchCondition = "eq";
								}
								break;
							}
						}
						searchValue = lovVal;
					}else if(dateVal){
						searchCondition = "between";
						searchValue = dateVal;
						if(dateVal == '空值'){
							searchCondition = 'IS NULL';
						}else if(dateVal == '非空'){
							searchCondition = 'NOT NULL';
						}
					}else{
						var items = $(searchInput).combobox('getData');
						for(var i=0; i<items.length; i++){
							var item = items[i];
							if(item.name == searchValue){
								searchCondition = item.searchCondition;
								break;
							}
						}
					}
					
			    	$(that.el).datagrid('load',formatRequest({
						searchParam: searchParam,
						searchValue:searchValue,
						searchCondition: searchCondition,
						filtersRaw:options.filterList,
					}));
				}
			});
		}
		//多条件搜索按钮
		if(options.buttonCombineSearch){
			//var buttonCombineSearch = $(datagridPanel).find('.easyui-linkbutton-combine-query-list-table');
			options.$buttonCombineSearch.linkbutton({
				onClick:function(){/*
					if(!options.buttonCombineSearch){
						return;
					}
					var arrayObj = new  Array();
		    		var fieldselect = '<select name="fields" style="background-color: #fff;border-color: #ccc;color: #333;">';
					for(var i=0; i < columns.length; i++){
						fieldselect += '<option value="'+columns[i].field+'" selected>' + columns[i].title + '</option>';
					}
					fieldselect += '</select>';
					var operateselect = "<select name='operate'><option value='='>等于</option><option value='LIKE'>包含</option><option value='>'>大于</option><option value='>='>大于等于</option><option value='<'>小于</option><option value='<='>小于等于</option></select>";
		            var inputtext = "<input name='val' type='text'/>";
		            var str = '<br/><center>' +
		            		'时间条件按以下格式输入，如创建日期大于2015年1月1日<br/><br/><div style="font-size:14px;color:red;">请输入：2015-01-01</div><br/>';
		            for(var i = 0; i < 4; i++){
		            	str += '<div>' + fieldselect + operateselect + inputtext + '</div><br/>';
		            }
		            str += '</center>';
		            that.$container = $('<div class="easyui-dialog combine-search-dialog" style="width:650px;height:500px;padding:0px;overflow-y="hidden">'+
		    			'</div>');
		            $('.combine-search-dialog').dialog("destroy");
					that.$container.insertAfter(that.$el);
					var dialogObj = $(that.$container);
					dialogObj.dialog({
						title: '组合查询',
					    width: '400px',
					    height: '400px',
					    closed: false,
					    cache: false,
					    content: str,
					    modal: true,
					    buttons:[{
							text:'确定',
							iconCls:'icon-ok',
							handler:function(){
								var s = dialogObj.find("select[name=fields]");
								var params = new Array();
								var i = 0;
			        			for(var m = 0; m < s.length; m++)
			    				{
			        				var operatefiled = s[m].value;
			        				var operateid = "help" + m;
			        				var operatecompare = $(s[m]).parent().find("select[name='operate']").val();
			        				var operateval = $(s[m]).parent().find("input").val();
			        				if(operateval != ''){
			        					var param = new Object();
				        				param.id = operateid;
				        				param.property = operatefiled;
				        				param.operator = operatecompare;
				        				param.value = operateval; 
				        				params[i] = param;
				        				i++;
			        				}
			    				}
			        			$(that.el).datagrid('load',{filtersRaw:JSON.stringify(params)});
			        			dialogObj.dialog('close');
							}
						},
						{	
							text:'取消',
							iconCls:'icon-cancel',
							handler:function(){dialogObj.dialog('close');}
						}]
					});
		            dialogObj.dialog('open');
				*/
					

					//获取所有可列，构建propertyGrid弹出窗
					/** +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
					//var that = this;
					var $dialog = $('<div class="easyui-dialog propertygrid-dialog" style="width:600px;height:90%;padding:0px;overflow-y="hidden">'
							+ '<div class="pickListTableDiv" style="width:100%;height:100%">'
							+ '<table id="searchPropertyGrid"></table>'
							+ '<div id="propertyTip" style="padding:20px;"></div>'
							+'</div>'
							+ '</div>');
					
					$dialog.insertAfter(that.$el);
					var $searchPropertyGrid = $("table", $dialog);
					var $propertyTip = $("#propertyTip", $dialog);
					
					$dialog.dialog({
						title : "组合查询",
						resizable : false,
						iconCls : 'icon-combine-search',
						modal : true,
						onClose : function() {
							$dialog.dialog("destroy");
						},
						draggable : true,
						buttons : [ {
							text : '确定',
							iconCls : 'icon-ok',
							width : '100px',
							handler : function() {
								confirm();
							}
						}, {
							text : '取消',
							iconCls : 'icon-no',
							width : '100px',
							handler : function() {
								$dialog.dialog("destroy");
							}
						} ]

					});
					var editorOp = {type:'combobox',
							options:{valueField:'val',
							textField:'name',
							data : [
							        {name:'等于', val: '='}, 
							        {name:'大于', val:'>'},
							        {name:'小于', val:'<'},
							        {name:'包含', val: 'LIKE'}, 
							        {name:'空值', val:'IS NULL'}, 
							        {name:'非空', val:'NOT NULL'},
							        {name:'取消', val:'*'}
							        ],
							editable:true,
							required:false}};
					$searchPropertyGrid.datagrid({
						rownumbers: true,
						singleSelect: true,
						striped:true,		//默认行区分
						border:true,		//默认无边框
						//checkOnSelect:false,
						//selectOnCheck:true,
						columns: [[/*{
							field:"checkbox",
							title:"checkbox",
							checkbox:true,
							width:100,
						},*/
						{  
		                    field : 'name',  
		                    title : '字段',  
		                    width:150,
		                },
		                {  
		                    field : 'op',  
		                    title : '条件',  
		                    width:80,
		                    formatter : function(val, row, index){
		                    	var data = editorOp.options.data;
		                    	for(var i=0; i< data.length; i++){
		                    		if(val == data[i].val){
		                    			row.opName = data[i].name;
		                    			return data[i].name;
		                    		}
		                    	}
		                    	row.opName = val;
								return val;
							},
		                },
		                {  
		                    field : 'value',  
		                    title : '值',  
		                    width:280,
		                    formatter : function(val, row, index){
								if(row.lov){
									return getLovShowName(row.lov, val);
								}
								return val;
							},
		                },]],
		                
		                onBeforeEdit : function(index, row) {
							var row = $searchPropertyGrid.datagrid("getRows")[index];
							var colVal = $searchPropertyGrid.datagrid("getColumnOption", "value");
							var colOp = $searchPropertyGrid.datagrid("getColumnOption", "op");
							colVal.editor = row.editor;
							colOp.editor = editorOp;
						},
						onSelect:  function(index, row){
							$searchPropertyGrid.datagrid("beginEdit", index);
							//endOtherEdit(index);
							var rows = $searchPropertyGrid.datagrid("getRows");
							for(var i=0; i<rows.length; i++){
								var index_1 = $searchPropertyGrid.datagrid("getRowIndex", rows[i]);
								if(index_1 != index)
									$searchPropertyGrid.datagrid("endEdit", index_1);
							}
						},
					});
					
					var rows = [];
					var columns = that.getAllColumns();
					for(var i=0; i< columns.length; i++){
						var col = columns[i];
						var row = {};
						row.name = col.title;
						row.field = col.field;
	
						row.value = "";
						if(col.lov){
							row.lov = col.lov;
						}
						if(col.editor){
							row.editor = col.editor;
							if(col.editor2){
								row.editor = col.editor2;
							}
							if(row.editor.type == "mvgPickbox" || row.editor.type == "picklistbox" || (row.editor.type == "combobox" && !col.lov)){
								row.editor = {type:'textbox'};
							}
						}else{
							if(col.lov){
								row.lov = col.lov;
								row.editor = {type:'combobox',
										options:{valueField:'val',
										textField:'name',
										data : getLovArray(col.lov),
										editable:false,
										required:false}};
							}else{
								row.editor = {type:'textbox'};
							}
						}
						if(row.editor.options){
							row.editor.options.required = false;
							row.editor.options.validType = '';
						}
						rows.push(row);
					}
					var data_2 = {};
					data_2.total = columns.length;
					data_2.rows = rows;
					$searchPropertyGrid.datagrid("loadData", data_2 );
					
					var confirm = function(){
						var rows = $searchPropertyGrid.datagrid("getRows");
						var rows_2 = [];
						var confirmMsg = "";
						for(var i=0; i<rows.length; i++){
							var row = rows[i];
							var index_1 = $searchPropertyGrid.datagrid("getRowIndex", rows[i]);
							$searchPropertyGrid.datagrid("endEdit", index_1);
							if(row.op && row.op != '*'){
								rows_2.push({id:row.field+"1231", property: row.field, operator: row.op, value: row.value});
								if(row.lov){
									confirmMsg += row.name+ " "+row.opName +" "+ getLovShowName(row.lov, row.value) +";<br>";
								}else{
									confirmMsg += row.name+ " "+row.opName +" "+ row.value+";<br>"
								}
							}
						}
						if(rows_2.length > 0){
							
							$.messager.confirm("查询确认", "根据以下条件查询数据：<br>"+confirmMsg, function(r){
								if(r){
									$(that.el).datagrid('load',{filtersRaw:JSON.stringify(rows_2)});
									$dialog.dialog("destroy");
								}else{
									
								}
							});
						}
					};
					/** <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
				}
			});
		}
		
		//新增按钮
		if(options.buttonNew){
			options.$buttonNew.linkbutton({
				onClick:function(){
					if(!options.buttonNew){
						return ;
					}
					if(options.onBeforeAdd() === false){
						return false;
					}
					if(options.newDefaultValue){
						if(options.newDefaultUrl == '' || options.newDefaultUrl == null){
							if( !$(that.el).datagrid('options').url ){
								$.messager.alert("错误","无法获取默认数据", "error");
								return;
							}
							//拼接出默认url
							options.newDefaultUrl = that.getControllerUrl($(that.el).datagrid('options').url) + '/preDefaultValue';
						}
						$.ajax({
							async:false,
							url:options.newDefaultUrl,
							method:"post",
							success: function(data){
								if (data.success) {
									var defaultValue = data.result;
									if(!defaultValue){
										$.messager.alert('警告', '无法获取默认值，对象为空。');
									}
									var newRow = that.trigger("onInitNewData",that);
									if(newRow == null){
										newRow = {};
									}
									newRow = $.extend({id:''},newRow);
									for(var str in defaultValue){//遍历取默认值
										if(defaultValue[str]){
											newRow[str] = defaultValue[str]; 
										}
					            	}
									that.newRow(newRow);//新增操作
								}else{
									//$.messager.alert('警告', data.result);
									detailAlert("错误", "error", data);
								}
							},
							error: function(obj, status, msg){
								alert(status);
							}
						});
					} else {
						var newRow = that.trigger("onInitNewData",that);
						if(newRow == null){
							newRow = {};
						}
						newRow = $.extend({id:''},newRow);
						that.newRow(newRow);//新增操作
					}
				}
			
			});
		}
		//删除按钮
		if(options.buttonDelete){
			options.$buttonDelete.linkbutton({
				onClick:function(){
					if(!options.buttonDelete){
						return;
					}
					that.deleteOneRecord();
				}
			});
		}

		//复制按钮
		if(options.buttonCopy){
			options.$buttonCopy.linkbutton({
				onClick:function(){
					if(!options.buttonCopy){
						return;
					}
					that.copyOneRecord();
					that.options.status = 'Edit';
				}
			});
		}

		//导出按钮
		if(options.buttonExport){
			options.$buttonExport.linkbutton({
				onClick:function(){
					if(!options.buttonExport){
						return ;
					}
					if(options.onBeforeExport(options.param,that) === false){
						return ;
					}
					that.exportGridData();
				}
			});
		}

		//导入按钮
		if(options.buttonImport){
			//var buttonImport = $(datagridPanel).find('.easyui-linkbutton-import-list-table');
			options.$buttonImport.linkbutton({
				onClick:function(){
					if(!options.buttonImport){
						return ;
					}
					$(".importButton",$(datagridPanel)).trigger("click");
				}
			});
			$(".importButton",$(datagridPanel)).change(function(){
		   		that.importGridData();
			});
		}

		//XML导出按钮
		if(options.buttonXmlExport){
			options.$buttonXmlExport.linkbutton({
				onClick:function(){
					if(!options.buttonXmlExport){
						return;
					}
					that.exportDataToXml();
				}
			});
		}
		
		//XML导入按钮
		if(options.buttonXmlImport){
			options.$buttonXmlImport.linkbutton({
				onClick:function(){
					if(!options.buttonXmlImport){
						return ;
					}
					$(".importXmlButton",$(datagridPanel)).trigger("click");
				}
			});
			$(".importXmlButton",$(datagridPanel)).change(function(){
		   		that.importXmlToData();
			});
		}
		
		//保存方法
		if(true){
			//var buttonSave = $(datagridPanel).find('.easyui-linkbutton-save-list-table');
			options.$buttonSave.linkbutton({
				onClick:function(){
					that.options.continueNewFlag = false;
					that.options.continueCopyFlag = false;
					that.saveOneRecord();
				}
			});
		}
		//撤销按钮
		if(true){
			//var buttonUndo = $(datagridPanel).find('.easyui-linkbutton-undo-list-table');
			options.$buttonUndo.linkbutton({
				onClick:function(){
					that.options.continueNewFlag = false;
					that.options.continueCopyFlag = false;
					that.undoOperationH();
					that.options.status = 'Query';
				}
			});
		}
		if(options.buttonNew && options.buttonContinueNew){ //继续新建按钮
			//var buttonContinueNew = $(datagridPanel).find('.easyui-linkbutton-continue-add-list-table');
			options.$buttonContinueNew.linkbutton({
				onClick:function(){
					if(options.buttonNew && options.buttonContinueNew){
						options.continueNewFlag = true;
						that.saveOneRecord();
					}
				}
			});
		}
		if(options.buttonCopy && options.buttonContinueCopy){ //保存并复制按钮
			//var buttonContinueCopy = $(datagridPanel).find('.easyui-linkbutton-continue-copy-list-table');
			options.$buttonContinueCopy.linkbutton({
				onClick:function(){
					if(options.buttonCopy && options.buttonContinueCopy){
						options.continueCopyFlag = true;
						that.saveOneRecord();
					}
				}
			});
		}
		
		//批量修改按钮
		if(that.options.buttonBatchEdit){
			if(true){
				//手动编辑多行按钮
				//var buttonEditMulRows = $(datagridPanel).find('.easyui-hdatagrid-splitbutton-menu-editMulRows-'+this.options.id);
				options.$buttonEditMulRows.click(function(){
					//设置批量修改标记，选中行时不刷新子表，不可双击修改，父表切换时本表不刷新
					that.options.batchEditFlag = true;
					that.options.status = 'Edit_Rows';
					/**工具栏按钮切换（父子表）*/
					that.changeToolBarStatus();
					//隐藏子表按钮
					var subGridIds = that.options.subGridIds;
					if( subGridIds.length > 0 ){
						for(var i=0; i<subGridIds.length; i++){
							var subGridId = subGridIds[i];
							if($('#'+subGridId).length){
								$('#'+subGridId).datagrid("options").hdatagrid.options.status = "Query_Only"
								$('#'+subGridId).datagrid("options").hdatagrid.changeToolBarStatus();
							}
						}
					}
					/**表格变为可多选 */
					if(that.options.singleSelect){
						$(that.el).datagrid("options").singleSelect = false;
						$(that.el).datagrid("unselectAll");
					}
					//清空子表数据
				});
				
				//统一编辑多行按钮
				options.$buttonEditMulRowsUniform.click(function(){
					//设置批量修改标记，选中行时不刷新子表，不可双击修改，父表切换时本表不刷新
					that.options.batchEditFlag = true;					
					that.options.status = 'Edit_Rows_Uniform';
					/**工具栏按钮切换（父子表）*/
					that.changeToolBarStatus();
					//隐藏子表按钮
					var subGridIds = that.options.subGridIds;
					if( subGridIds.length > 0 ){
						for(var i=0; i<subGridIds.length; i++){//给子表构造查询参数
							var subGridId = subGridIds[i];
							if($('#'+subGridId).length){
								$('#'+subGridId).datagrid("options").hdatagrid.options.status = "Query_Only";
								$('#'+subGridId).datagrid("options").hdatagrid.changeToolBarStatus();//隐藏子表按钮
							}
						}
					}
					/**表格变为可多选 */
					if(that.options.singleSelect){
						$(that.el).datagrid("options").singleSelect = false;
						$(that.el).datagrid("unselectAll");
					}
					//清空子表数据
				});
			}

			//批量修改撤销按钮
			if(true){
				options.$buttonBatchEditUndo.linkbutton({
					onClick:function(){
						//清除多选
						//取消批量修改标记
						that.options.batchEditFlag = false;
						//that.options.beginEditSelectedFlag = false;
						that.options.status = 'Query';
						/** 结束编辑状态 */
						$(that.el).datagrid("rejectChanges");
						if(that.options.singleSelect){
							$(that.el).datagrid("options").singleSelect = true;
							$(that.el).datagrid("selectRow", 0);
						}
						//工具栏按钮切换（父子表）
						that.changeToolBarStatus();
						//如果父表选中行未变，不刷新数据，如果发生变化则重新加载数据
					}
				});
			}
			//批量修改-保存按钮
			if(true){
				options.$buttonBatchEditSave.linkbutton({
					onClick:function(){
						//获取修改后数据并保存
						var rows = $(that.el).datagrid("getSelections");
						if(!rows.length ){
							$.messager.alert("提示", "请选择数据", "error");
							return;
						}
						/** 非逐行编辑 */
						if(that.options.status === "Edit_Rows_Uniform"){
							//var tipStr = "";
							var finishRows = that.options.batchEditUniformRows;
							for(var i=0; i < rows.length; i++){
								var row = rows[i];
								var index = $(that.el).datagrid("getRowIndex", row);
								//该行只读
								if(that.options.readOnlyCondition(row) == true ){
									continue;
								}
								for(var j=0; j<finishRows.length; j++){
									var finishRow = finishRows[j];
									var field = finishRow.field;
									
									var opts =$(that.el).datagrid('getColumnOption', field);//列属性集合
									if(opts.readOnlyCol) {
										//该字段只读 true
										if( opts.readOnlyCol(row[field],row, index) ){
											continue;
										}
									}
									row[field] = finishRow.value;
									if(finishRow.ext_obj){
										var ext = finishRow.ext_obj;
										for(var f in ext){
											row[f] = ext[f];
										}
									}
								}
								row.row_status = "UPDATE";
							}
						}else{
							/** 逐行编辑 */
							var indexs = [];
							//校验数据
							for(var i=0; i<rows.length; i++){
								var row = rows[i];
								var index = $(that.el).datagrid("getRowIndex", row);
								if(!$(that.el).datagrid('validateRow',index)){
									$.messager.alert("警告", "数据校验不通过，请检查数据是否规范", "warning");
									return;
								}
								row.row_status = "UPDATE";
								indexs.push(index);
							}
							//结束编辑以获取修改后值
							for(var i=0; i< indexs.length; i++){
								var index = indexs[i];
								$(that.el).datagrid("endEdit", index);
								$(that.el).datagrid("beginEdit", index);
							}
						}
						//显示遮罩
						$(that.el).datagrid("loading_2");
						that.trigger("onBatchUpdateAction",rows,that.onBatchUpdateSuccess,that.onBatchUpdateFailed,that);
						
						//清除多选
						//取消批量修改标记
						//工具栏按钮切换（父子表）
						//刷新表数据
					}
				});
			}
			//批量修改全选按钮
			if(true){
				options.$buttonBatchEditSelectAll.linkbutton({
					onClick:function(){
						//选中当前页全部记录
						$(that.el).datagrid("selectAll");
						/** 逐行编辑 */
						if(that.options.status === "Edit_Rows"){
							var rows = $(that.el).datagrid("getSelections");
							for(var i=0; rows && i<rows.length; i++){
								var row = rows[i];
								//该行只读
								if(that.options.readOnlyCondition(row) == true ){
									continue;
								}
								var index = $(that.el).datagrid("getRowIndex", row);
								$(that.el).datagrid("beginEdit", index);
							}
						}else{
							
						}
					}
				});
			}
			
			//批量修改 统一值修改(选中)按钮
			if(true){
				options.$buttonBatchEditSelectAllUniformEdit.linkbutton({
					onClick:function(){
						//获取当前页所有选中数据
						var rows = $(that.el).datagrid("getSelections");
						if(!rows || !rows.length){
							$.messager.alert("错误","请选择需要修改的数据", "error");
							return ;
						}
						//获取所有可编辑列，构建propertyGrid弹出窗
						/** +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
						//var that = this;
						var $dialog = $('<div class="easyui-dialog propertygrid-dialog" style="width:600px;height:90%;padding:0px;overflow-y="hidden">'
								+ '<div class="pickListTableDiv" style="width:100%;height:100%">'
								+ '<table id="propertyGrid"></table>'
								+ '<div id="propertyTip" style="padding:20px;"></div>'
								+'</div>'
								+ '</div>');
						
						$dialog.insertAfter(that.$el);
						var $propertyGrid = $("table", $dialog);
						var $propertyTip = $("#propertyTip", $dialog);
						that.options.batchEditPropertyGrid = $propertyGrid;
						$dialog.dialog({
							title : "修改",
							resizable : false,
							iconCls : 'icon-edit',
							modal : true,
							onClose : function() {
								$dialog.dialog("destroy");
							},
							draggable : true,
							buttons : [ {
								text : '确定',
								iconCls : 'icon-ok',
								width : '100px',
								handler : function() {
									confirm();
								}
							}, {
								text : '取消',
								iconCls : 'icon-cancel',
								width : '100px',
								handler : function() {
									$dialog.dialog("destroy");
								}
							} ]

						});
						$propertyGrid.datagrid({
							rownumbers: true,
							singleSelect: true,
							checkOnSelect:false,
							selectOnCheck:false,
							columns: [[{
								field:"checkbox",
								title:"checkbox",
								checkbox:true,
								width:100,
							},
							{  
			                    field : 'name',  
			                    title : '字段',  
			                    width:200,
			                },
			                {  
			                    field : 'value',  
			                    title : '值',  
			                    width:300,
			                    formatter : function(val, row, index){
									if(row.lov){
										return getLovShowName(row.lov, val);
									}
									return val;
								},
			                },]],
			                
			                onBeforeEdit : function(index, row) {
								var row = $propertyGrid.datagrid("getRows")[index];
								var col = $propertyGrid.datagrid("getColumnOption", "value");
								col.editor = row.editor;
							},
							onClickCell : function(index, field, value){
								$propertyGrid.datagrid("checkRow", index);
								endOtherEdit($propertyGrid);
								showTip();
								if(field == "value"){
									$propertyGrid.datagrid("beginEdit", index);
								}
							},
			                onLoadSuccess: function(){
			                	/*var rows = $propertyGrid.propertygrid("getRows");
			                	for(var i=0; i<rows.length; i++){
			                		var index = $propertyGrid.propertygrid("getRowIndex", rows[i]);
			                		$propertyGrid.propertygrid("beginEdit", index);
			       
			                	}*/
			                },
			                onCancelEdit: function(index, row){
			                	row.validate = false;
			                	showTip();
			                },
			                onAfterEdit: function(index, row){
			                	row.validate = true;
			                	showTip();
			                },
			                onCheck : function(index, row){
			                	if(row.editor.type == "picklistbox" && !row.ext_obj){
			                		$propertyGrid.datagrid("options").batchEditingIndex = index;
			                		row.editor.options.completeFun({});
			                	}
			                	endOtherEdit();
			                	showTip();
			                },
			                onCheckAll: function(rows){
			                	for(var i=0; i<rows.length; i++){
			                		var row = rows[i];
			                		var index = $propertyGrid.datagrid("getRowIndex", row);
			                		if(row.editor.type == "picklistbox" && !row.ext_obj){
			                			$propertyGrid.datagrid("options").batchEditingIndex = index;
				                		row.editor.completeFun({});
				                	}
			                		endOtherEdit();
			                		showTip();
			                	}
			                },
			                onUncheck: function(index, row){
			                	endOtherEdit();
		                		showTip();
			                },
			                onUncheckAll: function(rows){
			                	endOtherEdit();
		                		showTip();
			                }
						});
						var rows = [];
						var columns = that.getAllColumns();
						for(var i=0; i< columns.length; i++){
							var col = columns[i];
							var row = {};
							row.name = col.title;
							row.field = col.field;
							row.value = "";
							if(col.editor && col.editor.type != "mvgPickbox"){
								row.editor = col.editor;
								if(col.editor2){
									row.editor = col.editor2;
								}
								if(col.lov){
									row.lov = col.lov;
								}
								row.validate = true;
								rows.push(row);
							}
						}
						var data_2 = {};
						data_2.total = columns.length;
						data_2.rows = rows;
						$propertyGrid.datagrid("loadData", data_2 );
						
						var showTip = function(){
							var rows = $propertyGrid.datagrid("getChecked");
							if(!rows || !rows.length){
								return;
							}
							var tipMsg = "";
							for(var i=0; i<rows.length; i++){
								var row = rows[i];
								var index = $propertyGrid.datagrid("getRowIndex", row);
								if(row.validate === false) {
									//$.messager.alert("错误", row.name+" 校验不通过，请检查数据！", "error");
									//return ; 
								}
								if(row.lov){
									tipMsg += row.name+" = "+ getLovShowName(row.lov, row.value) +";<br>";
								}else{
									tipMsg += row.name+" = "+ row.value + ";<br>";
								}
								
							}
							$propertyTip.html(tipMsg);
						}
						
						/** 确认修改时 进行校验 */
						var confirm = function(){
							endOtherEdit();
							var rows = $propertyGrid.datagrid("getChecked");
							if(!rows || !rows.length){
								$.messager.alert("提示", "请至少选择一个字段进行修改，或者您可以取消操作", "warning");
								return;
							}
							var confirmMsg = "";
							for(var i=0; i<rows.length; i++){
								var row = rows[i];
								var index = $propertyGrid.datagrid("getRowIndex", row);
								if(row.validate === false) {
									$.messager.alert("错误", row.name+" 校验不通过，请检查数据！", "error");
									return ; 
								}
								if(row.lov){
									confirmMsg += row.name+" = "+ getLovShowName(row.lov, row.value) +";<br>";
								}else{
									confirmMsg += row.name+" = "+ row.value + ";<br>";
								}
								
							}
							$.messager.confirm("修改确认", "把选中的行数据统一做以下修改：<br>"+confirmMsg, function(r){
								if(r){
									that.options.batchEditUniformRows = rows;
									$dialog.dialog("destroy");
									that.options.$buttonBatchEditSave.trigger("click");
								}else{
									
								}
							});
						};
						/** 结束或取消编辑其他列 */
						var endOtherEdit = function() {
							var rows = $propertyGrid.datagrid("getRows");
							for(var i=0; i<rows.length; i++){
								var index = $propertyGrid.datagrid("getRowIndex", rows[i]);
								if ($propertyGrid.datagrid("validateRow", index)) {
									$propertyGrid.datagrid("endEdit", index);
								} else {
									/** picklist删除信息后校验不通过时取消操作则页面仍然显示之前选中信息，
										但关联的值已经清空了，会造成用户误解，所以赋予空白值并结束编辑，
										但校验标记设为false表示校验不通过 ，只对必填规则有效
									*/
									if(rows[i].editor.type == "picklistbox"){
										var ed = $propertyGrid.datagrid("getEditor", {
											index : index,
											field : 'value',
										});
										ed.target.picklist("setValue", " ");
										$propertyGrid.datagrid("endEdit", index);
										rows[i].validate = false;
									}else{
										$propertyGrid.datagrid("cancelEdit", index);
									}
									
								}
							}
						}
						/** <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
					}
				});
			}
		}
		if(options.buttonMenu){
			if(options.toolbarPullDownTags.length > 0){
				$(datagridPanel).find('.toolbar-menu-more').css("display", "");
				$(datagridPanel).find('.toolbar-menu-more').splitbutton({menu:$(datagridPanel).find('.toolbar-pull-down-menu')});
			} else {
				$(datagridPanel).find('.toolbar-menu-more').css("display", "none");
			}
		}
		
		/** 动态加载子表时，判断父表是否处于编辑中 */
		if(that.options.parentGridId){//存在父表
			var parentGridId = that.options.parentGridId;
			if($('#'+parentGridId).length && $('#'+parentGridId).hasClass("datagrid-f")){
				var parentRow = $('#'+parentGridId).datagrid('getSelected');
				if( that.options.batchEditFlag === true || parentRow == null || parentRow.row_status === 'NEW' ){//父表选中新建行时隐藏子表按钮
					that.options.status = "Query_Only"
					that.changeToolBarStatus();
				}
			}
		}
		//详细信息按钮
		if(true){
			options.$buttonHelp.click(function(e){
				that.showDetail();
			});
		}
		//计数
		if(options.menuButtonCount){
			options.$buttonCount.click(function(e){
				that.count();
			});
			$(that.el).datagrid("getPanel").find(".pagination-info").on("click", ".page-query", function(e){
	        	var $this = $(this);
	        	var options = that.options;
	        	if(options.countUrl == '' || options.countUrl == null){
	    			//拼接出默认url
	    			options.countUrl = $(that.el).datagrid('options').url;
	    		}
	    		options.param.onlyCountFlag = true;
	    		$.ajax({
	    			//async:false,
	    			url:options.countUrl,
	    			method:"POST",
	    			data: options.param,
	    			dataType:"json",
	    			timeout: 5000,
	    			success: function(data){
	    				if(data.success){
	    					$this.empty();
	    					$this.after(data.rows[0].total);
	    				}
	    			},
	    			error:function(jqXHR, textStatus, errorThrown){
	    		         //alert(textStatus);
	    		    },
	    		});
	    		options.param.onlyCountFlag = false;
	        });
		}
	};
	/** 记录计数 */
	HDataGrid.prototype.count = function(){
		var that = this;
		var options = this.options;
		if(options.menuButtonCount){
			if(options.countUrl == '' || options.countUrl == null){
				//拼接出默认url
				options.countUrl = $(that.el).datagrid('options').url;
			}
			options.param.onlyCountFlag = true;
			$.ajax({
				//async:false,
				url:options.countUrl,
				method:"POST",
				data: options.param,
				dataType:"json",
				timeout: 10000,
				success: function(data){
					if(data.success){
						var countInfo = '当前记录总数: '+data.rows[0].total;
						$.messager.alert('当前记录数量',countInfo, 'info');
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
			         alert(textStatus);
			    },
			});
		} 
	};
	HDataGrid.prototype.showDetail = function(){
		var row = $(this.el).datagrid('getSelected');
		if(row){
			var ids = [];
			ids.push(row.createdBy ? row.createdBy : "noMatchId");
			ids.push(row.lastUpdatedBy? row.lastUpdatedBy : "noMatchId");
			$.ajax({
				method:'post',
				data:{ids: ids},
				dataType: 'json',
				traditional: true,
				url:getRootPath() + '/action/portal/user/queryByIds',
				timeout:3000,
				success: function(data){
					if(data.success){
						var detailStr = '记录编号: '+row.id+'<br>创建人: '+data.result[0].firstName+' #'+data.result[0].username+'<br>创建时间: '+row.created+'<br>'
						+ '最后更新人: '+data.result[1].firstName+' #'+data.result[1].username+'<br>最后更新时间: '+row.lastUpdated;
					$.messager.alert('帮助',detailStr);
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
			         alert(textStatus);
			    },
			});
		}
		else{
			$.messager.alert('警告','请选择需要查看的一行','warnning');
		}
	};
	
	/**
	 * 父子表关联时根据配置属性，在子表数据修改后刷新父表
	 * @param that
	 */
	HDataGrid.prototype.refreshParentGrid=function(that){
		if(that == null){
			that = this;
		}
		if(that.options.parentGridId != null ){
			var $parentGrid = $("#"+that.options.parentGridId)
			if(that.options.refreshParentType == "row"){
				var url = $parentGrid.datagrid("options").url;
				var row = $parentGrid.datagrid("getSelected");
				var index = $parentGrid.datagrid('getRowIndex', row);
				
				var filtersRaw = '[{"id":"id10101","property":"id","value":"'+row.id+'"}]';
				$.post(url, {filtersRaw:filtersRaw, pageFlag:false}, function(data){
					if(data.success){
						if(data.rows.length == 1){
							var newRow = data.rows[0];
							$parentGrid.datagrid('updateRow', {index: index, row:newRow});
							$parentGrid.datagrid('acceptChanges');
						}else{
							alert("Confused");
						}
					}else{
						alert(data.result);
					}
				});
			}else if(that.options.refreshParentType == "all"){
				$parentGrid.datagrid("reload");
			}
			$parentGrid.datagrid("options").hdatagrid.refreshParentGrid();
		}
	}

	/**
	 * 批量修改成功后回调函数
	 * @param that
	 * @param data
	 */
	HDataGrid.prototype.onBatchUpdateSuccess=function(that, data){
		if(that == null){
			that = this;
		}
		that.options.batchEditFlag = false;
		that.options.status = "Query";
		if(that.options.singleSelect){
			$(that.el).datagrid("options").singleSelect = true;
			$(that.el).datagrid("selectRow", 0);
		}
		$(that.el).datagrid("reload");
		//工具栏按钮切换（父子表）
		that.changeToolBarStatus();
		$(that.el).datagrid("loaded");
	}
	
	/**
	 * 批量修改失败后回调函数
	 * @param that
	 * @param data
	 */
	HDataGrid.prototype.onBatchUpdateFailed=function(that, data){
		if(that == null){
			that = this;
		}
		if(data.result || data.result === false){
			//$.messager.alert("错误", data.result, "error");
			detailAlert("错误", "error", data);
		}else{
			$.messager.alert("错误", "保存时发生错误", "error");
		}
		$(that.el).datagrid("loaded");
		//var rows = $(that.el).datagrid("getSelections");
	}
	/**
	 * 操作成功后，不显示保存，撤销按钮
	 */
	HDataGrid.prototype.onOperationSuccess=function(that, data, unChange){
		if(that == null){
			that = this;
		}
		//var that = this;
		var options = that.options;
		var newFlag = false;
		options.updatingFlag = false;
		options.insertingFlag = false;
		//判断是否刷新单条数据还是整个列表
		if( options.editIndex != null && data != null && data.success && data.newRow !=null && options.autoRefresh===false){
			var oldRow = $(that.el).datagrid('getRows')[options.editIndex];
			
			if(oldRow.row_status === 'NEW' && options.subGridIds.length){
				newFlag = true;
			}
			oldRow.row_status = "";
			$(that.el).datagrid('updateRow', {index: options.editIndex, row:data.newRow})
			$(that.el).datagrid('acceptChanges');
		}else{
			if(unChange){
				
			}else{
				$(that.el).datagrid('reload');
			}
		}
		if(that.options.continueNewFlag == true){//继续新建数据
			that.options.$buttonNew.trigger("click");
		}else if(that.options.continueCopyFlag == true){ 
			//保存并复制
			if(that.options.editIndex != null){
				$(that.el).datagrid('selectRow', that.options.editIndex);
			}
			that.options.editIndex = null;
			that.options.$buttonCopy.trigger("click");
		}else{
			
			that.options.status = "Query";
			if(newFlag){//重新触发选择事件，以刷新子表
				var row = $(that.el).datagrid('getSelected');
				var index = $(that.el).datagrid('getRowIndex', row);
				if(index ==options.editIndex ){
					$(that.el).datagrid('selectRow', index);
				}
			}
			that.reInitHDataGridData();
			that.refreshParentGrid(that);
		}
	};
	/**
	 * 操作失败后，重新变回编辑模式
	 */
	HDataGrid.prototype.onOperationFailed=function(errMsg,that){
		if(that == null){
			that = this;
		}
		var options = that.options;
		options.updatingFlag = false;
		options.insertingFlag = false;
		//window.parent.operationtip(errMsg,'error');
		$.messager.alert("操作提示", errMsg, 'error');
		that.beginEditingH();
		that.options.continueNewFlag = false;
		that.options.continueCopyFlag = false;
		that.options.status = "Edit";
	};
	/**
	 * 结束编辑
	 */
	HDataGrid.prototype.endEditingH=function(){
		var options = this.options;
		if (options.editIndex == undefined || options.editIndex == null){
			return true
		};
		if ($(this.el).datagrid('validateRow',options.editIndex)){
			$(this.el).datagrid('endEdit', options.editIndex);
			return true;
		} else {
			return false;
		}
	};
	
	/**
	 * 开始编辑
	 * @returns {Boolean}
	 */
	HDataGrid.prototype.beginEditingH=function(){
		var options = this.options;
		if (options.editIndex == undefined){
			return true
		};
		$(this.el).datagrid('beginEdit', options.editIndex);
	};
	/**
	 * 撤销插入
	 */
	HDataGrid.prototype.undoOperationH=function(){
		var options = this.options;
		//var datagridPanel = $(this.el).datagrid("getPanel");
		var index = this.options.editIndex;
		var selectFirstRowFlag = this.options.selectFirstRow;
		this.options.selectFirstRow = false;//使得重新加载后不默认选中第一条
		$(this.el).datagrid('rejectChanges');//此操作会重新加载数据并触发onLoadSuccess
		this.options.selectFirstRow = selectFirstRowFlag;
		//this.reInitHDataGridData();
		$(this.el).datagrid("selectRow", index);
		//$(this.el).datagrid('rejectChanges');
	};
	/**
	 * 删除一条数据
	 */
	HDataGrid.prototype.deleteOneRecord=function(){
		var that = this;
		var options = this.options;
		if(options.editIndex != null){
			$.messager.alert("提示","存在数据没有保存，请先保存数据!");
			return;
		}
		var deleteRow = $(this.el).datagrid('getSelected');
		var deleteRowIndex = $(this.el).datagrid('getRowIndex', deleteRow);
		
		if(deleteRow == null){
			$.messager.alert("提示","请选中要删除的数据!");
			return;
		}
		if(options.onBeforeDelete(deleteRow, that) === false){
			return false;
		}
		this.trigger("onDeleteAction",deleteRow,function(){
			$(that.el).datagrid('deleteRow', deleteRowIndex);
			$(that.el).datagrid('acceptChanges');
			if($(that.el).datagrid('getRows') && $(that.el).datagrid('getRows').length>0 && options.autoRefresh===false ){
				$(that.el).datagrid('selectRow', deleteRowIndex);
				if($(that.el).datagrid('getSelected') == null){
					$(that.el).datagrid('selectRow', deleteRowIndex-1);
				}
				var row = $(that.el).datagrid('getSelected');
				options.onChangeSelectedItem(row);
			}else{
				$(that.el).datagrid('reload');
			}
			that.refreshParentGrid(that);
		},function(errMsg){
			if(errMsg == null || '' == errMsg){
				errMsg = '删除的数据失败，请稍后重试！';
			}
			$.messager.alert('警告',errMsg);
		},that);
	};
	
	HDataGrid.prototype.copyOneRecord=function(){
		var that = this;
		var options = this.options;
		if(options.editIndex != null){
			$.messager.alert("提示","存在数据没有保存，请先保存数据!");
			return;
		}
		var selectedRow = $(this.el).datagrid('getSelected');
		var index = $(this.el).datagrid('getRowIndex',selectedRow);
		if(selectedRow == null){
			$.messager.alert("提示","请选中要复制的数据!");
			return;
		}
		if(options.onBeforeAdd(selectedRow, that) === false){
			return false;
		}
		options.insertOneFlag = true;
		options.editIndex = index + 1;
		var initCopyRow = that.trigger("onInitCopyData",that);
		var copyRow = $.extend(true,{},selectedRow,initCopyRow);
		copyRow.id = '';
		copyRow.row_status = 'NEW';//添加了行状态为 插入 操作
		copyRow.copiedId = selectedRow.id;//把被复制记录的id传给basicmodel中的copiedid
		
		if(options.newDefaultValue){
			if(options.newDefaultUrl == '' || options.newDefaultUrl == null){
				//拼接出默认url
				options.newDefaultUrl = that.getControllerUrl($(that.el).datagrid('options').url) + '/preDefaultValue';
			}			
			$.ajax({
				async:false,
				url:options.newDefaultUrl,
				method:"post",
				success: function(data){
					if (data.success) {
						var defaultValue = data.result;
						if(!defaultValue){
							$.messager.alert('警告', '无法获取默认值，对象为空。');
						}
						for(var str in defaultValue){//遍历取默认值
							if(defaultValue[str]){
								copyRow[str] = defaultValue[str]; 
							}
		            	}
						options.status = 'Edit';
						that.changeToolBarStatus();
						$(that.el).datagrid('insertRow',{index: options.editIndex, row:copyRow});
						$(that.el).datagrid('selectRow', options.editIndex).datagrid('beginEdit', options.editIndex);
						options.onChangeSelectedItem({});
					}else{
						//$.messager.alert('警告', data.result);
						detailAlert("错误", "error", data);
					}
				},
				error: function(obj, status, msg){
					alert(status);
				}
			});
			
		} else {
			options.status = 'Edit';
			that.changeToolBarStatus();
			$(that.el).datagrid('insertRow',{index: options.editIndex, row:copyRow});
			$(that.el).datagrid('selectRow', options.editIndex).datagrid('beginEdit', options.editIndex);
			options.onChangeSelectedItem({});
		}
	};
	
	HDataGrid.prototype.exportGridData=function(){
		var that = this;
		var columns = that.getAllColumns();
		
		//导出字段
		var searchList = [];
		var order = 0;
		columns.forEach(function(column) {
			if(column.lov){
				var lovArray = getLovArray(column.lov);
				var lovMap = {};
				for(var i=0; i<lovArray.length; i++){
					lovMap[ lovArray[i].val ] = lovArray[i].name;
				}
			}
			searchList.push({
				'field': column.field, 
				'title': column.title,
				'lov':column.lov,
				'lovMap':lovMap,
				'order': order++
			});
		});
		//搜索文本框，下拉框
		var datagridOptions = $(that.el).datagrid('options');
		var queryParams = $.extend({
				order:datagridOptions.sortOrder,
				sort:datagridOptions.sortName,
				exportsRaw:searchList
			},that.options.param);
		var exportDataUrl = datagridOptions.url+'/exportData';
		if(that.options.exportDataUrl){
			exportDataUrl = that.options.exportDataUrl;
		}
		//var winRef = window.open("", "_blank");//打开一个新的页面
		$.post(exportDataUrl,formatRequest(queryParams),function(data){
			if(data.success){
				window.open(data.url);
				//winRef.location = data.url;//
				if(datagridOptions.exportReload){
					$(that.el).datagrid('reload');
				}
			}else{
				$.messager.alert("导出失败",data.result);
			}
		})
	};
	HDataGrid.prototype.importGridData=function(){
		var that = this;
		var options = this.options;
		var datagridPanel = $(that.el).datagrid("getPanel");
		var datagridOptions = $(that.el).datagrid('options');
		var columns = that.getAllColumns();
		
		//导入字段
		var fieldList = [];
		var order = 0;
		var parentParams = $(that.el).hdatagrid('getParentParams');
   		var parentId = parentParams.parentid;
   		var defaultVal =  that.trigger("onInitNewData",that);
   		//！parentId兼容以前代码。。。
   		if(that.options.parentGridId && !parentId){
   			var parentRows = $("#"+that.options.parentGridId).datagrid("getSelections");
   			if(parentRows.length !=1){
   				$.messager.alert("错误", "请选择一条父级记录", "error");
   				return ;
   			}
   			parentId = parentRows[0][that.options.parentGridField];
   		}
		columns.forEach(function(column) {
			if(column.lov){
				var lovArray = getLovArray(column.lov);
				var lovMap = {};
				for(var i=0; i<lovArray.length; i++){
					lovMap[ lovArray[i].name ] = lovArray[i].val;
				}
			}
			fieldList.push({
				'field':column.field, 
				'title': column.title,
				'order':order++,
				'parentid':parentId,
				'parentField':that.options.linkGridField,
				'lov':column.lov,
				'lovMap':lovMap,
			});
		});
		
		var fileName = $(".importButton",$(datagridPanel)).val();
   		var suffix = fileName.substr(fileName.length-4);
   		if(suffix != ".csv"&&suffix != ".CSV"){
   			$.messager.alert('提示','只能导入csv格式文件！');
   			return;
   		}
   		
   		var options = {
   				url:that.getControllerUrl(datagridOptions.url)+'/importData',
   				type:'post',
   				data:formatRequest({importsRaw:fieldList, importsDefValRaw:defaultVal}),
   				dataType:'json',
   				contentType:"application/vnd.ms-excel;charset=utf-8",
   				success : function(data) {
   					//$.messager.progress('close');
   					if(data.success){
   						$.messager.alert("提示","导入数据成功！");
   						$(that.el).datagrid('reload');
   					}else{
   						if(data.result == null){
   							data.result = "导入数据失败！";
   						}
   						//$.messager.alert("警告",data.result);
   						detailAlert("错误", "error", data);
   					}
   				}
   		};
   		$('.importForm',$(datagridPanel)).ajaxSubmit(options);
	};
	
	HDataGrid.prototype.exportDataToXml=function(){
		var that = this;
		var options = this.options;
		
		//搜索文本框，下拉框
		var datagridOptions = $(that.el).datagrid('options');
		var queryParams = $.extend({
				order:datagridOptions.sortOrder,
				sort:datagridOptions.sortName
			},datagridOptions.queryParams);
		$.post(that.getControllerUrl(datagridOptions.url)+'/exportDataToXml',formatRequest(queryParams),function(data){
			if(data.success){
				window.open(data.url);
			}else{
				//$.messager.alert("导出失败",data.result);
				detailAlert("错误", "error", data);
			}
		})
	};
	
	HDataGrid.prototype.importXmlToData=function(){
		var that = this;
		var options = this.options;
		var datagridPanel = $(that.el).datagrid("getPanel");
		var datagridOptions = $(that.el).datagrid('options');		
		
		var fileName = $(".importXmlButton",$(datagridPanel)).val();
   		var suffix = fileName.substr(fileName.length-4);
   		if(suffix != ".xml"){
   			$.messager.alert('提示','只能导入xml格式文件！');
   			return;
   		}
   		var options = {
   				url:that.getControllerUrl(datagridOptions.url)+'/importXmlData',
   				type:'post',
   				//data:formatRequest({importsRaw:fieldList}),
   				dataType:'json',
   				contentType:false,
   				success : function(data) {
   					if(data.success){
   						$.messager.alert("提示","导入数据成功！");
   						$(that.el).datagrid('reload');
   					}else{
   						if(data.result == null){
   							data.result = "导入数据失败！";
   						}
   						//$.messager.alert("警告",data.result);
   						detailAlert("错误", "error", data);
   					}
   				}
   		};
   		$('.importXmlForm',$(datagridPanel)).ajaxSubmit(options);
	};
	
	HDataGrid.prototype.hideToolBarButton=function(){
		var options = this.options;
		var datagridPanel = $(this.el).datagrid("getPanel");
		
		
	}
	HDataGrid.prototype.changeToolBarStatus = function(){
		var that = this;
		var datagridPanel = $(this.el).datagrid("getPanel");
		if(that.options.status == "Query"){
			$('.standard-query-toolbar',$(datagridPanel)).css("display", "inline-block");
			$('.standard-edit-toolbar',$(datagridPanel)).css("display", "none");
			$('.batch-edit-toolbar',$(datagridPanel)).css("display", "none");
			
			$('.moreToolbar',$(datagridPanel)).css("display", "inline-block");
			$('.toolbar-menu-more', $(datagridPanel)).css("display", "inline-block");//恢复显示下拉菜单
			this.options.$buttonSearch.css("display", "");//查询按钮
		}else if(that.options.status == "Edit"){
			$('.moreToolbar',$(datagridPanel)).css("display", "none");
			$('.standard-query-toolbar',$(datagridPanel)).css("display", "none");
			$('.standard-edit-toolbar',$(datagridPanel)).css("display", "inline-block");
			$('.batch-edit-toolbar',$(datagridPanel)).css("display", "none");
			this.options.$buttonSearch.css("display", "none");//编辑时隐藏查询按钮
		}else if(that.options.status == "Edit_Rows"){//编辑多行
			$('.standard-query-toolbar',$(datagridPanel)).css("display", "none");
			$('.standard-edit-toolbar',$(datagridPanel)).css("display", "none");
			$('.batch-edit-toolbar',$(datagridPanel)).css("display", "inline-block");
			
			$('.moreToolbar',$(datagridPanel)).css("display", "none");
			//$('.easyui-linkbutton-batchEdit-uniform-selected-list-table', $(datagridPanel)).css("display", "none");
			this.options.$buttonBatchEditSelectAllUniformEdit.css("display", "none");
			this.options.$buttonSearch.css("display", "none");//编辑时隐藏查询按钮
		}else if(that.options.status == "Edit_Rows_Uniform"){
			$('.standard-query-toolbar',$(datagridPanel)).css("display", "none");
			$('.standard-edit-toolbar',$(datagridPanel)).css("display", "none");
			$('.batch-edit-toolbar',$(datagridPanel)).css("display", "inline-block");
			$('.moreToolbar',$(datagridPanel)).css("display", "none");
			
			//$(datagridPanel).find('.easyui-linkbutton-batchEdit-save-list-table').css("display", "none");//隐藏保存按钮
			this.options.$buttonBatchEditSave.css("display", "none");
			this.options.$buttonSearch.css("display", "none");//编辑时隐藏查询按钮
		}else if(that.options.status == "Query_Only"){
			/**
			 * 隐藏工具栏查询以外所有按钮
			 */
			$('.standard-query-toolbar',$(datagridPanel)).css("display", "none");
			$('.standard-edit-toolbar',$(datagridPanel)).css("display", "none");
			$('.batch-edit-toolbar',$(datagridPanel)).css("display", "none");
			
			$('.moreToolbar',$(datagridPanel)).css("display", "none");
		}
	}
	/**
	 * 保存按钮、或其他行为触发保存操作
	 */
	HDataGrid.prototype.saveOneRecord=function(){
		var options = this.options;
		if(!this.endEditingH()){
			var that = $(this.el);
			var colName = checkFstRequired(that,options);
			if(colName !=null && !colName==""){
				$.messager.alert("提示","'"+colName+"'字段校验不通过，请检查数据！");
			}
			else{
				$.messager.alert("提示","行数据校验不通过，请检查数据！");
			}
			return;
		}
		var changedRows = $(this.el).datagrid('getChanges');
		this.addChangedRows(changedRows);//修复picklistbox或mvg的编辑框的显示值修改前后没有变化，则不会触发更新的bug
		if(changedRows.length > 1){
			$.messager.alert("提示",'当前已经改变多行记录的信息，请刷新页面后再操作！');
			return;
		}
		
		var row = $(this.el).datagrid('getRows')[options.editIndex];
		
		if(!options.insertOneFlag){
			if(changedRows.length < 1){
				this.onOperationSuccess(null, null, true);
			}else{
				var changedRow = changedRows[0];
			
				if(changedRow != row){
					$.messager.alert("提示",'当前获取更新数据存在问题，请刷新页面后重试！');
					return;
				}
				if(!options.updatingFlag){
					options.updatingFlag = true;
					this.trigger("onInsertOrUpdateAction",row,this.onOperationSuccess,this.onOperationFailed,this);
					this.trigger("onUpdateAction",row,this.onOperationSuccess,this.onOperationFailed,this);
				}
				
			}
		}else{
			var changedRow = changedRows[0];
			if(changedRow != row){
				$.messager.alert("提示",'当前获取新建数据存在问题，请刷新页面后重试！');
				return;
			}
			if(!options.insertingFlag){
				options.insertingFlag = true;
				this.trigger("onInsertOrUpdateAction",row,this.onOperationSuccess,this.onOperationFailed,this);
				this.trigger("onInsertAction",row,this.onOperationSuccess,this.onOperationFailed,this);
			}
			
		}
	};
	
	/**
	 * 【新增】触发的操作
	 * @param newRow 新增时的初始行
	 */
	HDataGrid.prototype.newRow=function(newRow){
		var that = this;
		var options = that.options;
		options.insertOneFlag = true;
		options.editIndex = 0;
		options.status = 'Edit';
		that.changeToolBarStatus();
		newRow.row_status = 'NEW';//添加了行状态为 插入 操作
		$(that.el).datagrid('insertRow',{index: options.editIndex, row:newRow});
		$(that.el).datagrid('selectRow', options.editIndex).datagrid('beginEdit', options.editIndex);
		options.onChangeSelectedItem(newRow);
	};
	
	/**
	 * 根据'方法'的路径,提取controller层的路径
	 * @param url 方法路径
	 */
	HDataGrid.prototype.getControllerUrl=function(fuctionUrl){
		var urls = fuctionUrl.split('/');
		var url = '';
		for(var i = 0; i < urls.length; i++){
			if(urls[i] == 'action'){
				url = url + urls[i] + '/' + urls[i+1] + '/' + urls[i+2];
				break;
			} else {
				url = url + urls[i] + '/';
			}
		}
		return url;
	};
	
	/**
	 * 为工具栏添加html标签
	 * @param seq 序号(int)
	 * @param tag html标签(String)
	 * @param that 填 that
	 * @param isPullDown 是否放入下拉按钮(【更多】)
	 */
	HDataGrid.prototype.addToolbarTag=function(seq, tag, that, isPullDown){
		var toolbarTags = [];
		var toolbarTag = {};//标签对象,临时存放标签(tag)和位置(seq)
		if(that == null){
			that = this;
		}
		if(!seq){//如果序号没有设置，则默认为999
			seq = 999;
		}
		if(isPullDown){
			toolbarTags = that.options.toolbarPullDownTags;
			if(tag && tag.indexOf('<div')>=0){
				
			}else{
				tag = '<div>'+tag+'</div>';
			}
		} else {
			toolbarTags = that.options.toolbarTags;//工具栏的html标签数组
			if(tag != null && tag.indexOf("moreToolbar_notHideFlag") < 0 ){
				tag = '<span class="moreToolbar">' + tag + '</span>';//为外部标签加上moreToolbar类，操作标签隐藏
			}
		}
		toolbarTag['seq'] = seq;
		toolbarTag['tag'] = tag;
		toolbarTags.push(toolbarTag);
	};
	
	/**
	 * 修改列属性
	 * @param columns 表头数组
	 */
	HDataGrid.prototype.formatterColumn=function(columns){
		if(!columns){
			return;
		}
		
		var that = this;
		that.options.fields = "";
		for(var i = 0; i < columns.length; i++){
			that.options.fields += columns[i].field+",";
			if(columns[i].formatter){
				continue;
			}
			if(columns[i].currency && !columns[i].formatter){//为设置了currency属性的列添加货币符号(以formatter的方式实现)
				columns[i].align = 'right';//设置为右对齐
				switch (columns[i].currency) {
				case "CNY"://人民币
					columns[i].formatter = function(value,rowData,rowIndex){return value ? ('¥' + parseFloat(value).toLocaleString()) : value};
					break;
				case "USD"://美元
					columns[i].formatter = function(value,rowData,rowIndex){return value ? ('$' + parseFloat(value).toLocaleString()) : value};
					break;
				case "HKD"://港币
					columns[i].formatter = function(value,rowData,rowIndex){return value ? ('HK$' + parseFloat(value).toLocaleString()) : value};
					break;
				case "EUR"://欧元
					columns[i].formatter = function(value,rowData,rowIndex){return value!=null ? ('€' + parseFloat(value).toLocaleString()) : value};
					break;
				}
			}
			
			else if(columns[i].editor && columns[i].editor.type == 'checkbox' && !columns[i].formatter ){//格式化checkbox类型列
				columns[i].formatter = function(val, row, index){
					if(val == 'Y'){		return "<input type='checkbox' checked onclick='return false' />" }
					else if(val == 'N'){		return "<input type='checkbox' onclick='return false' />"}
					return val;
				};
			}
			else if(columns[i].editor && columns[i].editor.type == 'flag' && !columns[i].formatter ){
				columns[i].formatter = function(val, row, index){
					if(val == 'Y'){		return "" }
					else if(val == 'N'){		return "<div style='color:#FF0033'>*</div>"}
					return val;
				};
			}
			else if(columns[i].lov && !columns[i].formatter){
				columns[i].formatter = function(val, row, index){
					if(val){
						//console.log(this);
						return getLovShowName(this.lov, val);
					}
				}
			}
 			else if (columns[i].mvgReadOnly) {//生成mvg只读标签
				var field = columns[i].field;
				that.options.mvgOptions = {};
				that.options.mvgOptions[field] = columns[i].editor.options;
				columns[i].editor = undefined;
				columns[i].formatter = function(value, rowData, rowIndex) {
					var mvgId = 'mvgPick-formatter-'+$(that.el).attr('id')+'-' + field;
					return '<input class="'+mvgId+'" value="' + value +'"/>';
				};
			}
		}
	};
	
	/**
	 * 初始化mvg只读标签
	 */
	HDataGrid.prototype.mvgReadOnlyInit=function() {
		var that = this;
		var columns = that.getAllColumns();
		for (var i = 0; i < columns.length; i++) {
			if(columns[i].mvgReadOnly){
				var field = columns[i].field;
				var mvgOptions = that.options.mvgOptions[field];
				if(mvgOptions.readOnly == undefined){
					that.options.mvgOptions[field].readOnly = true;//设置只读
				}
				$('.mvgPick-formatter-'+$(that.el).attr('id')+'-' + field).mvgPick(that.options.mvgOptions[field]);
			}
		}
	}
	
	/**
	 * sortBy函数接受一个成员名字符串做为参数,并返回一个可以用来对包含该成员的对象数组进行排序的比较函数,
	 * 使用例子：array.sort(sortBy("field"));
	 * @param field 排序的属性名
	 */
	HDataGrid.prototype.sortBy=function(field) {
		return function(o, p) {
			var a, b;
			if (typeof o === "object" && typeof p === "object" && o && p) {
				a = o[field];
				b = p[field];
				if (a === b) {
					return 0;
				}
				if (typeof a === typeof b) {
					return a < b ? -1 : 1;
				}
				return typeof a < typeof b ? -1 : 1;
			} else {
				throw ("error");
			}
		}
	}
	
	/**
	 * 解析标签数组，将其连接转换为字符串
	 * @param toolbarTags 标签数组
	 */
	HDataGrid.prototype.joinTag=function(toolbarTags) {
		toolbarTags.sort(this.sortBy("seq"));//排序
		var tagStr = '';
		for(var i = 0; i < toolbarTags.length; i++){//遍历提取tag内容，并且拼接成字符串
			tagStr = tagStr + toolbarTags[i].tag;
		}
		return tagStr;
	};
	
	/**
	 * 返回当前页的原始记录(最后一次提交修改后的记录)
	 */
	HDataGrid.prototype.getOriginalRows=function(){
		return $(this.el).data().datagrid.originalRows;
	};
	
	/**
     * 判断datagrid中是否有'picklistbox'或'mvgPickbox'编辑框;
     */
	HDataGrid.prototype.checkExistPicklistOrMvg=function(){
    	//var fields = $(this.el).datagrid('getColumnFields');//datagrid列集合
    	var fieldOpts = this.getAllColumns();
		for(var i=0;i < fieldOpts.length;i++){
			//var opts =$(this.el).datagrid('getColumnOption', fields[i]);//列属性集合
			var opts = fieldOpts[i];
			if(!opts.editor) {
				continue;
			}
			var sType = opts.editor.type;//控件类型
			if(sType =="picklistbox" || sType =="mvgPickbox") {
				return true;
			}
		}
		return false;
    };
    
    /**
     * 将遗漏的已修改的行记录 添加到 行更新数组
     */
	HDataGrid.prototype.addChangedRows=function(changedRows){
		if(this.options.insertOneFlag){//排除插入数据的情况
			return;
		}
		var editIndex = this.options.editIndex;//编辑行的序号
		var originalRow = deepCloneObj(this.getOriginalRows()[editIndex]);//编辑行的原始数据
		var editRow = $(this.el).datagrid('getRows')[editIndex];//编辑行的当前数据
		originalRow.row_status = editRow.row_status;
		if($.inArray(editRow, changedRows) == -1 && this.checkExistPicklistOrMvg() && !equalsObj(editRow,originalRow)){
			changedRows.push(editRow);
		}
    };
	
	HDataGrid.prototype.trigger = function (name) {
        var args = Array.prototype.slice.call(arguments, 1);
        name += '.bs.hdatagrid';
        return this.options[HDataGrid.EVENTS[name]].apply(this, args);
    };
    
    HDataGrid.EVENTS = {
		'onInsertOrUpdateAction.bs.hdatagrid':'onInsertOrUpdateAction',
		'onInsertAction.bs.hdatagrid':'onInsertAction',
		'onUpdateAction.bs.hdatagrid':'onUpdateAction',
		'onDeleteAction.bs.hdatagrid':'onDeleteAction',
		'onChangeSelectedItem.bs.hdatagrid':'onChangeSelectedItem',
		'onInitNewData.bs.hdatagrid':'onInitNewData',
		'onInitCopyData.bs.hdatagrid':'onInitCopyData',
		'onAddMoreButton.bs.hdatagrid':'onAddMoreButton',
		'onBatchUpdateAction.bs.hdatagrid':'onBatchUpdateAction'
    };
	
	$.fn.hdatagrid.methods = {
		//更新当前正在编辑行的数据
		updateCurrentRow:function(target,currentRow){
			var opts = $(target).datagrid('options');
			var options = $(target).datagrid('options').hdatagrid.options;
			
			if(options.status == "Edit"){
				$.extend($(target).datagrid('getRows')[options.editIndex],currentRow);
			}else if(options.status == "Edit_Rows"){
				$.extend($(target).datagrid('getRows')[opts.batchEditingIndex],currentRow);
			}else if(options.status == "Edit_Rows_Uniform"){
				var index = options.batchEditPropertyGrid.datagrid("options").batchEditingIndex;
				var row = options.batchEditPropertyGrid.datagrid("getRows")[index];
				if(!row.ext_obj){
					row.ext_obj = {};
				}
				$.extend(row.ext_obj, currentRow);
			}
		},
		//获取当前正在编辑的数据
		getCurrentRow:function(target){
			var opts = $(target).datagrid('options');
			var options = $(target).datagrid('options').hdatagrid.options;
			
			if(options.status == "Edit"){
				return $(target).datagrid('getRows')[options.editIndex];
			}else if(options.status == "Edit_Rows"){
				return $(target).datagrid('getRows')[opts.batchEditingIndex];
			}else if(options.status == "Edit_Rows_Uniform"){
				var index = options.batchEditPropertyGrid.datagrid("options").batchEditingIndex;
				var row = options.batchEditPropertyGrid.datagrid("getRows")[index];
				if(!row.ext_obj){
					row.ext_obj = {};
				}
				return row.ext_obj;
			}else{
				return $(target).datagrid('getSelected');
			}
			
		},
		//获取当前正在编辑行Index
		getCurrentRowIndex:function(target){
			var opts = $(target).datagrid('options');
			var options = $(target).datagrid('options').hdatagrid.options;
			
			if(options.status == "Edit"){
				return options.editIndex;
			}else if(options.status == "Edit_Rows"){
				return opts.batchEditingIndex;
			}else if(options.status == "Edit_Rows_Uniform"){
				return -1;
			}else{
				var row = $(target).datagrid('getSelected');
				if(row){
					return $(target).datagrid('getRowIndex', row);
				}
				return -1;
			}
		},
		//修改父子级联关系
		changeParentItemAndParams:function(target,reloadParam){
			var options = $(target).datagrid('options').hdatagrid.options;
	    	if(options.filterList == null){
	    		options.filterList = new Array();
	    	}
			//options.filterList = new Array();			
			options.parentParams = reloadParam;
			for (var key in reloadParam){
				var filter = {id:key,property:key,value:reloadParam[key]};
		    	addFilter(filter,options.filterList);
			};
			if(options.parentGridId == null){//为了适配以前的写法（不在插件里维护父子级联关系，通过客户化代码维护级联关系）
				$(target).datagrid('load',formatRequest({
					filtersRaw:options.filterList
				}));
			}
		},
		//获取父子级联关系
		getParentParams:function(target){
			var options = $(target).datagrid('options').hdatagrid.options;
			return options.parentParams;
		},
		changeRowValue:function(target,updatedRow){
			var options = $(target).datagrid('options').hdatagrid.options;
			if(options.editIndex != null){
				$.messager.alert('提示','当前存在行正在被编辑，请稍后再进行操作！');
				return;
			}
			var rows = $(target).datagrid('getRows');
			if(rows == null || rows.length == 0){
				$.messager.alert('提示','获取当前操作列表！');
				return;
			}
			if(updatedRow == null || updatedRow.id == null || updatedRow.id == ''){
				$.messager.alert('提示','要更新行的id不能为空！');
				return;
			}
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				if(row.id == updatedRow.id){
					row = $.extend(row,updatedRow);
					//datagrid 的修改行方法
				}
			}
			
		},
		changeAndSaveRowValue: function(target,updatedRow){
			var options = $(target).datagrid('options').hdatagrid.options;
			var rows = $(target).datagrid('getRows');
			if(options.editIndex != null){
				$.messager.alert('提示','当前正在操作行信息，不能执行该操作！');
				return;
			}
			if(rows == null || rows.length == 0){
				$.messager.alert('提示','获取当前操作列表！');
				return;
			}
			if(updatedRow == null || updatedRow.id == null || updatedRow.id == ''){
				$.messager.alert('提示','要更新行的id不能为空！');
				return;
			}
			var matched = false;
			for(var i=0;i<rows.length;i++){
				var row = rows[i];
				if(row.id == updatedRow.id){
					matched = true;
					row = $.extend(row,updatedRow,{row_status:'UPDATE'});
					$(target).datagrid("options").hdatagrid.trigger("onInsertOrUpdateAction",row,function(that,data){
						if(that == null){
							that = this;
						}
						var options = that.options;
						//判断是否刷新单条数据还是整个列表
						if( data != null && data.success && data.newRow !=null && options.autoRefresh===false){
							var rows = $(that.el).datagrid('getRows');
							var updateIndex = null;
							for(var j=0;rows != null && j<rows.length ;j++){
								if(rows[j].id == data.newRow.id){
									$(that.el).datagrid('updateRow', {index:j, row:data.newRow})
									$(that.el).datagrid('acceptChanges');
								}
							}
						}else{
							$(that.el).datagrid('reload');
						}
						
					},function(msg,that){
						$.messager.alert('提示','要更新行的id不能为空！');
					},$(target).datagrid("options").hdatagrid);
					$(target).datagrid("options").hdatagrid.trigger("onUpdateAction",function(that,data){
						if(that == null){
							that = this;
						}
						var options = that.options;
						//判断是否刷新单条数据还是整个列表
						if( data != null && data.success && data.newRow !=null && options.autoRefresh===false){
							var rows = $(that.el).datagrid('getRows');
							var updateIndex = null;
							for(var j=0;rows != null && j<rows.length ;j++){
								if(rows[j].id == data.newRow.id){
									$(that.el).datagrid('updateRow', {index:j, row:data.newRow})
									$(that.el).datagrid('acceptChanges');
								}
							}
						}else{
							$(that.el).datagrid('reload');
						}
						
					},function(msg,that){
						$.messager.alert('提示','要更新行的id不能为空！');
					},$(target).datagrid("options").hdatagrid);
				}
			}
			if(!matched){
				$.messager.alert('提示','未匹配到任何要操作的行信息，操作失败！');
				return;
			}
			
		},
		
		rejectChanges : function(target){
			var row = $datagrid.hdatagrid('getSelected');
			var index = $datagrid.hdatagrid('getRowIndex', row);

			var selectFirstRowFlag = this.options.selectFirstRow;
			this.options.selectFirstRow = false;//使得重新加载后不默认选中第一条
			$(this.el).datagrid('rejectChanges');//此操作会重新加载数据并触发onLoadSuccess
			this.options.selectFirstRow = selectFirstRowFlag;
			$(this.el).datagrid("selectRow", index);
		}
	};
	
	HDataGrid.DEFAULTS = $.extend({}, {
		
		/**
		 * 批量修改事件
		 */
		onBatchUpdateAction: function(rows, successFun,errFun, that){
			
		},
		
		/**
		 * 新增界面功能
		 */
		onAddMoreButton:function(that,addButtonFun){
			
		},
		/**
		 * 新增或修改数据后，触发保存事件
		 */
		onInsertOrUpdateAction:function(row,successFun,errFun,that){
			
		},
		/**
		 * 初始化新建的数据
		 */
		onInitNewData:function(that){
			return {};
		},
		onInitCopyData:function(that){
			return {};
		},
		/*onGetMoreFilters:function(){
			return [];
		},*/
		/**
		 * 新增数据后,触发保存事件
		 */
		onInsertAction:function(row,successFun,errFun,that){
			
		},
		/**
		 * 更新数据够，触发保存事件
		 */
		onUpdateAction:function(row,successFun,errFun,that){
		
		},
		/**
		 * 删除按钮后，触发删除事件
		 */
		onDeleteAction:function(row,successFun,errFun,that){
			
		},
		/**
		 * 切换行，或加载数据成功后，触发选中行信息
		 */
		onChangeSelectedItem:function(row,that){
			
		},
		/**
		 * 选择数据后，触发事件
		 */
		onSelect:function(index, row){
			
		},
		/**
		 * 加载数据成功后，触发事件
		 */
		onLoadSuccess:function(data){
			
		},
		/**
		 * 加载数据前，触发事件
		 */
		onBeforeLoad:function(param){
		},
		/**
		 * 编辑一行前判断当前行是否可进行编辑
		 */
		readOnlyCondition: function(row, that){
			return false;
		},
		/**
		 * 添加一行前判断可否进行添加，返回false则不添加
		 */
		onBeforeAdd: function(row, that){
			return true;
		},
		/**
		 * 删除一行前判断是否可删除，返回false则不删除
		 */
		onBeforeDelete: function(row, that){
			return true;
		},
		/**
		 * 导出前触发的事件，返回false则不导出
		 */
		onBeforeExport: function(param, that){
			return true;
		},
		updateable:false,	//默认是否可以更新行操作：false；
		striped:true,		//默认行区分
		border:false,		//默认无边框
		singleSelect:true,	//默认单选
	    pageSize: 25,//每页显示的记录条数，默认为20 
	    pageList: [25,50,100],//可以设置每页记录条数的列表 
		rownumbers:true,	//默认显示行号
		pagination:true,	//默认分页功能
		total:false,		//默认不统计总记录
		toolbarShow:false,	//显示工具栏
		buttonSearch:false,	//搜索框功能
		buttonCombineSearch:false,	//组合查询功能
		buttonNew:false,	//显示新建按钮
		buttonDelete:false,	//显示删除按钮
		buttonCopy:false,	//复制功能
		buttonExport:false,	//导出功能
		buttonImport:false,	//导入功能
		buttonXmlImport:false,//XML导入
		buttonXmlExport:false,//XML导出
		buttonSubmit:false,	//显示提交按钮
		buttonCancel:false,	//显示取消按钮
		buttonContinueNew:true,//编辑状态下显示继续添加按钮
		buttonContinueCopy:true,//编辑状态下显示继续添加按钮
		buttonMenu:true, //显示菜单，若为true，则默认显示查看记录详细信息菜单项
		menuButtonCount:true,//下拉菜单记录计数按钮
		buttonBatchEdit:false,
		countUrl:'',//记录计数url
		newDefaultValue:false, //关闭新增时的默认值
		newDefaultUrl:'',	//新增时的默认值取值来源url,默认为'*/preDefaultValue'
		sortable:true,      //默认全局排序
		keyFilterDiv:null,	//keyFilter
		parentParams:{},	//默认父对象参数为空
		//filterList:[],		//默认的filterList 为空
		selectFirstRow:true,		//默认加载成功后选中首行
		insertOneFlag:false,		//默认新增标志 为 false
	    editIndex:null,				//默认当前编辑行Index为null
	    oauthFlag:true,			//菜单安全性
		//sortName:'created',			//默认列表用创建时间排序
		//sortOrder:'desc',			//默认排列顺序为倒序
	    autoRefresh:false,			//默认不自动刷新
	    parentGridId: null,	//当前表的父表id
	    parentGridField:null, //当前表关联的父表字段名称
	    linkGridField:null, //当前表与父表关联的的字段名称
	    subGridIds : [], //当前表的子表的id，字符串列表
	    exportReload:false, //默认导出后不重新加载
	    refreshParentType:null,
	    autoSearchParam:null,//初始化表格后默认自动查询-条件
		autoSearchValue:null,//初始化表格后默认自动查询-内容
		columnMovingFlag: true, //列是否可拖动调整显示顺序
		defaultNoQueryFlag : false, //列表初始化后是否马上查询
	});
	$.fn.hdatagrid.defaults = HDataGrid.DEFAULTS;
	$.fn.hdatagrid.parseOptions = function(target){
		return $.extend({}, $.parser.parseOptions(target, ['buttonNew','buttonDelete','updateable','keyFilterDiv']),$.fn.datagrid.parseOptions(target));
	};
	
	function getRootPath(){
		if(typeof(appCtx) != 'undefined' && appCtx && appCtx.ctxPath != undefined){
			return appCtx.ctxPath;
		}
		var pathname = window.location.pathname;
		var pathArray = pathname.split("/");
		if(pathArray.length < 2 || pathArray[1] == '' || pathArray[1] == 'action' || pathArray[1] == 'portal'){
			return '';
		}
		return '/' + pathArray[1];
	};
})(jQuery);
