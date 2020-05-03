<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<table class="mvgPickTable">
	<thead>
		<tr>
			<th field="prodCode" width="120px">产品编码</th>
			<th field="prodName" width="120px" defaultSearch="true">产品名称</th>
			<th field="qty" width="120px" editor="{type:'numberspinner',options:{
													min:0,
													validType:'integer',
													required:true}}">数量</th>
		</tr>
	</thead>
</table>