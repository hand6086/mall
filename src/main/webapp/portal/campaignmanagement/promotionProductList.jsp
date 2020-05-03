<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" fit="true">
	<table id="promotion-table" pagination="true" fit="true" >
		<thead>
			<tr>
				<th field="cityName" width="120px" >城市</th>
				<th field="buyMerchName" width="280px" >商品名称</th>
				<th field="merchCode" width="280px">商品编码</th>
				<th field="status" width="120px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																										textField:'name',
																										data:getLovArray('TB_O2O_STATUS'),
																										editable:false,
																										required:true}}">商品状态</th>
				<th field="activityName" width="280px" >活动名称</th>
				<th field="promotionPrice" width="100px">活动价</th>	
				<th field="totalQty" width="120px">限购总量</th>
				<th field="purchasedQty" width="120px" >已售数量</th>
				<th field="lmtAmt" width="130px">单人限购数量</th>
				<th field="type" width="120px" lov="TB_O2O_CAMPAIGN_TYPE">促销类型</th>
				<th field="startTime" width="140px" mark="DATE">开始时间</th>
				<th field="endTime" width="140px" mark="DATE">结束时间</th>
				<th field="displaySeq" width="120px" editor="{type:'textbox'}">显示顺序</th>
			</tr>
		</thead>
	</table>
 </div>
	<script type="text/javascript">
	   $datagrid = $('#promotion-table');
	   $datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			nowrap:false,
			title : '名品促销商品列表',
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/promotionProduct/queryByExamplePage',
			onUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/promotionProduct/update', {
					id:row.id,
					rowId:row.rowId,
					status:row.status,
					displaySeq:row.displaySeq
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
		});
	</script>
</body>
</html>