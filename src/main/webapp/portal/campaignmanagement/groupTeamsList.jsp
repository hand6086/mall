<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:50%;width:100%" title="拼团列表">
  
	<table id="group-activity-table" fit="true" >
		<thead>
				<tr>
					<!-- <th field="id" width="120px">拼团编码</th> -->
					<th field="buyMerchName" width="200px" >拼团商品名称</th>
					<th field="merchCode" width="200px" >拼团商品编码</th>
					<th field="activityName" width="200px" >拼团活动名称</th>
					<!-- <th field="code" width="120px" >拼团活动编码</th> -->
					<th field="groupsNumber" width="120px" editor="{type:'numberbox',options:{min:0,precision:0}}">起拼人数</th>
					<th field="teamNum" width="120px" editor="{type:'numberbox',options:{min:0,precision:0}}">已拼人数</th>
					<th field="lackNum" width="120px" editor="{type:'numberbox',options:{min:0,precision:0}}">待拼人数</th>
					<th field="created" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >成团时间</th>
					<th field="effectiveDuration" width="120px" >成团有效时间(小时)</th>
					<th field="status" width="120px" lov="TB_O2O_GROUP_STATUS" editor="{type:'combobox',options:{valueField:'val',
																					  textField:'name',
																					  data:getLovArray('TB_O2O_GROUP_STATUS'),
																					  editable:false,
																					  required:true }}">拼团状态</th>
				</tr>
		</thead>
	</table>
 </div>
	<div border="false" style="width:100%;height:50%;" title="拼团成员">
		<table id="group-user-table" fit="true" >
			<thead>
				<tr>
					<!-- <th field="groupId" width="120px" >拼团编码</th> -->
					<th field="orderNum" width="120px" >订单编号</th>
					<!-- <th field="customerCode" width="120px" >消费者编码</th> -->
					<th field="customerName" width="120px" >消费者名称</th>
					<th field="phoneNumber" width="120px" >消费者电话</th>
					<th field="created" width="140px">入团时间</th>
					<th field="foundFlg" width="100px">是否发起人</th>
					<th field="payFlg" width="100px">是否支付</th>
				</tr>
			</thead>
		</table>
		</div>
	</div>
	<script type="text/javascript">
	   $datagrid = $('#group-activity-table');
	   $dataItemgrid=$('#group-user-table');
	   $datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			title:"拼团列表",
			nowrap:false,
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,20,50],//可以设置每页记录条数的列表 
		    newDefaultValue:true,
			subGridIds: ['group-user-table'],
			url:'${AppContext.ctxPath}/action/portal/groupTeams/queryByExamplePage',
			buttonBatchEdit : true,	
			onInitNewData:function(that){
				return{
					effectiveDuration : '24',
				};
			}
		});
		
		$dataItemgrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			oauthFlag:false,
			title:"拼团成员",
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/groupUser/queryByExamplePage',
			parentGridId : 'group-activity-table',
		    parentGridField : 'id',
		    linkGridField : 'groupId',
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				row.groupId = $datagrid.hdatagrid('getCurrentRow').id;
				$.post('${AppContext.ctxPath}/action/portal/groupUser/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
		});
	
	</script>
</body>
</html>