<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<table class="pickListTable" url="${AppContext.ctxPath}/action/portal/position/picklist">
	<thead>
		<tr>
			<th field="text" width="20%" defaultSearch="true">职位名称</th>
			<th field="positionType" width="15%" lov="POSTN_TYPE">职位类型</th>
			<th field="deptName" width="20%">部门名称</th>
			<th field="orgName" width="20%">组织名称</th>
			<th field="fstName" width="15%">主要负责人</th>
			<th field="isEffective" width="10%" lov="IS_EFFECTIVE">是否有效</th>			
		</tr>
	</thead>
</table>