<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="pickListTable"
	url='${AppContext.ctxPath}/action/portal/enterprise/queryByExamplePage'>
	<thead>
		<tr>
			<th field="id" width="100px"  noSearch="true" defaultSearch="false" hidden>id</th>
			<th field="created" width="100px" noSearch="true"  defaultSearch="false" hidden>创建时间</th>
			<th field="code" defaultSearch="false"   width="20%" editor="{type:'validatebox',options:{required:true}}"  >编号</th>
			<th field="name" width="30%" editor="{type:'validatebox',options:{required:true}}"  defaultSearch="true">名称</th>
			<th field="comments"   width="30%" editor="{type:'validatebox',options:{required:false}}"  >说明</th>
			<th field="defaultPrice" noSearch="true" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  hidden>默认价格表</th>

		</tr>
	</thead>
</table>