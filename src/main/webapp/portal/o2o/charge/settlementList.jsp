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
		
	<table id="settlement-city-table" style="width:98%;height:370px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
				<th field="cityName" width="20%" sortable="true" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
				<th field="cityNotes" width="77%" sortable="true" editor="{type:'text'}">说明</th>
				
			</tr>
		</thead>
	</table>
	<table id="settlement-detail-table" style="width:98%;height:370px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
			 <th field="startDate" width="160px" sortable="true" editor="{type:'datetimebox',options:{required:true}}">开始日期</th>
			 <th field="endDate" width="160px" sortable="true" editor="{type:'datetimebox',options:{required:true}}">结束日期</th>
			 <th field="isGenerated" width="100px" sortable="true" lov="S_IF">是否生成批次</th>
			 <th field="tAttr10" width="120px" sortable="true" lov="TB_O2O_COL_SET_STATUS">状态</th>
			 
			 <th field="cityId" noSearch="true" hidden="true" width="80px" sortable="true">城市id</th>
			 <th field="id" noSearch="true" hidden="true" width="80px" sortable="true">rowId</th>
			</tr>
		</thead>
	</table>

	<table id="settlement-subdetail-table" style="width:98%;height:390px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
			 <th field="ouNum" width="120px" sortable="true">商户编码</th>
			 <th field="name" width="120px" sortable="true">商户名称</th>
			 <th field="o2oContactPhone" width="100px" sortable="true">商户电话</th>
			 <th field="o2oAlipay" width="120px" sortable="true">支付宝账户</th>
			 <th field="o2oBank" width="120px" sortable="true" lov="TB_O2O_BANK">开户银行</th>
			 <th field="o2oAccontName" width="100px" sortable="true">开户人</th>
			 <th field="o2oCreditCard" width="130px" sortable="true">银行卡号</th>
			 <th field="tAttr04" width="80px" sortable="true">结算总金额</th>
			 <th field="settleTime" width="140px" sortable="true">结算时间</th>
			 <th field="status" width="80px" sortable="true" lov="TB_O2O_SETTLEMENT_STATUS"  editor="{options:{valueField:'val',textField:'name',
																				method:'get',data:getLovArray('TB_O2O_SETTLEMENT_STATUS'),editable:false,required:true}}">状态</th>
			 <th field="headId" noSearch="true" hidden="true" width="80px"  sortable="true">headId</th>
			 <th field="id" noSearch="true" hidden="true" width="80px" sortable="true">rowId</th>
			</tr>
		</thead>
	</table>

	<table id="settlement-sublinedetail-table" style="width:98%;height:390px;" singleSelect="true" rownumbers="true" pagination="true">
		<thead>
			<tr>
			 <th field="paymentNumber" width="130px" sortable="true">支付流水号</th>
			 <th field="paymentAcct" width="130px" sortable="true">支付账号</th>
			 <th field="receiveAcct" width="180px" sortable="true">收款账号</th>
			 <th field="amount" width="130px" sortable="true">交易金额</th>
			 <th field="tAttr01" width="130px" sortable="true" lov="TB_O2O_TRANSACTION_TYPE">交易类型</th>
			 <th field="type" width="130px" sortable="true" lov="TB_O2O_PAYMENT_TYPE">支付方式</th>
			 <th field="status" width="130px" sortable="true" lov="TB_O2O_PAYMENT_STATUS">支付状态</th>
			 <th field="orderNum" width="130px" sortable="true">订单编号</th>
			 <th field="created" width="130px" sortable="true">下单时间</th>
			 <th field="ouNum" width="130px" sortable="true">商户编码</th>
			 <th field="name" width="130px" sortable="true">商户名称</th>
			 <th field="attrib27" width="130px" sortable="true">接单时间</th>
			 <th field="attrib26" width="130px" sortable="true">付款时间</th>
			 <th field="attrib29" width="130px" sortable="true">收货时间</th>
			 <th field="attrib28" width="130px" sortable="true">配送时间</th>
			 <th field="attrib33" width="130px" sortable="true">结算时间</th>
			 <th field="attrib46" width="130px" sortable="true" lov="TB_O2O_SETTLEMENT_STATUS">结算状态</th>
			 
			 <th field="colSetLineId" noSearch="true" hidden="true" width="80px" sortable="true">lineId</th>
			</tr>
		</thead>
	</table>
   </div>
 </div>
	<script type="text/javascript">
		$datagrid = $('#settlement-city-table');
		$detaildatagrid = $('#settlement-detail-table');
		$subdetaildatagrid = $('#settlement-subdetail-table');
		$sublinedetaildatagrid = $('#settlement-sublinedetail-table');
		
		$sublinedetaildatagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			title:'交易明细',
			pageSize: 10, 
		    pageList: [10,20,50], 
			url:"${AppContext.ctxPath}/action/portal/charge/settlement/querySettlementSubDetailPage",
		    parentGridId : 'settlement-subdetail-table',
		    parentGridField : 'id',
		    linkGridField : 'colSetLineId',
		});
		
		$subdetaildatagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			title:'结算明细',
			pageSize: 10, 
		    pageList: [10,20,50], 
			url:"${AppContext.ctxPath}/action/portal/charge/settlement/querySettlementDetailPage",
		    parentGridId : 'settlement-detail-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
		    subGridIds: ['settlement-sublinedetail-table'],
		    onAddMoreButton : function(that, addButtonFun) {
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setSettlement(\'ok\')" iconCls="icon-ok" plain="true">结算</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="setSettlement(\'cancel\')" iconCls="icon-cancel" plain="true">取消结算</a>',that);
		    }
		});
		function setSettlement(param){
			var parnentRow = $detaildatagrid.datagrid('getSelected');
			var row = $subdetaildatagrid.datagrid('getSelected');
			if(param == 'ok'){
				if(!(row.status == 'No Settled' || row.status == '未结算')){
					window.parent.operationtip('该状态无法结算', 'warning');
					return;
				}
				parnentStatus = 'Being Settled';
				status = 'To Be Determined';
			} else if(param == 'cancel'){
				if(!(row.status == 'To Be Determined' || row.status == '已结算待确认')){
					window.parent.operationtip('该状态无法取消结算', 'warning');
					return;
				}
				parnentStatus = 'No Settled';
				status = 'No Settled';
			}
			if(row){
				row.status = status;
				$.post('${AppContext.ctxPath}/action/portal/charge/settlement/updateSubDetail',row ,function(data){
					if(data.success){
						var index = $subdetaildatagrid.hdatagrid('getRowIndex', row);
						row.settleTime = data.newRow.settleTime;//给被选中行的某个字段重新赋值(controller中updateSubDetail方法返回数据中的值)，再刷新
						$subdetaildatagrid.hdatagrid("refreshRow", index);
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				});
			} 
			if(parnentRow){
				parnentRow.tAttr10 = parnentStatus;
				$.post('${AppContext.ctxPath}/action/portal/charge/settlement/updateDetail', parnentRow ,function(data){
					if(data.success){
						var index = $detaildatagrid.hdatagrid('getRowIndex', parnentRow);
						$detaildatagrid.hdatagrid("refreshRow", index);
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				});
			}
		};
		
		$detaildatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:false,
			title:'',
			pageSize: 10, 
		    pageList: [10,20,50], 
			url:"${AppContext.ctxPath}/action/portal/charge/settlement/queryDetailPage",
		    parentGridId : 'settlement-city-table',
		    parentGridField : 'cityId',
		    linkGridField : 'cityId',
		    subGridIds: ['settlement-subdetail-table'],
			onInitNewData:function(that){
				return {
					isGenerated : 'N',
					tAttr10 : '未结算'
				};
			},
			readOnlyCondition: function(row, that){
				if(row.isGenerated != 'N'){
					return true;
				}
				return false;
			},
			onInsertAction :function(row,successFun,errFun,that) {
				if(row.startDate > row.endDate){
					$.messager.alert('错误','开始时间不能大于结束时间!','error');
					return true;
				}
		    	row.cityId = $datagrid.hdatagrid('getCurrentRow').cityId;
				$.post('${AppContext.ctxPath}/action/portal/charge/settlement/add', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onUpdateAction :function(row,successFun,errFun,that) {
				if(row.startDate > row.endDate){
					$.messager.alert('错误','开始时间不能大于结束时间!','error');
					return true;
				}
				//if(row.isGenerated == 'N'){ 
		    	row.cityId = $datagrid.hdatagrid('getCurrentRow').cityId;
		    	//row.id = $datagrid.hdatagrid('getCurrentRow').id;
				$.post('${AppContext.ctxPath}/action/portal/charge/settlement/updateDetail', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			 // } else{
				//  window.parent.operationtip('该状态可生成批次，无法修改', 'warning');
			  //}
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/charge/settlement/deleteDetailById', {
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
		
		$datagrid.hdatagrid({
			updateable:true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:false,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			pageSize: 10, 
		    pageList: [10,20,50],
			title:'O2O城市',
			border:false,
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
			subGridIds: ['settlement-detail-table'],
			onInsertAction : function(row,successFun,errFun,that){
 		    	$.post('${AppContext.ctxPath}/action/portal/charge/settlement/insertCity', row, function(data) {
 					if (!data.success) {
 						errFun(data.result,that);
 					}else{
 						successFun(that, data);
 					}
 				});
			},
			onUpdateAction: function(row,successFun,errFun,that){
 		    	$.post('${AppContext.ctxPath}/action/portal/charge/settlement/update', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/charge/settlement/deleteById', {
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

		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
	</script>
</body>
</html>