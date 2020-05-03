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
   <div class="easyui-layout" data-options="fit:true" border="false">
     <div data-options="region:'north'" collapsible="false" title="" border="false" style="width:100%;height:100%;padding:0px;">
     <form id="orderDetailFrom" method="post">
        <fieldset>
			<legend>订单信息</legend>
			<table style="width:1100px;">
				<tr>
					<td>
						<table>
						<tr>
								<td class="td-label"><label>订单编号 :</label></td>
								<td class="td-input">
									<input id="orderNo" name="orderNo" disabled class="easyui-textbox td-input-input" editable="false"  />
				         			<input id="acctId" name="acctId" type="hidden"></input>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>订单大类:</label></td>
								<td class="td-input">
			         				<input name="orderCategory" id="orderCategory" lov="ORDER_CATEGORY" size="25"  class="easyui-combobox td-input-input " 
			         				  disabled data-options="data:getLovArray('ORDER_CATEGORY'),
														valueField:'val',
														textField: 'name',
														required:true,
														editable:false,
														onSelect:function(){
													$('#status').combobox('reload');
													$('#status').combobox('setValue','');
												}"/>
								</td>
								
							</tr>
							<tr>
								<td class="td-label"><label>客户名称 :</label></td>
								<td class="td-input">
									<input id="acctName" name="acctName" disabled class="easyui-textbox td-input-input" editable="false"  />
				         			<input id="acctId" name="acctId" type="hidden"></input>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>订单状态 :</label></td>
								<td class="td-input">
									<input name="status" id="status" size="25" class="easyui-combobox td-input-input" disabled 
									data-options="data:getLovArray('ORDER_STATUS'),
													valueField:'val',
														textField: 'name',
														required:true,
														editable:false"
													/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>支付状态 :</label></td>
								<td class="td-input">
									<input name="payStatus" id="payStatus" size="25" class="easyui-combobox td-input-input" disabled 
			       			    				data-options="valueField:'text',
												textField:'text',
												required:true,
												data:[{'text':'未付款'},{'text':'已付款'}],
												editable:false
												"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>支付方式 :</label></td>
								<td class="td-input">
				         			<input id="payType" name="payType" disabled class="easyui-combobox td-input-input" 
				         			data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('PAY_TYPE_ALL'),
										" />
														
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>订单类型 :</label></td>
								<td class="td-input">
									<input id="orderType" name="orderType" disabled class="easyui-combobox td-input-input" 
										data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('ORDER_TYPE'),
										">
									<input id="isFlag" type="hidden" name="isFlag"></input>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>职位 :</label></td>
								<td class="td-input">
									<input id="postnId" name="postnId" type="hidden" />
			         				<input id="postnName" name="postnName" disabled class="easyui-textbox td-input-input" data-options="editable:false" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>组织 :</label></td>
								<td class="td-input">
									<input id="orgId" name="orgId" type="hidden"/>
			         				<input id="orgName" name="orgName" disabled class="easyui-textbox td-input-input" data-options="editable:false" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>价格表 :</label></td>
								<td class="td-input">
									 <input id="priceListId" name="priceListId" type="hidden"/>
				         			 <input id="priceListName" name="priceListName" disabled class="easyui-combobox td-input-input"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>期望发货日期 :</label></td>
								<td class="td-input">
									<input id="expectDate" name="expectDate" disabled class="easyui-datebox td-input-input" data-options="editable:false" >
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>收货地址 :</label></td>
								<td class="td-input">
									 <input id="addrId" name="addrId" type="hidden"/>
				         			 <input id="fullAddr" name="fullAddr" disabled class="easyui-combobox td-input-input"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>省 :</label></td>
								<td class="td-input">
			         				<input id="province" name="province" disabled class="easyui-combobox td-input-input province-combobox"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>市 :</label></td>
								<td class="td-input">
									<input id="city" name="city" disabled class="easyui-combobox td-input-input city-combobox"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>区/县 :</label></td>
								<td class="td-input">
									<input id="district" name="district" disabled class="easyui-combobox td-input-input district-combobox" data-options="editable:false" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>地址 :</label></td>
								<td class="td-input">
									<input id="customAddr" name="customAddr" disabled class="easyui-textbox td-input-input" data-options="editable:true"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>收货联系人 :</label></td>
								<td class="td-input">
									<input id="customConsignee" name="customConsignee" disabled class="easyui-textbox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>收货电话 :</label></td>
								<td class="td-input">
									<input id="customMobilePhone" name="customMobilePhone" disabled class="easyui-textbox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机 :</label></td>
								<td class="td-input">
									<input class="easyui-validatebox td-input-input"  id="optyName" name="optyName" disabled data-options="editable:true" />
				         			<input id="optyId" name="optyId" type="hidden" ></input>
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>送货方式 :</label></td>
								<td class="td-input">
									<input id="deliverType" name="deliverType" disabled class="easyui-combobox td-input-input"
									data-options="prompt:'请选送货方式...',
				         			    				data:getLovArray('DELIVER_TYPE'),
														valueField:'val',
														textField: 'name',
														editable:false"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>返利金额 :</label></td>
								<td class="td-input">
									<input id="rebateMoney" name="rebateMoney" disabled class="easyui-validatebox td-input-input" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>现金金额 :</label></td>
								<td class="td-input">
									<input id="cash" name="cash" disabled class="easyui-validatebox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>运费 :</label></td>
								<td class="td-input">
									<input id="freight" name="freight" disabled class="easyui-validatebox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>制单人 :</label></td>
								<td class="td-input">
									<input id="createdByName" name="createdByName" disabled class="easyui-textbox td-input-input" data-options="editable:false" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>货币 :</label></td>
								<td class="td-input">
			         				<input id="currency" name="currency" disabled class="easyui-combobox td-input-input" data-options="
										editable:false,
										valueField:'val',
										textField: 'name',
										data:getLovArray('CURRENCY'),
										" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>订单金额 :</label></td>
								<td class="td-input">
									<input id="orderTotalAmount" name="orderTotalAmount" disabled class="easyui-textbox td-input-input" type="text"/>
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							
							<tr>
								<td class="td-label"><label>物流公司 :</label></td>
								<td class="td-input">
									<input id="logisticsCompany" disabled name="logisticsCompany" class="easyui-combobox td-input-input"
									data-options="prompt:'请选物流公司...',
				         			    				data:getLovArray('LOGISTICS_COMPANY'),
														valueField:'val',
														textField: 'name',
														editable:false"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>快递编号 :</label></td>
								<td class="td-input">
									<input id="logisticsNo" name="logisticsNo" disabled class="easyui-textbox td-input-input" type="text"/>
								</td>
							</tr>
							<tr>
								<td class="td-label" rowspan="3"><label>备注 :</label></td>
								<td width="100" rowspan="3" class="td-input">
									<input id="comments" name="comments" disabled class="easyui-textbox td-input-input" data-options="multiline:true" 
										style="height:90px;" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr>
				<td></td>
				<td></td>
				<td></td>
				<td>
					<div style="width:100%;height:30px;padding:0px;margin-bottom:10px;text-align:right">
					<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
						plain="false" style="margin-left:100px;width: 100px;height:30px; margin-right:30px;" onclick="javascript:window.parent.closeReadOnlyWin()">返回</a>
			    	</div>
		    </td></tr>
			</table>
		</fieldset>
		<input id="orderId" name="id" hidden="true" />
		</form>
		
			<div id="sale-order-tabs" class="easyui-tabs"
				style="width: '$(window).width() - 18'; height: 60%;" data-options="border:false">
				<div title="订单行信息" href="${AppContext.ctxPath}/portal/order/modules/saleOrderItem.jsp">
				</div>
				<div title="政策结果信息" href="${AppContext.ctxPath}/portal/order/modules/orderPolicyResult.jsp">
				</div>
				<div title="付款记录" href="${AppContext.ctxPath}/portal/order/modules/paymentRecord.jsp">
				</div>
			</div
		</div>
   
  </div>
	<script type="text/javascript">	
	getLovOfList("[PROD_UNIT,ORDER_CATEGORY]");
	//$itemdatagrid = $('#sale-order-item-table');
	$orderDetailFrom = $('#orderDetailFrom');
	$('#sale-order-tabs').tabs();
	
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
					$orderDetailFrom.form("load", data.result);
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
			$orderDetailFrom.form("load", order);
			orderId = $("#orderId").val();
			//$itemdatagrid.datagrid("reload");
			//$orderPolicyResultGrid.datagrid("reload");
		}else{
			$.messager.alert("错误", "参数无效", "error");
		}
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