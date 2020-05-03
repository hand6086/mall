<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/ServiceProject/srpropersonlist'>
	<thead>
		<tr>
			<th field="username" width="20%" sortable="true">用户名</th>
			<th field="firstName" width="20%" sortable="true" defaultSearch="true">姓名</th>
			<th field="unitname" width="20%" sortable="true">部门</th>
			<th field="positionname" width="20%" sortable="true">职位</th>
			<th field="workdate" width="20%" sortable="true">入职时间</th>
			<th field="joblevel" width="20%" sortable="true">级别</th>
			<th field="contactPhone" width="20%" sortable="true">电话</th>
			<th field="email" width="30%" sortable="true">邮箱</th>
	   		<th field="id" width="5%" hidden="true"></th> 
		</tr>
	</thead>
</table>
