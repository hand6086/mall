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
<title>账号注册</title>
<%
	String ctxPath = request.getContextPath();
	String version = "2.9.21" + application.getAttribute("contextInitTimeStamp");//版本号
%>

<h3 class="head"><img src="<%=ctxPath%>/static/images/shareLogo.jpg" width="80px" class="img" alt="Logo"/><p>帐&nbsp;号&nbsp;注&nbsp;册</p></h3>
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
	border-bottom:5px solid #02b9cd;
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
	cxt.strokeStyle="#02b9cd";
	cxt.lineWidth=5;
	cxt.beginPath();
	cxt.arc(30,30,26,0,Math.PI*2);
	cxt.stroke();
	cxt.fillStyle="#EBEBEB";
	cxt.fill();
	cxt.fillStyle="#02b9cd";
	cxt.lineWidth=1;
	cxt.fillText("账号",18,26,35);
	cxt.fillText("信息",18,46,35);
	cxt.closePath();
	</script>
</div>

</head>
<body>

	<form id="form">

				<fieldset class="fieldset">
					<div class="enter enter1">
						<input type="text" name="phonenumber" id="phonenumber" class="entry" value="请输入手机号码"/>
						<div for="phonenumber" class="errorBorder" style="display: none"  id="phonenumberborder">
    					<div class="top"></div>
						</div>
					</div>
					
					<div class="enter enter2">
						<input type="text" name="VerifyCode" id="VerifyCode" class="entry entry-code" value="请输入验证码"/>
						<input type="button" class="code" id="sendSMSCode" value="获取手机验证码"></input>
					</div>
					<div class="bottom">
						<label id="showError" style="display: none" class="show-info"></label>
					</div>
					<div class="bottom bottom1">
						<div class="submit" id="confirmCode" align="center"><b>下&nbsp;一&nbsp;步</b></div>
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
				var interval;
				
				$("#sendSMSCode").click(function() {
					var p_phone=$("#phonenumber").val();
					if(!p_phone){
						$('#showError').show();
						$('#showError').text("请输入手机号码");
					}
					else{
						
					if($('#form').valid())
					{
						$.post('<%=ctxPath%>/action/portal/storeregister/storeStatusUpdate',{
							contactPhone:p_phone
						},function(data){
							if(data.success){
								alert("调用成功");
							}else{
								$('#showError').show();
								$('#showError').text(data.result);
							}
						})
						}
					}
				});
				
				$("#confirmCode").click(function() {
					var p_code = $("#VerifyCode").val();
					var p_phone=$("#phonenumber").val();
					if(!p_code&&!p_phone){
						$('#showError').show();						
						$('#showError').text("验证码或手机号错误");
					}
					else{
						
						if($('#form').valid()){
							
							$.post('<%=ctxPath%>/action/portal/sms/verifyCode',
							{
								VerifyCode : p_code,
								contactPhone:p_phone
							},
							function(data) {
								if (data.success) {
									clearInterval(interval);									
									$('body').load("<%=ctxPath%>/accountinfo.jsp",{"phonenumber":p_phone});
									<%-- window.location.href = "<%=ctxPath%>/accountinfo.jsp?a=123"; --%>
									
								} else {									
									$('#showError').show();
									$('#showError').text("验证码错误");
									
								}
							}
							);
							
							}
					}
					}); 
				$("#phonenumber").click(function(){
					$('#showError').hide();
					if($("#phonenumber").val().indexOf("请输入手机号码")>=0){
						$("#phonenumber").val(null);
						$("#phonenumber").attr({'style':'color:black'});
					}
				});
				$("#VerifyCode").click(function(){
					$('#showError').hide();
					if($("#VerifyCode").val().indexOf("请输入验证码")>=0){
						$("#VerifyCode").val(null);
						$("#VerifyCode").attr({'style':'color:black'});
					}
				});
				
				var validstate=$("#form").validate({
			    	rules:{
			    		phonenumber:{
			    			required:true,
			    			mobilePhone:true
			    		},
			    		
			    	},
			    	messages:{
			    		phonenumber:{
			    			required:"手机号码不能为空",
			    			mobilePhone:"请输入正确的手机号码",
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
			});	
		</script>
</body>
</html>