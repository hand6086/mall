<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%%; padding: 0px;">
			  <table id="prod-norms-table" 
						singleSelect="true" rownumbers="true"  pagination="true" fit="true">
					<thead>
						<tr>
							<!-- <th field="id" width="200px" >编号</th> -->
							<th field="prodNormName" noSearch="false" defaultSearch="false"   width="200px" editor="{type:'validatebox',options:{required:false}}"  >参数名称</th>
							<th field="prodNormVal" noSearch="false" defaultSearch="false"   width="200px" editor="{type:'validatebox',options:{required:false}}"  >参数值</th>
							<th field="prodId" hidden="true">商品ID</th>
						</tr>
					</thead>
				</table>
		</div>
	<script type="text/javascript">
		var prodId = "${param.prodId}";
		$datagrid = $('#prod-norms-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : ${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)},
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : ${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)},
			buttonDelete : ${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)},
			buttonCopy : false,
			buttonExport : false,
			buttonImport : false,
			newDefaultValue : false,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/prodNorms/queryByExamplePage',
			onBeforeLoad:function(param){
				param.prodId = prodId;
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				row.prodId = prodId;
				$.post('${AppContext.ctxPath}/action/portal/prodNorms/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
						window.parent.$promsdatagrid.hdatagrid('reload');
					}
				});
			},
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/prodNorms/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
									window.parent.$promsdatagrid.hdatagrid('reload');
								}
						});
					}
				});
			}
		});
	</script>
</style>
</body>
</html>