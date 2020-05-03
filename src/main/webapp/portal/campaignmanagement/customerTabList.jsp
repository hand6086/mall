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
		<table id="activity-table-coupon" style="height:100%;width:100%" fit="true">
			<thead>
				<tr>
					<th field="id" width="120px">编码</th>
					<th field="customerName" width="120px"
						editor="{type:'picklistbox',options:{title:'选择消费者',
					completeFun:completeCustomerPicklist,
					tableUrl:'${AppContext.ctxPath}/portal/picklist/couponCustomerPicklist.jsp'}}">消费者名称</th>
					<th field="customerCode" width="100px">消费者编码</th>
					<th field="couponCity" width="100px"
						editor="{type:'textbox',options:{required:true}}">优惠券城市</th>
					<th field="actualCity" width="100px"
						editor="{type:'textbox',options:{required:true}}">领取城市</th>
					<th field="status" width="100px" lov='TB_O2O_COUPON_STATUS'
						editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_COUPON_STATUS'),
											editable:true,
											required:true}}">状态</th>
					<th field="isUsed" width="100px"
						editor="{type:'checkbox', options:{on:'Y', off:'N'}}">不可使用</th>
					<th field="created" width="140px"
						editor="{type:'datetimebox',options:{required:true}}">领取时间</th>
				</tr>
			</thead>
		</table>
	</div>
	<script type="text/javascript">
		$datacustomer = $('#activity-table-coupon');
		$datacustomer.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonBatchEdit : false,
					buttonNew : true,
					oauthFlag:false,
					pageSize: 10,//每页显示的记录条数，默认为20 
				    pageList: [10,30,50],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/coupon/queryConsumerInformationPage',
					parentGridId : 'activity-table',
					parentGridField : 'id',
					linkGridField : 'headId',
					onInitNewData:function(that){
						var row = $dataItemgrid.hdatagrid('getSelected');
						return {
							created : appCtx.sysdate(),
							status : 'Unused',
							actualCity : row.cityName,
							couponCity : row.cityName,
						};
					},
					onBeforeAdd : function(row, that) {
						var headRow = $dataItemgrid.hdatagrid('getSelected');
						if (headRow.drawType == 'Seller Dispatch') {
							flag = true;
						} else {
							window.parent.operationtip('只有当优惠券的领取方式为卖家发放时，才可选择消费者！', 'info');
							return false;
						}
					},
					onInsertAction : function(row, successFun, errFun, that) {
						row.headId = $dataItemgrid.hdatagrid('getCurrentRow').id;
						
						row.customerId=$datacustomer.hdatagrid('getCurrentRow').customerId;
						$.post(
										'${AppContext.ctxPath}/action/portal/coupon/customerInsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
					onUpdateAction : function(row, successFun, errFun, that) {

						$
								.post(
										'${AppContext.ctxPath}/action/portal/coupon/customerUpdate',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
				});
		function completeCustomerPicklist(selectRow) {
			$datacustomer.hdatagrid('getCurrentRow').customerName = selectRow.customerName;
			$datacustomer.hdatagrid('getCurrentRow').customerId= selectRow.customerId;
			return selectRow.customerName;
		}
	</script>
</body>
</html>