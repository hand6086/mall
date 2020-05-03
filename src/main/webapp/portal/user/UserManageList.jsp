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
			<fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">筛选条件</span>
				</legend>
				<div class="row keyfilter-border">
					<ul id="empTypeKeyfilter" data-toggle="keyfilter"
						data-title="类型" data-filter-filed="empType"
						data-table-Id="user-table">
					</ul>
				</div>
			</fieldset>
			<table id="user-table" keyFilterDiv="keyFilter" fit="true">
				<thead>
					<tr>
						<th field="firstName" width="100px">姓名</th>
						<th field="username" width="100px">用户名</th>
						<th field="contactPhone" width="100px">联系电话</th>
						<th field="email" width="100px">邮件</th>
						<th field="postnName" width="150px">主要职位</th>	
						<th field="orgName" width="140px">组织名称</th>
						<th field="unitname" width="100px" >部门</th>
						<th field="dutyName" width="140px">职责</th>
						<th field="role" width="100px" lov="ROLE">角色</th>
						<th field="appResp" width="130px">APP职责</th>
						<th field="appRole" width="100px" lov="EMP_APP_ROLE">APP角色</th>
						<th field="contact" width="100px" style="display: none;">联系人</th>
						<th field="basename" width="100px">base地点</th>
						<th field="formuladate" width="100px" mark="DATE">聘用日期</th>
						<th field="hometown" width="100px">常住地</th>
						<th field="joblevel" width="100px">级别</th>
						<th field="joindate" width="100px" mark="DATE">入职日期</th>
						<th field="nextproj" width="100px">下一项目</th>
						<th field="positionname" width="100px">职务</th>
						<th field="trialdate" width="100px" mark="DATE">开始试用期</th>
						<th field="workdate" width="100px" mark="DATE">转正日期</th>
						<th field="status" width="100px" lov="USER_STATUS">状态</th>
						<th field="empType" lov="EMP_TYPE" width="100px">类型</th>
						<th field="corpName" width="120px" lov="CORP_ID">公司账套</th>
					</tr>
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
	<!-- ------------------------弹出框：结束----------------------------  -->

	<script type="text/javascript">
		var $datagrid = $('#user-table');
		var $changePdDiv = $('#changePdDiv');//修改密码的弹出框
		var $changePdForm = $('#changePdForm');//弹出框的表单
		getLovOfList("[CORP_ID,USER_STATUS,EMP_APP_ROLE,ROLE]");
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			oauthFlag:true,
			url : '${AppContext.ctxPath}/action/portal/user/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="openChangePdDiv()">修改密码</a>',that);
			}
		});
		
		$('#empTypeKeyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/EMP_TYPE'
		});
		
		
		/* ----------------------弹出框操作 start--------------------------------- */
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
		/* ----------------------弹出框操作 end--------------------------------- */
	</script>
</body>
</html>