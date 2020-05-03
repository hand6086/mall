<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable" url='${AppContext.ctxPath}/action/portal/appMenu/unSelectMenuList'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="moduleName" width="20%"  sortable="true">名称</th>
			<th field="moduleType" width="20%" sortable="true">类型</th>
			<th data-options="field:'universalInd'" width="100px">通用版</th>
		      <th data-options="field:'fmcgInd'" width="100px">快消行业版</th>
		      <th data-options="field:'highTechInd'" width="100px">制造/高科技版</th>
		      <th data-options="field:'homeInd'" width="100px">家居行业版</th>
		      <th data-options="field:'finInd'" width="100px">金融行业版</th>
		      <th data-options="field:'retailInd'" width="100px">零售行业版</th>
		      <th data-options="field:'autoInd'" width="100px">汽车行业版</th>
			<th field="urlPath" width="20%" sortable="true">URL</th>
			<th field="moduleCode" width="20%">编码</th>
			<th field="description" width="40%">说明</th>
		</tr>
	</thead>
</table>