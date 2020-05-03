<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <table id="loginLog-table"
             			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="userId" width="100px" editor="{type:'textbox'}">用户ID</th>
				<th field="openDate" width="140px" editor="{type:'textbox'}">打开时间</th>
				<th field="loginDate" width="140px" editor="{type:'textbox'}">登录时间</th>
				<th field="logoutDate" width="140px" editor="{type:'textbox'}">退出时间</th>
				<th field="deviceNum" width="100px" editor="{type:'textbox'}">设备号</th>
				<th field="phoneType" width="100px" editor="{type:'textbox'}">手机型号</th>
				<th field="systemVersion" width="100px" editor="{type:'textbox'}">系统版本</th>
				<th field="location" width="240px" editor="{type:'textbox'}">登录位置</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#loginLog-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			newDefaultValue:true,
			buttonExport : true,
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/o2oLoginLog/queryByExamplePage',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/o2oLoginLog/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/o2oLoginLog/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},

		});
		
		
	</script>
</body>
</html>