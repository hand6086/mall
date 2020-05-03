<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
   <table id="smsSendLine-table" 
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="headId" width=20% editor="{type:'textbox'}">短信编码</th>
				<th field="phoneNumber" width=76% editor="{type:'textbox'}">目标号码</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#smsSendLine-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			buttonImport : true,
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/smsLine/queryByExamplePage',

		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/smsLine/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/smsLine/deleteById', {
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
			
			

 			onAddMoreButton:function(that,addButtonFun){
			}, 

		});

	</script>
</body>
</html>