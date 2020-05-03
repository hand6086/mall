<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<body>
	<div id="menu_layout" class="easyui-layout" data-options="fit:true"
		border="false">
		<div data-options="region:'north',split:true" fit="true"
			border="false">
			<div data-options="region:'north'" title="" border="false"
				style="width: 100%; height: 347px; padding: 0px;">
				<table id="main-table" fit="true" pagination="true">
					<thead>
						<tr>
							<th field="tableName" width="25%"
								editor="{type:'textbox',options:{required:true}}">表名</th>
							<th field="tComment" width="70%"
								editor="{type:'textbox',options:{required:true}}">备注</th>
						</tr>
					</thead>
				</table>
			</div>
			<div data-options="region:'center'" border="false"
				style="width: 100%; height: 70%;">
				<table id="field-table" fit="true" singleSelect="true"
					rownumbers="true" pagination="true">
					<thead>
						<tr>
							<th data-options="field:'fieldName',width:'25%'"
								editor="{type:'textbox',options:{required:true}}">字段</th>
							<th data-options="field:'fComment',width:'25%'"
								editor="{type:'textbox',options:{required:true}}">备注</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$datagrid = $('#main-table');
		$dataitemgrid = $('#field-table');
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					pageSize : 10,
					pageList : [ 10, 30, 50 ],
					url : '${AppContext.ctxPath}/action/portal/tablemanage/queryByExamplePage',
					subGridIds : [ 'field-table' ],
					onInsertAction : function(row, successFun, errFun, that) {
						$.post(
										'${AppContext.ctxPath}/action/portal/tablemanage/insert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												$datagrid.datagrid('reload');
											}
										});
					},
					onUpdateAction : function(row, successFun, errFun, that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/tablemanage/update',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												refreshAddrToolBar();
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/tablemanage/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(
																				that,
																				data);
																	}
																});
											}
										});
					},
				});
		$dataitemgrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					url : "${AppContext.ctxPath}/action/portal/tablemanage/queryFieldPage",
					pageSize : 50,
					parentGridId : 'main-table',
					parentGridField : 'id',
					linkGridField : 'headId',
					onInsertAction : function(row, successFun, errFun, that) {
						row.headId = $datagrid.hdatagrid('getCurrentRow').id;
						$
								.post(
										'${AppContext.ctxPath}/action/portal/tablemanage/filedInsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												refreshAddrToolBar();
											}
										});
					},
					onUpdateAction : function(row, successFun, errFun, that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/tablemanage/filedupdate',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												refreshAddrToolBar();
											}
										});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/tablemanage/deletefiledId',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(
																				that,
																				data);
																	}
																});
											}
										});
					},
				});
	</script>
</body>
</html>