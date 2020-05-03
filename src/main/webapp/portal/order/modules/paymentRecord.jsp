<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<style type="text/css">
fieldset{
	margin:10px 10px;
	border:1px solid #acacac;
}

fieldset .textbox{
	border-color:#acacac;
	border-radius:0px;
}
/* -- td css start -- */
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
	width:120px;
}
.td-input{
	width:160px;
	height:30px;
	padding-left: 10px;
}
/* -- td css end -- */

.td-input-input{
	width:150px;
}
</style>
<body>
		<table id="payment-record-table" data-options="fit:true" border="false" style="width:100%;height:100%;padding:0px;">
			<thead>
				<tr>
					<th field="crmLineNo" width="10%" sortable="true">序号</th>
					<th field="orderId" width="15%" sortable="true">订单ID</th>
					<th field="payDate" width="20%">时间</th>
					<th field="type" lov="ORDER_ITEM_TYPE" width="15%">支付方式</th>
					<th field="amount" width="20%">金额</th>
					<th field="comments" width="20%">备注</th>
				</tr>
			</thead>
		</table>	
   
	<script type="text/javascript">
	getLovOfList("[PROD_UNIT]");
	$orderPayRecord = $('#payment-record-table');
	$orderDetailFrom = $('#orderDetailFrom');
	var orderId = '';
	
		//orderId = window.parent.getOrderId();
	
	/**
	* 初始化/刷新数据，若id不为空，则重新查询；
	* 若对象不为空，则加载订单对象
	* @id 订单id
	* @order 订单对象
	*/
	function orderInfoInit(id, order){
		//若id不为空，则重新查询
		if(id){ 
			$.post("${AppContext.ctxPath}/action/portal/saleorder/queryById", {id:id}, function(data){
				if(data.success){
					$orderDetailFrom.form("load", data.result);
					orderId = $("#orderId").val();
					$orderPayRecord.datagrid("reload");
				}else if(data.result){
					$.messager.alert("错误", data.result, "error");
				}else{
					$.messager.alert("错误", "加载数据失败", "error");
				}
			});
		}else if(order){ //若对象不为空，则加载订单对象
			var currency = getCurrencyLogo(order.currency);
			order.rebateMoney = currencyShowTool(order.rebateMoney, currency);
			order.cash = currencyShowTool(order.cash, currency);
			order.freight = currencyShowTool(order.freight, currency);
			$orderDetailFrom.form("load", order);
			orderId = $("#orderId").val();
			console.info(orderId);
			$orderPayRecord.datagrid("reload");
		}else{
			$.messager.alert("错误", "参数无效", "error");
		}
	}
	
	$orderPayRecord.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		//title:"订单行信息",
		width:$(window).width() - 18,
		height:'100%',
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
	    url:'${AppContext.ctxPath}/action/portal/payRecord/queryByExamplePage',
		onBeforeLoad:function(param){
			orderId=$("#orderId").val();
			console.info(orderId+"++++++++++++++orderID");
			if(orderId){
				param.headId =orderId;
			}else{
				param.headId ='noMatchId';
			}
		},
		onLoadSuccess:function(data){
			//getTotalAmount();
	    }
	});
	
	</script>
</body>
</html>