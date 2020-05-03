<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/duty/queryStandardPage'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true" hidden="true">职责 ID</th>
			<th field="name"  width="150px"  >职责</th>
			<th field="comments" width="200px" >备注</th>
			<th field="corpName" width="100px">企业帐套名称</th>
			<th field="corpid" width="100px">企业帐套编号</th>
		</tr>
	</thead>
</table>