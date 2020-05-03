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
						<th field="crmLineNo" width="50px">行号</th>
						<th field="prodCode" width="100px">产品编号</th>
						<th field="prodName" width="150px">产品名称</th>
						<th field="itemType" lov="ORDER_ITEM_TYPE" width="150px">行类型</th>
						<th field="policyDesc" width="150px">政策优惠说明</th>
						<th field="prodUnit" lov="PROD_UNIT" width="50px">单位</th>
						<th field="currency" width="80px" formatter="defaultCurrencyFormatter">货币</th>
						<th field="qty" width="70px" editor="{type:'numberspinner',options:{
																min:0,
																validType:'integer',
																required:true}}">数量</th>
						<th field="basePrice" width="100px" currency="CNY" 
														editor="{type:'numberspinner',options:{
																min:0,
																validType:'integer',
																required:true}}">原价</th>
						<th field="promotionPrice" width="100px" currency="CNY" 
														editor="{type:'numberspinner',options:{
																min:0,
																validType:'integer',
																required:true}}">促销价</th>
						<th field="discount" width="100px" editor="{type:'numberspinner',options:{
																precision:2,
																max:1,
																increment:0.01,
																min:0}}">折扣比率</th>
						<th field="manualPrice" width="100px" currency="CNY" 
														editor="{type:'numberspinner',options:{
																min:0,
																validType:'integer'}}">手动调整</th>
						<th field="netPrice" width="100px" currency="CNY">实际价格</th>
						<th field="amount"  width="100px" currency="CNY">金额</th>
						<th field="comments" width="200px" editor="{type:'textbox'}">备注</th>
					</tr>
				</thead>
		</table>
	<script type="text/javascript">
		getLovOfList("[PROD_UNIT,ORDER_ITEM_TYPE]");
		var headId = $("#orderId").val();
		var $orderEditForm = $("#orderEditForm");
		//headerInfoInit();
		//限制期望发货日期
		$('#expectDate').datebox().datebox('calendar').calendar({
			validator: function(date){
				var now = new Date('${currentDate}');
				var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				return today <= date;
			}
		});
		window.onresize=function(){  
			$itemdatagrid.datagrid('resize',{width:$(window).width() - 18});
        }
		$itemdatagrid=$('#sale-order-item-table');
		$itemdatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			striped:true,
			border:false,
			buttonDelete:true,
			width:$(window).width() - 18,
			height:'60%',
			//title:'选择产品',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
		    url:'${AppContext.ctxPath}/action/portal/saleorderitem/queryByExamplePage',
			onBeforeLoad:function(param){
				param.headId = headId;
			},
			onUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/saleorderitem/update', {
					id			:row.id,
					qty			:row.qty,
					comments	:row.comments,
					basePrice	:row.basePrice,
					promotionPrice	:row.promotionPrice,
					discount	:row.discount,
					manualPrice	:row.manualPrice
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
						countTotalCash();
					}
				});
			},
			onDeleteAction: function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/saleorderitem/deleteById', {
					id			:row.id,
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
						countTotalCash();
					}
				});
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(-2,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openMvg()">新建</a>',that);
			},
			onLoadSuccess:function(data) {		
				countTotalCash();
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
				param.orderId = headId;
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(-2,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="applyPolicy()">应用政策</a>',that);
				addButtonFun(-1,'<a href="javascript:void(0)" id="btn_add_item" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="applyPolicyTwo()">校验政策</a>',that);
			}
		});
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
				orderId:headId
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
			if($itemdatagrid.datagrid('getData').rows.length < 1){
				$.messager.alert('警告','订单行不能为空，请选择产品。'); 
				return;
			}
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
				orderType				: $('#orderType').textbox('getValue'),
				acctId				: $('#acctId').val(),
				addrId				: $('#addrId').val(),
				expectDate			: $('#expectDate').datebox('getValue'),
				comments			: $('#comments').textbox('getValue'),
				orgId				: $('#orgId').val(),
				postnId				: $('#postnId').val(),
				currency			: $('#currency').textbox('getValue'),
				payType				: $('#payType').combobox('getValue'),
				orderCategory		: $('#orderCategory').combobox('getValue'),
				payStatus			: $('#payStatus').combobox('getValue'),
				status				: $('#status').combobox('getValue'),
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
					$itemdatagrid.datagrid('reload');
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
					
					$itemdatagrid.datagrid('reload');
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
			headId = $("#orderId").val();
			$itemdatagrid.datagrid("reload");
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
			$itemdatagrid.hdatagrid('reload');
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
			$prodMvg.textbox('options').icons[0].handler();
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