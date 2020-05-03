<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<table class="pickListTable"
 url="${AppContext.ctxPath}/action/portal/area/actualCityPickListPage">
	<thead>
		<tr>
			<th field="actualCity" width="10%" >名称</th>
			<th field="areaCode" width="10%" >编码</th>
			<th field="parentAreaName" width="10%" >*省/直辖市</th>
			<th field="isO2OArea" width="20%" >是否O2O平台区域</th>
			<th field="isO2ODistrict" width="20%" >是否地配区域</th>
		</tr>
	</thead>
</table>