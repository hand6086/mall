<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable" url='${AppContext.ctxPath}/action/portal/duty/unSelectMenuList'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="text" width="120px">菜单名称</th>
			<th field="parentMenuName" width="100px">父菜单名称</th>
			<th field="platformType" width="70px">所属系统</th>
			<th field="universalInd" editor="{type:'checkbox'}">通用版</th>
	        <th field="fmcgInd" editor="{type:'checkbox'}">快消行业版</th>
	        <th field="highTechInd" editor="{type:'checkbox'}">制造/高科技版</th>
	        <th field="homeInd" editor="{type:'checkbox'}">家居行业版</th>
	        <th field="finInd" editor="{type:'checkbox'}">金融行业版</th>
	        <th field="retailInd" editor="{type:'checkbox'}">零售行业版</th>
	        <th field="autoInd" editor="{type:'checkbox'}">汽车行业版</th>
	        <th field="comments" width="150px">说明</th>
		</tr>
	</thead>
</table>