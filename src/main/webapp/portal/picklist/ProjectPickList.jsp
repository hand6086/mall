<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/Project/allprojectlist'>
	<thead>
		<tr>
			<th field="id" width="30%" >项目ID</th>
			<th field="projCode" width="35%" sortable="true">项目编号</th>
			<th field="projName" width="35%" sortable="true" defaultSearch="true">项目名称</th>
		</tr>
	</thead>
</table>