<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/priceList/queryStandardPage'>
	<thead>
		<tr>
			<th field="priceListName" width="180px"   defaultSearch="true">价格表</th>
			<th field="effStartDate" width="120px" >有效期开始时间</th>
			<th field="effEndDate" width="120px" >有效期结束时间</th>
			<th field="orgName" width="120px"  >组织</th>
            <th field="activated" width="80px"  >是否激活</th>
			<th field="comments" width="200px"  >说明</th>
		</tr>
	</thead>
</table>