<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <table id="mess-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="orderNumber" width=15% editor="{type:'combobox',options:{
																		valueField:'orderNumber',
																		textField:'orderNumber',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/goodsSuit/queryOrderPkAll',
																		editable:false,
																		onSelect:selectedOrder,}}">订单号</th>
				<th field="customerName" width=15% editor="{type:'combobox',options:{
																		valueField:'customerName',
																		textField:'customerName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/goodsSuit/queryCustomerPkAll',
																		editable:false,
																		onSelect:selectedCustomer,
																		required:true }}">消费者名称</th>
				<th field="merchRate" width=15% lov="TB_O2O_APPRAISE_RATE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_APPRAISE_RATE'),
																		editable:false}}">商品评级</th>
				<th field="context" width=15% editor="{type:'textbox'}">具体评价内容</th>
				<th field="isPositive" width=15% editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否正面评价</th>
				<th field="type" width=20% lov="TB_O2O_EVALU_LBL_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_EVALU_LBL_TYPE'),
																		editable:false}}">类型</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	    $datagrid = $('#mess-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:true,
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/goodsMess/queryByExamplePage',
			onBeforeLoad:function(param){
				if(!goodsId){
		    		param.merchId = "noMatchId";
		    	}else{
		    		param.merchId=goodsId;
		    	}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				if(row.row_status == 'NEW'){
					row.merchId=goodsId;
				}
				$.post("${AppContext.ctxPath}/action/portal/goodsMess/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsMess/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			onInitNewData:function(that){
				return {
					type : 'Product Evaluate'
				};
			},
		});
		
		/* //选择省份
		function selectedProvince(selectRow){
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.areaName;
			$datagrid.hdatagrid('getCurrentRow').city = '';
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').provinceId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').cityId = '';
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('setValue','');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
			
		} */
		
		function selectedOrder(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orderId = selectRow.id;
		}
		
		function selectedCustomer(selectRow){
			$datagrid.hdatagrid('getCurrentRow').customerId = selectRow.id;
		}
		
	</script>
</body>
</html>