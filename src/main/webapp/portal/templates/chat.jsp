<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<%@ include file="/portal/header.jsp" %>
	<style type="text/css">

		html,body{
			height: 100%;
			width: 100%;
		}
		body {
			display: flex;
			align-items: center;
			justify-content: center;
			background-color: #1b3163;
		}
		.head {
			color:wheat;
			position: fixed;
			top: -10px;
			left: 30px;
			width:30%;
			height: 30%;
			padding: 28px;
			padding-top:5%;
			padding-bottom:5%;
			padding-left:8px;
			padding-right:8px;
			text-align:center;
			font-size: 30px;
			border-radius: 120px;
		}
		.center>div {
			width: 100%;
			height: 100%;
			margin:auto;
		}
		.fieldset {
			width:320px;
			border: none;
			margin: -64px;

		}
		.bottom {
			margin-bottom:30px;
			position:center;
			top:70%;
			width:320px;

		}
		.bottom1{
			top:75%;
		}
		.submit {
			padding-top:20px;
			color:white;
			cursor: pointer;
			border-radius: 40px;
			font-size: 20px;
			width: 275px;
			height: 46px;
			background: #469ce7;
		    margin-left: 23px;
		}

		.body-wrapper{
			background-image: url("/static/images/online.jpg") ;
			background-repeat: no-repeat;
			background-position: center;
			background-size: auto 100%;
			height: 60vh;
			width: 100%;
			position: relative;
		}
		.content-wrapper{
			position: absolute;
			bottom: 0;
			width: 100%;
			display: flex;
			align-items: center;
			justify-content: center;
			flex-direction: column;
			color: white;
		}
	</style>
</head>
<body>
	<%--<h3 class="head"><p>客&nbsp;服&nbsp;平&nbsp;台</p></h3>--%>
	<%--<form id="form">--%>

		<%--<fieldset class="fieldset">--%>
			<%--<div class="bottom bottom1">--%>
				<%--<div class="submit" id="gotoUrl" align="center" ><b>跳转人工客服工作台</b></div>--%>
			<%--</div>--%>
		<%--</fieldset>--%>
	<%--</form>--%>
	<div class="body-wrapper">
		<h3 class="head">O2O在线沟通频道</h3>
		<form class="content-wrapper">
			<fieldset class="fieldset">
				<div class="bottom bottom1">
					<div class="submit" id="gotoUrl" align="center"><b>跳转人工客服工作台</b></div>
				</div>
			</fieldset>
		</form>
	</div>
</body>



<script language="javascript">
	<%--默认为true--%>
    	var isClick=true;
        $("#gotoUrl").click(function() {
            if(!isClick){
                return;
            }
            isClick=false;
            $.post("/action/portal/manager/getConsoleDirectUrl",{id:appCtx.userId},function(data){
               isClick=true;
                var data =  eval('(' + data + ')');
                if(data.code == '1000'){
                    window.open(data.data.url);
                }else {
                    if(data.result){
                        $.messager.alert("信息", data.result , "info");
                    }else {
                        $.messager.alert("信息", "跳转人工客服平台失败，请确认智齿邮箱正确", "info");
                    }
                }
            });
        });
</script>
</body>
</html>