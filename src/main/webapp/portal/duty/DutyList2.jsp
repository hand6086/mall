<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<div id="menu_layout"  class="easyui-layout" border="false" fit="true">
		
		<div data-options="region:'north',split:true" title="" border="false" style="width:98%;height: 100%;padding:0px;">
			<table id="duty-table">
				<thead>
					<tr>
						<th field="name" width="30%" editor="{type:'validatebox',options:{required:true}}">名称</th>
						<c:if test="${UserContext.systemRole == 'super_administrator'}">
							<th field="corpName" width="15%">企业帐套名称</th>
							<th field="corpid" width="10%">企业帐套编号</th>
							<th field="isDefault" width="8%" lov="S_IF">是否默认职责</th>
						</c:if>
						<th field="comments" width="32%" editor="{type:'validatebox',options:{required:false}}">说明</th>
					</tr>
				</thead>
			</table>	
			
			<div id="duty-tabs" class="easyui-tabs"
				style="width: 98%; height: 800px;"
				data-options="border:false">
				<div title="菜单" href="${AppContext.ctxPath}/portal/duty/modules/menuTabList.jsp"></div>
				<div title="用户" href="${AppContext.ctxPath}/portal/duty/modules/userTabList.jsp"></div>
				<div title="URL" href="${AppContext.ctxPath}/portal/duty/modules/urlTabList.jsp"></div>
			</div>
		</div>
		
		
		
	</div>
   	
	<script type="text/javascript">
		$('#menu_layout').layout();
		$datagrid = $('#duty-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
		    subGridIds: ['menu-table','user-table','urlDutyLink-table'],
		    pageSize: 10,//每页显示的记录条数，默认为10 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/duty/queryDutyListPage',
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id       :row.id,
							name     :row.name,
							comments :row.comments,
							isDefault :row.isDefault
					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/duty/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},				
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/duty/upsert',{
					row_status : row.row_status,
					id       :row.id,
					name     :row.name,
					comments :row.comments,
					isDefault :row.isDefault
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						if(row.isDefault == 'Y'){
							$("input:checkbox").removeAttr("checked");
						}
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
				$.messager.confirm("操作提示",'是否确定删除信息？',function(data){
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/duty/deleteById',{
							id : row.id
						},function(data){
							if(!data.success){
								errFun(data.result,that);
							}
							else{
								successFun(that, data);
							}
						});
					}
				});
			},
			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(92,'<a href="javascript:void(0)" id="btn_default" class="easyui-linkbutton" onClick="toDefault()" iconCls="icon-undo" plain="true">设置默认职责</a>',that);
 			}, 
			onInitNewData:function(that){
				return {
					isDefault: 'N'
				};
			},
		});
	
		//失效
		function toDefault(){
			var row = $datagrid.datagrid('getSelected');
			row.isDefault = 'Y';
			$.post('${AppContext.ctxPath}/action/portal/duty/update',row, 
				function(data) {
					if (!data.success) {
						window.parent.operationtip(data.result, 'error');
					}else{
						window.parent.operationtip('更新默认职责成功！', 'info');
						$datagrid.hdatagrid('reload');
					}
				});
		}
	</script>
</body>
</html>