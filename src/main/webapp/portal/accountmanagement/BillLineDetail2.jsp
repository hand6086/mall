<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
/* 
//造成弹出table没有列标题
table {
	margin: 0 auto;
	border-collapse:collapse;
} */
.left{
	float: left;
	width: 360px;
}
.center{
	float: left;
	width: 90%;
	margin-left:10px;
	
	/* position:absolute; */
}
.right{
	float: left;
	width: 360px;
	margin-left:10px;
}

.form-table{
	margin: 5px auto; 
	width: 1200px;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
.table-block tr{
	height:40px;
}
.td-label {
	width:90px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
	width:90px;
}
.td-content input{
	width:180px;
}
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.ui-btn {
    min-width: 85px;
	width: auto;
	margin-bottom: 0;
	font-weight: 400;
	white-space: nowrap;
	background-image: none;
	line-height: 32px;
	height: 32px;
	display: inline-block;
	text-align: center;
	border: 0;
	background-color: #f0f0f0;
	font-size: 14px;
	vertical-align: middle;
	cursor: pointer;
	color: #555;
}
.ui-btn:focus,.ui-btn:hover {
	background-image:none;
	text-decoration:none;
	color:#555;
	background-color:#e8eaeb;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" title="账户概况" border="false" width="100%" height="100%">
			<form id="billForm" method="post" enctype ="multipart/form-data" style="margin-bottom: 0px;" > 
				<div>
					<table class="table-block">
						<tr>
							<td class="td-label"><label>单据类型 : &nbsp;</label></td>
							<td><label >提现对账单</label></td>
							<td class="td-label"><label>单据编号 : &nbsp;</label></td>
							<td><label id="id"></label></td>
							<td><label id="count" hidden="true"></label></td>
						</tr>
						<tr>
							<td class="td-label"><label>商家名称 : &nbsp;</label></td>
							<td><label id="enterpriseName"></label></td>
						</tr>
						<tr>
							<td class="td-label"><label>提现银行卡 : &nbsp;</label></td>
							<td><input id="merchantAccount" name="merchantAccount" style="width: 500px" /></td>
						</tr>
						<tr>
							<td class="td-label"><label>到账金额 : &nbsp;</label></td>
							<td class="td-content"><input id="arrivedAmount" name="arrivedAmount"readOnly="true" /></td>
							<td class="td-label"><label>手续费: &nbsp;</label></td>
							<td class="td-content"><input id="serviceCharge" name="serviceCharge"readOnly="true" /></td>
						</tr>
						
						<tr>
							<td class="td-label"><label>绑定手机号 : &nbsp;</label></td>
							<td class="td-content"><input id="applicantPhone" name="applicantPhone"readOnly="true" /></td>
							<td class="td-label"><label>创建时间 : &nbsp;</label></td>
							<td class="td-content"><input id="created" name="created"readOnly="true" /></td>
						</tr>
						<tr>
							<td class="td-label"><label>状态: &nbsp;</label></td>
							<td class="td-content"><input id="status" name="status"readOnly="true" /></td>
						</tr>
						
						<tr>
							<td class="td-label">
							<a href="###" class="easyui-linkbutton"  onclick="goBack()">返&nbsp;&nbsp;回</a>
							</td>
						</tr>
				</table>
			</div>
		</form>
		<div id="fundsDetails-tabs" class="easyui-tabs" style="width: 100%;height:400px;" data-options="border:false">
			<div title="单据明细">
				<div>
					<table id="fundsDetails-table"style="width: 100%;height:400px;border:1px ">
						<thead>
							<tr>
								<th field="receiptCode" width="100px">订单编号</th>
								<th field="prodName" width="100px">产品名称</th>
								<th field="number" width="80px" >数量</th>
								<th field="arrivedAmount" width="80px" >金额</th>
							</tr>
						</thead>
					</table> 
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
		//window.onload =billInit
		var billId="${param.billId}";
		var $datagrid = $("#fundsDetails-table");
		var amount=0;
		var serviceCharge=0;
		$statusCombobox = $("#status");//状态
		
		
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			selectFirstRow:false,
			buttonExport : true,
			buttonDelete:false,
			striped : true,
			border : false,
			pagination : true,
			pageSize : 10,//每页显示的记录条数，默认为20 
			pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表
			url :'',
			/* onBeforeLoad:function(param){
				//var entpId=$("#entpId").text();
				if(!entpId){
		    		param.enterpId = "noMatchId";
		    	}else{
		    		param.enterpId=entpId;
		    	}
			}, */
			onAddMoreButton: function(that, addButtonFun){},
		});	
		
		
		 $statusCombobox.combobox({ 
			method:'get',
			data:getLovArray('BILL_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		}); 
		//刷新
		function refresh(){
			 location.reload(); 
			// interval();
		}
		
		 //初始化对账单
		function billInit(billId){
			
			$.post("${AppContext.ctxPath}/action/portal/applyingcash/queryById",{id:billId},
			function(data){
				if(data.success){
					var bill = data.result;
					if(bill !=null){
						$("#id").text(bill.id);
						$("#created").val(bill.created);
						$("#status").combobox('setValue',bill.status);
						$("#enterpriseName").text(bill.entpName);
						$("#applicantPhone").val(bill.phone);
						$("#merchantAccount").val(bill.bank+"-"+bill.merchantAccount);
						$("#arrivedAmount").val(bill.arrivedAmount);
						$("#serviceCharge").val(bill.serviceCharge);
						billId=bill.id;
						amount=bill.arrivedAmount;
						serviceCharge=bill.serviceCharge;
						$datagrid.datagrid('reload','${AppContext.ctxPath}/action/portal/availablecash/queryByBillId?'+"billId="+billId);
					}
				}
			});
		} 
		 
		//返回
		function goBack(){
			window.parent.editWinClose2();
		}

	</script>
</body>
</html>