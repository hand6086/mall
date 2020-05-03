<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
          .td-label{
				text-align:right;
				height:30px;
				width:120px;
             }
</style>

<body>
        <form id="headForm" method="post">
        <fieldset>
		 	<legend>订单信息</legend>
			<table id="flow-info-table" style="width:100%; padding:0px;" >
				<tr>
					<td class="td-label" ><label>客户名称 :</label></td>
					<td class="td-input">
						<input id="acctName" name="acctName" disabled style="width: 150px ! important;" editable="false"  />
	         			<input id="acctId" type="hidden"></input>
					</td>
					
					<td class="td-label"><label>收货地址 :</label></td>
					<td class="td-input">
						 <input id="addrId"  disabled name="addrId" type="hidden"/>
	         			 <input id="addr"  disabled name="addr" style="width: 150px ! important;" class="easyui-combobox td-input-input" />
					</td>
					
					<td class="td-label"><label>期望发货日期 :</label></td>
					<td class="td-input">
						<input id="expectDate" name="expectDate" disabled  style="width: 150px ! important;" class="easyui-datebox td-input-input" data-options="editable:false" >
					</td>
				</tr>
         		
				<tr>
					<td class="td-label"><label>支付方式 :</label></td>
					<td class="td-input">
	         			<input id="payType" name="payType" disabled style="width: 150px ! important;" class="easyui-combobox td-input-input"  />
					</td>
					
					<td class="td-label"><label>收货联系人 :</label></td>
					<td class="td-input">
						<input id="consignee" name="consignee" class="easyui-textbox td-input-input" disabled/>
					</td>
					
					<td class="td-label"><label>制单人 :</label></td>
					<td class="td-input">
						<input id="createdByName" name="createdByName" class="easyui-textbox td-input-input" disabled />
					</td>
				</tr>
				
				<tr>
					<td class="td-label"><label>订单类型 :</label></td>
					<td class="td-input">
						<input id="orderType" name="orderType" disabled style="width: 150px ! important;" class="easyui-combobox td-input-input"  data-options="editable:false,valueField:'id',textField: 'text',url:''">
						<input id="isFlag" type="hidden" ></input>
					</td>
					
					<td class="td-label"><label>收货电话 :</label></td>
					<td class="td-input">
						<input id="mobilePhone" name="mobilePhone" disabled class="easyui-textbox td-input-input" data-options="editable:false" />
					</td>
					
					<td class="td-label" rowspan="2"><label>备注 :</label></td>
					<td width="100" rowspan="2" class="td-input">
						<input id="comments" name="comments" disabled class="easyui-textbox td-input-input" data-options="multiline:true" 
							 style="height:60px;" />
					</td>
	         	</tr>
	         	<tr>
	         		<td class="td-label"><label>组织 :</label></td>
					<td class="td-input">
						<input id="orgId" name="orgId" type="hidden" />
         				<input id="orgName" name="orgName"  disabled class="easyui-textbox td-input-input" data-options="editable:false" />
					</td>
					
	         		<td class="td-label"><label>订单金额 :</label></td>
					<td class="td-input">
						<input id="orderTotalAmount" name="orderTotalAmount" disabled class="easyui-textbox td-input-input" type="text"/>
					</td>
	         	</tr>
			</table> 
	</fieldset>
	</form>
	   <div style="overflow:hidden;padding:5px;height:250px;">
		<table id="sale-order-item-table" >
			<thead>
				<tr>
					<th field="crmLineNo" width="50px" sortable="true">行号</th>
					<th field="prodCode" width="100px" sortable="true">产品编号</th>
					<th field="prodName" width="150px">产品名称</th>
					<th field="prodUnit" lov="PROD_UNIT" width="50px" sortable="true">单位</th>
					<th field="currency" width="50px" lov="CURRENCY" sortable="true">货币</th>
					<th field="qty" width="70px" sortable="true">数量</th>
					<th field="price" width="100px" sortable="true">价格</th>
					<th field="amount" width="100px" sortable="true">金额</th>
					<th field="comments" width="200px">备注</th>
				</tr>
			</thead>
		</table>
	  </div>
<script type="text/javascript">
	getLovOfList("[PROD_UNIT,CURRENCY]");
	var $headForm = $('#headForm');
	$("#acctName").picklist({
		title:'选择客户',
		completeFun:function(selectedRow){},
		tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp'
	});
	
	//订单头信息
	var saleOrder = {};
	var sflowObjId = "noMatchId";	      //订单ID
	sflowObjId = parent.sflowObjId;
	$.post("${AppContext.ctxPath}/action/portal/saleorder/queryById", {
		id : sflowObjId
	}, function(data){
		if(data.success){
			saleOrder = data.result;
			$headForm.form("load", saleOrder);
			$('#orderType').combobox('setValue',getLovShowName("ORDER_TYPE", saleOrder.orderType));
			$('#payType').combobox('setValue',getLovShowName("PAY_TYPE", saleOrder.payType));
			/* return;
			$('#acctName').textbox('setValue',saleOrder.acctName);
		    $('#addr').combobox('setValue',saleOrder.addr);
		    $('#expectDate').datebox('setValue',saleOrder.expectDate);
		    $('#payType').combobox('setValue',saleOrder.payType);
		    $('#consignee').textbox('setValue',saleOrder.consignee);
		    $('#createdByName').textbox('setValue',saleOrder.createdByName);
		    $('#orderType').combobox('setValue',saleOrder.orderType);
		    $('#mobilePhone').textbox('setValue',saleOrder.mobilePhone);
		    $('#comments').textbox('setValue',saleOrder.comments);
		    $('#orgName').textbox('setValue',saleOrder.orgName); */
		  //  $('#orderTotalAmount').textbox('setValue',saleOrder.orderTotalAmount); 
		}else{
			$.messager.alert("警告",data.result);
		}
	});
	

	$itemdatagrid = $('#sale-order-item-table');
	$itemdatagrid.hdatagrid({
		title:"订单行信息",
		toolbarShow:true,
		buttonSearch:true,
		striped:true,
		border:false,
		width:$(window).width() - 18,
		height:'100%',
		width:'100%',
	    pageSize: 5,//每页显示的记录条数，默认为20 
	    pageList: [5,5,15],//可以设置每页记录条数的列表 
	    url:'${AppContext.ctxPath}/action/portal/saleorderitem/queryByExamplePage',
		onBeforeLoad:function(param){
			param.headId = sflowObjId
		},
		onLoadSuccess:function(data){
			getTotalAmount();
	    }
	});
	
	/**
	 * 计算订单总金额
	 */
	function getTotalAmount(){
		$.post('${AppContext.ctxPath}/action/portal/saleorder/queryTotalAmount',{
			id		: saleOrder.id
		},function(data){
			if(data.success){
				$('#orderTotalAmount').textbox('setValue', data.amount);
			} else {
				window.parent.operationtip(data.result, 'error');
			}
		});
	}
</script>
</body>
</html>