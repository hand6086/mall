<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/invloc/queryByExamplePage'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true">仓库编码</th>
			<th field="invlocName" width="230px" sortable="true" defaultSearch="true">仓库名称</th>
			<th field="invlocType" width="80px" lov="INVLOC_TYPE" sortable="true">仓库类型</th>
            <th field="ownerId" width="80px"  sortable="true">客户编码</th>
			<th field="ownerName" width="80px"  sortable="true">客户名称</th>
		</tr>
	</thead>
</table>