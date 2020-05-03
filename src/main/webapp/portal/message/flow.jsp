<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center',split:true" title="" border="false" style="width: 100%; height: 100%; padding: 0px;">

			<table id="flow-table" width="100%" height="100%"  rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="type" width="20%" defaultSearch="true">标题</th>
					<th field="pushNote" width="60%" formatter="nameFormatter">内容</th>
					<th field="created" width="150px">创建时间</th>
			   </tr>
			</thead>
		</table>
		</div>
	</div>

	<script type="text/javascript">
		$datagrid = $("#flow-table");
			
		$datagrid.hdatagrid({
			idField:'id',
			toolbarShow:true,
			buttonSearch:true,
			striped : true,
			border : false,
			nowrap : false,
			pagination : true,
			pageSize : 20,//每页显示的记录条数，默认为20 
			pageList : [ 20, 30, 50 ],//可以设置每页记录条数的列表
			url : '${AppContext.ctxPath}/action/portal/pushNotice/queryFlowPage',
		});
		
		function nameFormatter(val,row){
		     if(val != null){
		    	 	var attr4 = '${AppContext.ctxPath}' + row.attr4;
					return "<a href='###' onclick='window.top.quickEnter(\""+row.attr1+"\",\""+row.attr2+"\",\""+row.attr3+"\",\""+attr4+"\")'>"+val+"</a>";
		     }
		}
	</script>
</body>
</html>