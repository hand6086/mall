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
     <div data-options="region:'center'" collapsible="false" title="" border="false" style="width:100%;height:100%;padding:0px;">
     <form id="orderEditForm" method="post">
        <fieldset>
			<legend>订单信息</legend>
			<table style="width:1100px;">
				<tr>
					<td>
						<table>
						<tr>
								<td class="td-label"><label>订单编号 :</label></td>
								<td class="td-input">
			         				<input id="orderNo" name="orderNo" disabled class="easyui-textbox td-input-input" data-options="editable:false" />
								</td>
								
							</tr>
						<tr>
								<td class="td-label"><label>订单大类:</label></td>
								<td class="td-input">
			         				<input name="orderCategory" id="orderCategory" size="25"  class="easyui-combobox td-input-input" 
			         				data-options="data:getLovArray('ORDER_CATEGORY'),
														valueField:'val',
														textField: 'name',
														required:true,
														editable:false"
														/>
								</td>
								
							</tr>
							<tr>
								<td class="td-label"><label>客户名称 :</label></td>
								<td class="td-input">
									<%-- <input id="acctName" class="easyui-textbox td-input-input" editable="false" value="${saleOrder.acctName}"
				         				data-options="buttonText:'',
				         							  buttonIcon:'icon-search',
				         							  prompt:'选择客户...',
				         							  onClickButton: function(){
				         							  	acctPicklist();
													}" 
										/> --%>
									<input class="easyui-validatebox td-input-input"  id="acctName" name="acctName" />
				         			<input id="acctId" name="acctId" type="hidden" ></input>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>订单状态 :</label></td>
								<td class="td-input">
									<input name="status" id="status" size="25" class="easyui-combobox td-input-input"
										data-options="data:getLovArray('ORDER_STATUS'),
														valueField:'val',
														textField: 'name',
														required:true,
														editable:false
													"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>支付状态 :</label></td>
								<td class="td-input">
									<input name="payStatus" id="payStatus" size="25" class="easyui-combobox td-input-input"
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
				         			<input id="payType" name="payType" class="easyui-combobox td-input-input" 
				         			    data-options="prompt:'请选支付方式...',
				         			    				data:getLovArray('PAY_TYPE_ALL'),
														valueField:'val',
														textField: 'name',
														required:true,
														editable:false"/>
														
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>订单类型 :</label></td>
								<td class="td-input">
									<input id="orderType" name="orderType" readonly="readonly" class="easyui-combobox td-input-input"  
										data-options="prompt:'请选订单类型...',
				         			    				data:getLovArray('ORDER_TYPE'),
														valueField:'val',
														textField: 'name',
														required:true,
														editable:false">
									<input id="isFlag" name="isFlag" type="hidden" ></input>
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
									<input id="orgId" name="orgId" type="hidden" />
			         				<input id="orgName" name="orgName" disabled class="easyui-textbox td-input-input" data-options="editable:false" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>价格表 :</label></td>
								<td class="td-input">
				         			<input id="priceListId" name="priceListId" type="hidden" ></input>
				         			 <input class="easyui-validatebox td-input-input"  id="priceListName" name="priceListName" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>期望发货日期 :</label></td>
								<td class="td-input">
									<input id="expectDate" name="expectDate" class="easyui-datebox td-input-input" data-options="editable:false" required="true" >
								</td>
							</tr>
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>收货地址 :</label></td>
								<td class="td-input">
									 <input id="addrId" name="addrId" type="hidden" />
				         			 <input id="fullAddr" name="fullAddr" class="easyui-combobox td-input-input" 
				         			    data-options="prompt:'请选择收货地址...',
				         			    				url:'',
														valueField:'id',
														textField: 'fullAddr',
														required:true,
														editable:false,
														"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>省 :</label></td>
								<td class="td-input">
			         				<input id="province" name="province" class="easyui-combobox td-input-input province-combobox"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>市 :</label></td>
								<td class="td-input">
									<input id="city" name="city" class="easyui-combobox td-input-input city-combobox"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>区/县 :</label></td>
								<td class="td-input">
									<input id="district" name="district" class="easyui-combobox td-input-input district-combobox" data-options="editable:false" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>地址 :</label></td>
								<td class="td-input">
									<input id="customAddr" name="customAddr" class="easyui-textbox td-input-input" data-options="editable:true"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>收货联系人 :</label></td>
								<td class="td-input">
									<input id="customConsignee" name="customConsignee"  class="easyui-textbox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>收货电话 :</label></td>
								<td class="td-input">
									<input id="customMobilePhone" name="customMobilePhone" class="easyui-textbox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>商机 :</label></td>
								<td class="td-input">
									<input class="easyui-validatebox td-input-input"  id="optyName" name="optyName" />
				         			<input id="optyId" name="optyId" type="hidden" ></input>
								</td>
							</tr>
							<!-- <tr><td></td><td></td></tr> -->
						</table>
					</td>
					<td>
						<table>
							<tr>
								<td class="td-label"><label>送货方式 :</label></td>
								<td class="td-input">
									<input id="deliverType" name="deliverType" class="easyui-combobox td-input-input"
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
									<input id="rebateMoney" name="rebateMoney" class="easyui-validatebox td-input-input" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>现金金额 :</label></td>
								<td class="td-input">
									<input id="cash" name="cash" class="easyui-validatebox td-input-input" data-options="editable:true" />
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>运费 :</label></td>
								<td class="td-input">
									<input id="freight" name="freight" class="easyui-validatebox td-input-input" data-options="editable:true" />
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
							<tr><td></td><td></td></tr>
						</table>
					</td>
					<td>
						<table>
							
							<tr>
								<td class="td-label"><label>物流公司 :</label></td>
								<td class="td-input">
									<input id="logisticsCompany" name="logisticsCompany" class="easyui-combobox td-input-input"
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
									<input id="logisticsNo" name="logisticsNo" class="easyui-textbox td-input-input" type="text"/>
								</td>
							</tr>
							<tr>
								<td class="td-label" rowspan="3"><label>备注 :</label></td>
								<td width="100" rowspan="3" class="td-input">
									<input id="comments" name="comments" class="easyui-textbox td-input-input" data-options="multiline:true" 
										style="height:90px;" />
								</td>
							</tr>
							
						</table>
					</td>
				</tr>
			</table>
			<div style="width:100%;height:30px;padding:0px;margin-top:30px;">
				<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
					plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="goBack()">取消</a>
		    	<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
		    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="orderSave()">保存</a>
		    </div>
		</fieldset>
		<input id="orderId" name="id" hidden="true" />
		<input id="row_status" name="row_status" hidden="true" />
		<input id="orderNo" name="orderNo" hidden="true" />
		<span hidden="true" id="prodMvgHl"><input id="prodMvg"/></span><!-- MVG隐藏编辑框 -->
		</form>
		
		<div id="sale-order-tabs" class="easyui-tabs"
				style="width: '$(window).width() - 18'; height: 60%;" data-options="border:false">
				<div title="订单行信息" href="${AppContext.ctxPath}/portal/order/modules/saleOrderItemNew.jsp">
				</div>
				<div title="政策结果信息" href="${AppContext.ctxPath}/portal/order/modules/orderPolicyResult.jsp">
				</div>
			</div 
	</div>
  </div>
	<script type="text/javascript">
		getLovOfList("[PROD_UNIT,ORDER_ITEM_TYPE]");
		var headId = $("#orderId").val();
		var $orderEditForm = $("#orderEditForm");
		//headerInfoInit();orderCategory
		//限制期望发货日期
		$('#expectDate').datebox().datebox('calendar').calendar({
			validator: function(date){
				var now = new Date('${currentDate}');
				var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return today <= date;
			}
		});
		/* window.onresize=function(){  
			$itemdatagrid.datagrid('resize',{width:$(window).width() - 18});
        } */
		
		/**
		* 计算订单金额
		*/
		function countTotalCash(){
			$.post('${AppContext.ctxPath}/action/portal/saleorder/countTotalCash',{
				id:headId
			},
			function(data_){
				if(data_.success){
					$('#orderTotalAmount').textbox('setValue', currencyShowTool(data_.totalCash, "￥"));
				}	
			});
		}
		
		/**
		*应用政策接口
		*/
		function applyPolicy(){
			$.post('${AppContext.ctxPath}/action/portal/saleorder/applyPolicyOne', 
			{
				orderId:headId
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
				orderId:headId
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

		
		function updateAddr(acctId){
			$.post('${AppContext.ctxPath}/action/portal/saleorder/updateOrderAcctId', 
			{
				id:headId,
				acctId:acctId
		    },
			function(data){
		    	if(!data.success){
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
		function orderSave(){
			//if($itemdatagrid.datagrid('getData').rows.length < 1){
			//	$.messager.alert('警告','订单行不能为空，请选择产品。'); 
			//	return;
			//} 
			var rebateMoney = $('#rebateMoney').val()
			var cash = $('#cash').val()
			var freight = $('#freight').val()
			if (isNaN(rebateMoney)){
				alert('返利金额必须为数字格式！');
			}
			if (isNaN(cash)){
				alert('现金必须为数字格式！');
			}
			if (isNaN(freight)){
				alert('运费必须为数字格式！');
			}
			$.post('${AppContext.ctxPath}/action/portal/saleorder/upsert', 
			{
				row_status			: $("#row_status").val(), //'${saleOrder.row_status}',
				id					: headId,
				orderNo				: $("#orderNo").val(), //'${saleOrder.orderNo}',
				//orderType			: $("#orderType").val(), //'${saleOrder.orderTypeLovType}',
				orderType			: $('#orderType').textbox('getValue'),
				acctId				: $('#acctId').val(),
				addrId				: $('#addrId').val(),
				expectDate			: $('#expectDate').datebox('getValue'),
				comments			: $('#comments').textbox('getValue'),
				orgId				: $('#orgId').val(),
				postnId				: $('#postnId').val(),
				currency			: $('#currency').textbox('getValue'),
				orderCategory		: $('#orderCategory').combobox('getValue'),
				payStatus			: $('#payStatus').combobox('getValue'),
				status				: $('#status').combobox('getValue'),
				payType				: $('#payType').combobox('getValue'),
				priceListId			: $('#priceListId').val(),
				deliverType 		: $('#deliverType').combobox('getValue'),	//送货方式：商家配送、自提
				rebateMoney			: $('#rebateMoney').val(),
				cash				: $('#cash').val(),
				freight				: $('#freight').val(),
				province			: $('#province').combobox('getValue'),
				city				: $('#city').combobox('getValue'),
				district			: $('#district').combobox('getValue'),
				customAddr			: $('#customAddr').val(),
				customConsignee		: $('#customConsignee').val(),
				customMobilePhone	: $('#customMobilePhone').val(),
				logisticsCompany	: $('#logisticsCompany').combobox('getValue'),
				logisticsNo			: $('#logisticsNo').val(),
				optyId				: $('#optyId').val()
		    },
			function(data){
		    	if(!data.success){
					window.parent.operationtip(data.result, 'error');
				}else{
					//window.parent.operationtip('提交成功！<br>该单的CRM编号为：${saleOrder.orderNo}', 'info');
					//gotoContentPage('${AppContext.ctxPath}/portal/order/SaleOrderList.jsp');
					window.parent.editWinClose($("#row_status").val(), data.newRow);
					var orderRow = {id:headId};
					if($('#status').combobox('getValue')!="New"){
						window.parent.cumulateSale("add",orderRow);
					}
					
				}
			});
		}
		
		
		/**
		 * 根据客户地址ID查询当前的地址信息
		 * 并且设置收货联系人和电话
		 */
		function setContactInput(acctAddressId){
			$.post('${AppContext.ctxPath}/action/portal/acctaddress/queryByExamplePage',{
				id		   : acctAddressId,
				pageFlag: false,
				filtersRaw : '[{"id":"id","property":"id","value":"'+acctAddressId+'"}]'
			},function(data){
				if(data.success){
					var acctAddress = data.rows[0];//acctAddress;
					if(acctAddress){
						$('#province').combobox('setValue',acctAddress.province);
						$('#city').combobox('setValue',acctAddress.city);
						$('#district').combobox('setValue',acctAddress.district);
						$('#customAddr').textbox('setValue',acctAddress.addr);
						$('#customConsignee').textbox('setValue',acctAddress.consignee);
						var contactTelValue = '';
						if(acctAddress.fixedPhone == null || acctAddress.mobilePhone == null){
							contactTelValue = (acctAddress.fixedPhone == null ? '':acctAddress.fixedPhone) + 
											  (acctAddress.mobilePhone == null ? '':acctAddress.mobilePhone);
							$('#customMobilePhone').textbox('setValue',contactTelValue);
						} else {
							contactTelValue = acctAddress.fixedPhone + '/' +acctAddress.mobilePhone;
							$('#customMobilePhone').textbox('setValue',contactTelValue);
						}
					}else{
						window.parent.operationtip("查询地址无数据", 'error');
					}
				} else {
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
		
		$.extend($.fn.validatebox.defaults.rules, {
			integer: {
				validator: function(value, param){
					return /^[+]?[1-9]+\d*$/i.test(value);
				},
				message: '请输入正整数'
		    }
		});
		$acctPickList = $("#acctName");
		$acctPickList.picklist({
			title:'客户列表',
			required:true,
			completeFun:function(selectRow){
				if(selectRow){
					$('#acctName').textbox('setValue', selectRow.acctName);
					$('#acctId').val(selectRow.id);
					$('#orgName').textbox('setValue', selectRow.orgName);
					$('#orgId').val(selectRow.orgId);
					$('#priceListName').textbox('setValue', selectRow.priceListName);
					$('#priceListId').val(selectRow.priceListId);
					$('#postnId').val(selectRow.postnId);
					$('#postnName').textbox('setValue', selectRow.postnName);
					$('#currency').textbox('setValue', selectRow.currency);
					$('#fullAddr').combobox('options').url = '${AppContext.ctxPath}/action/portal/acctaddress/queryByExamplePage';
					$('#fullAddr').combobox({
						onBeforeLoad: function(param){
							  param.pageFlag = false;
							  param.filtersRaw = '[{"id":"acctId","property":"acctId","value":"'+selectRow.id+'"},{"id":"addrTypeCode","property":"addrTypeCode","value":"RECEIVE_ADDR"}]'; 
							
						},
						loadFilter:function(data){
						  	 return data.rows
						},onSelect:function(record){
							$('#addrId').val(record.id);
							setContactInput(record.id);
						},onLoadSuccess:function(data){
							if(data != '' && data.length > 0){
								$('#contact').textbox('setValue','');
								$('#contactTel').textbox('setValue','');
							}else{
								if(selectRow.orgId == null){
									$.messager.alert("提示","该客户未维护组织及收货地址！");
								}else{
									$.messager.alert('提示','该客户未维护收货地址！');
								}
								
							}
						}
					});
					
					/* if(selectRow.orgId == null){
						$.messager.alert("提示","该客户未维护组织！");
					} */
					//$itemdatagrid.datagrid('reload');
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'
		});
		$pricePickList = $("#priceListName");
		$pricePickList.picklist({
			title:'选择价格列表',
			required:true,
			completeFun:function(selectRow){
				if(selectRow){
					$('#priceListId').val(selectRow.id);
					return selectRow.priceListName;
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/priceListPickList.jsp'
		});
		
		$optyPickList = $("#optyName");
		$optyPickList.picklist({
			title:'商机列表',
			required:false,
			completeFun:function(selectRow){
				if(selectRow){
					$('#optyName').textbox('setValue', selectRow.optyName);
					$('#optyId').val(selectRow.id);
					
					//$itemdatagrid.datagrid('reload');
				}
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/optyPickList.jsp'
		});
		
		function goBack(){
			//gotoContentPage('${AppContext.ctxPath}/portal/order/SaleOrderList.jsp');
			window.parent.editWinClose("CANCEL");
	    }
		/**
		 * 初始化数据
		 */
		 function initInfo(id, order){
			if(id){
				$.post('${AppContext.ctxPath}/action/portal/saleorder/queryById', 
						{
							id	: id
					    },
						function(data){
					    	if(data.success){
					    		var obj = data.result;
					    		if(!obj.row_status){
					    			obj.row_status = 'UPDATE';//设为更新状态
					    		}
					    		fillData(obj);
							}else if(data.result){
								$.messager.alert('错误',data.result, "error");
							}else{
								$.messager.alert("错误", "加载数据出错啦!", "error");
							}
						});
			}else if(order){
				var obj = order;
				if(!obj.row_status){
					$.messager.alert("错误", "加载数据出错啦!<br>无法识别当前为更新或新建状态", "error");
					return;
				}
	    		fillData(obj);
			}else{
				$.messager.alert("错误", "加载数据出错啦!<br>请传入正确参数", "error");
			}
		}
		/**
		* 填充数据
		*/
		function fillData(obj){
			$orderEditForm.form("load", obj);
			//$('#status').combobox({url:'${AppContext.ctxPath}/action/portal/basic/list/ORDER_STATUS_CATEGORY'})
			//$('#status').combobox('setValue',obj.status);
			headId = $("#orderId").val();
			//$itemdatagrid.datagrid("reload");
			$('#orderType').combobox('setValue', obj.orderType);
			$('#prodMvgHl').empty();
			$('#prodMvgHl').append('<input id="prodMvg"/>');

			$('#fullAddr').combobox('options').url = '${AppContext.ctxPath}/action/portal/acctaddress/queryByExamplePage';
			$('#fullAddr').combobox({
				onBeforeLoad: function(param){
					  param.pageFlag = false;
					  param.filtersRaw = '[{"id":"acctId","property":"acctId","value":"'+obj.acctId+'"},{"id":"addrTypeCode","property":"addrTypeCode","value":"RECEIVE_ADDR"}]'; 
					
				},
				loadFilter:function(data){
				  	 return data.rows
				},onSelect:function(record){
					$('#addrId').val(record.id);
					setContactInput(record.id);
				},onLoadSuccess:function(data){
					if(data != '' && data.length > 0){
						$('#contact').textbox('setValue','');
						$('#contactTel').textbox('setValue','');
					}else{
						if(selectRow.orgId == null){
							$.messager.alert("提示","该客户未维护组织及收货地址！");
						}else{
							$.messager.alert('提示','该客户未维护收货地址！');
						}
						
					}
				}
			});
			$('#fullAddr').combobox("setValue", obj.fullAddr);
		}
		
		function defaultCurrencyFormatter(val,row)
		{
			var result = '';
			if(val == null){
				if($('#currency') && $('#currency').textbox('getValue')){
					result = $('#currency').textbox('getValue')
				} else {
					result =  '人民币';
				}
			} else {
				result = val;
			}
			return result;
		}
		
		/* ----------------产品MVG操作 start-------------------------------------------- */
		function prodLeftMvgPickParam(){
			return {attr1:headId,attr2:$('#priceListId').val()};
		}
		function prodRightMvgPickParam(){
			return {headId:headId};
		}
		function prodMvgComplete(row){
			//$itemdatagrid.hdatagrid('reload');
		}
		function openMvg(){
			var $prodMvg = $('#prodMvg');
			$prodMvg.mvgPick({
				title:'选择产品',
				completeFun:prodMvgComplete,
				optionsLeft:{
					tableUrl:'${AppContext.ctxPath}/portal/order/mvgPick/ProdLeftMvgPick.jsp',
					url:'${AppContext.ctxPath}/action/portal/product/prodOrderlist',
					initParam:prodLeftMvgPickParam
				},
				optionsRight:{
					tableUrl:'${AppContext.ctxPath}/portal/order/mvgPick/ProdRightMvgPick.jsp',
					url:'${AppContext.ctxPath}/action/portal/saleorderitem/queryByExamplePage',
					initParam:prodRightMvgPickParam,
					radio:false,//不显示单选框列
					updateable:true,
					singleSelect:true,
					onUpdateAction:function(row,successFun,errFun,that) {
						$.post('${AppContext.ctxPath}/action/portal/saleorderitem/qtyUpdate',{
							id		: row.id,
							qty		: row.qty
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that,data);
							}
						});
					}
				},
				insertOptions:{url:'${AppContext.ctxPath}/action/portal/saleorderitem/batchInsert',
					param:{
							headId		 : headId,
							qty			 : '1.0',
							prodId		 : 'MVG_ROW.id',
							basePrice		 : 'MVG_ROW.price',
							promotionPrice	 : 'MVG_ROW.promoPrice',
							itemType	 : 'Common Item'
				}},//param中的'MVG_ROW' 为mvg的选中行
				deleteOptions:{url:'${AppContext.ctxPath}/action/portal/saleorderitem/batchDelete',
					param:{
						id	: 'MVG_ROW.id'
				}},//param中的'MVG_ROW' 为mvg的选中行
				deleteAllOptions:false  //不显示【删除所有】按钮
			});
			//$prodMvg.textbox('options').icons[0].handler();
		}
		/* ----------------产品MVG操作 end-------------------------------------------- */
	$provinceRegisterCombobox	= $('#province');
	$cityRegisterCombobox	 	= $('#city');
	$districtRegisterCombobox	= $('#district');
	/**
	 * 省市县 下拉框选择控件
	 */
	 $provinceRegisterCombobox.combobox({
			url : '${AppContext.ctxPath}/action/portal/address/provinceList',
			valueField : 'addrName',
			textField : 'addrName',
			editable : false, //不可编辑状态
			cache : false,
			onSelect : function() {
				var province = $provinceRegisterCombobox.combobox('getValue');
				$(".province-combobox").each(function(index, element){
					if(!$(element).combobox('getValue')){
						$(element).combobox('select', province);
					}
				});
				$cityCombobox	 = $provinceRegisterCombobox.closest("fieldset").find(".city-combobox");
				$districtCombobox  = $cityCombobox.closest("fieldset").find(".district-combobox");
				$cityCombobox.combobox("setValue", '');
				$districtCombobox.combobox("setValue", '');
				
				/* if(!$(".province-combobox").combobox('getValue')){
					$(".province-combobox").combobox('select', province);
				} */
				if (province != '') {
					loadAddrPstAjax(encodeURI("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + province+"&addrType=City"), $cityCombobox);
				}
			},
			onLoadSuccess: function () { 
			}
		});
	 
	 $cityRegisterCombobox.combobox({
			editable : false, //不可编辑状态
			cache : false,
			valueField : 'addrName',
			textField : 'addrName',
			onSelect : function() {
				var province = $provinceRegisterCombobox.combobox('getValue');
				//var province = $cityCombobox.closest("fieldset").find(".province-combobox").combobox('getValue');
				var city = $cityRegisterCombobox.combobox('getValue');
				$(".city-combobox").each(function(index, element){
					if( !$(element).combobox('getValue')){
						if($(element).closest("fieldset").find(".province-combobox").combobox('getValue') == province){
							$(element).combobox('select', city);
							$districtCombobox  = $(element).closest("fieldset").find(".district-combobox");
							loadAddrPstAjax(encodeURI("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + city+"&addrType=County"), $districtCombobox);
						}
					}
				});
				$districtCombobox  = $cityRegisterCombobox.closest("fieldset").find(".district-combobox");
				$districtCombobox.combobox("setValue", '');
				if (city != '') {
					loadAddrPstAjax(encodeURI("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + city+"&addrType=County"), $districtCombobox);
				}
			}
		});

	 $districtRegisterCombobox.combobox({
			editable : false, //不可编辑状态
			cache : false,
			valueField : 'addrName',
			textField : 'addrName',
			onSelect : function() {
				var city = $cityRegisterCombobox.combobox('getValue');
				var district = $districtRegisterCombobox.combobox('getValue');
				$(".district-combobox").each(function(index, element){
					if( !$(element).combobox('getValue')){
						if($(element).closest("fieldset").find(".city-combobox").combobox('getValue') == city){
							$(element).combobox('select', district);
						}
					}
				});
				/* if(!$('#address').val()){
					var address = $provinceRegisterCombobox.combobox('getText') + $cityRegisterCombobox.combobox('getText') + $districtRegisterCombobox.combobox('getText');
					$('#address').val(address);
				} */
			}
		});
	/**
	 * 异步加载级联地址数据
	 */
	function loadAddrPstAjax(url, nextObjCombobox){
		$.ajax({
			type : "POST",
			url : url,
			cache : false,
			dataType : "json",
			success : function(data) {
				if(nextObjCombobox != null){
					nextObjCombobox.combobox("loadData", data);
				}
			}
		});
	}
	
	
	</script>
</body>
</html>