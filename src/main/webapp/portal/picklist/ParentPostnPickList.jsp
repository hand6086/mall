<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	   url='${AppContext.ctxPath}/action/portal/position/parentPicklist'>
	<thead>
		<tr>
			<th field="text" width="15%" defaultSearch="true">职位名称</th>
			<th field="positionType" lov="POSTN_TYPE" width="15%">职位类型</th>
			<th field="username" width="18%">主要负责人用户名</th>	
			<th field="fstName" width="15%">主要负责人姓名</th>	
			<th field="deptName" width="15%">部门</th>
			<th field="orgName" width="15%">组织</th>
		</tr>
	</thead>
</table>