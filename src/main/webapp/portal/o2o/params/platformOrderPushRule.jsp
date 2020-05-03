<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" fit="true">

			<table id="platformOrderPushRule-table" singleSelect="true" rownumbers="true"
				pagination="true" fit="true">
				<thead>
					<tr>
						<th field="name" width="100px" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
						<th field="rounds" width="120px" editor="{type:'text'}">推送轮数</th>
						<th field="firstRndDist" width="120px" editor="{type:'text'}">第1轮推送距离(米)</th>
						<th field="firstRndTime" width="120px" editor="{type:'text'}">第1轮等待时间(分钟)</th>
						<th field="secondRndDist" width="130px" editor="{type:'text'}">第2轮推送距离(米)</th>
						<th field="secondRndTime" width="130px" editor="{type:'text'}">第2轮等待时间(分钟)</th>
						<th field="thirdRndDist" width="130px" editor="{type:'text'}">第3轮推送距离(米)</th>
						<th field="thirdRndTime" width="130px" editor="{type:'text'}">第3轮等待时间(分钟)</th>
						<th field="tAttr10" width="130px" editor="{type:'text'}">兜底短信发送间隔</th>
						<th field="tAttr09" width="130px" editor="{type:'text'}">兜底短信发送次数上限</th>
						
						<th field="id" width="60px" noSearch="true" hidden="true">Id</th>
						<th field="locId" width="60px" noSearch="true" hidden="true">locId</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$datagrid = $('#platformOrderPushRule-table');
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			striped:true,
			title:'',
			border:false,
			url : '${AppContext.ctxPath}/action/portal/params/platformOrderPushRule/queryByExamplePage',
		    onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/params/platformOrderPushRule/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/params/platformOrderPushRule/deleteById', {
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
			},
		});
		
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').name = selectRow.name;
			$datagrid.hdatagrid('getCurrentRow').locId = selectRow.id;
			return selectRow.name;
		}
	</script>
</body>
</html>