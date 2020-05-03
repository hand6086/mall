(function($){
	$.fn.exthdatagrid = function(options, param){
		if (typeof options == 'string'){
			var method = $.fn.exthdatagrid.methods[options];
			if (method){
				return method(this, param);
			} else {
				return this.hdatagrid(options, param);
			}
		}
		
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'exthdatagrid');
			if (state){
				$.extend(state.options, options);
			} else {
					opts = $.extend({}, $.fn.exthdatagrid.defaults, $.fn.exthdatagrid.parseOptions(this), options);
					$.data(this, "exthdatagrid", {
						options : opts
					});
			}
			exthdatagridInit(this, options);
            //$(this).data('hdatagrid', (data = new HDataGrid(this, options)));
            $(this).addClass("link-crm-hdatagrid");
            $(this).addClass("link-crm-exthdatagrid");
		});
	};
	function setOptionsParam(){
		
	}
	function row2Col(row){
		if(row.extList){
			var extList = row.extList;
			for(var j=0; j<extList.length; j++){
				row[ extList[j].name ] = extList[j].value;
			}
			delete row.extList;
		}
	}
	function col2Row(row, options){
		if(options.extFlag && options.extFieldsArry){
			var extList = [];
			for(var i=0; i<options.extFieldsArry.length; i++){
				var name = options.extFieldsArry[i].name;
				var value = row[name];
				if(value != undefined){
					var obj = {name : name, value: value};
					extList.push( obj );
					delete row[ name ];
				}
			}
			row.extList = extList;
			row.extFlag = true;
			row.extFields = options.extFields;
		}
	}
	function submit2Server(row, successFun,errFun,that, url){
		if(!url){
			return ;
		}
		$.ajax({
			url: opts.upsertUrl,
			data:JSON.stringify(row),
			dataType:"json",
			contentType: "application/json",
			method:'post',
			success: function(data){
				if(data.success){
					if(data.newRow){
						row2Col(data.newRow);
					}
					successFun(that, data);
				}else{
					errFun(data.result,that);
				}
			},
			error: function(obj, status, errorMsg){
				errFun(errorMsg,that);
			}
		});
	}
	function parseExt(rows, options){
		var columns = [];
		var extFlag = false;
		var extFieldsArry = [];
		var baseFieldsArry = [];
		var extFields = "";
		var baseFields = "";
		var stayFields = "";
		var cols_1 = [];
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if(row.active != "Y"){
				continue;
			}
			stayFields += row.name+',';
			var col = {};
			col.field = row.name;
			col.title = row.displayName;
			col.width = row.length;
			if(row.lovType){
				col.lov = row.lovType;
			}
			//扩展表字段不能查询
			if(row.extFlag == "Y"){
				//col.noSearch = true;
				extFlag = true;
				extFieldsArry.push(row);
				extFields += row.name+",";
			}else{
				baseFieldsArry.push(row);
			}
			if(row.readOnly == "N"){
				var editor = {};
				editor.type = row.type;
				editor.options = {};
				if(row.required == "Y"){
					editor.options.required = true;
				}
				if(row.lovType && row.type == "combobox"){
					editor.options.valueField = 'val';
					editor.options.textField = 'name';
					editor.options.data = getLovArray(row.lovType);
					editor.options.editable = false
				}else if(row.type == "checkbox"){
					editor.options.on = "Y";
					editor.options.off = "N";
				}else if(!row.type || row.type == "other"){
					/** picklist mvg等涉及到前端比较复杂代码的自定义列需要在页面事先写好 */
					var foundFlag = false;
					for(var j=0; j<options.columnsDefault.length; j++){
						var colDefault = options.columnsDefault[j];
						if(colDefault.field == row.name){
							editor.type = colDefault.editor.type;
							editor = $.extend(true, colDefault.editor, editor );
							foundFlag = true;
							break;
						}
					}
					if(!foundFlag){
						editor.type = "textbox";
					}
				}
				col.editor = editor;
			}
			cols_1.push(col);
		}
		if(extFlag){
			stayFields += "name,value";
		}
		columns.push(cols_1);
		
		options.columns = columns;
		options.extFlag = extFlag;
		options.extFieldsArry = extFieldsArry;
		options.baseFieldsArry = baseFieldsArry;
		options.extFields = extFields;
		options.baseFields = baseFields;
		options.stayFields = stayFields;
	}
	function exthdatagridInit(ele, options){
		$(ele).empty();
		var opts = $.data(ele, "exthdatagrid").options;
		opts.exthdatagrid={};
		opts.exthdatagrid.options = options;
		options.columnsDefault = opts.columnsDefault;
		if(!opts.modelCode){
			$.messager.alert("错误", "模块编码不能为空", "error");
			$(ele).datagrid({url:''});
			return;
		}
		$.ajax({
			async:false,
			url:getRootPath()+'/action/portal/autoCfgItem/getExtConfig',
			data:{objCode:opts.modelCode},
			dataType:'json',
			method:'post',
			success:function(data){
				if(data instanceof Array){
					parseExt(data, options);
				}else if(data instanceof Object){
					alert(data.error);
				}
			}
		});
		$(ele).hdatagrid($.extend({}, opts,{
			columns: options.columns,
			onBeforeLoad:function(param){
				param.stayFields = options.stayFields;
				param.extFlag = options.extFlag;
				param.extFields = options.extFields;
				
				var loadFlag = opts.onBeforeLoad(param);
				if(loadFlag == false){
					return false;
				}
				
				/** 扩展表字段条件查询 */
				if(param.searchParam && param.searchValue){
					for(var i=0; i<options.extFieldsArry.length; i++){
						if(options.extFieldsArry[i].name == param.searchParam){
							if(param.searchCondition == "IS NULL"){
								$.messager.alert("错误", "字段【"+options.extFieldsArry[i].displayName+"】不支持空查询", "error");
								return false;
							}
							param.extJoinFlag = true;
							param.extName = param.searchParam;
							break;
						}
					}
				}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {				
				col2Row(row, options);
				submit2Server(row, successFun,errFun,that, opts.upsertUrl);
			},
			onUpdateAction:function(row,successFun,errFun,that) {				
				col2Row(row, options);
				submit2Server(row, successFun,errFun,that, opts.updateUrl);
			},
			onInsertAction:function(row,successFun,errFun,that) {				
				col2Row(row, options);
				submit2Server(row, successFun,errFun,that, opts.insertUrl);
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				if(!opts.deleteUrl){
					return ;
				}
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post(opts.deleteUrl, {
								id : row.id,
								extFlag: options.extFlag,
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},
			loadFilter: function(data){
				if (data.rows){
					var rows = data.rows;
					for(var i=0; i<rows.length; i++){
						var row = rows[i];
						if(row.extList){
							var extList = row.extList;
							for(var j=0; j<extList.length; j++){
								row[ extList[j].name ] = extList[j].value;
							}
							delete row.extList;
						}
					}
				}
				return data;
			},
		}));
		
		//$(ele).hdatagrid("options").exthdatagrid = '';
	}
	
	$.fn.exthdatagrid.parseOptions = function(target){
		return $.extend({}, $.parser.parseOptions(target, ['buttonNew','buttonDelete','updateable','keyFilterDiv']),$.fn.datagrid.parseOptions(target));
	};
	
$.fn.exthdatagrid.defaults = $.extend({}, $.fn.hdatagrid.defaults, {
	upsertUrl:'',
	updateUrl:'',
	insertUrl:'',
	deleteUrl:'',
	modelCode: '',
	columnsDefault:[],
});

$.fn.exthdatagrid.methods = {};

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
})(jQuery)