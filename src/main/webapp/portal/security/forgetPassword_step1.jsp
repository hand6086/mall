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
				<div class="liulist"></div>
				<div class="liulist"></div>
				<div class="liulist"></div>
				<div class="liutextbox">
					<div class="liutext for-cur">
						<em>1</em><br />
						<strong>填写账户名</strong>
					</div>
					<div class="liutext">
						<em>2</em><br />
						<strong>验证身份</strong>
					</div>
					<div class="liutext">
						<em>3</em><br />
						<strong>设置新密码</strong>
					</div>
					<div class="liutext">
						<em>4</em><br />
						<strong>完成</strong>
					</div>
				</div>
			</div>
 			<form id="form1" method="get" class="forget-pwd">
				<dl>
					<dt>账户名：</dt>
					<dd>
						<input type="text" id="noteTitle" name="noteTitle" placeholder="请输入登录账号" />
					</dd>
					<div class="clears"></div>
				</dl>
				<dl>
					<dt>验证码：</dt>
					<dd>
						<input type="text" id="simpleNote" name="simpleNote"/>
						<div class="yanzma">
								<img alt="验证码看不清" src="${AppContext.ctxPath}/action/security/forword/code"  title="验证码看不清，换一张" class="easyui-tooltip yanzmaCode"  id="validateCodeImg" onclick="changeImg()"/>
						</div>
					</dd>
					<div class="clears"></div>
				</dl>
				<div class="subtijiao">
					<input type="button" onClick="submitForm()"  value="提交" />
				</div>
			</form>
		</div>
	</div>
	
<script type="text/javascript">
	//刷新验证码
	function changeImg() {
		  //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
		  document.getElementById("validateCodeImg").src= '${AppContext.ctxPath}/action/security/forword/code?tamp='+(new Date()).valueOf();
	};
	
	//校验输入是否为空
	function check(){
		var inputAccnt =  $("#noteTitle").val();
		var inputCode = $("#simpleNote").val();
		if(inputAccnt == null || inputAccnt == ""){
			$.messager.alert("错误信息提示", "账户名不能为空！","warning");
			return false;
		}else if(inputCode == null || inputCode == ""){
			$.messager.alert("错误信息提示", "验证码不能为空！","warning");
			return false;
		}else{
		 	return true;
		}
	};
	
	//提交事件
	function submitForm(){
		if(check()){
			 $.post('${AppContext.ctxPath}/action/security/forword/validateAccount',
			      {
			 		noteTitle:$("#noteTitle").val(),
			 		simpleNote:$("#simpleNote").val()
			      },function (data){
			    	  if(!data.success){   
			    		  $.messager.alert("错误信息提示", data.result,"warning");
			    	  }else{
			    		  window.location.href='${AppContext.ctxPath}/action/security/forword/forgetPass/step2';
			    	  }
			      })
		}
	};
	
	function formclear() {
		$('#noteTitle').val('');
		$('#simpleNote').val('');
	}
</script>
</body>
</html>
