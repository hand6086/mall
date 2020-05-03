<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',collapsible:false" title="流程基本信息" border="false" style="width:100%;height:100%;padding:0px;" title="">
	       	<form id="approvalForm" method="post" align="center" style="width:98%;">
				<div class="row row-control">
					<div class="col-xs-3">
						<label class="input-label">流程名称 :</label> <input
							class="easyui-textbox form-control" disabled="true" name="flowName"
							id="flowName" />
					</div>
					<div class="col-xs-3">
					<label class="input-label">发起人 :</label> <input
						class="easyui-textbox form-control"  disabled="true" name="flowStartPsnName" id="flowStartPsnName" /> <input
						hidden="true" name="flowStartPsnId" id="flowStartPsnId" />
				    </div>
					<div class="col-xs-3">
						<label class="input-label">发起时间 :</label> <input
							class="easyui-datetimebox form-control"  disabled="true" name="flowStart" id="flowStart" />
					</div>
				</div>
	            
				<div class="row row-control">
				    <div class="col-xs-3">
					<label class="input-label">运行状态 :</label> <input
						data-options="{ valueField:'name',
										textField:'name',
										data:getLovArray('FLOW_STATUS'),
										editable:false,
										required:true}",
						class="easyui-combobox form-control"  disabled="true" name="flowStatus" id="flowStatus" />
				    </div>
				    <div class="col-xs-3">
					<label class="input-label">待审批人 :</label> <input
						class="easyui-textbox form-control"  disabled="true" name="flowNodePsnName" id="flowNodePsnName" /> <input
						hidden="true" name="flowNodePsnId" id="flowNodePsnId" />
				    </div>
					<div class="col-xs-3">
						<label class="input-label">送审时间 :</label> <input
							class="easyui-datetimebox form-control"  disabled="true" name="flowNodeStart" id="flowNodeStart" />
					</div>
				</div>
			</form>
	       
	       
	        <div id="p1" title="审批历史"  class="easyui-panel" collapsible="true" collapsed="false" border="false" style="height:35%; padding:0px;" >
	       	<table id="approval-record-table" style="width:98%;height:100%;">
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
           
            <div id="p2" title="审批明细"  class="easyui-panel" collapsible="true" collapsed="false" border="false" style="height:80%; padding:0px;" >
			     	<iframe id="typeFrame"  frameborder="0"  src="" style="width:100%;height:98%;"></iframe>
            </div>
	</div>
</div>


<script type="text/javascript">
		getLovOfList("[APPROVAL_OPERA]");
		var sflowId ="noMatchId"; //流程ID
		var sflowObjId = "noMatchId"; //审批对象ID
		
		var sApprPsnId = "noMatchId"; //当前待审批人ID
		sflowId = getUrlParams("flowId");
		sflowObjId = getUrlParams("flowObjId");
		$('#flowStartPsnName').picklist({
			title:'选择发起人',
			completeFun:function(selectRow){
				$('#flowStartPsnId').val(selectRow.id)
				return selectRow.firstName;
			},
			tableUrl:'${AppContext.ctxPath}/portal/account/contact/picklist/userPickList.jsp'
		});
		
		$.post("${AppContext.ctxPath}/action/portal/flow/queryById", {
			id : sflowId
		}, function(data) {
			if (data.success) {
				record = data.result;
				sApprPsnId = record.flowNodePsnId;
				record.flowStatus = getLovShowName('FLOW_STATUS',record.flowStatus);
				$('#approvalForm').form("load", record);
				$('#typeFrame').attr('src','${AppContext.ctxPath}'+record.crmShowUrl); 
			} else {
				$.messager.alert("警告", data.result);
			}
		});
		
 	$datagrid = $('#approval-record-table');
	$datagrid.hdatagrid({
		toolbarShow:false,
		buttonSearch:true,
		buttonExport:false,
		striped:true,
		border:false,
		pagination:false, 
		url:'${AppContext.ctxPath}/action/portal/flowRecord/queryByExamplePage',
		onBeforeLoad:function(param){
			param.attr1 = sflowId;
		}
	}); 
	
	
</script>
</body>
</html>