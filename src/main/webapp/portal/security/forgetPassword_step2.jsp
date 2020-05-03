<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %> 
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css?version=<%=version%>"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/jquery-validate.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js?version=<%=version%>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author" contect="http://www.webqin.net">
	<title>忘记密码</title>
	<link type="text/css" href="${AppContext.ctxPath}/static/css/forgetPass.css?version=<%=version%>"
		rel="stylesheet" />
</head>

<body>
  <div class="content">
   <div class="web-width">
     <div class="for-liucheng">
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist"></div>
      <div class="liulist"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext for-cur"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div>
     <form method="get" class="forget-pwd">
       <dl>
	        <dt>已验证邮箱：</dt>
	       		<dd><input type="text" id="forgetEmail" readonly />&nbsp;&nbsp;&nbsp;<a style="color: #059CD4; width: 100px;" title="可能邮箱已被屏蔽，点击进入QQ邮箱白名单设置介绍" class="easyui-tooltip"  href="https://jingyan.baidu.com/article/d45ad148cc39eb69552b8034.html">收不到邮件？</a></dd>
	        <div class="clears"></div>
       </dl>
       <dl>
	        <dt>验证码：</dt>
	        	<dd><input type="text" id="emailCode"/> <button id="getEmailCode" type="button" onclick="sendEmailCode()">获取邮件验证码</button></dd>
	        <div class="clears"></div>
       </dl>
        <div class="subtijiao">
			<input type="button" onclick="submitForm2()"  value="提交" />
		</div>
     </form>
   </div>
  </div>
  
<script type="text/javascript">
	var noSendEmail = false;
	$(document).ready(function(){
		 //session中获取用户Email地址
		 var forgetUserEmail = "<%=session.getAttribute("forgetEmail")%>"; 
         $("#forgetEmail").val(forgetUserEmail);
	});
	
	//向邮箱发送验证码
	function sendEmailCode(){
		var forgetEmail = $('#forgetEmail').val();
		if(forgetEmail == null || forgetEmail == ""){
			 $.messager.alert("错误信息", "用户邮箱为空,请维护邮箱信息！","warning");
		}else{
			 var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
             if(!myreg.test(forgetEmail))//校验邮箱格式
             {
            	 $.messager.alert("错误信息", "用户邮箱格式错误,请维护邮箱信息！","warning");
             }else{
            	$("#getEmailCode").attr("disabled", true);
         	 	$.get('${AppContext.ctxPath}/action/security/forword/getEmailCode',{
         			
         		},function(data){
         			if (!data.success) {
         				$("#getEmailCode").attr("disabled", false);
         				$.messager.alert("错误信息提示", data.result,"warning");
         			}else{ //"获取邮箱验证码"1分钟内重复触发
         				setTimeout(function(){
         					$("#getEmailCode").attr("disabled", false);
         				},60000)
         			}
         		});  
             }
		}
	}
	 
	//提交邮箱验证码
	function submitForm2(){
		if(check()){
			  $.get('${AppContext.ctxPath}/action/security/forword/validateEmailCode', {
				  userEmail : $("#forgetEmail").val(),
				  emailCode : $("#emailCode").val()
				}, function(data) {
					if (!data.success) {
						 formclear();
						 $.messager.alert("错误信息提示", data.result,"warning");
					}else{
						window.location.href='${AppContext.ctxPath}/action/security/forword/forgetPass/step3';
					}
				}); 
		}
	};
	
	//提交前校验
	function check(){
		var forgetEmail = $("#forgetEmail").val();
		var emailCode = $("#emailCode").val();
		if(forgetEmail == null || forgetEmail == ""){
			$.messager.alert("错误信息提示", "用户邮箱不能为空！","warning");
			return false;
		}else if(emailCode == null || emailCode == ""){
			$.messager.alert("错误信息提示", "邮箱验证码不能为空！","warning");
			return false;
		}else{
			return true;
		} 
	} 
	
	//清除form输入框
	function formclear() {
		$('#emailCode').val('');
	}
	
</script>
</body>
</html>
