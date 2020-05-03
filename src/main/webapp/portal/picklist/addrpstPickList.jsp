<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<table class="pickListTable" url='${AppContext.ctxPath}/action/portal/alladdress/queryByExamplePage'>
	<thead>
		<tr>
			<th field="addrType" lov="IS_ADDR_TYPE" width="30%">类型</th>
			<th field="addrName" width="30%">名称</th>
			<th field="addrCode" width="30%">编码</th>
		</tr>
	</thead>
</table>