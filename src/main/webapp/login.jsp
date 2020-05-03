<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="appQrCodeImg" value="<%=com.hand.core.util.AppConstants.appQrCodeImg%>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Link CRM</title>
<%
		String ctxPath = request.getContextPath();
		String version = "2.9.21" + application.getAttribute("contextInitTimeStamp");//版本号
	%>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0, width=device-width" name="viewport">
    <meta content="telephone=no" name="format-detection">
    <meta content="email=no" name="format-detection">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/static/css/loginnew.css?version=<%=version%>">
<script src="<%=ctxPath%>/static/js/jquery.min.js?version=<%=version%>" type="text/javascript"></script>
<script src="<%=ctxPath%>/static/js/jquery.hiSlider.min.js?version=<%=version%>" type="text/javascript"></script>
<script src="<%=ctxPath%>/static/js/jquery.cookie.js?version=<%=version%>" type="text/javascript"></script>
<script src="<%=ctxPath%>/static/js/main.js?version=<%=version%>"></script>
<script src="<%=ctxPath%>/static/js/md5.js?version=<%=version%>"></script>
<script language="javascript">
	if(window != top){//防止首页嵌套在子页面
		top.location.href =window.location.href;
	}
	window.history.forward(1);//防止浏览器后退
	$(function() {
		//不支持浏览器提醒
		isBrowserSupport();

        getTicketImg();
		
		$('.loginbox').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		});
		$('#password').keydown(function(e){
			if(e.keyCode==13){
				var user = $('#username').val();
				var pass = $('#password').val();
				var verifyCode = $('#verifyCode').val();
				if(user != "" && pass != "" ){
					if(verifyCode != "" && verifyFlag == true){
						document.loginForm.submit();
					} else{
						$('#errorMessage').html('请输入正确验证码');
					}
				}	
			}
		}); 
		$('#username').keydown(function(e){
			if(e.keyCode==13){
				var user = $('#username').val();
				var pass = $('#password').val();
				var verifyCode = $('#verifyCode').val();
				if(user != "" && pass != ""){
					if(verifyCode != "" && verifyFlag == true){
						document.loginForm.submit();
					} else{
						$('#errorMessage').html('请输入正确验证码');
					}
				}
			}
		}); 
		
	 	$('#checkNumber').keydown(function(e){
			if(e.keyCode==13){
				var user = $('#username').val();
				var pass = $('#password').val();
				var verifyCode = $('#verifyCode').val();
				if(user != "" && pass != "" ){
					if(verifyCode != "" && verifyFlag == true){
						document.loginForm.submit();
					} else{
						$('#errorMessage').html('请输入正确验证码');
					}
				}
			}
		}); 		
	 	$('#verifyCode').keydown(function(e){
			if(e.keyCode==13){
				var user = $('#username').val();
				var pass = $('#password').val();
				var verifyCode = $('#verifyCode').val();
				if(user != "" && pass != ""){
					if(verifyCode != "" && verifyFlag == true){
						document.loginForm.submit();
					} else{
						$('#errorMessage').html('请输入正确验证码');
					}
				}
			}
		}); 		
		$('#btnsubmit').click(function(){
			var user = $('#username').val();
			var pass = $('#password').val();
			var verifyCode = $('#verifyCode').val();
			if(user != "" && pass != ""){
				if(verifyCode != "" && verifyFlag == true){
					document.loginForm.submit();
				} else{
					$('#errorMessage').html('请输入正确验证码');
				}
			} 
		});
				
		var username = $.cookie('username');
		var password = $.cookie('password');
		$('#username').val(username);
		$('#password').val(password);
		if (username != null && password != null) {
			document.getElementById("rember_me").checked = true;
		}
		
		$('input:checkbox').on('change', function() {
			if ($('input[name="firstCheck"]').prop("checked")) {
				var username = $("#username").val();
				var password = $("#password").val();
				$.cookie("username", username, {
					expires : 7
				});
				$.cookie("password", password, {
					expires : 7
				});
			} else {//删除cookie
				$.cookie('username', '', {
					expires : -1,
					path : '/'
				});
				$.cookie('password', '', {
					expires : -1,
					path : '/'
				});

			}
		});
	}); 

	function checkNumberImage() {
		var imageNumber = document.getElementById("imageNumber");
		imageNumber.src = "${AppContext.ctxPath}/portal/image.jsp?timestamp="
				+ new Date().getTime();
	}
	function fastExperience(){
		$('#username').val('CRM1101');
		$('#password').val('');
		loginSubmit();
		$('#username').val('');
		$('#password').val('');
	}
	function loginSubmit(){
		var user = $('#username').val();
		var pass = $('#password').val();
		var verifyCode = $('#verifyCode').val();
		if(user != "" && pass != ""){
			if(verifyCode != "" && verifyFlag == true){
				document.loginForm.submit();
			} else{
				$('#errorMessage').html('请输入正确验证码');
			}
		}
	}
</script>
<style type="text/css">
.denglu1{ margin:15px 20px 30px 20px; height:40px; line-height:40px; width:110px; background:#469ce7; display:inline-block; text-align:center; color:#fff;}
.zhuce{ margin:15px 20px 30px 20px; height:40px;width:110px; float:right;line-height:40px; background:#469ce7; display:block; text-align:center; color:#fff;}
</style>
</head>
    <body class="denglu">
    	<div class="denglu_top">    		
		    <div class="denglu_top_left" id="dengluTop"><p class="size1">管理平台</p></div>
    	</div>
    	<div class="denglu_content">
    		<div class="denglu_banner" id="juti1">
			     <img src="<%=ctxPath%>/static/css/img/banner1.png">
			</div>
		    <div class="denglu_juti" id="juti">

			    <%-- <div class="qrimg01">
			     	<span style="display:block;margin:15px;margin-left:45px;" class="apptitle">IOS下载</span>
				    <div style="display:inline-block;margin-left:40px;">
				    	<div class="span12 margin-bottom-30" style="text-align:center;"></div>
				    	<a href="${iosDownloadLinkUrl}" target="_blank"><img class="img-qr " src="<%=ctxPath%>${iosQrCodeImg}"/></a>
				    	<span style="display:none;">扫描二维码安装</span>
				    </div>
			    </div> --%>
				<div class="mimaForm">
				    <form action="<%=ctxPath%>/j_spring_security_check" method="post" name="loginForm" id="loginForm">
					    <div class="denglu_juti_right">
					    <img src="<%=ctxPath%>/static/css/img/login_03.png" width="300px">
					    <div class="zhanghu">
					    <div class="zhanghu_juti">
					    <a class="shuru">
					    <div class="shuru_left"><img src="<%=ctxPath%>/static/css/img/login_10.png"></div>
					    <div class="shuru_right"><input   type="text" id='username' name="username" onclick="JavaScript:this.value=''" class="input"></div>
					    </a>
					    <a class="shuru">
					    <div class="shuru_left"><img src="<%=ctxPath%>/static/css/img/login_14.png"></div>
					    <div class="shuru_right"><input   type="password" class="input" id='password' name="password" value="" onclick="JavaScript:this.value=''"></div>
					    </a>
					    <a class="shuru">
					    <div style="width:150px; float:left;"><input style="outline:none;border-right: 1px solid #ddd;" type="text" class="input" id='verifyCode' name="verifyCode" value="" maxlength="6" onclick="JavaScript:this.value=''"/></div>
					    <object><a href="javascript:void(0)" ><img src="" id="randomImg" style="width:100px;height:45px"/></a></object>
					    </a>
					<!--
					    <a class="shuru">
					    <div class="shuru_left"><img src="${AppContext.ctxPath}/static/css/img/login_16.png"></div>
					    <div class="shuru_right1"><input name="" type="text" class="input"></div>
					    <div class="shuru_mid"><img src="${AppContext.ctxPath}/static/css/img/login_18.png"></div>
					    </a>
					    -->
					
					    </div>
					    <div class="mima">
					    <a class="mima_left"><input type="checkbox" value="" align="absmiddle" name="firstCheck" id="rember_me">记住密码</a>
					    <a class="mima_right" href="/forgotpassword.jsp">忘记密码？</a>
					   <!-- 
					    <a class="mima_right" href="/action/security/forword/forgetPass/step1">忘记密码？</a>
					     -->
					    </div>
					    <!-- <div style="margin-right:20px;">
					    	<a href="###" style="text-align: center;font-size: 14px;color: #469ce7;" onclick="fastExperience();">快速体验&nbsp;&nbsp;&nbsp;</a>
					    </div> -->
					    <div id="errorMessage" style="  text-align: center;
					    margin-left: 20px;width: 260px; margin-top: 10px; color: red;">${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</div>
					    <a class="denglu1"  href="###"  style="margin-top:10px;" id="btnsubmit">登录</a>

					    </div>
					    </div>
				
				    </form>
			    </div>
 		    </div>
	    </div>
<!-- 	    <div class="footer">版权所有 © 1996–2017 上海汉得信息技术股份有限公司 保留全部权利&nbsp;&nbsp;</br>黔ICP备16004808号</div> -->
	    <div class="denglu_bottom">
    	<div class="denglu_bottom_wrap" id="dengluBottom"><p>版权所有@2015-2018 青岛啤酒电子商务有限公司 保留全部权利&nbsp;&nbsp;</br>鲁ICP备14020027号</p></div>
    	</div>
    </body>
<script type="text/javascript">
/* 实现未知高度的垂直居中  start*/
$id=function(o){
	return document.getElementById(o) || o;
}
function vTop(inner){
	var outer = (inner.parentNode.className == 'denglu_top') ?  document.documentElement : inner.parentNode;
	var innerHeight = inner.offsetHeight,
		outerHeight = outer.offsetHeight ;
		(outerHeight > innerHeight) ? (function(){
			inner.style.marginTop = -innerHeight/2 + "px" ;
			inner.style.top = "50%";
		})()
		: (function(){
			inner.style.marginTop = 0;
			inner.style.top = 0;
		})();
}
function vMiddle(inner){
	var outer = (inner.parentNode.className == 'denglu_content') ?  document.documentElement : inner.parentNode;
	var innerHeight = inner.offsetHeight,
		innerWidth = inner.offsetWidth,
		outerHeight = outer.offsetHeight ,
		outerWidth = outer.offsetWidth ;
		(outerHeight > innerHeight) ? (function(){
			inner.style.marginTop = -innerHeight/2 + "px" ;
			inner.style.top = "50%";
		})()
		: (function(){
			inner.style.marginTop = 0;
			inner.style.top = 0;
		})();
		(outerWidth > innerWidth) ?  (function(){
			inner.style.marginLeft = -innerWidth/2 + "px" ;
			inner.style.left = "50%";
		})()
		: (function(){
			inner.style.marginLeft = 0;
			inner.style.left = 0;
		})();
}
function vBottom(inner){
	var outer = (inner.parentNode.className == 'denglu_bottom') ?  document.documentElement : inner.parentNode;
	var innerHeight = inner.offsetHeight,
	innerWidth = inner.offsetWidth,
	outerHeight = outer.offsetHeight ,
	outerWidth = outer.offsetWidth ;
	(outerHeight > innerHeight) ? (function(){
		inner.style.marginTop = -innerHeight/2 + "px" ;
		inner.style.top = "50%";
	})()
	: (function(){
		inner.style.marginTop = 0;
		inner.style.top = 0;
	})();
	(outerWidth > innerWidth) ?  (function(){
		inner.style.marginLeft = -innerWidth/2 + "px" ;
		inner.style.left = "50%";
	})()
	: (function(){
		inner.style.marginLeft = 0;
		inner.style.left = 0;
	})();
}
window.onload = window.onresize = function(){
	vTop($id("dengluTop"));
	vMiddle($id("juti"));
	vMiddle($id("juti1"));
	vBottom($id("dengluBottom"));
}
/* 实现未知高度的垂直居中 end*/
 


  //点击验证码图片
  $('#randomImg').click(function() {
    getTicketImg();
  });

var retrunCode = null;
/**
 * 获取图片验证码
 */
function getTicketImg() { 
  $("#verifyCode").val("");
  var time = new Date().getTime();
  // 火狐浏览器需要在后面加一个随机数(相同的话浏览器会有缓存),否则无效
  var imageCode = "${AppContext.ctxPath}/action/portal/sms/valicode?time=" + time;
    $.ajax({
        url: "${AppContext.ctxPath}/action/portal/sms/valicode",
        type:"post",
        data:{
            "time" : time
        },
        contentType: "application/x-www-form-urlencoded",
        success: function(data){
            var imgsrc = data.imgsrc;
            retrunCode = data.code;
            $("#randomImg").attr("src", "data:image/png;base64," + imgsrc);
        }
    });

}
 
var verifyFlag = false;
$("#verifyCode").on('input propertychange',function(e){
	var code = $("#verifyCode").val();
	// 每次输入后重置验证标识为false，防止输入正确后verifyFlag标识一直为true
	verifyFlag = false;
	//验证码长度为4的时候才进行后台验证
	if( code.length == 4 ){
	    var getCode = hex_md5(code.toLowerCase());
	    if(retrunCode == getCode){
            verifyFlag = true;
            $('#errorMessage').html('');
        }else {
            $('#errorMessage').html('验证码错误');
        }
	}else if( code.length > 4 ){
        $('#errorMessage').html('验证码错误');
    }
});
</script>
 
</html>
