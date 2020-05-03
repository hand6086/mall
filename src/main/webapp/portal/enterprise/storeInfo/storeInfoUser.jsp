<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body>
		<table class="form-table">
		    <tr>
				<td>
					<fieldset>
						<legend>管理人信息</legend>
						<table class="form-table" style="height: 50px;">							
							<tr>
								<td class="td-label"><label>管理人姓名 ：</label></td>
								<td class="td-content">
									<input name="applicantName1" id="applicantName1" type="text" disabled/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>管理人邮箱 ：</label></td>
								<td class="td-content">
									<input name="applicantMailbox" id="applicantMailbox" type="text" disabled/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>管理人手机 ：</label></td>
								<td id="td-updatePhone" class="td-content">
									<input name="applicantPhone" id="applicantPhone" type="text" disabled/>
									<a href="javascript:void(0)" onclick="updatePhone()" id="updatePhone" style="margin-left:100px;">修改手机号</a>
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
		    <tr>
				<td>
					<fieldset>
						<legend>网店客服信息</legend>
						<table class="form-table">							
							<tr>
								<td class="td-label"><label>客服账号1 ： </label></td>
								<td class="td-content user1">
									<input class="easyui-textbox" name="num1" id="num1" type="text" disabled/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>客服电话： </label></td>
								<td class="td-content user1">
									<input class="easyui-textbox" name="pho1" id="pho1" type="text" disabled data-options="validType:'phoneNum'"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>客服当前状态 ： </label></td>
								<td class="td-content user1">
									<input class="easyui-textbox" name="sta1" id="sta1" type="text" disabled/>
									<a href="javascript:void(0)" onclick="user1()" id="user1" style="margin-left:100px;background-color: #e0ecff; width: 80px;" class="easyui-linkbutton button" plain="true">更改</a>
								</td>
							</tr>
							<tr style="height: 35px;"></tr>
							<tr>
								<td class="td-label"><label>客服账号2 ： </label></td>
								<td class="td-content user2">
									<input class="easyui-textbox" name="num2" id="num2" type="text" disabled/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>客服电话： </label></td>
								<td class="td-content user2">
									<input class="easyui-textbox" name="pho2" id="pho2" type="text" disabled data-options="validType:'phoneNum'"/>
								</td>
							</tr>
							<tr>
								<td class="td-label"><label>客服当前状态 ： </label></td>
								<td class="td-content user2">
									<input class="easyui-textbox" name="sta2" id="sta2" type="text" disabled/>
									<a href="javascript:void(0)" onclick="user2()" id="user2" style="margin-left:100px;background-color: #e0ecff; width: 80px;" class="easyui-linkbutton" plain="true">更改</a>
								</td>
							</tr>
						</table>
					</fieldset>
				</td>
			</tr>
		</table>
<script type="text/javascript">
$("#applicantName1").val(applicantName);
$("#applicantMailbox").val(applicantMailbox);
$("#applicantPhone").val(applicantPhone);

function updatePhone(){
	$('#dlg-login').dialog('open');
	$('#type').val("user");
	$('#bankCardId').val($("#id").val());
}

function user1(){
	if($("#user1").text()=='更改'){
		$(".user1").removeClass("td-content");
		$("#user1").linkbutton({text:'保存'});
		$("#num1").textbox('enable'); 
		$("#pho1").textbox('enable'); 
		$("#sta1").textbox('enable'); 
	}else{
		$(".user1").addClass("td-content");
		$("#user1").linkbutton({text:'更改'});
		$("#num1").textbox('disable'); 
		$("#pho1").textbox('disable'); 
		$("#sta1").textbox('disable'); 
	}
}

function user2(){
	if($("#user2").text()=='更改'){
		$(".user2").removeClass("td-content");
		$("#user2").linkbutton({text:'保存'});
		$("#num2").textbox('enable'); 
		$("#pho2").textbox('enable'); 
		$("#sta2").textbox('enable'); 
	}else{
		$(".user2").addClass("td-content");
		$("#user2").linkbutton({text:'更改'});
		$("#num2").textbox('disable'); 
		$("#pho2").textbox('disable'); 
		$("#sta2").textbox('disable'); 
	}
}
</script>
</body>
</html>