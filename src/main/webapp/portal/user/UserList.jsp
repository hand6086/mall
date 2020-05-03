<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/mvg.css?version=<%=version%>">
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.mvg.js?version=<%=version%>"></script>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width: 100%; height: 100%; padding: 0px;">

			<table id="user-table" 
			     singleSelect="true" rownumbers="true" pagination="true" style="width:100%;height:100%;">
				<thead>
					<tr>
						<th field="firstName" width="100px" editor="{type:'textbox', options:{required:true}}">姓名</th>
						<th field="username" width="100px" editor="{type:'textbox', options:{required:true}}">用户名</th>
						<th field="contactPhone" width="100px"
							editor="{type:'validatebox',options:{required:true,validType:'mobile' }}">联系电话</th>
						<th field="email" width="100px" editor="{type:'validatebox', options:{required:true, validType:'email' }}">邮件</th>
						<th field="postnName" width="150px" editor="{type:'mvgPickbox',
							options:{title:'职位',completeFun:postnMvgPickComplete,
									mvgMapperName:'userPostn',
									tableId:'user-table',
									optionsLeft:{
										tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnLeftMvgPick.jsp',
										initParam:postnMvgPickParam
									},
									optionsRight:{
										tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnRightMvgPick.jsp'
									}
									}}">主要职位</th>
						<th field="postnId" hidden="true">职位ID</th>	
<!-- 						<th field="orgName" width="140px">组织名称</th>
						<th field="unitname" width="100px">部门</th> -->
						<th field="acctName" width="200px" editor="{ 
							type:'picklistbox',
							options:{
								title:'选择经销商',
								completeFun:accntPicklistComplete,
								tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp',
								initParam:accntPicklistInit,
								required:true 
								}
							}" >经销商</th>
						<th field="dutyName" width="140px" editor="{
							type:'mvgPickbox',
							options:{
								title:'职责',completeFun:dutyMvgPickComplete,
								mvgMapperName:'userDuty',
								tableId:'user-table',
								optionsLeft:{
									tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/DutyLeftMvgPick.jsp',
									initParam:dutyMvgPickParam
								}
							}
						}">职责</th>
						<th field="dutyId" hidden="true">职责ID</th>
						<th field="role" width="100px" lov="ROLE">角色</th>
						<th field="gender" width="60px" lov="GENDER" editor="{type:'combobox',options:{valueField:'val',
																	textField:'name',
																	data:getLovArray('GENDER'),
																	editable:false}}">性别</th>
						<th field="status" width="100px" lov="USER_STATUS"
							editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('USER_STATUS'),
											editable:false}}">状态</th>
						<th field="empType" lov="EMP_TYPE" width="100px">类型</th>
						<!-- <th field="corpid" width="120px" lov="CORP_ID"
							editor="{type:'combobox',
							options:{valueField:'val',
							textField:'name',
							method:'get',
							data:getLovArray('CORP_ID'),
							editable:false,
							required:false}}">公司账套</th> -->
						<!--
			<th field="uKeyId" width="100px" editor="{type:'validatebox',options:{validType:'length[0,20]'}}">UKey的唯一标识符</th>
			<th field="zqsfmy1" width="100px" editor="{type:'validatebox',options:{validType:'length[0,40]'}}">增强算法密钥</th>
			-->
						<!-- <th field="errorTimes" width="100px">登陆错误次数</th> -->
					</tr>
				</thead>
			</table>

		</div>
	</div>


	<script type="text/javascript">
	getLovOfList("[CORP_ID,USER_STATUS,EMP_APP_ROLE,ROLE]");
		var pickSelectedRow = undefined;
		var pickSelectedIndex = undefined;
		var userInsertFlag = false;
		$datagrid = $('#user-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			oauthFlag:true,
			newDefaultValue:true,
			newDefaultUrl:"${AppContext.ctxPath}/action/portal/user/list/OUTER_EMP/preDefaultValue",
			striped : true,
			border : false,
			url : '${AppContext.ctxPath}/action/portal/user/list/OUTER_EMP',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setPsw()">初始化密码</a>',that);
				
			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id           : row.id,
							acctId       : row.acctId,
							username     : row.username,
							firstName    : row.firstName,
							role         : row.role,
							corpid       : row.corpid,
							contactPhone : row.contactPhone,
							email        : row.email,
							status       : row.status,
							postnId 	 : row.postnId,
							dutyId		 : row.dutyId,
							gender		 : row.gender,
							empType			:'OUTER_EMP'
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/user/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
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
			onInsertAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/user/insert', {
					row_status   	: row.row_status,
					id: row.id,
					acctId         : row.acctId,
					username       : row.username,
					firstName      : row.firstName,
					role           : row.role,
					corpid         : row.corpid,
					contactPhone   : row.contactPhone,
					email          : row.email,
					status         : row.status,
					empType        :'OUTER_EMP',
					postnId 	   : row.postnId,
					dutyId		   : row.dutyId,
					gender		   : row.gender
				},function(data){
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
	    	
            },
            onUpdateAction:function(row,successFun,errFun,that) {	
		    	$.post('${AppContext.ctxPath}/action/portal/user/update', {
		    		row_status   	: row.row_status,
					id           : row.id,
					acctId       : row.acctId,
					username     : row.username,
					firstName    : row.firstName,
					role         : row.role,
					corpid       : row.corpid,
					contactPhone : row.contactPhone,
					email        : row.email,
					status       : row.status,
					postnId 	 : row.postnId,
					dutyId		 : row.dutyId,
					gender		 : row.gender,
					empType			:'OUTER_EMP'
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});

            },/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					empType:"OUTER_EMP",
					status:"NORMAL",
					corpid:appCtx.corpId
				};
			},	
		    onDeleteAction:function(row,successFun,errFun,that) {
		    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/user/deleteById', {
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
		    }		
				
		});
		
		
		function accntPicklistComplete(selectRow){
			/* $datagrid.hdatagrid('updateCurrentRow', {
				acctId   : selectRow.id
			}) */
			$datagrid.hdatagrid('getCurrentRow').acctId = selectRow.id;
			return selectRow.acctName;
		}
		function accntPicklistInit(){
			return {filtersRaw:'[{"id":"acctType","property":"acctType","value":"DEALER1"}]'};
		}
		/**
		 * 职位mvgPick 按【确定】后执行的方法
		 */
		function postnMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.postnId = rightRowsMvg.id;
				currentRow.postnName = rightRowsMvg.postnName;
			}
			return currentRow.postnName;
		}
		/**
		 * 职位mvgPick 列表数据初始化参数
		 */
		function postnMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
		}
		//职位Mvg的添加 end
		
		function appDutyPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').appResp = selectRow.respName;
			return selectRow.respName;
		}
		
		/**
		 * 职责mvgPick 按【确定】后执行的方法
		 */
		function dutyMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.dutyId = rightRowsMvg.id;
				currentRow.dutyName = rightRowsMvg.name;
			}
			return currentRow.dutyName;
		}
		/**
		 * 职责mvgPick 列表数据初始化参数
		 */
		function dutyMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
		}
		//职位Mvg的添加 end
		
		function setPsw(){
			var row = $datagrid.hdatagrid("getSelected");
			if(!row){
				$.messager.alert("错误", "请选择一行", "error");
				return;
			}
			$.post("${AppContext.ctxPath}/action/portal/user/genPsw", {id: row.id}, function(data){
				if(data.success){
					$.messager.alert("成功", "初始化成功，密码为联系电话后六位", "info");
				}else{
					$.messager.alert("成功", data.result, "info");
				}
			});
		}
	</script>
</body>
</html>