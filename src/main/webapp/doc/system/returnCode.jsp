<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="../css/pintuer.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="../js/jquery.js"></script>
<script src="../js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong class="icon-reorder"> 状态返回码说明</strong></div>
  <div class="padding border-bottom">  
	<table width="100%">
		
		<tr>
			<td>
				<table class="table table-bordered table-striped">
					<tr>
						<td width="100px;">编码</td>
						<td width="200px;">描述</td>
					</tr>
					<tr>
						<td>100</td>
						<td>成功</td>
					</tr>
					<tr>
						<td>101</td>
						<td>参数错误</td>
					</tr>
					<tr>
						<td>102</td>
						<td>账号不存在错误</td>
					</tr>
					<tr>
						<td>103</td>
						<td>密码校验失败</td>
					</tr>
					<tr>
						<td>104</td>
						<td>企业编码错误</td>
					</tr>
					<tr>
						<td>105</td>
						<td>token失效</td>
					</tr>
					<tr>
						<td>120</td>
						<td>其他错误</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
  </div>
</div>
</body>
</html>