<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.td-label {
	width:90px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,fit:true" border="false"
			style="padding: 0px;">
			<table id="user-table"  fit="true">
				<thead>
					<tr>
						<th field="name" width="24%" editor="{type:'textbox', options:{required:true}}">姓名</th>
						<th field="phoneNumber" width="24%"
							editor="{type:'textbox',options:{required:true, validType:'mobile',}}">电话号码</th>
						<th field="status" width="24%" lov="TB_O2O_STATUS" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('TB_O2O_STATUS'),
																		panelHeight: 'auto',//自动高度适合
																		editable:false}}">状态</th>
						<th field="userType" width="24%" lov="TB_O2O_USER_TYPE" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getdata(),
																		panelHeight: 'auto',//自动高度适合
																		editable:false}}">用户类型</th>
					</tr>
				</thead>
			</table>

		</div>
	</div>
	
	<script type="text/javascript">
		var $datagrid = $('#user-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			oauthFlag:false,
			url : '${AppContext.ctxPath}/action/portal/appuser/queryByExamplePage',
			onBeforeLoad:function(param){
				if(!accntCode){
		    		param.attr2 = "noAccId";
		    	}else{
		    		param.attr1="storeInfo";
		    		param.attr2=accntId;
		    	}
			},
			
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setLoginErrorTimes()">重置登录次数</a>',that);
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/appuser/upsert', {
					row_status   	: row.row_status,
					id 				: row.id,
					name 			: row.name,
					userType 		: row.userType,
					phoneNumber 	: row.phoneNumber,
					status 			: row.status,
					attr2 			: accntId
				}, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/appuser/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
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
				return {
					userType:"Store Employee",
					status:'Active',
				};
			}
	
		});
		
		function getdata(){
			var data = getLovArray('TB_O2O_USER_TYPE');
			for (var i = data.length - 1; i >=0; i--) {
				if (data[i].val != 'Store Owner' && data[i].val != 'Store Employee') {
					data.splice(i,1);
				}
			}
			return data;
		}
		
		function setLoginErrorTimes(){
			var row = $datagrid.hdatagrid("getSelected");
			if(!row){
				$.messager.alert("错误", "请选择一行", "error");
				return;
			}
			$.post("${AppContext.ctxPath}/action/portal/appuser/resetErrorTimes", row, function(data){
				if(data.success){
					$.messager.alert("成功", "重置成功，已将登录错误次数重置为0", "info");
				}else{
					$.messager.alert("错误", data.result, "info");
				}
			});
		}
	
	</script>
</body>
</html>