<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',collapsible:false" title="流程基本信息" border="false" style="width:100%;height:100%;padding:0px;" title="">
	       	<form id="approvalForm" method="post" align="center">
				<div class="row row-control">
					<div class="col-xs-3">
						<label class="input-label">流程描述 :&nbsp;</label> <input
							class="easyui-textbox form-control" disabled="true" name="flowName"
							id="flowName" />
					</div>
					<div class="col-xs-3">
					<label class="input-label">发起人 :&nbsp;</label> <input
						class="easyui-textbox form-control"  disabled="true" name="flowStartPsnName" id="flowStartPsnName" /> <input
						hidden="true" name="flowStartPsnId" id="flowStartPsnId" />
				    </div>
					<div class="col-xs-3">
						<label class="input-label">发起时间 :&nbsp;</label> <input
							class="easyui-datetimebox form-control"  disabled="true" name="flowStart" id="flowStart" />
					</div>
				</div>
	            
				<div class="row row-control">
				    <div class="col-xs-3">
					<label class="input-label">运行状态 :&nbsp;</label> <input
						data-options="{ valueField:'name',
										textField:'name',
										data:getLovArray('FLOW_STATUS'),
										editable:false,
										required:true}",
						class="easyui-combobox form-control"  disabled="true" name="flowStatus" id="flowStatus" />
				    </div>
				    <div class="col-xs-3">
					<label class="input-label">当前审批节点 :&nbsp;</label> <input
						class="easyui-textbox form-control"  disabled="true" name="approvalNodeDesc" id="approvalNodeDesc" /> <input
						hidden="true" name="flowNodePsnId" id="flowNodePsnId" />
				    </div>
					<div class="col-xs-3">
						<label class="input-label">送审时间 :&nbsp;</label> <input
							class="easyui-datetimebox form-control"  disabled="true" name="flowNodeStart" id="flowNodeStart" /><input
						hidden="true" name="approvalNodeId" id="approvalNodeId" />
					</div>
				</div>
	            
				<div class="row row-control">
				    <div class="col-xs-3">
						<label class="input-label">备注 :&nbsp;</label> <input
							class="easyui-textbox form-control" disabled="true" name="comments" id="comments" />
				    </div>
				    <div class="col-xs-3">
						<label class="input-label">当前节点审核情况 :&nbsp;</label> <input
							class="easyui-textbox form-control" disabled="true" name="currentDesc" id="currentDesc" />
				    </div>
				</div>
			</form>
	       
	       
	        <div id="p1" title="审批历史"  class="easyui-panel" collapsible="true" collapsed="false" border="false" style="height:35%; padding:0px;" >
	       		<table id="approval-record-table" style="width:100%;height:100%;">
			<thead>
				<tr>
					<th field="approvalNodeDesc" width="150px">审批节点描述</th>
					<th field="approvalUserName" width="100px">审批人</th>
				    <th field="approvalEnd" width="150px" >审批时间</th>
		    		<th field="approvalOpera" width="150px" lov="APPROVAL_OPERA" editor="{type:'combobox',
		                                             options:{valueField:'name',
															textField:'name',
															method:'get',
															data:getLovArray('APPROVAL_OPERA'),
															editable:false,
															required:true
		                                             }}">审批操作</th>
				    <th field="approvalView" width="250px">审批意见</th>
				</tr>
			</thead>
           </table>
           </div>
           
            <div id="p2" title="审批明细"  class="easyui-panel" collapsible="true" collapsed="true" border="false" style="height:80%; padding:0px;" >
			     	<iframe id="typeFrame"  frameborder="0"  src="" style="width:100%;height:98%;"></iframe>
            </div>
           
           	<div id="p3" title="审批操作"  class="easyui-panel" border="false" style="height:80%;adding:0px;">
           		<div id="otherOperateDiv"></div>
				<table id="editorTable" border="0" width="100%" >
				    <tr>
				        <td class="td-label" width="10%">审批意见:</td>
				        <td colspan="4" width="80%">
				        	<input id="approvalView" name="approvalView" class="easyui-textbox" data-options="multiline:true" style="height:150px; width:80%"></input>
				        </td>
				    </tr>
				     <tr height="30px">
				         <td></td>
			             <td>
				        	<input type="button" style="width: 100px;height:30px;" value="同意" onClick="agreeApproval()" >
			             </td>
			             <td>
				        	<input id="endButton"  type="button" style="display: none;width: 100px;height:30px;" value="结束" onClick="endApproval()" >
			             </td>
			             <td>
			        		<input type="button" style="width: 100px;height:30px;" value="拒绝" onClick="refruseApproval()" >
			             </td>
			              <td>
			              	<div id="otherUserDiv" style="display:none">
			              		<input id="otherUser">
			              	</div>
			              	<div id="nextUserDiv" style="display:none">
			              		<input id="nextUser">
			              	</div>
			        		<input id="allowButton" type="button"  style="display: none;width: 100px;height:30px;" value="转送" onClick="goApproval()" >
			             </td>
				    </tr>	
				</table>
		   </div>
	</div>
</div>


<script type="text/javascript">
		getLovOfList("[APPROVAL_OPERA]");
		var sflowId ="noMatchId"; 			//审批记录ID
		var sflowObjId = "noMatchId"; 		//审批对象ID
		var sapprovalNodeId = "noMatchId";	//当前待审批步骤
		sflowId = getUrlParams("flowId");
		sflowObjId = getUrlParams("flowObjId");
		
		$.post("${AppContext.ctxPath}/action/portal/flow/queryById", {
			id : sflowId
		}, function(data) {
			if (data.success) {
				record = data.result;
				sapprovalNodeId = record.approvalNodeId;
				record.flowStatus = getLovShowName('FLOW_STATUS',record.flowStatus);
				$('#approvalForm').form("load", record);
				if(record.allowTransfer == 'Y'){
					$('#allowButton').css('display','');
				}
				if(record.allowEnd == 'Y'){
					$('#endButton').css('display','');
				}
				$('#typeFrame').attr('src',record.crmShowUrl); 
				if(record != null && record.crmOperateUrl != null && record.crmOperateUrl  != ''){
					$('#otherOperateDiv').load(record.crmOperateUrl);
				}
			} else {
				$.messager.alert("警告", data.result);
			}
		});
		
		
 	$datagrid = $('#approval-record-table');
	$datagrid.hdatagrid({
		toolbarShow:false,
		pagination:false,
		url:'${AppContext.ctxPath}/action/portal/flowRecord/queryByExamplePage',
		onBeforeLoad:function(param){
			param.attr1 = sflowId;
		}
	}); 
	
	$('#otherUser').picklist({
		title:'选择用户',
        required:false,
        completeFun:function(selectedRow){
        	var comments = $('#approvalView').val();
    		$.post("${AppContext.ctxPath}/action/portal/flow/goApproval", {
    			flowId : sflowId,
    			userId : selectedRow.id,
    			comments : comments
    		}, function(data) {
    			if(data.success){
    				$.messager.alert("提示","转交完成！");
    				gotoContentPage('${AppContext.ctxPath}/portal/approval/FlowList.jsp');
    			}else{
    				$.messager.alert("提示",data.result);
    			}
    		});
        },
        tableUrl:'${AppContext.ctxPath}/portal/basic/picklist/userPickList.jsp'
	});
	
	//转发
	function goApproval(){
		$('.searchbox-button','#otherUserDiv').click();
	};
	
	function otherValue(){
		if(typeof(getOtherInfo) != "undefined"){
			return getOtherInfo();
		}
		return null;
	};
	
	//同意并结束
	function endApproval(){
		var comments = $('#approvalView').val();
		$.post("${AppContext.ctxPath}/action/portal/flow/endApproval", $.extend({
			flowId : sflowId,
			comments : comments,
		},otherValue()), function(data) {
			if(data.success){
				$.messager.alert("提示","审批完成并结束该流程！");
				gotoContentPage('${AppContext.ctxPath}/portal/approval/FlowList.jsp');
			}else{
				$.messager.alert("提示",data.result);
			}
		});
	};
	
	//同意
	function agreeApproval(){
		var comments = $('#approvalView').val();
		$.post("${AppContext.ctxPath}/action/portal/flow/agreeApproval", $.extend({
			flowId : sflowId,
			comments : comments
		},otherValue()), function(data) {
			if(data.success){
				$.messager.alert("提示","审批完成！");
				gotoContentPage('${AppContext.ctxPath}/portal/approval/FlowList.jsp');
			}else{
				if(data.mustSelectUser){
					$('#nextUser').picklist("destroy")
					$('#nextUser').picklist({
						title:'选择审批人',
				        required:false,
				        initParam:function(){
				        	return {
				        		nodeId:data.nodeId,
				        		userId:data.userId
				        	};
				        },
				        completeFun:function(selectedRow){
				        	var comments = $('#approvalView').val();
				    		$.post("${AppContext.ctxPath}/action/portal/flow/agreeApproval", $.extend({
				    			flowId : sflowId,
				    			comments : comments,
				    			userId	:selectedRow.id
				    		},otherValue()), function(data){
				    			if(data.success){
				    				$.messager.alert("提示","审批完成！");
				    				gotoContentPage('${AppContext.ctxPath}/portal/approval/FlowList.jsp');
				    			}else{
									$.messager.alert("提示",data.result);
								}
				    		});
				        },
				        tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/userSelectPickList.jsp'
					});
					$('.searchbox-button','#nextUserDiv').click();
				}else{
					$.messager.alert("提示",data.result);
				}
			}
		});
	};
	
	//拒绝
	function refruseApproval(){
		var comments = $('#approvalView').val();
		$.post("${AppContext.ctxPath}/action/portal/flow/refuseApproval", {
			flowId : sflowId,
			comments : comments
		}, function(data) {
			if(data.success){
				$.messager.alert("提示","拒绝完成！");
				gotoContentPage('${AppContext.ctxPath}/portal/approval/FlowList.jsp');
			}else{
				$.messager.alert("提示",data.result);
			}
		});
	};
</script>
</body>
</html>