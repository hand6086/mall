<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title=""
			style="width: 100%; height: 100%; padding: 0px;">

			<div id="header" class="easyui-panel" style="height: 950px;">
				<table id="lnkDocMenu-table" style="height: 470px; width: 100%">
					<thead>
						<tr>
							<th field="menuName" noSearch="false" defaultSearch="false"
								width="50%"
								editor="{type:'validatebox',options:{required:true}}">菜单名称</th>
							<th field="menuIcon" noSearch="false" defaultSearch="false"
								width="40%"
								editor="{type:'validatebox',options:{required:false}}">菜单图标</th>
						</tr>
					</thead>
				</table>
				<table id="lnkDocMenuLine-table" style="height: 470px; width: 99%">
					<thead>
						<tr>
							<th field="menuLineName" noSearch="false" defaultSearch="false"
								width="100px"
								editor="{type:'validatebox',options:{required:true}}">子菜单名称</th>
							<th field="requestAddress" noSearch="false"
								defaultSearch="false" width="400px"
								editor="{type:'validatebox',options:{required:false}}">请求地址</th>
							<th field="interfaceSpecification" noSearch="false"
								defaultSearch="false" width="400px"
								editor="{type:'validatebox',options:{required:true}}">接口说明</th>
							<th field="requestMode" noSearch="false" defaultSearch="false"
								width="100px"
								lov='DOC_REQUEST_TYPE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('DOC_REQUEST_TYPE'),
											editable:true,
											required:true}}">请求方式</th>
							<th field="requestHeader" noSearch="false" defaultSearch="false"
								width="100px"
								editor="{type:'validatebox',options:{required:false}}">请求Header</th>
							<th field="dataType" noSearch="false" defaultSearch="false"
								width="100px"
								lov='DOC_TRANSMIT'
								 editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('DOC_TRANSMIT'),
											editable:true,
											required:true}}">数据类型</th>
							<th field="transmissionDirection" noSearch="false"
								defaultSearch="false" width="100px"
								lov='DOC_TRANSMISSION_DIRECTION'
								 editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('DOC_TRANSMISSION_DIRECTION'),
											editable:true,
											required:true}}">传输方向</th>

							<th field="encryptionMode" noSearch="false" defaultSearch="false"
								width="100px"
								lov='DOC_ENCRYPTING_TYPE'
								 editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('DOC_ENCRYPTING_TYPE'),
											editable:true,
											required:true}}"
								>加密方式</th>
							<th field="secret_key_encryption" noSearch="false"
								defaultSearch="false" width="100px"
								editor="{type:'validatebox',options:{required:false}}">加密秘钥</th>

							<th field="sampleAfter" noSearch="false" defaultSearch="false"
								width="500px"
								editor="{type:'validatebox',options:{required:false}}">示例（解密后）</th>

							<th field="sampleBefore" noSearch="false" defaultSearch="false"
								width="500px"
								editor="{type:'validatebox',options:{required:false}}">示例（解密前）</th>
						</tr>
					</thead>
				</table>
			</div>
			<div data-options="region:'east',split:true"
				style="width: 100%; height: 100%">
				<div id="menu-tabs" class="easyui-tabs"
					style="width: 100%; height: 150px;" data-options="border:false"
					fit="true">
					<div title="参数内容"
						href="${AppContext.ctxPath}/portal/doc/lnkDocParamList.jsp"></div>
					<div title="结果内容"
						href="${AppContext.ctxPath}/portal/doc/lnkDocResultList.jsp"></div>
				</div>

			</div>
		</div>


		<script type="text/javascript">
			$datagrid = $('#lnkDocMenu-table');
			$datamenuLine = $('#lnkDocMenuLine-table');
			$datagrid
					.hdatagrid({
						title : '',
						pageSize : 15,//每页显示的记录条数，默认为20 
						pageList : [ 15, 30, 50 ],//可以设置每页记录条数的列表 
						updateable : true,
						toolbarShow : true,
						buttonSearch : true,
						buttonNew : true,
						buttonDelete : true,
						buttonCopy : true,
						buttonExport : true,
						buttonImport : true,
						newDefaultValue : false,
						striped : true,
						border : false,
						url : '${AppContext.ctxPath}/action/portal/lnkDocMenu/queryByExamplePage',

						parentGridId : null, //当前表的父表id
						parentGridField : null, //当前表关联的父表字段名称
						linkGridField : null, //当前表与父表关联的的字段名称
						subGridIds : [ 'lnkDocMenuLine-table' ], //当前表的子表的id，字符串列表
						onInsertOrUpdateAction : function(row, successFun,
								errFun, that) {

							$
									.post(
											'${AppContext.ctxPath}/action/portal/lnkDocMenu/upsert',
											row, function(data) {
												if (!data.success) {
													errFun(data.result, that);
												} else {
													successFun(that, data);
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
																	'${AppContext.ctxPath}/action/portal/lnkDocMenu/deleteById',
																	{
																		id : row.id
																	},
																	function(
																			data) {
																		if (!data.success) {
																			errFun(
																					data.result,
																					that);
																		} else {
																			successFun(that);
																		}
																	});
												}
											});
						},
						onChangeSelectedItem : function(row) {
							//$datagrid.hdatagrid("changeParentItemAndParams",{LnkDocMenuId:row.id});
						},
						/**
						 * 初始化新建的数据
						 */
						
						onAddMoreButton : function(that, addButtonFun) {
							//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editLnkDocMenuPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
							//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);

						},
					/**
					 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
					 */
					//readOnlyCondition: function(row, that){
					//	return false;
					//},
					});
			$datamenuLine
					.hdatagrid({
						title : '',
						pageSize : 15,//每页显示的记录条数，默认为20 
						pageList : [ 15, 30, 50 ],//可以设置每页记录条数的列表 
						updateable : true,
						toolbarShow : true,
						buttonSearch : true,
						buttonNew : true,
						buttonDelete : true,
						buttonCopy : true,
						buttonExport : true,
						buttonImport : true,
						newDefaultValue : false,
						striped : true,
						border : false,
						url : '${AppContext.ctxPath}/action/portal/lnkDocMenuLine/queryByExamplePage',

						parentGridId : 'lnkDocMenu-table', //当前表的父表id
						parentGridField : 'id', //当前表关联的父表字段名称
						linkGridField : 'menuId', //当前表与父表关联的的字段名称
						subGridIds : [ 'lnkDocParam-table',
								'lnkDocResult-table' ], //当前表的子表的id，字符串列表 
						onInsertOrUpdateAction : function(row, successFun,
								errFun, that) {
							row.menuId = $datagrid.hdatagrid('getCurrentRow').id;
							$
									.post(
											'${AppContext.ctxPath}/action/portal/lnkDocMenuLine/upsert',
											row, function(data) {
												if (!data.success) {
													errFun(data.result, that);
												} else {
													successFun(that, data);
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
																	'${AppContext.ctxPath}/action/portal/lnkDocMenuLine/deleteById',
																	{
																		id : row.id
																	},
																	function(
																			data) {
																		if (!data.success) {
																			errFun(
																					data.result,
																					that);
																		} else {
																			successFun(that);
																		}
																	});
												}
											});
						},
						onChangeSelectedItem : function(row) {
							//$datagrid.hdatagrid("changeParentItemAndParams",{LnkDocMenuLineId:row.id});
						},
						/**
						 * 初始化新建的数据
						 */
						 onInitNewData : function(that) {
								return {
									requestMode : 'DOC_POST',
									dataType : 'DOC_JSON',
									transmissionDirection : 'OOUSIDE_CALL',
									encryptionMode : 'DES'
								};
							},
						onAddMoreButton : function(that, addButtonFun) {
							//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editLnkDocMenuLinePrice()" iconCls="icon-edit" plain="true">修订</a>',that);
							//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);

						},
					/**
					 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
					 */
					//readOnlyCondition: function(row, that){
					//	return false;
					//},
					});
		</script>
</body>
</html>
