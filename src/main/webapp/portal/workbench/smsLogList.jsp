<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <table id="smsSendLog-table"
             			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="targetPhone" width="100px" editor="{type:'textbox'}">发放手机号</th>
				<th field="context" width="300px" editor="{type:'textbox'}">短信内容</th>
				<th field="expireTime" width="140px" editor="{type:'textbox'}">过期时间</th>
				<th field="type" width="550px" lov="TB_O2O_SMS_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_SMS_TYPE'),
																		editable:false}}">内容</th>
				
			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#smsSendLog-table');
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
		    url:'${AppContext.ctxPath}/action/portal/smsLog/queryByExamplePage',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/smsLog/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/smsLog/deleteById', {
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