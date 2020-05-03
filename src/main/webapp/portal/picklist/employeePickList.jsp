<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable" url='${AppContext.ctxPath}/action/portal/user/queryByExamplePage'>
	<thead>
		<tr>
			<th field="username" width="100px">用户名</th>
			<th field="firstName" width="100px" defaultSearch="true">姓名</th>
			<th field="contactPhone" width="100px">联系电话</th>
			<th field="empType" lov="EMP_TYPE" width="100px">类型</th>
			<th field="postnName" width="100px">职位名称</th>
			<th field="orgName" width="100px">所属组别</th>
			<th field="status" width="100px" lov="USER_STATUS">状态</th>
		</tr>
	</thead>
</table>