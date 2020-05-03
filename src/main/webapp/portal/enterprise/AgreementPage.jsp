<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.wap {
	 margin: 20px 100px;
}
.wap .wap-content {
	text-align:center;
}
input {
	margin: 40px 10px;
}
p {
	text-indent:2em;
}
</style>
<body>
	<div class="wap">
		<div class="head" style="background: #469ce7; color: #FFFFFF; padding: 20px 0; text-align: center; font-size: 18px;">协议确认</div>
		<div class="wap-content">
			<p>
			<h3>快购平台合作协议</h3>
			<p>
			V1.0版本生效时间：2018年4月 <br><br>
			签约须知：<br><br>
			<div class="iframe-content">
				<iframe src="agreementFile.jsp" width="800px" height="400px"></iframe>
			</div>
			<input type="checkBox" onclick="if (this.checked) {enable()} else {disable()}">
			<span>我已阅读</span>
			<a href="javascript:void(0);" onclick="window.location.href='${AppContext.ctxPath}/portal/enterprise/agreementFile.jsp'"><快购平台协议> </a>
			<div>
				<center>
					<a href="javascript:void(0)" disabled="true" style="background-color: #469ce7; width: 100px;" class="easyui-linkbutton" plain="true" id="accept" onclick="accept()">确认</a>
				</center>
			</div>
		</div>
		
	</div>
<script type="text/javascript">
	$.post("${AppContext.ctxPath}/action/portal/enterprise/queryByUserId",{},
			function(data){
				if(data.success){
					var enter = data.result;
					if(enter!=null){
						if(enter.storeStatus == "ALREADY_PAID"){
							$.messager.alert('操作提示','您的转账申请已审核通过！请点击确认进行协议确认！', 'info',function(){
								
							});
						}
					}
				}
		});
	
	function disable()
	{
		$('#accept').linkbutton('disable');
	}
	function enable()
	{
		$('#accept').linkbutton('enable');
	}
	
	function accept() {
		$.post('${AppContext.ctxPath}/action/portal/storeregister/storeStatusUpdate',{},
		function(data) {
			if (data.success) {
				window.location.href = "/login.jsp";
			} else {									
				alert("failed");
			}
		});
	}

</script>
</body>
</html>
	