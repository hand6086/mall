<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/project/projectlist'>
	<thead>
		<tr>
			<th field="id" width="20%" >项目ID</th>
			<!-- 
			<th field="projCode" width="35%" sortable="true">项目编号</th>
			 -->
			<th field="projName" width="40%" sortable="true" defaultSearch="true">项目名称</th>
			  
			<th field="comments" width="40%" sortable="true">备注</th>
			 
			
		</tr>
	</thead>
</table>