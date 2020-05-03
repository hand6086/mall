<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>忘记密码</title>
<%
	String ctxPath = request.getContextPath();
	String version = "2.9.21" + application.getAttribute("contextInitTimeStamp");//版本号
%>

<h3 class="head"><%-- <img src="<%=ctxPath%>/static/images/shareLogo.jpg" width="80px" class="img" alt="Logo"/> --%><p>忘&nbsp;记&nbsp;密&nbsp;码</p></h3>
<script src="<%=ctxPath%>/static/js/jquery.min.js?version=<%=version%>"
	type="text/javascript"></script>
<script
	src="<%=ctxPath%>/static/jquery-validate/jquery.validate.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="<%=ctxPath%>/static/jquery-validate/additional-methods.js"></script>
<style type="text/css">
body{
	background:#EBEBEB;
}
:-webkit-autofill {
  -webkit-text-fill-color: #000 !important;
  transition: background-color 3600s ease-in-out 0s;
}

.head {
	color:gray;
	width:100%;
	margin-top: -9px;
	margin-left:-8px;
	background: #eef3f9;
	padding: 28px;
	padding-top:5%;
	padding-bottom:5%;
	padding-left:8px;
	padding-right:8px;
	text-align:center;
}

.enter {
	margin-top: 30px;
	overflow: hidden;
	width:340px;
	height:90px;
	position:absolute;
	top:40%;
}
.enter1{
	top:50%;
}
.enter2{
	top:60%;
}

.center>div {
	width: 100%;
	height: 100%;
	margin:auto;
}

.entry {
	width: 310px;
	height: 45px;
	border: 1px solid #e0e0e0;
	float: left;
	border-radius:10px;
	padding-left:15px;
	color:gray;
}

.entry-code {
	width: 175px;
	padding-right:0px;
	border-radius:5px;
}

.code {
	border-radius:5px;
	width: 130px;
	margin-top:1px;
	margin-left: 0px;;
	height: 47px;
	float: left;
	background: #ffffff;
	color: #02b9cd;
	font-size: 14px;
	text-align: center;
	line-height: 32px;
	cursor: pointer;
	border: 0;
}
.codeWait {
	border-radius:5px;
	width: 130px;
	margin-top:1px;
	margin-left: 0px;;
	height: 47px;
	float: left;
	background: gray;
	color: #fff;
	font-size: 14px;
	text-align: center;
	line-height: 32px;
	border: 0;
}
.fieldset {
	width:320px;
	border: none;
	margin:auto;
	
}

.show-info {
	font-size: 16px;
	text-align:center;
	width:320px;
	color: #02b9cd;
}

.bottom {
	margin-bottom:30px;
	position:absolute;
	top:70%;
	width:320px;
	
}
.bottom1{
	top:75%;
}
.submit {
	padding-top:10px;
	color:white;
	cursor: pointer;
	border-radius: 5px;
	font-size: 20px;
	width: 320px;
	height: 40px;
	background: #02b9cd;
}
.error {
	color: white;

}
.errorBorder{
	float:left;
	width:170px;
	height:25px;
	border-radius:5px;
	padding:0px;
	border:1px solid #02b9cd;
	background:#02b9cd;
	position:absolute;
	margin-left:2px;
	top:52px;
	
}
.top{
	border-width:5px;
	border-style:none solid solid solid;
	border-color:#02b9cd transparent;
	margin-left:10px;
	position:absolute;
	top:-6px;
}
.progress{
	width:100%;
	margin-top:-18px;
}
.left{
    position: absolute;
	width:32.6%;
	border-bottom:5px solid orange;
	left:-1%;
}
.center{
    position: absolute;
	width:35%;
	border-bottom:5px solid orange;
	left:32%;
}
.right{
    position: absolute;
	width:34%;
	border-bottom:5px solid #02b9cd;
	right:0px;
}
.step1{
	padding:0px;
	margin-top:-30px;
	position:absolute;
	left:32%;
	margin-left:-10px;
	
}
.step2{
	padding:0px;
	margin-top:-30px;
	position:absolute;
	right:30%;
	margin-left:-10px;
	
}
input,button,select,textarea{outline:none;}
</style>

<div class="progress">
	<div class="left"></div>
	<div class="right"></div>
	<div class="center"></div>
	<canvas id="step1" width="80px" height="80px" style="border:none" class="step1">
	</canvas>
	<script type="text/javascript">

	var c=document.getElementById("step1");
	var cxt=c.getContext("2d");
	cxt.strokeStyle="orange";
	cxt.lineWidth=5;
	cxt.beginPath();
	cxt.arc(30,30,26,0,Math.PI*2);	
	cxt.closePath();
	cxt.stroke();
	cxt.fillStyle="#EBEBEB";
	cxt.fill();
	cxt.fillStyle="orange";
	cxt.lineWidth=1;
	cxt.fillText("验证",18,26,35);
	cxt.fillText("手机",18,46,35);
	</script>
	<canvas id="step2" width="80px" height="80px" style="border:none" class="step2">
	</canvas>
	<script type="text/javascript">

	var c=document.getElementById("step2");
	var cxt=c.getContext("2d");
	cxt.strokeStyle="orange";
	cxt.lineWidth=5;
	cxt.beginPath();
	cxt.arc(30,30,26,0,Math.PI*2);
	cxt.stroke();
	cxt.fillStyle="#EBEBEB";
	cxt.fill();
	cxt.fillStyle="orange";
	cxt.lineWidth=1;
	cxt.fillText("重置",18,26,35);
	cxt.fillText("密码",18,46,35);
	cxt.closePath();
	</script>
</div>

</head>
<body>

	<form id="form1">
				<fieldset class="fieldset">
					<div class="enter enter1">
 						<label id="username" class="userid" style="display: none"><%=request.getParameter("username")%></label>
 						<label id="contactPhone" class="userid" style="display: none"><%=request.getParameter("contactPhone")%></label>
						<input placeholder="设置密码"name="passwd1" id="passwd1" type="text" class="entry" />
						<div for="passwd1" class="errorBorder" style="display: none" id="passwd1border">
    						<div class="top"></div>
						</div>
					</div>
					
					<div class="enter enter2">
						<input placeholder="密码确认"name="passwd2" id="passwd2" type="text" class="entry"/>
						<div for="passwd2" class="errorBorder" style="display: none" id="passwd2border">
    						<div class="top"></div>
						</div>
					</div>
					<div class="bottom">
						<label id="showError" style="display: none" class="show-info"></label>
					</div>
					<div class="bottom bottom1">
						<div class="submit" id="confirm" align="center">确&nbsp;认&nbsp;提&nbsp;交</div>
					</div>
				</fieldset>
	</form>

	<script language="javascript">
 		$().ready(function() {
 			var ua = navigator.userAgent;
		    if(ua.indexOf("Android")>0 || ua.indexOf("iPhone")>0 || ua.indexOf("iPad")>0){
			$(".step1").css("left","20%");
			$(".step2").css("right","13%");
			$(".left").css("width","25%");
			$(".center").css("left","24%");
			$(".center").css("width","42%");
			$(".progress").css("margin-top","-25px");
			$(".head").css("padding-bottom","15%");
			
			$(".enter").css("top","35%");
			$(".enter1").css("top","48%");
			$(".enter2").css("top","60%");
			$(".bottom").css("top","73%");
			$(".bottom1").css("top","78%");
		    }
		});
		
$(function() {
			
			$("#confirm").click(function() {
				var p_username = $("#username").text();
				var p_phone = $("#contactPhone").text();
				var p_passwd = $("#passwd1").val();
				var p_passwd2= $("#passwd2").val();
							
				if($('#form1').valid()){
					$.post('<%=ctxPath%>/action/portal/user/resetPassword',
					{
						username : p_username,
                        contactPhone:p_phone,
						password : p_passwd
					},
					function(data) {
						if (data.success) {
							window.location.href = "<%=ctxPath%>/login.jsp";
						}else{
							$('#showError').show();
							$('#showError').text(data.result);
						}
					});
				}
				
			}); 
			
			$("#userid").click(function(){
				$('#showError').hide();
				$("#userid").attr({"style":"color:black"});
			});
			$("#passwd1").keydown(function(){
				$("#passwd1").attr({"type":"password"});
				$("#passwd1").attr({"style":"color:black"});
			});
			$("#passwd2").keydown(function(){
				$("#passwd2").attr({"type":"password"});
				$("#passwd2").attr({"style":"color:black"});
			});
		});
		var validstate=$("#form1").validate({
	    	rules:{
	    		passwd1:{
	    			required:true,
	    			minlength:8,
	    			passwdFormat:true,
	    		},
	    		passwd2:{
	    			required:true,
	    			equalTo:'#passwd1'
	    		},
	    	},
	    	messages:{
	    		
	    		passwd1:{
	    			required:"请输入密码",
	    			minlength:"密码长度不能少于8位",
	    			passwdFormat:"密码应包含字母和数字",
	    		},
	    		passwd2:{
	    			required:"请再次输入密码",
	    			equalTo:"两次输入的内容不一致"
	    		},
	    	},
	    	errorElement: "span",
	    	errorPlacement: function(error, element) {
				// Append error within linked label
				
				$( element )
					.closest( "form" )
						.find( "div[for='" + element.attr( "id" ) + "']" )
							.append( error );
				$('#' + element.attr( "id" ) +"border" ).show();
				
			},
			success:function(label) {
				$(label).parent().hide();
				$(label).remove();
				
		    }
	    });
		</script>
</body>
</html>