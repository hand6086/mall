/**
 * 促销政策向导页面的公共方法
 *
 */

/**
 * 初始化含有iCheck样式的input标签(单选框和复选框)
 */
function iCheckInit(){
	$('.iCheck').iCheck({
		checkboxClass : 'icheckbox_square-blue',
		radioClass : 'iradio_square-blue',
		increaseArea : '20%' // optional
	});
}

/**
 * 生成步骤条的html
 */
function createStepFlow(tagId,stepNum){
	var steps = ['基本信息', '政策应用范围', '政策规则', '政策规则条件', '政策规则结果', '完成']
	var html = [];
	html.push('<div class="lnk-step">');
	html.push('<div class="lnk-step-logo-icon">&nbsp;</div>');
	stepNum = stepNum - 1;//用于循环时与i同步
	for (var i = 0; i < steps.length; i++) {
		var stepTitle = steps[i];
		if(i == 0){
			html.push('<div class="lnk-step-icon lnk-step-icon-first-finish">' + stepTitle + '</div>');
		}
		else if(i <= stepNum){
			if(i == steps.length - 1){
				html.push('<div class="lnk-step-icon lnk-step-icon-last-finish">' + stepTitle + '</div>');
			} else {
				html.push('<div class="lnk-step-icon lnk-step-icon-finish">' + stepTitle + '</div>');
			}
		} else {
			if(i == steps.length - 1){
				html.push('<div class="lnk-step-icon lnk-step-icon-last-unfinish">' + stepTitle + '</div>');
			} else {
				html.push('<div class="lnk-step-icon lnk-step-icon-unfinish">' + stepTitle + '</div>');
			}
		}
	}
	html.push('</div>');
	$('#' + tagId).append(html.join(''));
}


/**
 * 如果是参数为ID则返回对应列表对象，为对象则返回本身，其余返回null
 * @param table 列表对象 or 列表ID
 * @returns 列表对象
 */
function getDatagridObj(table){
	var $objDatagrid = null;
	if(typeof (table) === "string"){
		$objDatagrid = $('#' + table);
	}
	else if(typeof (table) === "object"){
		$objDatagrid = table;
	}
	return $objDatagrid;
}
/**
 * 根据行ID获取指定列表行记录
 * @param table 列表对象 or 列表ID
 * @param rowId 行记录ID
 */
function getRowById(table, rowId){
	if(!rowId){
		return null;
	}
	var $objDatagrid = getDatagridObj(table);
	if(!$objDatagrid){
		$.messager.alter("列表对象不能为空！");
		return;
	}
	var rows = $objDatagrid.datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if(rowId == row.id){
			return row;
		}
	}
}

/**
 * 根据行ID删除指定列表一条数据
 */
function delRowByIndex(table, index){
	if(index == undefined){
		return;
	}
	var $objDatagrid = getDatagridObj(table);
	var rowIndex = index;
	$objDatagrid.datagrid('deleteRow', rowIndex);
	$objDatagrid.datagrid('acceptChanges');
	$objDatagrid.datagrid('loadData', $objDatagrid.datagrid('getRows'));
}

/**
 * 根据行ID删除指定列表一条数据
 */
function delRowById(table, rowId){
	var $objDatagrid = getDatagridObj(table);
	var row = getRowById($objDatagrid, rowId);
	if(!row){
		return;
	}
	var rowIndex = $objDatagrid.datagrid('getRowIndex', row);
	delRowByIndex($objDatagrid, rowIndex);
}

/**
 * 删除指定列表所有数据
 */
function delAllRow(table){
	var $objDatagrid = getDatagridObj(table);
	var data = {rows:[]};
	$objDatagrid.datagrid({url:'',data:data});
	$objDatagrid.datagrid('acceptChanges');
}

/**
 * 根据非空ID从数组里获取对应的对象,找不到则在数组中插入新对象，并且返回该对象
 */
function getObjById(id,array){
	if(!id){
		return null;
	}
	for (var i = 0; i < array.length; i++) {
		var obj = array[i];
		if(obj.id == id){
			return obj
		}
	}
	var newObj = {id:id};
	array.push(newObj);
	return newObj;
}

/**
 * 根据指定元素，将对象数组中指定元素用','连接,例如'[id1,id2,id3...]'
 */
function objListJoinAry(objArray, property){
	var rows = objArray;
	var arrayStr = '';
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if(!row[property]){
			continue;
		}
		if(arrayStr == ''){
			arrayStr += row[property];
		} else {
			arrayStr += ',' + row[property];
		}
	}
	if(arrayStr){
		arrayStr = '[' + arrayStr + ']';
	}
	return arrayStr;
}

/**
 * 修改列属性
 */
function formatterColumn(columns){
	for(var i = 0; i < columns.length; i++){
		if(columns[i].lov){
			columns[i].formatter = function(val, row, index){
				if(val){
					return getLovShowName(this.lov, val);
				}
			}
		}
	}
}


