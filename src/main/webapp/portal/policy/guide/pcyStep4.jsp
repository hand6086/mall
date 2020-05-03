<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.js?version=<%=version%>"></script>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.css?version=<%=version%>">
<style type="text/css">
.context{padding-top: 10px;height: 80%;}
.table-div {width: 100%;height: 100%;}
/* .table-div {width: 500px;height: 200px;padding-bottom: 10px;border: solid 1px #95b8e7;} */
/* 修改列表的行高 */
.table-div .datagrid-btable tr{height: 40px;}
.datagrid-header .datagrid-cell span{font-family: "微软雅黑" !important;}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div region="center" border="false">
			<div id="guide-step"></div><!-- 步骤条 -->
			<div class="context">
				<div class="table-div">
					<table id="pcyCnd-table" class="easyui-datagrid" fit="true">
						<thead>
							<tr>
								<th field="opt" width="30px" formatter="optFormatter"></th>
								<th field="cndType" width="100px" lov="PCY_CND_TYPE" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_CND_TYPE'),editable:false,required:false}}">条件类型</th>
								<th field="cndBasis" width="100px" lov="PCY_CND_BASIS" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_CND_BASIS'),editable:false,required:false}}">条件基数</th>
								<th field="cndObjType" width="100px" lov="PCY_CND_OBJ_TYPE" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_CND_OBJ_TYPE'),editable:false,required:false}}">条件对象类型</th>
								<th field="valueType" width="100px" lov="PCY_VALUE_TYPE" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_VALUE_TYPE'),editable:false,required:false}}">值类型</th>
								<th field="startTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">开始时间</th>
								<th field="endTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">结束时间</th>
								<th field="cndOpr" width="100px" lov="PCY_CND_OPR" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_CND_OPR'),editable:false,required:false}}">运算符</th>
								<th field="cndMinimum" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">最小值</th>
								<th field="cndMaximum" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">最大值</th>
								<th field="circulated" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否循环</th>
								<th field="priority" width="100px" editor="{type:'numberbox',options:{min:0}}">优先级</th>
								<th field="prodMatSeries" width="100px" lov="PROD_MAT_SERIES" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PROD_MAT_SERIES'),editable:false,required:false}}">产品类别</th>
								<th field="prodName" width="150px" editor="{type:'mvgPickbox',
									options:{title:'产品',completeFun:cndProdMvgPickComplete,
											mvgMapperName:'pcyCndprod',
											tableId:'pcyCnd-table',
											tableType:'datagrid',
											optionsLeft:{
												tableUrl:'${AppContext.ctxPath}/portal/policy/mvgPick/ProdMvgPick.jsp',
												initParam:cndProdMvgPickParam
											}
											}}">产品名称</th>
								<th field="comments" width="200px" editor="{type:'validatebox',options:{required:false}}">备注</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<div region="south" border="false" style="height:40px;">
			<div style="width: 100%; height: 40px;line-height:40px; text-align:right; background:#e8f1ff;">
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-undo" 
						onclick="prevOpt()" style="width: 100px;margin-right: 20px;">上一步</a> 
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-redo" 
						onclick="nextOpt()" style="width: 100px;margin-right: 20px;">下一步</a>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	initData(policy);
});
var policy = window.parent.$guideWinFram.wholePolicy;
var pcyRule = policy.newPcyRule;
var $pcyCndDatagrid = $('#pcyCnd-table');
createStepFlow('guide-step', 4);

/**
 * 上一步
 */
function prevOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	saveObj(pcyRule);
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep3.jsp");
}
/**
 * 下一步
 */
function nextOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	saveObj(pcyRule);
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep5.jsp");
}

/**
 * 保存并返回对象值
 */
function saveObj(obj){
	$pcyCndDatagrid.datagrid('selectRow', $pcyCndDatagrid.datagrid('getRows').length - 1);//结束编辑
	var rows = $pcyCndDatagrid.datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if(row.opt_flag_status == 'ADD_ROW'){
			rows.splice(i, 1);//移除该元素
		}
	}
	obj.conditionList = rows;
	return obj;
}

/**
 * 初始化数据
 */
function initData(pcyObj){
	var obj = pcyObj.newPcyRule;
	obj.conditionList.push({opt_flag_status:'ADD_ROW'});//操作标记，在列表最后添加一行用于放【+(添加)】按钮
	formatterColumn($pcyCndDatagrid.datagrid('options').columns[0]);
	$pcyCndDatagrid.datagrid({data:{rows:obj.conditionList}});
}

/* --------------------------------- 规则列表 ----------------------------------------- */
$pcyCndDatagrid.datagrid({
	striped : true,
	border : false,
	rownumbers : true,
	singleSelect : true,
	onSelect : function(rowIndex, rowData){
		editRow(rowIndex, rowData);
    },
	onLoadSuccess : function(data){
		$('.opt-btn').linkbutton();
	}
});

/**
 * 编辑一行
 */
function editRow(rowIndex, rowData){
	var editIndex = $pcyCndDatagrid.datagrid('options').editIndex;//获取编辑行序号
	if(editIndex >= 0){
		$pcyCndDatagrid.datagrid('endEdit', editIndex);
		$('.opt-btn').linkbutton();
	}
	if(rowData.opt_flag_status === 'ADD_ROW'){
		return;
	}
	$pcyCndDatagrid.datagrid('options').editIndex = rowIndex;
	$pcyCndDatagrid.datagrid('acceptChanges');
	$pcyCndDatagrid.datagrid('beginEdit', rowIndex);
}
/**
 * 在操作列添加按钮
 */
function optFormatter(val,row,index){
	var html = '';
	if(row.opt_flag_status === 'ADD_ROW'){
		html = '<a href="javascript:void(0)" class="opt-btn" onclick="addEditRow(\'pcyCnd-table\')" iconCls="icon-add" plain="true"></a>';
	} else {
		html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRowById(\'pcyCnd-table\',\''+row.id+'\')" iconCls="icon-remove" plain="true"></a>';
	}
	return html;
}

/**
 * 添加一个编辑行
 */
function addEditRow(table){
	var $objDatagrid = getDatagridObj(table);
	$.post('${AppContext.ctxPath}/action/portal/pcyCnd/preDefaultValue',{},function(data){
		if (data.success) {
			var newRow = {
					id : data.result.id,
					row_status : 'NEW'
			};//新建的行
			var newRowIndex = $objDatagrid.datagrid('getRows').length - 1;//行索引为倒数第二
			$objDatagrid.datagrid('insertRow', {index:newRowIndex,row:newRow});
			$objDatagrid.datagrid('selectRow', newRowIndex);
		} else {
			$.messager.alert("错误", data.result, "error");
		}
	});
}

/**
 * 条件产品mvgPick 列表数据初始化参数
 */
function cndProdMvgPickParam(){
	var currentRow = $pcyCndDatagrid.datagrid('getSelected');
	return {mvgParentId:currentRow.id};
}
/**
 * 条件产品mvgPick 按【确定】后执行的方法
 */
function cndProdMvgPickComplete(rightRowsMvg) {
	var currentRow = $pcyCndDatagrid.datagrid('getSelected');
	if(rightRowsMvg != null){
		currentRow.prodId = rightRowsMvg.id;
		currentRow.prodName = rightRowsMvg.prodName;
	}
	return currentRow.prodName;
}

</script>
</body>
</html>
