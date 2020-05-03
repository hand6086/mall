<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,fit:true" border="false"
			style="padding: 0px;">
			<fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">筛选条件</span>
				</legend>
				<div class="row keyfilter-border">
					<ul id="empTypeKeyfilter" data-toggle="keyfilter"
						data-title="类型" data-filter-filed="empType"
						data-table-Id="user-table">
					</ul>
				</div>
			</fieldset>
			<table id="user-table" keyFilterDiv="keyFilter" fit="true">
				<thead>
					<tr>
						<th field="firstName" width="100px">姓名</th>
						<th field="username" width="100px">用户名</th>
						<th field="contactPhone" width="100px">联系电话</th>
						<th field="email" width="100px">邮件</th>
						<th field="postnName" width="150px">主要职位</th>	
						<th field="orgName" width="140px">组织名称</th>
						<th field="unitname" width="100px" >部门</th>
						<th field="dutyName" width="140px">职责</th>
						<th field="role" width="100px" lov="ROLE">角色</th>
						<th field="appResp" width="130px">APP职责</th>
						<th field="appRole" width="100px" lov="EMP_APP_ROLE">APP角色</th>
						<th field="contact" width="100px" style="display: none;">联系人</th>
						<th field="basename" width="100px">base地点</th>
						<th field="formuladate" width="100px" mark="DATE">聘用日期</th>
						<th field="hometown" width="100px">常住地</th>
						<th field="joblevel" width="100px">级别</th>
						<th field="joindate" width="100px" mark="DATE">入职日期</th>
						<th field="nextproj" width="100px">下一项目</th>
						<th field="positionname" width="100px">职务</th>
						<th field="trialdate" width="100px" mark="DATE">开始试用期</th>
						<th field="workdate" width="100px" mark="DATE">转正日期</th>
						<th field="status" width="100px" lov="USER_STATUS">状态</th>
						<th field="empType" lov="EMP_TYPE" width="100px">类型</th>
						<th field="corpName" width="120px" lov="CORP_ID">公司账套</th>
					</tr>
				</thead>
			</table>

		</div>
	</div>

	<script type="text/javascript">
		var $datagrid = $('#user-table');
		getLovOfList("[CORP_ID,USER_STATUS,EMP_APP_ROLE,ROLE]");
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			oauthFlag:true,
			url : '${AppContext.ctxPath}/action/portal/user/queryByExamplePage'
		});
		
		$('#empTypeKeyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/EMP_TYPE'
		});
	</script>
</body>
</html>