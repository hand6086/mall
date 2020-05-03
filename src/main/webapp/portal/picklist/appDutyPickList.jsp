<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/appduty/queryByExamplePage'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true" hidden="true">职责 ID</th>
			<th field="respName"  width="150px"  defaultSearch="true">职责</th>
			<th field="comments" width="200px" >备注</th>
		</tr>
	</thead>
</table>