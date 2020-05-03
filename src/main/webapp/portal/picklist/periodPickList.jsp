<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<table class="pickListTable" url="${AppContext.ctxPath}/action/portal/period/queryByExamplePage">
	<thead>
		<tr>
			<th field="id" width="10%" >编号</th>
			<th field="title" width="30%" defaultSearch="true" defaultSearch="true">期间名称</th>
			<th field="type" width="15%" defaultSearch="false" lov="PERIOD_TYPE">类型</th>
			<th field="startDate" width="20%" defaultSearch="false" formatter="dateFormate">开始日期</th>
			<th field="endDate" width="20%" defaultSearch="false" formatter="dateFormate">结束日期</th>
		</tr>
	</thead>
</table>