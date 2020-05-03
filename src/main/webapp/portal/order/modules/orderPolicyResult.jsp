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
   <table id="order-policy-result-table" data-options="fit:true" border="false" style="width:100%;height:100%;padding:0px;">
			<thead>
				<tr>
					<th field="policyName" width="20%">政策名称</th>
					<th field="policyRuleName" width="40%">政策规则名称</th>
					<th field="resultDesc" width="20%">生成说明</th>
					<th field="applyNum" width="10%">配赠次数</th>
					<th field="applyFlag" width="10%">已应用</th>
				</tr>
			</thead>
	</table>
	<script type="text/javascript">
	//getLovOfList("[PROD_UNIT]");
	//$itemdatagrid = $('#sale-order-item-table');
	//$orderDetailFrom = $('#orderDetailFrom');
	var orderId = '';
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
					//$orderDetailFrom.form("load", data.result);
					orderId = $("#orderId").val();
					//$itemdatagrid.datagrid("reload");
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
			//$orderDetailFrom.form("load", order);
			orderId = $("#orderId").val();
			//$itemdatagrid.datagrid("reload");
			$orderPolicyResultGrid.datagrid("reload");
		}else{
			$.messager.alert("错误", "参数无效", "error");
		}
	}
	
	
	$orderPolicyResultGrid = $('#order-policy-result-table');
	$orderPolicyResultGrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		width:$(window).width() - 18,
		height:'40%',
		//title:'政策结果信息',
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
	    url:'${AppContext.ctxPath}/action/portal/orderPolicyResult/queryPcyRuleByOrderId',
		onBeforeLoad:function(param){
			param.orderId = $("#orderId").val();
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(-2,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="applyPolicy()">应用政策</a>',that);
			addButtonFun(-1,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="applyPolicyTwo()">校验政策</a>',that);
		}
	});
		
	
	/**
	 * 计算订单总金额
	 */
	function getTotalAmount(){
		$.post('${AppContext.ctxPath}/action/portal/saleorder/queryTotalAmount',{
			id		: $("#orderId").val()
		},function(data){
			if(data.success){
				var currency = getCurrencyLogo($('#currency').combobox('getValue'));
				$('#orderTotalAmount').textbox('setValue', currencyShowTool(data.amount,currency));
			} else {
				window.parent.operationtip(data.result, 'error');
			}
		});
	}
	/**
	*应用政策接口
	*/
	function applyPolicy(){
		$.post('${AppContext.ctxPath}/action/portal/saleorder/applyPolicyOne', 
		{
			orderId:$("#orderId").val()
	    },
		function(data){
	    	if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				$orderPolicyResultGrid.hdatagrid("reload");
				//$itemdatagrid.hdatagrid("reload");
				window.parent.operationtip("应用政策成功！", 'info');
			}
		});
	};
	
	/**
	*校验政策接口
	*/
	function applyPolicyTwo(){
		$.post('${AppContext.ctxPath}/action/portal/saleorder/applyPolicyTwo', 
		{
			orderId:$("#orderId").val()
	    },
		function(data){
	    	if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				$orderPolicyResultGrid.hdatagrid("reload");
				//$itemdatagrid.hdatagrid("reload");
				window.parent.operationtip("校验政策成功！", 'info');
			}
		});
	};
	
	function getCurrencyLogo(value){
		var currency = '';
		if(value == 'CNY'){
			currency = '¥'
		}else if(value == "USD"){
			currency = '$'
		}else if(value == 'HKD'){
			currency = 'HK$'
		}else if(value == "EUR"){
			currency = '€'
		}
		return currency;
	}
	</script>
</body>
</html>