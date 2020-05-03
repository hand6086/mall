<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<table class="multiSelectTable" url='${AppContext.ctxPath}/action/portal/duty/unSelectUrlList'>
	<thead>
		<tr>
			<th field="check" checkbox="true"></th>
			<th field="url"  defaultSearch="true"   width="300px"   >URL</th>
				<th field="name" noSearch="false" defaultSearch="false"   width="150px"  >名称</th>
				<th field="comments" noSearch="false" defaultSearch="false"   width="100px" >备注</th>
				<th field="insertFlag" noSearch="false" defaultSearch="false"  width="60px"  >添加</th>
				<th field="delFlag" noSearch="false" defaultSearch="false"  width="60px" >删除</th>
				<th field="updateFlag" noSearch="false" defaultSearch="false"  width="60px"  >修改</th>
				<th field="selectFlag" noSearch="false" defaultSearch="false"  width="60px" >查询</th>
				<th field="defaultAccessFlag" noSearch="false" defaultSearch="false"  width="60px"  >默认可访问</th>
		</tr>
	</thead>
</table>