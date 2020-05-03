<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable" url='${AppContext.ctxPath}/action/portal/publishProgram/selectRelatedTasksList'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="projName" width="30%"  sortable="true">项目</th>
			<th field="rFirstName" width="30%" sortable="true">责任人</th>
			<th field="abstracts"  width="30%" sortable="true">内容</th>
		</tr>
	</thead>
</table>