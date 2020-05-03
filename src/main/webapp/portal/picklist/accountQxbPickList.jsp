<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/accnt/getQxbAccntListPaging'>
	<thead>
		<tr>
			<th field="name" width="230px"  sortable="false" defaultSearch="true">公司名称</th>
			<th field="oper_name" width="130px" noSearch="true" sortable="false">企业法人</th>
			<th field="start_date" width="130px"  noSearch="true" sortable="false">成立日期</th>
		</tr>
	</thead>
</table>