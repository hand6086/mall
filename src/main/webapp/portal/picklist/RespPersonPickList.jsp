<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/ServiceProject/resppersonlist'>
	<thead>
		<tr>
			<th field="username" width="35%" sortable="true">用户名</th>
			<th field="firstName" width="30%" sortable="true" defaultSearch="true" defaultSearch="true">姓名</th>
		    <th field="id" width="30%" hidden="true"></th>
			<!-- <th field="orgType" width="30%">组织类型</th> -->
		</tr>
	</thead>
</table>