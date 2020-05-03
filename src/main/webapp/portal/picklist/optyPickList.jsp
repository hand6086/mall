<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/opty/queryByExamplePage'>
	<thead>
		<tr>
			<th field="id" width="80px" sortable="true">商机编码</th>
			<th field="optyCode" width="80px" hidden="true" sortable="true">商机编码</th>
			<th field="optyName" width="230px" sortable="true" defaultSearch="true">商机名称</th>
			<th field="optyAddr" width="230px" sortable="true">商机地点</th>
			<!-- <th field="contact" width="80px"  sortable="true">联系人</th> -->
            <th field="stage" width="80px" lov="OPTY_STAGE" sortable="true">商机阶段</th>
			<th field="source" width="150px" lov="OPTY_SOURCE" sortable="true">商机来源</th>
			<th field="rate" width="80px" lov="OPTY_SUCCESS_RATE" sortable="true">成交概率</th>
			<th field="comments" width="80px"  sortable="true">备注</th>
		</tr>
	</thead>
</table>