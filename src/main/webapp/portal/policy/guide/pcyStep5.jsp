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
/* 修改列表的行高 */
.table-div .datagrid-btable tr{height: 40px;}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div region="center" border="false">
			<div id="guide-step"></div><!-- 步骤条 -->
			<div class="context">
				<div class="table-div">
					<table id="pcyResult-table" class="easyui-datagrid" fit="true">
						<thead>
							<tr>
								<th field="opt" width="30px" formatter="optFormatter"></th>
								<th field="promType" width="100px" lov="PCY_PROM_TYPE" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_PROM_TYPE'),editable:false,required:false}}">促销类型</th>
								<th field="promObjType" width="170px" lov="PCY_PROM_OBJ_TYPE" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_PROM_OBJ_TYPE'),editable:false,required:false}}">促销对象类型/限购范围类型</th>
								<th field="limitType" width="100px" lov="PCY_LIMIT_TYPE" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_LIMIT_TYPE'),editable:false,required:false}}">限制类型</th>
								<th field="promMethod" width="100px" lov="PCY_PROM_METHOD" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PCY_PROM_METHOD'),editable:false,required:false}}">促销方式</th>
								<th field="proportion" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				max:1,
																				precision:2}}">折扣比例</th>
								<th field="qty" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">数量</th>
								<th field="spclPrice" width="100px" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">特价</th>
								<th field="subjectId" width="100px" editor="{type:'validatebox',options:{required:false}}">科目ID</th>
								<th field="campaignId" width="100px" editor="{type:'validatebox',options:{required:false}}">活动ID</th>
								<th field="prodMatSeries" width="100px" lov="PROD_MAT_SERIES" editor="{type:'combobox',options:{valueField:'val',
								textField:'name',data:getLovArray('PROD_MAT_SERIES'),editable:false,required:false}}">产品类别</th>
								<th field="prodName" width="150px" editor="{type:'mvgPickbox',
									options:{title:'产品',completeFun:rltProdMvgPickComplete,
											mvgMapperName:'pcyrltProd',
											tableId:'pcyResult-table',
											tableType:'datagrid',
											optionsLeft:{
												tableUrl:'${AppContext.ctxPath}/portal/policy/mvgPick/ProdMvgPick.jsp',
												initParam:rltProdMvgPickParam
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
						onclick="nextRound()" style="width: 100px;margin-right: 20px;">下一规则</a>
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-ok" 
						onclick="nextOpt()" style="width: 100px;margin-right: 20px;">完成</a>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	initData(policy);
});
var policy = window.parent.$guideWinFram.wholePolicy;
var pcyRule = policy.newPcyRule;
var $pcyResultDatagrid = $('#pcyResult-table');
createStepFlow('guide-step', 5);
/**
 * 上一步
 */
function prevOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	saveObj(pcyRule);
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep4.jsp");
}
/**
 * 完成
 */
function nextOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	saveObj(pcyRule);
	policy.ruleList.push(pcyRule);
	policy.newPcyRule = {};//置空新建规则
	window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep6.jsp");
}

/**
 * 循环下一轮,重新跳回第三步
 */
function nextRound(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	$.post('${AppContext.ctxPath}/action/portal/pcyRule/preDefaultValue',{},function(data){
		if (data.success) {
			saveObj(pcyRule);
			policy.ruleList.push(pcyRule);
			policy.newPcyRule = {
					id : data.result.id,
					row_status : 'NEW'
			};//新建的规则
			window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep3.jsp");
		} else {
			$('.step-opt').linkbutton('enable');//解锁按钮
			$.messager.alert("错误", data.result, "error");
		}
	});
}

/**
 * 保存并返回对象值
 */
function saveObj(obj){
	$pcyResultDatagrid.datagrid('selectRow', $pcyResultDatagrid.datagrid('getRows').length - 1);//结束编辑
	var rows = $pcyResultDatagrid.datagrid('getRows');
	for (var i = 0; i < rows.length; i++) {
		var row = rows[i];
		if(row.opt_flag_status == 'ADD_ROW'){
			rows.splice(i, 1);//移除该元素
		}
	}
	obj.resultList = rows;
	return obj;
}

/**
 * 初始化数据
 */
function initData(pcyObj){
	var obj = pcyObj.newPcyRule;
	obj.resultList.push({opt_flag_status:'ADD_ROW'});//操作标记，在列表最后添加一行用于放【+(添加)】按钮
	formatterColumn($pcyResultDatagrid.datagrid('options').columns[0]);
	$pcyResultDatagrid.datagrid({data:{rows:obj.resultList}});
}

/* --------------------------------- 规则列表 ----------------------------------------- */
$pcyResultDatagrid.datagrid({
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
	var editIndex = $pcyResultDatagrid.datagrid('options').editIndex;//获取编辑行序号
	if(editIndex >= 0){
		$pcyResultDatagrid.datagrid('endEdit', editIndex);
		$('.opt-btn').linkbutton();
	}
	if(rowData.opt_flag_status === 'ADD_ROW'){
		return;
	}
	$pcyResultDatagrid.datagrid('options').editIndex = rowIndex;
	$pcyResultDatagrid.datagrid('acceptChanges');
	$pcyResultDatagrid.datagrid('beginEdit', rowIndex);
}
/**
 * 在操作列添加按钮
 */
function optFormatter(val,row,index){
	var html = '';
	if(row.opt_flag_status === 'ADD_ROW'){
		html = '<a href="javascript:void(0)" class="opt-btn" onclick="addEditRow(\'pcyResult-table\')" iconCls="icon-add" plain="true"></a>';
	} else {
		html = '<a href="javascript:void(0)" class="opt-btn" onclick="delRowById(\'pcyResult-table\',\''+row.id+'\')" iconCls="icon-remove" plain="true"></a>';
	}
	return html;
}

/**
 * 添加一个编辑行
 */
function addEditRow(table){
	var $objDatagrid = getDatagridObj(table);
	$.post('${AppContext.ctxPath}/action/portal/pcyResult/preDefaultValue',{},function(data){
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
 * 结果产品mvgPick 列表数据初始化参数
 */
function rltProdMvgPickParam(){
	var currentRow = $pcyResultDatagrid.hdatagrid('getSelected');
	return {mvgParentId:currentRow.id};
}
/**
 * 结果产品mvgPick 按【确定】后执行的方法
 */
function rltProdMvgPickComplete(rightRowsMvg) {
	var currentRow = $pcyResultDatagrid.hdatagrid('getSelected');
	if(rightRowsMvg != null){
		currentRow.prodId = rightRowsMvg.id;
		currentRow.prodName = rightRowsMvg.prodName;
	}
	return currentRow.prodName;
}

</script>
</body>
</html>
