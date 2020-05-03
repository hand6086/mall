<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:100%;width:100%">
  
	<table id="BatchRelease-table" fit="true" >
		<thead>
			<tr>
				<th field="checkStatus" width="10%" lov="TB_CHECK_STATUS">校验状态</th>							
				<th field="importStatus" width="10%" lov="TB_IMPORT_STATUS">导入状态</th>
				<th field="errorMessage" width="400px" formatter="titleFormatter">错误信息</th>
				<th field="couponCode" width="10%" editor="{type:'validatebox'}">	优惠券编码</th>
				<th field="telephoneNumber" width="20%" editor="{type:'numberbox'}">手机号</th>
			</tr>
		</thead>
	</table>
 </div>
	
   		</div>
	<script type="text/javascript">
	   $datagrid = $('#BatchRelease-table');
		$datagrid.hdatagrid({
			buttonNew:true,
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			buttonExport:true,
			buttonImport:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/batchrelease/queryByExamplePage',
			buttonBatchEdit : false,			
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_check" class="easyui-linkbutton" iconCls="icon-folder-page" plain="true" onclick="check()">校验数据</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="accntImpInsert()">提交数据</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="allDelete()">全部删除</a>',that);
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			
				$.post('${AppContext.ctxPath}/action/portal/batchrelease/upsert', row, function(data) {
					
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/batchrelease/deleteById', {
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
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				//var firstName = appCtx.firstName != null ? '' : appCtx.firstName;
				return {
					checkStatus : 'New',
					importStatus : 'New'
					
				};
			},
		});
		//错误信息title
		function titleFormatter(val,row){
		     if(val != null){
		        var content = '';
		        var content = val.replace(/\\n/g,'\n');
		        var val = val.replace(/\\n/g,'; ');
		     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
		     }
		}
		
		function check(){
			$.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/batchrelease/check', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		function accntImpInsert(){
			$.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/batchrelease/runCouponImport', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		function allDelete(){
			/* var rows = $datagrid.hdatagrid('getSelections');
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				alert(row);
			} */
			$.messager.confirm("操作提示", '是否确定删除全部信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/batchrelease/allDelete', {},
							function(data){
							if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
			
		}
		
	</script>
</body>
</html>