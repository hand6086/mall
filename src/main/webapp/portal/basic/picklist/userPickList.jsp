<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/user/list/INTER_EMP'>
	<thead>
		<tr>
			<th field="username" width="35%">用户名</th>
			<th field="firstName" width="31%" defaultSearch="true">姓名</th>
			<th field="empType" width="30%">员工类型</th>
		</tr>
	</thead>
</table>