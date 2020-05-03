<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body>
<table id="withdrawalsDetails-table" fit="true" rownumbers="true" pagination="true">
			<thead>
			<tr>
			<!-- <th field="corpid" width="100px">单据编号</th> -->
			<th field="receiptCode" width="100px" >单据编号</th>
			<th field="receiptType" width="100px">单据类型</th>
			<th field="fundingDirection" width="80px" editor="{type:'validatebox',options:{required:true}}" formatter="fundingFormatter">资金往来方向</th>
			<th field="arrivedAmount" width="80px" editor="{type:'checkbox',options:{on:'Y', off:'N'}}" align="center">到账金额</th>
			<th field="serviceCharge" width="80px" align="center">手续费</th>
			<th field="created" width="200px" editor="{type:'textarea'}">创建时间</th>
			<th field="createdBy" width="100px" editor="{type:'textarea'}" >创建人</th>
			<th field="merchantAccount" width="120px" editor="{type:'textarea'}" >商户账户</th>
			<th field="bank" width="120px" editor="{type:'textarea'}" >开户行</th>
			<th field="status" width="80px"width="80px" lov="FUNDS_STATUS" editor="{type:'textbox',options:{valueField:'val',
																					textField:'name',
																					data :getLovArray('FUNDS_STATUS'),
																					editable:true,
																					required:true}}">状态</th>
			<th field="remarks" width="100px" editor="{type:'textarea'}" >备注</th>
			<th field="billId" width="100px" editor="{type:'textarea'}" >提现对账单号</th>
			</tr>
			</thead>
			</table>

<script type="text/javascript">
var $datagrid = $("#withdrawalsDetails-table");
$datagrid.hdatagrid({
	updateable:false,
	toolbarShow:true,
	buttonSearch:true,
	selectFirstRow:false,
	//buttonNew:true,
	//buttonDelete:true,
	striped : true,
	border : false,
	pagination : true,
	buttonExport:true,
	pageSize : 10,//每页显示的记录条数，默认为20 
	pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表
	//url :'',
	 url :'${AppContext.ctxPath}/action/portal/availablecash/queryByExamplePage',
	onBeforeLoad:function(param){
		if(!corpid){
    		param.usercorpid = "noMatchId";
    	}else{
    		param.usercorpid=corpid;
    	}
	},
});

function fundingFormatter(val,row){
	if(val=='+'){
		return "收入";
	}else if(val=='-'){
		return "退款";
	}
}
</script>
</body>
</html>