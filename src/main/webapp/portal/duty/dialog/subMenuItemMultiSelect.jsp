<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable" url='${AppContext.ctxPath}/action/portal/duty/unSelectSubMenuList'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="text" width="30%">菜单名称</th>
			<th field="parentMenuName" width="30%">父菜单名称</th>
			<th field="comments" width="30%">说明</th>
		</tr>
	</thead>
</table>