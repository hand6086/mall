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
			<table id="storeInfo-table"  singleSelect="true" rownumbers="true"  pagination="true" style="width:100%;height:100%;">
				<thead>
				<tr>
				<th field="id" defaultSearch="false" width="100px">网店编码</th>
				<th field="storeName" width="200px"  editor="{type:'validatebox',options:{required:true}}"  >网店名称</th>
				<th field="name" width="200px"  editor="{type:'validatebox',options:{required:true}}"  >企业名称名称</th>
				<th field="enterpriseStatus"   width="100px" lov="ENTERPRISE_STATUS"editor="{type:'textbox',options:{	valueField:'val',
															textField:'name',
															data:getLovArray('ENTERPRISE_STATUS'),
															editable:false}}">网店状态</th>
				<th field="applicantName"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >店铺管理员</th>
				<th field="applicantPhone"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >管理员手机</th>
				<th field="applicantMailbox"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >管理员邮箱</th>
				<th field="mainProductCategory"   width="100px" lov="MAIN_PRODUCTS"editor="{type:'textbox',options:{	valueField:'val',
															textField:'name',
															data:getLovArray('MAIN_PRODUCTS'),
															editable:false}}">主营产品类目</th>
				<!-- <th field="servChargePro"width="100px" editor="{type:'numberbox',options:{required:false}}">手续费比例 </th>
				<th field="salesNum" width="130px" editor="{type:'numberbox',options:{required:true}}">累计总销量</th>
				<th field="userName" width="130px" editor="{type:'numberbox',options:{required:true}}">月均销量</th>
				<th field="sales" width="130px" editor="{type:'numberbox',options:{required:true}}">累计总销售额</th>
				<th field="userName" width="130px" editor="{type:'numberbox',options:{required:true}}">月均销售额</th> 
				<th field="paymentTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">注册日期</th>
				-->
				<th field="totalDeposit" defaultSearch="false"  width="120px" editor="{type:'textbox',options:{required:false}}">店铺保证金</th>
				<th field="appDutyName" defaultSearch="false"  width="120px" editor="{type:'textbox',options:{required:false}}">网店收货地址</th>
				<th field="storeLogo" width="100px" editor="{type:'textbox',options:{showSeconds:false}}">店铺Logo</th>
				<th field="storeDetails" width="100px" editor="{type:'textbox',options:{showSeconds:false}}">店铺介绍</th>
				</tr>
			</thead>
		</table>
		</div>
	</div> 
	<script type="text/javascript">
		$('.easyui-layout').layout();
		$datagrid = $('#storeInfo-table');
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

	</script>
</body>
</html>