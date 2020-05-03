<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <table id="sku-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="productDisplayName" width=20% editor="{type:'picklistbox',options:{title:'选择商品',
															completeFun:merchandisePicklistComplete,
															initParam:initPickMerchandiseParam,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp'}}">商品名称</th>
				<th field="productIntCode" width=20%>商品编码</th>
				<th field="quantity" width=40%  editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">数量</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	    $datagrid = $('#sku-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			oauthFlag:false,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/goodsSku/queryByExamplePage',
			onBeforeLoad:function(param){
				if(!goodsId){
		    		param.parentProductId = "noMatchId";
		    	}else{
		    		param.parentProductId=goodsId;
		    	}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				if(row.row_status == 'NEW'){
					row.parentProductId=goodsId;
				}
				$.post("${AppContext.ctxPath}/action/portal/goodsSku/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsSku/deleteById', {
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
		});
		function merchandisePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').productId = selectRow.id;
			return selectRow.o2oDisplayName;
		}
		
		/**
		 * 套装单品  商品名称 picklist 初始化参数
		 */
		function initPickMerchandiseParam() {
			var suitProductFlg = 'N';
			return {suitProductFlg:suitProductFlg};
		}
	</script>
</body>
</html>