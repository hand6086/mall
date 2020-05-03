<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css"></style>

<body>		
	<div id="menu_layout"  class="easyui-layout" border="false" fit="true">
   		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<table id="deposit-table"  singleSelect="true" rownumbers="true"  pagination="true" style="width:98%;height:347px;">
				<thead>
				<tr>
				<th field="id" defaultSearch="false" width="100px">网店编码</th>
				<th field="name" width="200px"  editor="{type:'validatebox',options:{required:true}}"  >网店名称</th>
				<th field="enterpriseStatus"   width="100px" lov="ENTERPRISE_STATUS"editor="{type:'textbox',options:{	valueField:'val',
															textField:'name',
															data:getLovArray('ENTERPRISE_STATUS'),
															editable:false}}">网店状态</th>
				<th field="mainProductCategory"   width="100px" lov="MAIN_PRODUCTS"editor="{type:'textbox',options:{	valueField:'val',
															textField:'name',
															data:getLovArray('MAIN_PRODUCTS'),
															editable:false}}">主营产品类目</th>
				<th field="transferCode"   width="100px" >转账验证码</th>
				<th field="depositPayable" width="130px" editor="{type:'validatebox',options:{required:true}}">应付店铺押金</th>
				<th field="depositPaid" defaultSearch="false"  width="120px" editor="{type:'textbox',options:{required:false}}"  >已付店铺押金</th>
				<th field="activityDeposit"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >已付活动押金</th>
				<th field="totalDeposit"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >平台押金合计</th>
				</tr>
			</thead>
		</table>
		<table id="deposit-table-record" title="押金明细记录" style="width:98%;height:347px;">
			<thead>
				<tr>
				<th field="sourceCode" width="18%" editor="{type:'textbox', options:{required:true}}">来源编号</th>
				<th field="sourceType" width="18%" editor="{type:'textbox',options:{required:false}}">来源方式</th>
				<th field="money" width="18%" editor="{type:'numberbox',options:{required:true}}">金额</th>
				<th field="paymentTime" width="18%" editor="{type:'datebox',options:{showSeconds:false}}">时间</th>
				<th field="remarks"  width="18%" editor="{type:'textbox',options:{required:false}}">备注</th>
				</tr>
			</thead>
		</table>
		</div>
	</div> 
	<script type="text/javascript">
		$('.easyui-layout').layout();
		$datagrid = $('#deposit-table');
		$dataItemgrid = $('#deposit-table-record');
		
		var initId = getUrlParams("id");
		
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true, //显示工具栏
					buttonSearch : true, //搜索框功能
					//buttonExport : true,
					//buttonDelete :true,
					//buttonCopy : false,
					buttonMenu : true,
					//buttonNew : true,
					oauthFlag : true,
					menuButtonCount : true,
					striped : true,
					title : '',
					border : false,
					pageSize: 10,//每页显示的记录条数，默认为10 
				    pageList: [5,10,15],//可以设置每页记录条数的列表 
				    url:'${AppContext.ctxPath}/action/portal/enterprise/queryByExamplePage',
					subGridIds: ['deposit-table-record'],					
		 			
					onBeforeLoad:function(param){
						if(initId != '' && initId != null && typeof(initId) != 'undefined'){
							param.id = initId;
						}
					},
					
					onLoadSuccess: function (data) {
						if(initId != '' && initId != null && typeof(initId) != 'undefined'){
							initId = '';
						}
			        },
					
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="receiveDeposit()" iconCls="icon-undo" plain="true">押金到账</a>',that);
		 			}, 
					onUpdateAction : function(row, successFun, errFun, that) {
						$.post('${AppContext.ctxPath}/action/portal/enterprise/update',
						row, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
								}
							});
					},
				});

		$dataItemgrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					buttonDelete : true,
					//pagination:false,//是否分页
					parentGridId : 'deposit-table',
					parentGridField : 'id',
					linkGridField : 'entpId',
					url : '${AppContext.ctxPath}/action/portal/enterprise/queryDepositDetailsPage',
					pageSize : 10,//每页显示的记录条数，默认为10 
					pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表 

					onInsertAction : function(row, successFun, errFun, that) {
						//获取头的row_id
						row.entpId = $datagrid.hdatagrid('getCurrentRow').id;
						$.post('${AppContext.ctxPath}/action/portal/enterprise/depositDetailsInsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												$datagrid.datagrid('reload');
											}
										});
					},
					
					
					onDeleteAction : function(row, successFun, errFun, that) {
						//获取头的row_id
						row.entpId = $datagrid.hdatagrid('getCurrentRow').id;
						$.post('${AppContext.ctxPath}/action/portal/enterprise/depositDetailsDelete',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
												$datagrid.datagrid('reload');
											}
										});
					},
				});
		
		//押金支付
		function receiveDeposit(){
			var userId =$datagrid.hdatagrid('getCurrentRow').userId;
			$.post("${AppContext.ctxPath}/action/portal/enterprise/storeStatusPayUpdate",{userId:userId},
					function(data){
						if(data){
							if(data.success){
								window.parent.operationtip('操作成功！','info');
							}
						}
			});
		}
	</script>
</body>
</html>