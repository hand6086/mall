<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
  <div data-options="region:'north',split:true" fit="true" border="false">
   <table id="feedBack-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="userId" width="120px" editor="{type:'textbox'}">消费者ID或回复员工ID</th>
				<th field="created" width="120px">反馈时间</th>
				<th field="phoneNumber" width="100px" editor="{type:'textbox'}">消费者联系电话</th>
				<th field="context" width="120px" editor="{type:'textbox'}">反馈或回复内容</th>
				<th field="type" width="120px" editor="{type:'textbox'}">反馈、回复</th>
				<th field="parentId" width="120px" editor="{type:'textbox'}">回复的对象ID</th>
				<th field="tAttr01" width="120px" editor="{type:'textbox'}">定位城市</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#feedBack-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			buttonExport : true,
			border:false,
			pageSize: 20, 
		    pageList: [15,20,30],
		    url:'${AppContext.ctxPath}/action/portal/feedBack/queryByExamplePage',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/feedBack/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/feedBack/deleteById', {
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
			
			onInitNewData:function(that){
				return {
					created: appCtx.sysdate()
				};
			},

 			onAddMoreButton:function(that,addButtonFun){
			}, 

		});

	</script>
</body>
</html>