<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">


</style>
<body >
 <div id="menu_layout"  class="easyui-layout" border="false" fit="true">
   <div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
		
	<table id="chargeVerification-city-table" style="width:98%;height:370px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
				<th field="cityName" width="160px" sortable="true" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
				<th field="cityNotes" width="160px" sortable="true" editor="{type:'text'}">说明</th>
				
				<th field="cityId" noSearch="true" hidden="true" width="80px" sortable="true">城市id</th>
			</tr>
		</thead>
	</table>
	<table id="chargeVerification-chargeDate-table" style="width:98%;height:350px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
			 <th field="startDate" width="140px" sortable="true" editor="{type:'datetimebox',options:{required:true}}">开始日期</th>
			 <th field="endDate" width="140px" sortable="true" editor="{type:'datetimebox',options:{required:true}}">结束日期</th>
			 <th field="isGenerated" width="100px" sortable="true" lov="S_IF">是否生成批次</th>
			 
			 <th field="cityId" noSearch="true" hidden="true" width="80px" sortable="true">城市id</th>
			 <th field="id" width="80px" noSearch="true" hidden="true" sortable="true">rowId</th>
			</tr>
		</thead>
	</table>

	<table id="chargeVerification-chargeDetail-table" style="width:98%;height:390px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
			 <th field="ouNum" width="140px" sortable="true">商户编码</th>
			 <th field="name" width="140px" sortable="true">商户名称</th>
			 <th field="o2oContactPhone" width="140px" sortable="true">商户电话</th>
			 <th field="o2oAlipay" width="120px" sortable="true">支付宝账户</th>
			 <th field="o2oBank" width="120px" sortable="true">开户银行</th>
			 <th field="o2oAccontName" width="100px" sortable="true">开户人</th>
			 <th field="o2oCreditCard" width="100px" sortable="true">银行卡号</th>
			 <th field="tAttr04" width="80px" sortable="true">结算总金额</th>
			 <th field="status" width="80px" sortable="true" lov="TB_O2O_EXPENSE_STATUS"  editor="{type:'combobox',options:{valueField:'name',textField:'name',
																				method:'get',data:getLovArray('TB_O2O_EXPENSE_STATUS'),editable:false,required:true}}">状态</th>
			 
			 <th field="headId" width="80px" noSearch="true" hidden="true" sortable="true">headId</th>
			 <th field="id" width="80px" noSearch="true" hidden="true" sortable="true">rowId</th>
			</tr>
		</thead>
	</table>

	<table id="chargeVerification-chargeOrderDetail-table" style="width:98%;height:390px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
			 <th field="orderNum" width="130px" sortable="true">订单编号</th>
			 <th field="created" width="130px" sortable="true" mark="DATE">下单时间</th>
			 <th field="ouNum" width="130px" sortable="true">商户编码</th>
			 <th field="name" width="140px" sortable="true">商户名称</th>
			 <th field="attrib27" width="140px" sortable="true">接单时间</th>
			 <th field="attrib26" width="140px" sortable="true">付款时间</th>
			 <th field="attrib29" width="140px" sortable="true">收货时间</th>
			 <th field="attrib28" width="140px" sortable="true">配送时间</th>
			 <th field="xAttrib66" width="130px" sortable="true">费用核销确认时间</th>
			 <th field="sumCharge" width="130px" sortable="true">需核销费用总额</th>
			 
			 <th field="colSetLineId" noSearch="true" hidden="true" width="80px" sortable="true">lineId</th>
			</tr>
		</thead>
	</table>

	</div>
  </div>
	<script type="text/javascript">
		$datagrid = $('#chargeVerification-city-table');
		$chargeDatedatagrid = $('#chargeVerification-chargeDate-table');
		$chargeDetaildatagrid = $('#chargeVerification-chargeDetail-table');
		$chargeOrderDetaildatagrid = $('#chargeVerification-chargeOrderDetail-table');
		
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:false,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			title:'O2O城市',
			border:false,
			pageSize: 10, 
		    pageList: [10,20,50], 
			subGridIds: ['chargeVerification-chargeDate-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goodsCity/upsert",row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				})
			},
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsCity/deleteById', row, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							} else {
								successFun(that, data);
							}
						})
					}
				})
		    },
			onUpdateAction : function(row, successFun, errFun, that) {
				$.post('${AppContext.ctxPath}/action/portal/platformfavorable/updateCity', row, function(data) {
						if (!data.success) {
							errFun(data.result, that);
						} else {
							successFun(that, data);
						}
				})
			}
		});
		
		$chargeDatedatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:false,
			title:'',
			pageSize: 10, 
		    pageList: [10,20,50], 
			url:"${AppContext.ctxPath}/action/portal/charge/chargeVerification/queryChargeDatePage",
		    parentGridId : 'chargeVerification-city-table',
		    parentGridField : 'id',
		    linkGridField : 'cityId',
		    subGridIds: ['chargeVerification-chargeDetail-table'],
		    onAddMoreButton : function(that, addButtonFun) {
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setBatch()" iconCls="icon-ok" plain="true">生成批次</a>',that);
		    },
			onInitNewData:function(that){
				return {
					isGenerated : 'N'
				};
			},
			readOnlyCondition: function(row, that){
				if(row.isGenerated == 'Y'){
					return true;
				}
				return false;
			},
			onInsertAction : function(row,successFun,errFun,that){
				if(row.startDate > row.endDate){
					$.messager.alert('错误','开始时间不能大于结束时间!','error');
					return true;
				}
				row.cityId = $datagrid.hdatagrid('getCurrentRow').id;
 		    	$.post('${AppContext.ctxPath}/action/portal/charge/chargeVerification/insertDetail', row, function(data) {
 					if (!data.success) {
 						errFun(data.result,that);
 					}else{
 						successFun(that, data);
 					}
 				});
			},
			onUpdateAction : function(row,successFun,errFun,that){
				if(row.startDate > row.endDate){
					$.messager.alert('错误','开始时间不能大于结束时间!','error');
					return true;
				}
 		    	$.post('${AppContext.ctxPath}/action/portal/charge/chargeVerification/updateDetail', row, function(data) {
 					if (!data.success) {
 						errFun(data.result,that);
 					}else{
 						successFun(that, data);
 					}
 				});
			},
			onDeleteAction : function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/charge/chargeVerification/deleteDetailById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			}
		});
		function setBatch(){
			var row = $chargeDatedatagrid.datagrid('getSelected');
				if(row.isGenerated == 'Y'){
					window.parent.operationtip('无法生成批次', 'warning');
					return;
				}
				row.isGenerated = 'Y';
				$.post('${AppContext.ctxPath}/action/portal/charge/chargeVerification/updateDetail',row ,function(data){
					if(data.success){
						var index = $chargeDatedatagrid.hdatagrid('getRowIndex', row);
						$chargeDatedatagrid.hdatagrid("refreshRow", index);
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				});
		}
		
		$chargeDetaildatagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			title:'结算明细',
			pageSize: 10, 
		    pageList: [10,20,50], 
			url:"${AppContext.ctxPath}/action/portal/charge/chargeVerification/queryChargeDetailPage",
		    parentGridId : 'chargeVerification-chargeDate-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
		    subGridIds: ['chargeVerification-chargeOrderDetail-table'],
		});
		
		$chargeOrderDetaildatagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			title:'交易明细',
			pageSize: 10, 
		    pageList: [10,20,50], 
			url:"${AppContext.ctxPath}/action/portal/charge/chargeVerification/queryChargeOrderDetailPage",
		    parentGridId : 'chargeVerification-chargeDetail-table',
		    parentGridField : 'id',
		    linkGridField : 'expVrfLnId',
		});
		
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
	</script>
</body>
</html>