function datagridPickListFormatter(val, row, rowIndex, func)
{
	var str = '<span class="textbox searchbox" style="width: 139px; height: 20px;">' +
					'<span class="textbox-addon textbox-addon-right" style="right: 0px;">' +
					'<a onclick="' + func + '(' + rowIndex + ')" class="textbox-icon searchbox-button" tabindex="-1" icon-index="0" href="javascript:void(0)" style="width: 18px; height: 20px;"></a>' +
				'</span>' +
				'<input  class="textbox-text" readonly type="text" style="margin-left: 0px; margin-right: 18px; padding-top: 2px; padding-bottom: 2px; width: 113px;" value="'+ (val==null?'':val) +'"></input>' +
				'</span>';
	return str;
}
/*
function datagridPickListFormatter(val, row, rowIndex, func)
{
    var str = '<span class="textbox searchbox" style="width: 139px; height: 20px;">' +
        '<span class="textbox-addon textbox-addon-right" style="right: 0px;">' +
        '<a onclick="' + func + '(' + rowIndex + ')" class="textbox-icon searchbox-button" tabindex="-1" icon-index="0" href="javascript:void(0)" style="width: 18px; height: 20px;"></a>' +
        '</span>' +
        '<input onfocus="' + func + '(' + rowIndex + ')" class="textbox-text" type="text" style="margin-left: 0px; margin-right: 18px; padding-top: 2px; padding-bottom: 2px; width: 113px;" value="'+ (val==null?'':val) +'"></input>' +
        '</span>';
    return str;
}
*/

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

$.extend($.fn.datagrid.methods, {
	editCell: function(jq,param){
		return jq.each(function(){
			var opts = $(this).datagrid('options');
			var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (fields[i] != param.field){
					col.editor = null;
				}
			}
			var bge = $(this).datagrid('beginEdit', param.index);
			var ed = bge.datagrid('getEditor', {index:param.index,field:param.field});
			if(ed!=null){
				$(ed.target).focus();
			}
			
			for(var i=0; i<fields.length; i++){
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
			
			
		
		});
	},
	searchHelp: function(jq,param){
		return jq.each(function(){
			var that = $(this);
			var opts = $(this).datagrid('options');
			var columns = opts.columns[0];
			
			var arrayObj = new  Array();
    		var fieldselect = '<select name="fields" style="background-color: #fff;border-color: #ccc;color: #333;">';
			for(var i=0; i < columns.length; i++){
				fieldselect += '<option value="'+columns[i].field+'" selected>' + columns[i].title + '</option>';
			}
			fieldselect += '</select>';
			var operateselect = "<select name='operate'><option value='='>等于</option><option value='>'>大于</option><option value='>='>大于等于</option><option value='<'>小于</option><option value='<='>小于等于</option></select>";
            var inputtext = "<input name='val' type='text'/>";
            var str = '<br/><center>'
            for(var i = 0; i < 4; i++){
            	str += '<div>' + fieldselect + operateselect + inputtext + '</div><br/>';
            }
            str += '</center>';
            var dialogObj = window.parent.$('#exportdataid');
            dialogObj.dialog({
				title: '数据导出',
			    width: 400,
			    height: 260,
			    closed: false,
			    cache: false,
			    content: str,
			    modal: true,
			    buttons:[{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						var s = $(dialogObj).find("select[name=fields]");
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
	        			that.datagrid('load',{filtersRaw:JSON.stringify(params)});
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
		});
	},
	importData: function(jq,jps){
		return jq.each(function(){
			var that = $(this);
			var opts = $(this).datagrid('options');
			var columns = opts.columns[0];
			
			var importColumns = new Array();//构建导出对象
			var arrayObj = new  Array();//构建查询对象
			for(var i=0; i < columns.length; i++){
				//构建导出对象 start
				var importColumn = new Object();
				importColumn.title = columns[i].title;
				importColumn.field = columns[i].field;
				importColumn.order = i;
				importColumns[i] = importColumn;
			}
			window.parent.operationprogress('进度提示','正在导入...');
			$('#importsRaw').val(JSON.stringify(importColumns));
		   	var options = {
	   			url:jps.url,
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/vnd.ms-excel;charset=utf-8",
	   			success : function(data) {
	   				window.parent.$.messager.progress('close');
	   				if(data.success == "error"){
	   					window.parent.operationtip("csv文件的头字段不正确！", 'error');
	   				}
	   				else if(data.success){
	   					if(data.message != null){
	   						window.parent.operationtip(data.message, data.success);
	   					}else{
	   						window.parent.operationtip("导入成功！", data.success);
	   					}
	   				}
	   				that.datagrid('reload');
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
	},
	exportData: function(jq,jps){
		return jq.each(function(){
			var that = $(this);
			var opts = $(this).datagrid('options');
			var columns = opts.columns[0];
			
			var exportColumns = new Array();//构建导出对象
			var arrayObj = new  Array();//构建查询对象
    		var fieldselect = '<select name="fields" style="background-color: #fff;border-color: #ccc;color: #333;">';
			for(var i=0; i < columns.length; i++){
				//构建导出对象 start
				var exportColumn = new Object();
				exportColumn.title = columns[i].title;
				exportColumn.field = columns[i].field;
				exportColumn.order = i;
				exportColumns[i] = exportColumn;
				//构建导出对象 end
				fieldselect += '<option value="'+columns[i].field+'" selected>' + columns[i].title + '</option>';
			}
			fieldselect += '</select>';
			var operateselect = "<select name='operate'><option value='='>等于</option><option value='>'>大于</option><option value='>='>大于等于</option><option value='<'>小于</option><option value='<='>小于等于</option></select>";
            var inputtext = "<input name='val' type='text'/>";
            var str = '<br/><center>'
            for(var i = 0; i < 4; i++){
            	str += '<div>' + fieldselect + operateselect + inputtext + '</div><br/>';
            }
            str += '</center>';
            var dialogObj = window.parent.$('#exportdataid');
            dialogObj.dialog({
				title: '数据导出',
			    width: 400,
			    height: 260,
			    closed: false,
			    cache: false,
			    content: str,
			    modal: true,
			    buttons:[{
					text:'确定',
					iconCls:'icon-ok',
					handler:function(){
						var s = $(dialogObj).find("select[name=fields]");
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
	        			$.post(jps.url, 
    					{
	        				filtersRaw:JSON.stringify(params),
	        				exportsRaw:JSON.stringify(exportColumns)
    				    },
    					function(data){
    				    	if(!data.success){
    							window.parent.operationtip(data.result, 'error');
    						}else{
    				        	window.location.href = data.url;
    						}
    				    	
    					});
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
		});
	},
	doSearch: function(jq, row){
		var toolbarId = jq.datagrid('options').toolbar;
		var searchParam = $(toolbarId).find('.easyui-combobox').combobox('getValue');
		var searchValue = $(toolbarId).find('.easyui-textbox').textbox('getValue');

		var options = jq.datagrid('options');
		var filterList = options.filterList;
		
		jq.datagrid('reload',formatRequest({
			searchParam: searchParam,
			searchValue: searchValue,
			filtersRaw:options.filterList
		}));
		$(toolbarId).find('.easyui-textbox').textbox('setValue', '');
	},
	doCellTip:function (jq) {
	    return jq.each(function () { 
	    	var grid = $(this);
	        var options = $(this).data('datagrid');
	        var index;
	        if (!options.tooltip) {
	            var panel = grid.datagrid('getPanel').panel('panel');
	            panel.find('.datagrid-body').each(function () {
	                var delegateEle = $(this).find('> div.datagrid-body-inner').length ? $(this).find('> div.datagrid-body-inner')[0] : this;
	                $(delegateEle).undelegate('td', 'mouseover').undelegate('td', 'mouseout').undelegate('td', 'mousemove').delegate('td[field]', {
	                    'mouseover':function (e) {
	                        //if($(this).attr('field')===undefined) return;
	                        var that = this;
	                        var rowIndex = $(this).parent().attr('datagrid-row-index');
	                        if(rowIndex != index){
	                        	index = rowIndex;
	                        	var row = $datagrid.datagrid('getData').rows[rowIndex];
	                        	$(that).tooltip({
	                				position: 'bottom',
	                				content: '<div style="padding:5px;background:#eee;color:#000">This is the tooltip message.</div>',
	                				onShow: function(){
	                					$(that).tooltip('tip').css({
	                						backgroundColor: '#fff000',
	                						borderColor: '#ff0000',
	                						boxShadow: '1px 1px 3px #292929'
	                					});
	                				},
	                				onPosition: function(){
	                					$(this).tooltip('tip').css('left', $(this).offset().left);
	                					$(this).tooltip('arrow').css('left', 20);
	                				}
	                			});
	                        	
	                        }
	                    },
	                    'mouseout':function (e) {
	                       /* if (options.factContent) {
	                            options.factContent.remove();
	                            options.factContent = null;
	                        }*/
	                    }
	                });
	            });
	        }
	    });
	}
});

var editIndex = undefined;
function endEditing(obj){
	if (editIndex == undefined){
		return true};
	if (obj.datagrid('validateRow', editIndex)){
		obj.datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		window.parent.$.messager.alert("提示","必输的字段不能为空！");
		return false;
	}
}


var childEditIndex = undefined;
function endChildEditing(obj){
	if (childEditIndex == undefined){
		return true};
	if (obj.datagrid('validateRow', childEditIndex)){
		obj.datagrid('endEdit', childEditIndex);
		childEditIndex = undefined;
		return true;
	} else {
		return false;
	}
}
/**
 * add弹出框
 * @param id
 * @param title
 * @param url
 * @param callback
 */
function addObjPick(title, w, h, url, obj){
	var $dialog = parent.window.$('#addobjectid');
	$dialog.dialog({     
           title: title,     
           width: w,     
           height: h,     
           iconCls : 'icon-search',    
           closed: false,     
           cache: false,     
           href: url,
           Left:'50%',
           Top:'50%',
           modal: true,
           loadingMessage:'正在努力加载数据,请稍后......',
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                id 	 : 'picklistOK',
                width: '100px',
                handler : function() {
                	window.parent.addMenu(obj, $dialog);
                	/*callback();*/
                }    
            },{    
                text : '取消',    
                iconCls : 'icon-cancel',
                width: '100px',
                handler : function() {    
                    $dialog.dialog('close');
                }    
            }]  
      });    
}



/**
 * picklist弹出框
 * @param id
 * @param title
 * @param url
 * @param callback
 */
function picklist(title, url, callback){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: title,     
           width: '80%',     
           height: '80%',     
           iconCls : 'icon-search',    
           closed: false,     
           cache: false,     
           href: url,     
           modal: true,
           loadingMessage:'正在努力加载数据,请稍后......',
           buttons : [{    
                text : '确定', 
                id 	 : 'picklistOK',
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	var selectRow = window.parent.$picklistdatagrid.datagrid('getSelected');
                	callback(selectRow);
                	$dialog.dialog('close');
                }    
            },{    
                text : '取消',    
                iconCls : 'icon-cancel',
                width: '100px',
                handler : function() {    
                    $dialog.dialog('close');
                }    
            }]  
      });    
}

/**
 * 为客户添加地址的picklist弹出框
 * @param title
 * @param url1 picklist页面url
 * @param ur12 更新地址的url
 * @param callback 回调方法，只写方法名，不能加引号和括号
 */
function addAcctAddressPickList(title, url1, ur12, callback){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: title,     
           width: '900px',     
           height: '500px',     
           iconCls : 'icon-search',    
           closed: false,     
           cache: false,     
           href: url1,     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                id 	 : 'picklistOK',
                width: '100px',
                handler : function() {   
                	$.post(ur12, {
						acctId		: window.parent.$('#acctId').val(),
                		province	: window.parent.$('#province').combobox('getValue'),
                		city		: window.parent.$('#city').combobox('getValue'),
                		district	: window.parent.$('#district').combobox('getValue'),
                		town		: window.parent.$('#town').combobox('getValue'),
                		addr		: window.parent.$('#addr').val(),
                		addrType	: window.parent.$('#addrType').combobox('getValue'),
                		consignee	: window.parent.$('#consignee').val(),
                		mobilePhone	: window.parent.$('#mobilePhone').val(),
                		comments	: window.parent.$('#comments').val(),
                		fixedPhone	: window.parent.$('#fixedPhone').val()
               			
               		}, function(data) {
               			if (data.success) {
               				callback();
               				$dialog.dialog('close');
               			} else {
               				window.parent.operationtip(data.result,'error');
               			}
               		});
                }    
            },{    
                text : '取消',    
                iconCls : 'icon-cancel',
                width: '100px',
                handler : function() {    
                    $dialog.dialog('close');
                }    
            }]  
      });    
}

/**
 * 修改地址的省市县的picklist弹出框
 * @param title
 * @param url1 picklist页面url
 * @param ur12 更新地址的url
 * @param callback 回调方法，只写方法名，不能加引号和括号
 */
function addrPstOfAddressUpdatePickList(title, url1, ur12, callback){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: title,     
           width: '900px',     
           height: '500px',     
           iconCls : 'icon-search',    
           closed: false,     
           cache: false,     
           href: url1,     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	$.post(ur12, {
						id			: window.parent.$('#addressId').val(),
                		province	: window.parent.$('#province').combobox('getValue'),
                		city		: window.parent.$('#city').combobox('getValue'),
                		district	: window.parent.$('#district').combobox('getValue'),
                		town		: window.parent.$('#town').combobox('getValue'),
                		addr		: window.parent.$('#addr').val(),
                		addrType	: window.parent.$('#addrType').combobox('getValue')
               			
               		}, function(data) {
               			if (data.success) {
               				callback();
               				$dialog.dialog('close');
               			} else {
               				window.parent.operationtip(data.result,'error');
               			}
               		});
                }    
            },{    
                text : '取消',    
                iconCls : 'icon-cancel',
                width: '100px',
                handler : function() {    
                    $dialog.dialog('close');
                }    
            }]  
      });    
}

function mvg(title, url, callback){
	var $dialog = window.parent.$('#mvgid');
	$dialog.dialog({     
           title: title,     
           width: '90%',     
           height: '90%',     
           iconCls : 'icon-search',    
           closed: false,     
           cache: false,     
           href: url,     
           modal: true,
           border:false,
           closable:false,
           loadingMessage:'正在努力加载数据,请稍后......',
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {    
                	callback();
                	$dialog.dialog('close');
                }    
            }]  
      });    
}

function orgOfAnneMvg(title, url, callback){
	var $dialog = window.parent.$('#mvgid');
	$dialog.dialog({     
           title: title,     
           width: '95%',     
           height: '90%',     
           iconCls : 'icon-search',    
           closed: false,     
           cache: false,     
           href: url,     
           modal: true,
           border:false,
           closeOnEscape:false,
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {    
                	var selectRow = window.parent.$mvgSelectedDatagrid.datagrid('getSelected');
                	callback(selectRow);
                	$dialog.dialog('close');
                }    
            }]  
      });    
}

var mvgPickId = undefined;
/**
 * 拼接mvg字符串
 * @param val
 * @param row
 * @param obj
 * @param column
 * @param func
 * @returns {String}
 */
function getmvgstr(val, row, obj, column, func)
{
	//当值为空时，显示空白而不显示'null'
	if(val == null){
		val = '';
	}
	var index = obj.datagrid('getRowIndex', row);
	var datagridid = obj.selector.substring(1);
	var str = '<span class="textbox mvgsearchbox" style="width: 139px; height: 20px;">' +
					'<span class="textbox-addon textbox-addon-right" style="right: 0px;">' +
					'<a onclick="' + func + '(' + index + ')" class="textbox-icon mvgsearchbox-button" tabindex="-1" icon-index="0" href="javascript:void(0)" style="width: 18px; height: 20px;"></a>' +
				'</span>' +
				'<input onfocus="' + func + '(' + index + ')" id="'+ datagridid + '-' + column + '-' + index +'" class="textbox-text" type="text" style="margin-left: 0px; margin-right: 18px; padding-top: 2px; padding-bottom: 2px; width: 113px;" value="'+ val +'"></input>' +
				'</span>';
	return str;
}

/**
 * 拼接picklist字符串
 * @param val
 * @param row
 * @param obj
 * @param column
 * @param func
 * @returns {String}
 */
function columnPickListstr(val, row, obj, func)
{
	var index = obj.datagrid('getRowIndex', row);
	//var datagridid = obj.selector.substring(1);
	var str = '<span class="textbox searchbox" style="width: 139px; height: 20px;">' +
					'<span class="textbox-addon textbox-addon-right" style="right: 0px;">' +
					'<a onclick="' + func + '(' + index + ')" class="textbox-icon searchbox-button" tabindex="-1" icon-index="0" href="javascript:void(0)" style="width: 18px; height: 20px;"></a>' +
				'</span>' +
				'<input onfocus="' + func + '(' + index + ')" class="textbox-text" type="text" style="margin-left: 0px; margin-right: 18px; padding-top: 2px; padding-bottom: 2px; width: 113px;" value="'+ (val==null?'':val) +'"></input>' +
				'</span>';
	return str;
}

/**
 * 根据独立源代码来设置datagrid的combobox列的值
 * @param obj datagrid对象
 * @param fieldName 字段名
 * @param val 要设置的独立源代码
 */
function datagridComboboxValue(obj, fieldName, val){
	var selectRow = obj.datagrid('getSelected');
	var selectRowIndex = obj.datagrid('getRowIndex',selectRow);
	var ed = obj.datagrid('getEditor', {index:selectRowIndex, field: fieldName});
	//通过combobox的url来拼接 查询值列表的值 的方法的url
	var strs = $(ed.target).combobox('options').url.split('/');
	var type = strs[strs.length - 1];
	var data = $(ed.target).combobox('getData');
	var url = $(ed.target).combobox('options').url.replace(strs[strs.length - 2] + '/' + strs[strs.length - 1], 'getLov');
	if(data.length > 0){
		$.post(url,{
			type  : type,
			val	  : val
		}, function (data){
			  if(data.success){
				  $(ed.target).combobox('setValue', data.result.name);
			  	} else {
			  		window.parent.operationtip(data.result,'error');
			  	}
		    });
	}
}

/**
 * 根据独立源代码来设置combobox的值
 * @param obj combobox对象
 * @param val 要设置的独立源代码
 */
function comboboxValue(obj, val){
		//通过combobox的url来拼接 查询值列表的值 的方法的url
		var strs = obj.combobox('options').url.split('/');
		var type = strs[strs.length - 1];
		var data = obj.combobox('getData');
		var url = obj.combobox('options').url.replace(strs[strs.length - 2] + '/' + strs[strs.length - 1], 'getLov');
		if(data.length > 0){
			$.post(url,{
				type  : type,
				val	  : val
			}, function (data){
				  if(data.success){
					  obj.combobox('setValue', data.result.name);
				  	} else {
				  		window.parent.operationtip(data.result,'error');
				  	}
			    });
		}
}

/**
 * 屏蔽backspace键后退
 * 注释原因：导致百度富文本插件中回退键无法生效
 */

/*
$(document).on('keydown', function(e){
    switch(e.keyCode){
    case 8:
   	 return e.target.type!= undefined;
    }
    return true;
}); 
*/
