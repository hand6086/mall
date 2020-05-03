<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/campaign/queryByConsDrawPage'>
	<thead>
		<tr>
			<th field="city" defaultSearch="true" width="20%">城市</th>
			<th field="endTime" width="20%">结束时间</th>
			<th field="name" width="20%">活动名称</th>
			<th field="notes" width="20%">备注</th>
			<th field="startTime" width="20%">开始时间</th>
		</tr>
	</thead>
</table>