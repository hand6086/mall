<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" fit="true">
	<table id="prodRcmd-table" fit="true">
		<thead>
			<tr>
				<th field="prodCode" width="150px" editor="{type:'textbox',options:{disabled:true}}"  >产品编码</th>
				<th field="prodName" width="200px" editor="{type:'picklistbox',options:{title:'选择产品',
	   																		     completeFun:prodPickListComplete,
	   																		     tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp',
		   																		 required:true}}">产品名称</th>
				<th field="annualSales" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">年销量</th>
				<th field="monthlySales" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">月销量</th>
				<th field="seq" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2,
																				required:true}}">顺序</th>
				<th field="activeFlag" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否推荐</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#prodRcmd-table');
		$datagrid.hdatagrid({
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonExport : true,
			buttonImport : true,
			sortName:'seq',			//默认列表用创建时间排序
			sortOrder:'asc',			//默认排列顺序为倒序
			url:'${AppContext.ctxPath}/action/portal/prodRcmd/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/prodRcmd/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/prodRcmd/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/prodRcmd/deleteById', {
								id : row.id
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
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName,
					activeFlag : 'Y'
				};
			}
		});

		/**
		 * 产品picklist回调事件
		 */
	 	function prodPickListComplete(selectRow){
	 		$datagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
	 		$datagrid.hdatagrid('getCurrentRow').prodCode = selectRow.prodCode;
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'prodCode'}).target).textbox('setValue',selectRow.prodCode);
	 		return selectRow.prodName;
	 	}; 
	</script>
</body>
</html>
