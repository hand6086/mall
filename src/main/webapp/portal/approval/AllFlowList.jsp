<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">

   <div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
	<table id="approval-table"
			singleSelect="true" rownumbers="true"  pagination="true" style="height:100%;">
		<thead>
			<tr>
				<th field="id" width="100px"  formatter="idFormatter">流程ID</th>
				<th field="flowName" width="300px" editor="{type:'textbox'}">流程描述</th>
				<th field="approvalName" width="150px" editor="{type:'textbox'}">审批流程名称</th>
				<th field="flowNodePsnName" width="150px">处理人</th>
				<th field="flowStatus" width="100px" editor="{type:'combobox',
				                                             options:{valueField:'name',
																	textField:'name',
																	method:'get',
																	data:getLovArray('FLOW_STATUS'),
																	editable:false,
																	required:true
				                                             }}">流程状态</th>
				<th field="flowStartPsnName" width="100px" editor="{type:'picklistbox',
				                                                   options:{title:'选择发起人',
			                                                       required:true,
                                                                   completeFun:completeStartUserSelect,
                                                                   tableUrl:'${AppContext.ctxPath}/portal/account/contact/picklist/userPickList.jsp'}}">发起人</th>
				<th field="flowStart" width="100px" mark="DATE" editor="{type:'datetimebox',
				                                             options:{showSeconds:false,
				                                             }}">发起时间</th>
				<th field="flowNodeStart" width="100px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">送审时间</th>
				<th field="approvalNodeId" width="150px" hidden>待审批流程节点ID</th>
				<th field="approvalNodeDesc" width="150px" editor="{type:'textbox'}">待审批节点</th>
				<th field="comments" width="200px" editor="{type:'textbox'}">备注</th>
			</tr>
		</thead>
	</table>
	</div>
   	
	<script type="text/javascript">
	   function completeStartUserSelect(val,row){
		   $datagrid.hdatagrid('updateCurrentRow', {
			   flowNodePsnId : selectRow.id
			})
			return selectRow.firstName;
	   }
      
	   $datagrid = $('#approval-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			buttonCopy:false,
			striped:true,
			border:false,
		    pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/flow/queryByExamplePage'
		});	
		
		function idFormatter(val,row){
		     if(val != null){
		    	 var url = '${AppContext.ctxPath}/portal/approval/FlowDetail.jsp?flowId=' + row.id +'&flowObjId='+row.flowObjId;
	 		     var URL = '<a href="###" onclick="gotoContentPage(\'' + url + '\')">' + row.id + '</a>';
		    	 return URL; 
		     }
		}
		
	</script>
</body>
</html>