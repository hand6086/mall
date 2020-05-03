<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<div border="false" style="height: 100%; width: 100%">
		<table id="lnkDocParam-table" style="height: 100%; width: 100%"
			fit="true">
			<thead>
				<tr>
					<th field="param" noSearch="false" defaultSearch="false"
						width="100px"
						editor="{type:'validatebox',options:{required:false}}">参数</th>
					<th field="paramName" noSearch="false" defaultSearch="false"
						width="200px"
						editor="{type:'validatebox',options:{required:false}}">名称</th>
					<th field="ifNecessary" noSearch="false" defaultSearch="false"
						width="100px" lov='S_IF'
						editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:true,
											required:true}}">是否必要</th>
					<th field="type" noSearch="false" defaultSearch="false"
						width="100px" lov='DOC_DATA_TYPE'
						editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('DOC_DATA_TYPE'),
											editable:true,
											required:true}}">类型</th>



					<th field="menuDescribe" noSearch="false" defaultSearch="false"
						width="600px"
						editor="{type:'validatebox',options:{required:false}}">描述</th>

				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
		$dataParam = $('#lnkDocParam-table');
		$dataParam
				.hdatagrid({
					buttonDelete : true,
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonBatchEdit : true,
					buttonNew : true,
					pageSize : 10,//每页显示的记录条数，默认为20 
					pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/lnkDocParam/queryByExamplePage',
					parentGridId : 'lnkDocMenuLine-table',
					parentGridField : 'id',
					linkGridField : 'menuLineId',

					onInitNewData : function(that) {

					},
					onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {
						row.menuLineId = $datamenuLine
								.hdatagrid('getCurrentRow').id;
						$
								.post(
										'${AppContext.ctxPath}/action/portal/lnkDocParam/upsert',
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
																'${AppContext.ctxPath}/action/portal/lnkDocParam/deleteById',
																{
																	id : row.id
																},
																function(data) {
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
						//$datagrid.hdatagrid("changeParentItemAndParams",{LnkDocParamId:row.id});
					},
					/**
					 * 初始化新建的数据
					 */
					onInitNewData : function(that) {
						return {
							ifNecessary : 'Y',
							type : 'DOCSTRING',
							orgName : appCtx.orgName,
							postnId : appCtx.postnId,
							postnName : appCtx.postnName
						};
					},
					onAddMoreButton : function(that, addButtonFun) {
						//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editLnkDocParamPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
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