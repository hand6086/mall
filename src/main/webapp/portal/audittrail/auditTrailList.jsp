<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	
   <div data-options="region:'north',split:true" title="" border="false" fit="true">	
	<table id="auditTrail-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="id" width="80px"   editor="{type:'textbox',options:{disabled:true}}">记录ID</th>
				<th field="userName" width="80px"  defaultSearch="true" editor="{type:'textbox',options:{disabled:true}}" >员工登录</th>
				<th field="userFirstName" width="80px"  defaultSearch="true" editor="{type:'textbox',options:{disabled:true}}" >员工姓名</th>
				<th field="buscompName" width="300px"  editor="{type:'textbox'}" >业务组件</th>
				<th field="field" width="400px"  editor="{type:'textarea'}" formatter="fieldFormatter">字段</th>
				<th field="action" width="80px"  editor="{type:'textbox'}" >操作</th>
<!-- 				<th field="oldValue" width="80px"  editor="{type:'textbox'}" >旧值</th>
				<th field="newValue" width="80px"  editor="{type:'textbox'}" >新值</th> -->
				<th field="dateTime" width="130px" mark="DATE" editor="{type:'datetimebox'}" >日期</th>
<!-- 				<th field="service" width="150px"  editor="{type:'textbox'}" >service</th> -->
				<th field="sourceName" width="80px"  editor="{type:'textbox'}" >来源</th>
<!-- 				<th field="baseTable" width="150px"  editor="{type:'textbox'}" >基本表</th>
				<th field="childTable" width="150px"  editor="{type:'textbox'}" >子表名称</th>
 				<th field="childValue" width="80px"  editor="{type:'textbox'}" >子值</th>
				<th field="rowName" width="150px"  editor="{type:'textbox'}" >列</th>
				<th field="synDate" width="130px" mark="DATE" editor="{type:'datetimebox'}" >同步日期</th>
				<th field="groupId" width="80px"  editor="{type:'textbox'}" >组ID</th>
				<th field="linkName" width="180px"  editor="{type:'textbox'}" >链接</th>
				<th field="node" width="80px"  editor="{type:'textbox'}" >节点</th> 
				<th field="tableName" width="150px"  editor="{type:'textbox'}" >表</th> -->
				<th field="lineFlag" width="80px"  editor="{type:'textbox'}" >行标识</th>		
				<th field="corpName" width="120px">公司账套</th>		
			</tr>
		</thead>
	</table>
</div>
<div id="msg-dlg-buttons" style="display: none;">
	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="javascript:$('#field-dlg').dialog('close')">确定</a>
</div>
<div id="field-dlg" class="easyui-dialog" style="width:500px;height:400px;"
		closed="true" buttons="#msg-dlg-buttons" style="display: none;">		
	<div class="ftitle"></div>
	<form id="fm" method="post">	
	<table class="table-block" align="center">		
		<tr>
			<td class="td-content">
				<textarea id="field" name="field" readonly="readonly" class="easyui-validatebox" style="width: 470px;height:300px;font-size: 12px;border-style:none;"></textarea>
			</td>
		</tr>		
	</table>
	</form>	
</div>

<script type="text/javascript">
	$datagrid = $('#auditTrail-table');
	$fm = $('#fm');
	$msgDlg = $('#field-dlg');
	
	var field = '';
	
	$datagrid.hdatagrid({
 		updateable : false,
		toolbarShow:true,
		buttonNew:true,
		buttonSearch:true,
		buttonDelete:true,
		selectFirstRow:false,
		newDefaultValue:true,
		striped:true,
		border:false,
		url:'${AppContext.ctxPath}/action/portal/auditTrail/queryByExamplePage',
		onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			$.post('${AppContext.ctxPath}/action/portal/auditTrail/upsert', {
				row_status   : row.row_status,
				id           : row.id,
				userId       : row.userId,
				buscompName  : row.buscompName,
				field        : row.field,
				action       : row.action,
				oldValue     : row.oldValue,
				newValue     : row.newValue,
				dateTime     : row.dateTime,
/* 				service      : row.service, */
				sourceName   : row.sourceName,
				baseTable    : row.baseTable,
				childTable   : row.childTable,
/* 				childValue   : row.childValue,
				rowName      : row.rowName,
				synDate      : row.synDate,
				pricgroupIde : row.groupId,
				linkName     : row.linkName,
				node         : row.node, */
				tableName    : row.tableName,
				lineFlag     : row.lineFlag
			}, function(data) {
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/auditTrail/deleteByIdNew', {
							id : row.id
					}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							} else {
								successFun(that, data);
								
							}
					});
				}
			});
		},
		onInitNewData : function(that){
			return{
				corpName : appCtx.corpName,// 默认显示公司账套
			};
		}
 	}); 
	
	//公司账套
	function enterpPicklistComplete(selectRow){
		var row = $datagrid.datagrid('getSelected');
		row.corpid = selectRow.code;
		return selectRow.name;
	}
	
	//字段显示全部
	function fieldFormatter(val, row, index) {
			if(val == null){
				val = '';
			}
			var content = "点击查看明细";
			return "<a href='###' class='easyui-tooltip' title='"+content+"' onClick='fieldDetailShow(" + index + ")'>"+val+"</a>";
	} 
	
	function fieldDetailShow(index){
		var selectRow = $datagrid.hdatagrid('getRows')[index];
		$msgDlg.dialog('open').dialog('setTitle','字段明细');
		$fm.form('load',selectRow);
	}

</script>

</body>