<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
<table id="autoconfig-table-link" fit="true">
		<thead>
			<tr>

				<th field="name" width="160px" defaultSearch="true"
					editor="{type:'validatebox',options:{required:true}}">名称</th>
				<th field="tablename" width="160px"
					editor="{type:'validatebox',options:{required:true}}">表</th>
				<th field="attr01" width="60px"
					editor="{type:'validatebox',options:{required:true}}">表别名</th>
				<th field="outerflag" width="60px"
					editor="{type:'checkbox',options:{on:'Y',off:'N'}}">外连接</th>
				<th field="linkcoms" width="160px"
					editor="{type:'validatebox',options:{required:false}}">连接条件(主表在前)</th>
				<th field="coms" width="100px"
					editor="{type:'validatebox',options:{required:false}}">说明</th>

				<th field="attr02" width="60px"
					editor="{type:'checkbox',options:{on:'Y',off:'N'}}">有效</th>


				<!-- 
<th field="attr02" width="100px" editor="{type:'validatebox',options:{required:false}}">备注2</th>
<th field="attr03" width="100px" editor="{type:'validatebox',options:{required:false}}">备注3</th>
<th field="attr04" width="100px" editor="{type:'validatebox',options:{required:false}}">备注4</th>
<th field="attr05" width="100px" editor="{type:'validatebox',options:{required:false}}">备注5</th>
<th field="attr06" width="100px" editor="{type:'validatebox',options:{required:false}}">备注6</th>
<th field="attr07" width="100px" editor="{type:'validatebox',options:{required:false}}">备注7</th>
<th field="attr08" width="100px" editor="{type:'validatebox',options:{required:false}}">备注8</th>
<th field="attr09" width="100px" editor="{type:'validatebox',options:{required:false}}">备注9</th>
<th field="attr10" width="100px" editor="{type:'validatebox',options:{required:false}}">备注10</th>
 -->
			<th field="created" width="130px">创建时间</th>
		</tr>
	</thead>
	</table>
	
	<script type="text/javascript">
	$dataItemgridlink = $('#autoconfig-table-link');
	$dataItemgridlink
	.hdatagrid({
		pageSize : 200,//每页显示的记录条数，默认为20 
		pageList : [ 200, 300, 500 ],//可以设置每页记录条数的列表 
		updateable : true,
		toolbarShow : true,
		buttonSearch : true,
		buttonNew : true,
		buttonDelete : true,
		buttonCopy : true,
		buttonExport : false,
		buttonImport : false,
		newDefaultValue : true,
		url : '${AppContext.ctxPath}/action/portal/LnkInnerLink/queryByExamplePage',

		onBeforeLoad:function(param){
			if(objStatus == "NEW"){ //对象头未保存
				return false;
			}
			var parentid = objId ? objId : "noMatchId";
			param.filtersRaw = '[{"id":"parentid","property":"parentid","value":"'+parentid+'"}]';
		},
		onBeforeAdd: function(row, that){
			if(objStatus == "NEW"){ //对象头未保存
				$.messager.alert("警告", "请先保存配置对象", "info");
				return false;
			}
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/LnkInnerLink/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
							dataType:"json",
							contentType: "application/json",
							success: function(data){
								if(data.success){
									successFun(that, data);
								}else{
									errFun(that, data);
								}
							},
							error: function(xhr, code, msg){
								errFun(that, "msg");
							}
						});
					},				
					onInsertOrUpdateAction : function(row, successFun, errFun,
				that) {
			$
					.post(
							'${AppContext.ctxPath}/action/portal/LnkInnerLink/upsert',
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
													'${AppContext.ctxPath}/action/portal/LnkInnerLink/deleteById',
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

		onInitNewData : function(that) {
			return {
				created : appCtx.sysdate(),
				parentid : objId,
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				attr02 : "Y",
				outerflag : "Y",
				postnName : appCtx.postnName
			};
		},
		onAddMoreButton : function(that, addButtonFun) {
			addButtonFun(
					94,
					'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFinish()" iconCls="icon-ok" plain="true">校验</a>',
					that);
		}
	});
	</script>
</body>
</html>