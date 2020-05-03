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
  <div class="panel-head"><strong class="icon-reorder"> 方法说明</strong></div>
  <div class="padding border-bottom">  
	<table width="100%">
		<tr>
			<td><div class="h33">请求地址：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">${docAppUrl}/action/portal/order/platformOrder/queryLogisticsCompany</div></td>
		</tr>
		<tr>
			<td><div class="h333">接口说明：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">查询物流公司列表</div></td>
		</tr>
		<tr>
			<td><div class="h333">请求方式：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">POST</div></td>
		</tr>
		<tr>
			<td><div class="h333">请求Header：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">Referer=http://www.hand-china.com/</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">数据类型：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">JSON</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">传输方向：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">外部调用</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">加密方式：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">DES</div></td>
		</tr>
		
		<tr>
			<td><div class="h333">加密秘钥：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">F6a9f50C</td>
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
					<tr>
						<td>session_token</td>
						<td>Token值</td>
						<td>是</td>
						<td>字符串</td>
						<td></td>
					</tr>
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
					<tr>
						<td>returnCode</td>
						<td>接口返回编码</td>
						<td>是</td>
						<td></td>
						<td>参见：系统参数-返回状态码</td>
					</tr>
					<tr>
						<td>returnStatus</td>
						<td>接口返回状态</td>
						<td>是</td>
						<td></td>
						<td>SUCCESS：成功；ERROR：失败</td>
					</tr>
					<tr>
						<td>returnMsg</td>
						<td>接口返回消息</td>
						<td>否</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>listValueList</td>
						<td>返回物流公司列表</td>
						<td>是</td>
						<td></td>
						<td style="color:red;">加密，解密后如下表</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td><div class="h333">interfaceOrderList 解密列表：</div></td>
		</tr>
		<tr>
			<td>
				<table class="table table-bordered table-striped">
					<tr>
						<td width="100px;">实体归属</td>
						<td width="100px;">参数</td>
						<td width="200px;">名称</td>
						<td width="100px;">是否必要</td>
						<td>描述</td>
					</tr>
					
					<tr>
						<td></td><td>logisticsCompany</td><td>物流公司名称</td><td></td><td></td>
					</tr>
					<tr>
						<td></td><td>logisticsCode</td><td>物流公司代码</td><td></td><td></td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td><div class="h333">示例（解密前）：</div></td>
		<tr>
			<td>
				"{
				    \"returnCode\": \"100\",
				    \"returnStatus\": \"SUCCESS\",
				    \"listValueList\": \"czJn7lDmwePzhtLBHzkheLlFiGOt6zQwPH1VSwM1vdDYWK2OTX7qUjNyaGz2yS7X+H1uDJGJBx6cBZfipNTkdSOaTJHKMmdhdj+ldDFeKCdUfAPZszOn6I1vMzNZRtzKOVQhjc1OXCzAqxvzWYb/Ue26fHj0wttWDprb358Dcrc=\"
				}"
			</td>
		</tr>
		<tr>
			<td height="20px;"></td>
		</tr>
		<tr>
			<td><div class="h333">示例（解密后）：</div></td>
		<tr>
			<td>
		"{
		    \"returnCode\": \"100\",
		    \"returnStatus\": \"SUCCESS\",
		    \"listValueList\": \"[
		        {
		            \\\"logisticsCompany\\\": \\\"EMS\\\",
		            \\\"logisticsCode\\\": \\\"ems\\\"
		        },
		        {
		            \\\"logisticsCompany\\\": \\\"\\\顺\\\丰\\\速\\\运\\\",
		            \\\"logisticsCode\\\": \\\"shunfeng\\\"
		        }
		    ]\"
		}"
			</td>
		</tr>
	
	</table>
  </div>
</div>
</body>
</html>