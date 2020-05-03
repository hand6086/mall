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
			<td><div class="highlight">${docAppUrl}/action/portal/order/platformOrder/updateOrderLogistics</div></td>
		</tr>
		<tr>
			<td><div class="h333">接口说明：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">根据订单编号更新订单物流信息</div></td>
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
					<tr>
						<td>orderNum</td>
						<td>订单编号</td>
						<td>是</td>
						<td>字符串</td>
						<td style="color:red;">加密</td>
					</tr>
					<tr>
						<td>logisticsCompany</td>
						<td>物流公司名称</td>
						<td>是</td>
						<td>字符串</td>
						<td style="color:red;">加密</td>
					</tr>
					<tr>
						<td>logisticsNum</td>
						<td>物流单号</td>
						<td>是</td>
						<td>字符串</td>
						<td style="color:red;">加密</td>
					</tr>
					
					<tr>
						<td>logisticsAddress</td>
						<td>发货地址</td>
						<td>否</td>
						<td>字符串</td>
						<td style="color:red;">加密</td>
					</tr>
					<tr>
						<td>shippingTime</td>
						<td>发运时间</td>
						<td>否</td>
						<td>字符串</td>
						<td style="color:red;">加密：格式yyyymmddhhmiss，<br/>如:2017年10月1日12点36分24秒 20171001123624</td>
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
				</table>
			</td>
		</tr>
	
	</table>
  </div>
</div>
</body>
</html>