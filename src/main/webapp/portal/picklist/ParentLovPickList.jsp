<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable" url='${AppContext.ctxPath}/action/portal/basic/parentPickList'>
	<thead>
		<tr>
			<th field="name" width="15%" defaultSearch="true">显示值</th>
			<th field="val" width="20%">独立源代码</th>
			<th field="type" width="20%">类型</th>
			<th field="parentName" width="15%">父对象</th>
			<th field="langId" width="7%">语言</th>
			<th field="seq" width="6%">排序</th>
			<th field="corpId" width="7%">公司账套</th>
			<th field="activeFlag" width="6%">是否有效</th>
		</tr>
	</thead>
</table>