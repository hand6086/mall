<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
 <div class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north'" title="审批流程" border="false" style="width:100%;height:55%;padding:0px;">
	<table id="approval-table"
			singleSelect="true" rownumbers="true" pagination="true" style="height:100%;">
		<thead>
			<tr>
				<th field="id" width="100px" hidden editor="{type:'textbox'}">审批流程ID</th>
			    <th field="approvalName" width="100px" defaultSearch="true" editor="{type:'textbox'}">审批流程名称</th>
			    <th field="approvalFlowType" width="150px" lov="APPROVAL_OBJECT_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('APPROVAL_OBJECT_TYPE'),
																		editable:false,
																		required:true}}">审批单类型</th>
			    <th field="status" width="80px" lov="APPROVAL_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('APPROVAL_STATUS'),
																		editable:false,
																		required:true}}">状态</th>
			    <th field="objUrl" width="200px" editor="{type:'textbox'}">CRM查看页面</th>	
			    <th field="appObjUrl" width="200px" editor="{type:'textbox'}">APP查看页面</th>	
	    		<th field="isSendEmail" width="100px"  editor="{type:'checkbox',options:{on:'Y',off:'N'}}">发邮件</th>
		      	<th field="comments" width="200px"  editor="{type:'textbox'}">备注</th>
			</tr>
		</thead>
	</table>
	</div>
	
	<div data-options="region:'south'" title="审批流程节点" border="false" style="width:100%;height:45%">
	<table id="approvalNode-table" 
			rownumbers="false" style="width:98%;height:98%;">
		<thead>
			<tr>
				<th field="approvalId" width="100px" hidden>审批流程ID</th>
                <th field="sn" width="40px" editor="{type:'numberspinner',options:{min: 1,
																        precision:0
																        }}">序号</th>
                <th field="approvalNodeDesc" width="100px" defaultSearch="true" editor="{type:'textbox'}">节点名称</th>
			    <th field="status" width="60px" lov="APPROVAL_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('APPROVAL_STATUS'),
																		editable:false,
																		required:true}}">状态</th>
			    <th field="mustSelectUser" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">选择用户</th>
			    <th field="allowTransfer" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">允许转送</th>
			    <th field="allowEnd" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">允许结束</th>
			    <th field="judgeMethod" hidden="true" lov="JUDGE_METHOD" width="100px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('JUDGE_METHOD'),
																		editable:false
																		}}">评判方法</th>
																		
			    <th field="approvalType" width="60px" lov="APPROVAL_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('APPROVAL_TYPE'),
																		editable:false,
																		required:true}}">人员类型</th>
				<th field="userName" width="100px"  editor="{type:'mvgPickbox',
								options:{title:'用户',
								completeFun:userMvgPickComplete,
										mvgMapperName:'approvalUser',
										tableId:'approvalNode-table',
										optionsLeft:{
											tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/UserLeftMvgPick.jsp',
											initParam:userMvgPickParam
										},
										optionsRight:{
											tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/UserRightMvgPick.jsp'
										}
										}}">主要雇员</th>
				<th field="postnName" width="100px"
					editor="{type:'mvgPickbox',
							options:{title:'职位',
							completeFun:postnMvgPickComplete,
							mvgMapperName:'approvalPostn',
							tableId:'approvalNode-table',
							optionsLeft:{
								tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnLeftMvgPick.jsp',
								initParam:postnMvgPickParam
							},
							optionsRight:{
								tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnRightMvgPick.jsp'
							}
						}}">主要职位</th>
								
                <th field="positionTypeName" width="100px"  editor="{type:'mvgPickbox',
							options:{title:'职位类型',
							completeFun:potsnTypeMvgPickComplete,
							mvgMapperName:'approvalPostnType',
							tableId:'approvalNode-table',
							optionsLeft:{
								tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnTypeLeftMvgPick.jsp',
								initParam:postnTypeMvgPickParam
							}
						}}">主要职位类型</th> 

				<th field="orgScope" width="100px" lov="ORG_TYPE" editor="{type:'combobox',options:{valueField:'val',
																textField:'name',
																method:'get',
																data:getLovArray('ORG_TYPE'),
																editable:false,
																required:false}}">组织类型</th>   
																		
				<th field="relationship" width="100px" lov="RELATION_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('RELATION_TYPE'),
																		editable:false,
																		required:false}}">上下级关系</th>  	
																		                                                    
			    <th field="nextSN" width="50px" editor="{type:'numberspinner',options:{min: 1,
																        precision:0
																        }}">下一步骤</th>
			    <th field="successCallFunName" width="100px"  editor="{type:'picklistbox',
				                                                    options:{
				                                                    title:'选择调用方法',
			                                                        required:false,
                                                                    completeFun:approvalOperatePicklistComplete,
                                                                    tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/ApprovalOperatePickList.jsp'}}">同意调用方法</th>
			    <th field="refuseSN" width="50px" editor="{type:'numberspinner',options:{min: 1,
																        precision:0
																        }}">拒绝返回步骤</th>
			    <th field="refuseCallFunName" width="100px"  editor="{type:'picklistbox',
				                                                    options:{
				                                                    title:'选择调用方法',
			                                                        required:false,
                                                                    completeFun:approvalRefuseOperatePicklistComplete,
                                                                    tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/ApprovalOperatePickList.jsp'}}">拒绝调用方法</th>
			    <th field="nodeUrl" width="100px" editor="{type:'textbox'}">CRM查看页面</th>
			    <th field="appNodeUrl" width="100px" editor="{type:'textbox'}">APP查看页面</th>
			    <th field="operateUrl" width="100px" editor="{type:'textbox'}">CRM额外操作页面</th>
			    <th field="appOperateUrl" width="100px" editor="{type:'textbox'}">APP额外操作页面</th>
			    <th field="otherFunName" width="100px"  editor="{type:'picklistbox',
				                                                    options:{
				                                                    title:'选择调用方法',
			                                                        required:false,
                                                                    completeFun:otherOperatePicklistComplete,
                                                                    tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/ApprovalOperatePickList.jsp'}}">额外操作方法</th>
                                                                    
			    <th field="decideFunName" width="100px"  editor="{type:'picklistbox',
				                                                    options:{
				                                                    title:'选择调用方法',
			                                                        required:false,
                                                                    completeFun:decideOperatePicklistComplete,
                                                                    tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/ApprovalOperatePickList.jsp'}}">分支判断方法</th>
			    <th field="comments" width="100px" editor="{type:'textbox'}">备注</th>     
			</tr>
		</thead>
	</table>
	</div>
</div>
	<script type="text/javascript">
	   var maxSN ="noMatchId";
	   getLovOfList("[ORG_TYPE,APPROVAL_STATUS,APPROVAL_OBJECT_TYPE,RELATION_TYPE,JUDGE_METHOD,APPROVAL_STATUS,APPROVAL_TYPE]");
	   $datagrid = $('#approval-table');
	   $dataitemgrid = $('#approvalNode-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:false,
			striped:true,
			border:false,
		    pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,20,30],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/approval/queryByExamplePage',
			subGridIds: ['approvalNode-table'],
			onInsertAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/approval/insert', {
					approvalName  : row.approvalName,
					approvalFlowType: row.approvalFlowType,
					status        : row.status,
					orgId         : row.orgId,
					isSendEmail   : row.isSendEmail,
					objUrl        : row.objUrl,
					appObjUrl     : row.appObjUrl,
					comments      : row.comments
				},function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/approval/update', {
					id            : row.id,
					approvalName  : row.approvalName,
					approvalFlowType: row.approvalFlowType,
					status        : row.status,
					orgId         : row.orgId,
					isSendEmail   : row.isSendEmail,
					objUrl        : row.objUrl,
					appObjUrl     : row.appObjUrl,
					comments      : row.comments
				},function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/approval/deleteById', {
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
			onChangeSelectedItem:function(row,that){
				var record = $datagrid.datagrid('getSelected');
				$dataitemgrid.hdatagrid('changeParentItemAndParams',{approvalId:record.id});
			}
			
		});	
		 
			$dataitemgrid.hdatagrid({
				updateable:true,
				toolbarShow:true,
				buttonSearch:true,
				buttonNew:true,
				buttonDelete:true,
				buttonCopy:true,
				newDefaultValue:true,
				sortName:'sn',
				sortOrder:'asc',
			    pageSize: 10,//每页显示的记录条数，默认为20 
			    pageList: [10,20,30],//可以设置每页记录条数的列表 
				url:'${AppContext.ctxPath}/action/portal/approvalNode/queryByExamplePage',
				
				parentGridId : 'approval-table',
			    parentGridField : 'id',
			    linkGridField : 'approvalId',
				subGridIds : [], //当前表的子表的id，字符串列表
				
				buttonBatchEdit : true,
				onBatchUpdateAction : function(rows, successFun, errFun, that){
					var rows_2 = [];
					for(var i=0; i< rows.length; i++){
						var row = rows[i];
						var row_2 = {
								row_status   	: "UPDATE",
								id           :  row.id,
								approvalId   :  Params.approvalId,
						    	approvalNodeDesc : row.approvalNodeDesc,
								userId       :  row.userId,
								userName     :  row.userName,
								postnId      :  row.postnId,
								orgScope     :  row.orgScope,
								relationship :  row.relationship,
							 	positionTypeId :  row.positionTypeId,
							    sn           :  row.sn,
							    approvalTypeValue :  row.approvalTypeValue,
								approvalType :  row.approvalType,
								status       :  row.status,
								defaultResult   :  row.defaultResult,
								allowApproval   :  row.allowApproval,
								allApproval     :  row.allApproval,
								allowTransfer   :  row.allowTransfer,
								allowEnd		:  row.allowEnd,
								judgeMethod     :  row.judgeMethod,
								condition       :  row.condition,
								nextSN          :  row.nextSN,
								conditionNoSN   :  row.conditionNoSN,
								refuseSN        :  row.refuseSN,
								nodeUrl         :  row.nodeUrl,
								appNodeUrl     	:  row.appNodeUrl,
								operateUrl		:  row.operateUrl,
								appOperateUrl	:  row.appOperateUrl,
								isEmail         :  row.isEmail,						
								overtimeNum     :  row.overtimeNum,	
								overtimeUnit    :  row.overtimeUnit,
								successCallFunId:  row.successCallFunId,
								refuseCallFunId	:  row.refuseCallFunId,
								otherFunId		:	row.otherFunId,
								decideFunId		:	row.decideFunId,
								mustSelectUser	:	row.mustSelectUser,
								comments        :  row.comments
						}
						rows_2.push(row_2);
					}
					$.ajax({
						url: "${AppContext.ctxPath}/action/portal/approvalNode/batchUpdate",
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
				onInsertOrUpdateAction:function(row,successFun,errFun,that){
					var Params = $dataitemgrid.hdatagrid('getParentParams');
					$.post('${AppContext.ctxPath}/action/portal/approvalNode/upsert', {
						row_status   :  row.row_status,
						id           :  row.id,
						approvalId   :  Params.approvalId,
				    	approvalNodeDesc : row.approvalNodeDesc,
						userId       :  row.userId,
						userName     :  row.userName,
						postnId      :  row.postnId,
						orgScope     :  row.orgScope,
						relationship :  row.relationship,
					 	positionTypeId :  row.positionTypeId,
					    sn           :  row.sn,
					    approvalTypeValue :  row.approvalTypeValue,
						approvalType :  row.approvalType,
						status       :  row.status,
						defaultResult   :  row.defaultResult,
						allowApproval   :  row.allowApproval,
						allApproval     :  row.allApproval,
						allowTransfer   :  row.allowTransfer,
						allowEnd		:  row.allowEnd,
						judgeMethod     :  row.judgeMethod,
						condition       :  row.condition,
						nextSN          :  row.nextSN,
						conditionNoSN   :  row.conditionNoSN,
						refuseSN        :  row.refuseSN,
						nodeUrl         :  row.nodeUrl,
						appNodeUrl     	:  row.appNodeUrl,
						operateUrl		:  row.operateUrl,
						appOperateUrl	:  row.appOperateUrl,
						isEmail         :  row.isEmail,						
						overtimeNum     :  row.overtimeNum,	
						overtimeUnit    :  row.overtimeUnit,
						successCallFunId:  row.successCallFunId,
						refuseCallFunId	:  row.refuseCallFunId,
						otherFunId		:	row.otherFunId,
						decideFunId		:	row.decideFunId,
						mustSelectUser	:	row.mustSelectUser,
						comments        :  row.comments
					}, function(data) {
						if (!data.success) {
							errFun(data.result,that);
						}else{
							successFun(that, data);
						}
					});
				},
				onDeleteAction:function(row,successFun,errFun,that){
					$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
						if(data){
							$.post('${AppContext.ctxPath}/action/portal/approvalNode/deleteById', {
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
						return {sn: maxSN};
				},
				onLoadSuccess:function(data){
					    maxSN = data.total+1;
				},
			});
		     
			 
			 //雇员picklist
			 function completeStartUserSelect(selectRow){
			 		$dataitemgrid.hdatagrid('getCurrentRow').userId = selectRow.id;
			 		return selectRow.firstName;
			 }
			 
			 
			 //职位picklist
			 function postnPicklistComplete(selectRow){
			 		$dataitemgrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			 		return selectRow.text;
			 }
			 
			 function approvalOperatePicklistComplete(selectRow){
			 		$dataitemgrid.hdatagrid('getCurrentRow').successCallFunId = selectRow.id;
			 		return selectRow.objectText;
			 }

			 function approvalRefuseOperatePicklistComplete(selectRow){
			 		$dataitemgrid.hdatagrid('getCurrentRow').refuseCallFunId = selectRow.id;
			 		return selectRow.objectText;
			 }
			 
			 function otherOperatePicklistComplete(selectRow){
			 		$dataitemgrid.hdatagrid('getCurrentRow').otherFunId = selectRow.id;
			 		return selectRow.objectText;
			 }
			 
			 function decideOperatePicklistComplete(selectRow){
			 		$dataitemgrid.hdatagrid('getCurrentRow').decideFunId = selectRow.id;
			 		return selectRow.objectText;
			 }
			 
			 /**
			 * 职位mvgPick 按【确定】后执行的方法
			 */
			function postnMvgPickComplete(rightRowsMvg) {
				var currentRow = $dataitemgrid.hdatagrid('getCurrentRow');
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
				var currentRow = $dataitemgrid.hdatagrid('getCurrentRow');
				return {mvgParentId:currentRow.id};
			}
			
			//用户MVG
			function userMvgPickParam(){
				var currentRow = $dataitemgrid.hdatagrid('getCurrentRow');
				return {mvgParentId:currentRow.id};
			}
			
			//用户完成
			function userMvgPickComplete(rightRowsMvg) {
				var currentRow = $dataitemgrid.hdatagrid('getCurrentRow');
				if(rightRowsMvg != null){
					currentRow.userId = rightRowsMvg.id;
					currentRow.userName = rightRowsMvg.firstName;
				}
				return currentRow.userName;
			}
			
			//职位类型MVG
			function postnTypeMvgPickParam(){
				var currentRow = $dataitemgrid.hdatagrid('getCurrentRow');
				return {mvgParentId:currentRow.id};
			}
			
			//职位类型完成
			function potsnTypeMvgPickComplete(rightRowsMvg) {
				var currentRow = $dataitemgrid.hdatagrid('getCurrentRow');
				if(rightRowsMvg != null){
					currentRow.positionTypeId = rightRowsMvg.id;
					currentRow.positionTypeName = rightRowsMvg.name;
				}
				return currentRow.positionTypeName;
			}
			
			
	</script>
</body>
</html>