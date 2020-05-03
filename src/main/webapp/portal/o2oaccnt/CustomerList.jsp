<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:180px;
}
</style>

<body>		
 <!-- <div id="menu_layout" class="easyui-layout" border="false" fit="true">		
		<div data-options="region:'north',split:true" title="" border="false" fit="true"> -->
	<div id="menu_layout"  class="easyui-layout" border="false" fit="true">
   		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
	   		<fieldset class="x-fieldset" id="customKeyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速查询</span>
				</legend>
				<div class="row keyfilter-border">
					<table class="form-table">
					    <tr>
			   				<td class="td-label"><label>注册城市：</label></td>
							<td class="td-input">
								<input  class="easyui-picklistbox" name="city" type="text" id="city" size="25" />
							</td>
							
							<td class="td-label"><label>消费者名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="custmName" type="text" id="custmName" size="25" />
							</td>
							
							<td class="td-label"><label>消费者手机号：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="custmPhone" type="text" id="custmPhone" size="25" />
							</td>
			   			</tr>
					    <tr>
							<td class="td-label"><label>注册时间从：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="createdStart" type="text" id="createdStart" size="25" />
							</td>
							
							<td class="td-label"><label>注册时间到：</label></td>
							<td class="td-input">
								<input  class="easyui-datetimebox" name="createdEnd" type="text" id="createdEnd" size="25" />
							</td>
			   			</tr>
			   		</table>
			   	</div>
		   	</fieldset>
			<table id="customer-table"  singleSelect="true" rownumbers="true"  pagination="true" 
					style="width:98%;height:420px;" keyFilterDiv="customKeyFilter">
				<thead>
					<tr>
						<th field="custmId" width="80px">消费者编码</th>
						<th field="custmName" width="80px" editor="{type:'textbox', options:{required:true}}">姓名</th>
						<th field="custmPhone" width="100px" 
							editor="{type:'numberbox', options:{required:true}}">手机号</th>
						<%--是否活跃用户--%>
						<th field="isActiveUser" width="100px"lov="S_IF"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('S_IF'),
																editable:false}}">是否活跃用户</th>
						<th field="inviteCode" width="80px"editor="{type:'textbox', options:{required:false}}">邀请码</th>
						<th field="custmType" width="80px"lov="TB_O2O_ACCT_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																required:true,
																data:getLovArray('TB_O2O_ACCT_TYPE'),
																editable:false}}">类型</th>
						<th field="custmSource" width="100px" lov="TB_O2O_STORE_NAME"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_STORE_NAME'),
																editable:false}}">消费者来源</th>
						<th field="isEmployee" width="80px"lov="TB_O2O_JUDGE_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false}}">是否员工</th>
						<th field="isRegisted" width="100px"lov="S_IF"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('S_IF'),
																editable:false}}">是否APP注册</th>
						<th field="createdTime" width="140px" mark="DATE">注册时间</th>
						<th field="city" width="80px"editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:registerCityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/RegisterCityPickList.jsp'}}">注册城市</th>
						<th field="inviteName" width="80px">邀请人</th>
						<th field="invitePhone" width="100px">邀请人手机号</th>
						<th field="inviteCode2" width="80px">邀请人邀请码</th>
					</tr>
				</thead>
			</table>
			<table id="customer-table-invitee" title="被邀请人列表" style="width:98%;height:347px;"> 
				<thead>
					<tr>
						<th field="invitedPhone" width="20%">被邀请手机号</th>
						<th field="invitedTime" width="20%" mark="DATE">邀请时间</th>
						<th field="invitedStatus" width="20%" lov="INVITE_STATUS">邀请状态</th>
						<th field="invitedType" width="20%">邀请方式</th>
						<!-- <th field="inviterId" width="20%">邀请方式</th> -->
					</tr>
				</thead>
			</table>
		</div>
	</div> 
	<script type="text/javascript">
		var city = null;
		var custmName = null;
		var custmPhone = null;
		var createdStart = null;
		var createdEnd = null;
		$('.easyui-layout').layout();
		$datagrid = $('#customer-table');
		$dataItemgrid = $('#customer-table-invitee');
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true, //显示工具栏
					buttonSearch : false, //搜索框功能
					buttonExport : true,
					buttonCopy : false,
					buttonMenu : true,
					oauthFlag : true,
					menuButtonCount : true,
					striped : true,
					title : '',
					border : false,
					pageSize: 100,//每页显示的记录条数，默认为10 
				    pageList: [100,300,1000],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/customer/queryByExamplePage',
					subGridIds: ['customer-table-invitee'],		
					onBeforeLoad:function(param){
						if(city != null && city != ''){
				    		param.city = city;
						}
						if(custmName != null && custmName != ''){
				    		param.custmName = custmName;
						}
						if(custmPhone != null && custmPhone != ''){
				    		param.custmPhone = custmPhone;
						}
						if(createdStart != null && createdStart != ''){
				    		param.createdStart = createdStart;
						}
						if(createdEnd != null && createdEnd != ''){
				    		param.createdEnd = createdEnd;
						}
					},
		 			onInsertAction : function(row,successFun,errFun,that) {
					 $.post('${AppContext.ctxPath}/action/portal/customer/insert', row, function(data) {
					 if (!data.success) {
					 errFun(data.result,that);
					 }else{
					 successFun(that, data);
					 }
					 });
					 },
					 onUpdateAction : function(row,successFun,errFun,that) {
					 $.post('${AppContext.ctxPath}/action/portal/customer/update', row, function(data) {
					 if (!data.success) {
					 errFun(data.result,that);
					 }else{
					 successFun(that, data);
					 }
					 });
					 }, 
					/* onInsertOrUpdateAction:function(row,successFun,errFun,that){
						$.post('${AppContext.ctxPath}/action/portal/customer/upsert',row, 
						function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					}, */
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager.confirm("操作提示",'是否确定删除信息？',
						function(data) {
							if (data) {
								$.post('${AppContext.ctxPath}/action/portal/customer/deleteById',
								{id : row.id},
								function(data) {
									if (!data.success) {
										errFun(data.result,that);
									} else {successFun(that);
									}
									});
								}
							});
						},
						onInitNewData:function(){
							return{
								createdTime :appCtx.sysdate(),
								custmType : 'Customer'
							};
						},
						onAddMoreButton:function(that,addButtonFun){
			 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="custmSearch()" iconCls="icon-search" plain="true">查询</a>',that);
							addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="custmClean()" iconCls="icon-reload" plain="true">重置</a>',that);
						},
					});
		
		$dataItemgrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			oauthFlag:false,
			//pagination:false,//是否分页
		    parentGridId : 'customer-table',
		    parentGridField : 'id',
		    linkGridField : 'inviterId',
			url:'${AppContext.ctxPath}/action/portal/customer/inviteeQuery',
		    pageSize: 10,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
		    
		    buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				for(var i=0; i< rows.length; i++){closeClueDetailWin
					var row = rows[i];
					if(row.name){
						row.name = toFirstLower(row.name);
					}
					if(row.columnname){
						row.columnname = toUpper(row.columnname);
					}
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/customer/batchUpdate",
					type:"post",
					data:JSON.stringify(rows),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},			  
		});

		
		//城市picklist
		function registerCityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').city= selectRow.city;
			return selectRow.city;
		}
		
		$('#city').picklist({
			title:'选择城市',
			completeFun:function(selectRow){
				$('#city').textbox('setValue', selectRow.city);
				return selectRow.city;
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/RegisterCityPickList.jsp'
		});
		
		function custmSearch(){
			city = $('#city').textbox('getValue');
			custmName = $('#custmName').val();
			custmPhone = $('#custmPhone').val();
			createdStart = $('#createdStart').datetimebox('getValue');
			createdEnd = $('#createdEnd').datetimebox('getValue');
		  	$datagrid.datagrid('reload');
	  	 }
	   
	  	 function custmClean(){
		   $('#city').textbox('setValue',''); 
		   $('#custmName').val('');
		   $('#custmPhone').val('');
		   $('#createdStart').datetimebox('setValue','');
		   $('#createdEnd').datetimebox('setValue','');
		   city = null;
		   custmName = null;
		   custmPhone = null;
		   createdStart = null;
		   createdEnd = null;
		   $datagrid.datagrid('reload');
	  	 }
	</script>
</body>
</html>