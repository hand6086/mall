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
		<table id="sale-order-item-table" data-options="fit:true" border="false" style="width:100%;height:100%;padding:0px;">
			<thead>
				<tr>
					<th field="crmLineNo" width="50px" sortable="true">行号</th>
					<th field="prodCode" width="100px" sortable="true">产品编号</th>
					<th field="prodName" width="150px">产品名称</th>
					<th field="itemType" lov="ORDER_ITEM_TYPE" width="150px">行类型</th>
					<th field="policyDesc" width="150px">政策优惠说明</th>
					<th field="prodUnit" width="50px" lov="PROD_UNIT" sortable="true">单位</th>
					<th field="currency"  lov="CURRENCY" width="50px" sortable="true">货币</th>
					<th field="qty" width="70px" sortable="true">数量</th>
					<th field="basePrice" width="100px" currency="CNY" >原价</th>
					<th field="promotionPrice" width="100px" currency="CNY" >促销价</th>
					<th field="discount" width="100px">折扣比率</th>
					<th field="manualPrice" width="100px" currency="CNY" >手动调整</th>
					<th field="netPrice" width="100px" currency="CNY">实际价格</th>
					<th field="amount"  width="100px" currency="CNY">金额</th>
					<th field="comments" width="200px">备注</th>
				</tr>
			</thead>
		</table>	
   
	<script type="text/javascript">
	getLovOfList("[PROD_UNIT]");
	$itemdatagrid = $('#sale-order-item-table');
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
					$itemdatagrid.datagrid("reload");
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
			$itemdatagrid.datagrid("reload");
			$orderPolicyResultGrid.datagrid("reload");
		}else{
			$.messager.alert("错误", "参数无效", "error");
		}
	}
	
	$itemdatagrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		//title:"订单行信息",
		width:$(window).width() - 18,
		height:'100%',
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
	    url:'${AppContext.ctxPath}/action/portal/saleorderitem/queryByExamplePage',
		onBeforeLoad:function(param){
			orderId=$("#orderId").val()
			if(orderId){
				param.headId =orderId;
			}else{
				param.headId ='noMatchId';
			}
		},
		onLoadSuccess:function(data){
			getTotalAmount();
	    }
	});
	$orderPolicyResultGrid = $('#order-policy-result-table');
	$orderPolicyResultGrid.hdatagrid({
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		width:$(window).width() - 18,
		height:'40%',
		title:'政策结果信息',
	    pageSize: 15,//每页显示的记录条数，默认为20 
	    pageList: [15,30,50],//可以设置每页记录条数的列表 
	    url:'${AppContext.ctxPath}/action/portal/orderPolicyResult/queryPcyRuleByOrderId',
		onBeforeLoad:function(param){
			param.orderId = orderId;
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(-2,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="applyPolicy()">应用政策</a>',that);
			addButtonFun(-1,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="applyPolicyTwo()">校验政策</a>',that);
		}
	});
		
	window.onresize=function(){  
		$itemdatagrid.datagrid('resize',{width:$(window).width() - 18});
       }
	/**
	 * 计算订单总金额
	 */
	function getTotalAmount(){
		$.post('${AppContext.ctxPath}/action/portal/saleorder/queryTotalAmount',{
			id		: orderId
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
			orderId:orderId
	    },
		function(data){
	    	if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				$orderPolicyResultGrid.hdatagrid("reload");
				$itemdatagrid.hdatagrid("reload");
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
			orderId:orderId
	    },
		function(data){
	    	if(!data.success){
				window.parent.operationtip(data.result, 'error');
			}else{
				$orderPolicyResultGrid.hdatagrid("reload");
				$itemdatagrid.hdatagrid("reload");
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