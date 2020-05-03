<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/promotion/queryCityPage'>
	<thead>
		<tr>
			<th field="cityName" width="120px" sortable="true" defaultSearch="true">城市</th>
			<th field="name" width="100px" sortable="true">省</th>
			<th field="cityNotes" width="100px" sortable="true">说明</th>

			<th field="id" width="100px" hidden="true" noSearch="true">id</th>
			
			
		</tr>
	</thead>
</table>