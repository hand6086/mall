<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <table class="pickListTable" url='${AppContext.ctxPath}/action/portal/flow/queryUserSelectPage'>
	<thead>
		<tr>
			<th field="username" width="30%"  sortable="true">用户名</th>
			<th field="firstName" width="30%" sortable="true">姓名</th>
			<th field="empType" width="30%" sortable="true">员工类型</th>
		</tr>
	</thead>
</table>