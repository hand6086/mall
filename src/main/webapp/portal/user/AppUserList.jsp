<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>
<body>
	<div  class="easyui-layout" data-options="fit:true" border="false">
	   <div data-options="region:'north',split:true" fit="true" border="false">
			<table id="user-table" width="100%" height="100%" title=""
				singleSelect="true" rownumbers="true" toolbar="#user-table-toolbar"
				pagination="true">
				<thead>
					<tr>
						<th field="name" width="24%" editor="{type:'textbox', options:{required:true}}">姓名</th>
						<th field="userType" width="24%" lov="TB_O2O_USER_TYPE" >用户类型</th>
						<th field="phoneNumber" width="24%"
							editor="{type:'textbox',options:{required:true, validType:'mobile',}}">电话号码</th>
						<th field="status" width="24%" lov="TB_O2O_STATUS"
														editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('TB_O2O_STATUS'),
																		editable:false}}">状态</th>
				</thead>
			</table>
		</div>
	</div>
	<!-- ------------------------弹出框：开始----------------------------  -->
	<div id="changePdDiv">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<form method="post" id="changePdForm" style="text-align:center;margin-top: 30px;" 
					enctype="multipart/form-data" >
					<table class="table-block" style="text-align:center;margin: 0px auto;">
						<tr>
							<td class="td-label"><label>新密码 : &nbsp;</label></td>
							<td class="td-content">
								<input id="newPassword" name="newPassword" type='password' required="true" class="easyui-textbox"/>
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>确认密码 : &nbsp;</label></td>
							<td class="td-content">
								<input id="confirmPassword" name="confirmPassword" type='password' required="true" class="easyui-textbox"/>
							</td>
						</tr>
					</table>
					<input name="id" hidden="true" />
					<input name="empType" hidden="true" />
				</form>
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
				<a class="easyui-linkbutton upload" style="width:100px;margin-right: 30px;" 
					data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="changePassword()">确定修改</a>
				<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" 
					data-options="iconCls:'icon-cancel'" href="javascript:void(0)" 
					onclick="closeDiv()">取消</a>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		$datagrid = $('#user-table');
		var $changePdDiv = $('#changePdDiv');//修改密码的弹出框
		var $changePdForm = $('#changePdForm');//弹出框的表单
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			
			newDefaultValue:true,
			oauthFlag:true,
			url : '${AppContext.ctxPath}/action/portal/appuser/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				/* addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setPsw()">初始化密码</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="openChangePdDiv()">修改密码</a>',that); */
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setLoginErrorTimes()">重置登录次数</a>',that);
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/appuser/upsert', {
					row_status   	: row.row_status,
					id 				: row.id,
					name 			: row.name,
					userType 		: row.userType,
					phoneNumber 	: row.phoneNumber,
					status 			: row.status
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
					userType:"Customer",
					status:'Active',
				};
			}
		});
		
		function setPsw(){
			var row = $datagrid.hdatagrid("getSelected");
			if(!row){
				$.messager.alert("错误", "请选择一行", "error");
				return;
			}
			$.post("${AppContext.ctxPath}/action/portal/user/genPsw", {id: row.id}, function(data){
				if(data.success){
					$.messager.alert("成功", "初始化成功，密码为联系电话后六位", "info");
				}else{
					$.messager.alert("成功", data.result, "info");
				}
			});
		}
		function openChangePdDiv(){
			$changePdDiv.dialog({
				title:'修改密码',
			    width:'400px',
			    height:'250px',
			    closable:false,
			    minimizable:false,
			    collapsible:false,
			    modal:true,
			    closed:true
			});
			$changePdDiv.window('open');
		}
		
		$changePdForm.form({
			url : '${AppContext.ctxPath}/action/portal/userUtil/changeEmployeePassword',
			onSubmit : function(){
				return $changePdForm.form('validate');
			},
			success : function(data){
				var data = eval('(' + data + ')'); // change the JSON string to javascript object
				if (data.success) {
					$.messager.alert('提示','修改成功！');
					closeDiv();
				} else {
					$.messager.alert('提示', data.result);
				}
			}
		});
		
		/**
		 * 修改选中行的密码
		 */
		function changePassword() {
			var row = $datagrid.hdatagrid('getSelected');
			if(!row){
				$.messager.alert('提示', '请选择行。');
				return false;
			}
			$('input[name=id]',$changePdDiv).val(row.id);
			$('input[name=empType]',$changePdDiv).val(row.empType);
			$changePdForm.submit();
		}
		
		/**
		 * 关闭并清空弹出框内容
		 */
		function closeDiv(){
			$('input[name=id]',$changePdDiv).val('');
			$('input[name=empType]',$changePdDiv).val('');
			$('#newPassword',$changePdDiv).textbox('setValue','');
			$('#confirmPassword',$changePdDiv).textbox('setValue', '');
			$changePdDiv.window('close');
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