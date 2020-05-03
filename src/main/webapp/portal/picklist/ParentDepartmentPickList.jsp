<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	   url='${AppContext.ctxPath}/action/portal/dept/parentPicklist'>
	<thead>
		<tr>
			<th field="deptCode" width="22%" sortable="true" >部门编码</th>
			<th field="text" width="22%" defaultSearch="true">部门名称</th>
			<th field="deptType" width="22%" lov="ORG_TYPE">部门类型</th>
			<th field="orgName" width="22%">组织</th>
		</tr>
	</thead>
</table>