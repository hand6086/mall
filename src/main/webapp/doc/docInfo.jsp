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
<link rel="stylesheet" href="css/pintuer.css">
<link rel="stylesheet" href="css/admin.css">
<script src="js/jquery.js"></script>
<script src="js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong class="icon-reorder"> 方法说明</strong></div>
  <div class="padding border-bottom">  
	<table width="100%">
		<tr>
			<td><div class="h33">请求地址：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.requestAddress}</div></td>
		</tr>
		<tr>
			<td><div class="h333">接口说明：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.interfaceSpecification}</div></td>
		</tr>
		<tr>
			<td><div class="h333">请求方式：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.requestMode}</div></td>
		</tr>
		<tr>
			<td><div class="h333">请求Header：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.requestHeader}</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">数据类型：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.dataType}</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">传输方向：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.transmissionDirection}</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">加密方式：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.encryptionMode}</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">加密秘钥：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${lnkDocMenuLine.secretKeyEncryption}</td>
		</tr>
		 
		<tr>
			<td><div class="h333">请求参数：</div></td>
		</tr>
		<tr>
			<td>
				<table class="table table-bordered table-striped">
					<tr>
						<td width="100px;">参数</td>
						<td width="200px;">名称</td>
						<td width="100px;">是否必要</td>
						<td width="100px;">类型</td>
						<td>描述</td>
					</tr>
					
					<c:forEach items="${lnkDocParamList}" var="lnkDocParam">  
     					<tr>
							<td>${lnkDocParam.param}</td>
							<td>${lnkDocParam.paramName}</td>
							<td>${lnkDocParam.ifNecessary}</td>
							<td>${lnkDocParam.type}</td>
							<td>${lnkDocParam.menuDescribe}</td>
						</tr>
  					</c:forEach>	
					
				</table>
			</td>
		</tr> 
		
		<tr>
			<td><div class="h333">应答参数：</div></td>
		</tr>
		<tr>
			<td>
				<table class="table table-bordered table-striped">
					<tr>
						<td width="100px;">参数</td>
						<td width="200px;">名称</td>
						<td width="100px;">是否必要</td>
						<td width="100px;">类型</td>
						<td>描述</td>
					</tr>
					<c:forEach items="${lnkDocResultList}" var="lnkDocResult">  
     					<tr>
							<td>${lnkDocResult.param}</td>
							<td>${lnkDocResult.paramName}</td>
							<td>${lnkDocResult.ifNecessary}</td>
							<td>${lnkDocResult.type}</td>
							<td>${lnkDocResult.menuDescribe}</td>
						</tr>
  					</c:forEach>	
				</table>
			</td>
		</tr>
		<tr>
			<td><div class="h333">请求解码前：</div></td>
		<tr>
			<td>
			<div class="highlight">${lnkDocMenuLine.sampleBefore}</div>
			</td>
		</tr>
		<tr>
			<td><div class="h333">请求解码后：</div></td>
		<tr>
			<td>
			<div class="highlight">${lnkDocMenuLine.sampleAfter}</div>
			</td>
		</tr>
	
	</table>
  </div>
</div>
<script type="text/javascript">


</script>

</body>
</html>