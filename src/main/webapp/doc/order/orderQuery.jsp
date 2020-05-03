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
			<td><div class="highlight">${docAppUrl}/action/portal/order/platformOrder/queryByOrderNum</div></td>
		</tr>
		<tr>
			<td><div class="h333">接口说明：</div></td>
		</tr>
		<tr>
			<td><div class="highlight">根据订单编号查询订单信息</div></td>
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
						<td>count</td>
						<td>返回数量/td>
						<td>否</td>
						<td></td>
						<td>返回空</td>
					</tr>
					<tr>
						<td>interfaceOrderList</td>
						<td>订单信息/td>
						<td>是</td>
						<td></td>
						<td style="color: red;">DES加密，解密后字段如下表</td>
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
						<td>订单头</td><td>orderNum</td><td>订单编号（主键）</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>customerName</td><td>消费者用户名</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>contact</td><td>收货人</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>province</td><td>省</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>city</td><td>市</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>district</td><td>区／县</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>address</td><td>详细地址</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>contactPhone</td><td>联系电话</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>businessName</td><td>商户名称</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>orderStatus</td><td>订单状态</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>orderTime</td><td>下单时间</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>orderAmount</td><td>订单总金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>payType</td><td>支付方式</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>payTime</td><td>付款时间</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>logisticsStatus</td><td>物流状态</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>logisticsCompany</td><td>物流公司</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>logisticsNum</td><td>物流单号</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>shippingTime</td><td>发运时间</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>allDiscountAmount</td><td>优惠总金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>customerComments</td><td>买家留言</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>cancelTime</td><td>取消时间</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>gightGroups</td><td>拼团名称</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>couponAmount</td><td>优惠券金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>orderComments</td><td>订单备注</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单头</td><td>logisticsPayAmount</td><td>总运费</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>lineId</td><td>行号（主键）</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>productName</td><td>商品名称</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>productCode</td><td>商品条码</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>marketPrice</td><td>报价</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>qtyReq</td><td>数量</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>marketPriceAmount</td><td>报价总金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>dealPrice</td><td>成交价</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>dealPriceAmount</td><td>成交总金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>giftFlag</td><td>是否赠品</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>itemDiscountAmount</td><td>促销活动名称</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>itemDiscountAmount</td><td>优惠总金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>couponName</td><td>优惠券名称</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>couponDiscount</td><td>优惠券抵扣金额</td><td></td><td></td>
					</tr>
					<tr>
						<td>订单行</td><td>logisticsPay</td><td>商品运费</td><td></td><td></td>
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
				    \"interfaceOrderList\": \"7Exhhunr194RZFcB+8BLtGBPnaho9NhUvQ6Ed93XZxvj6szavOURZ6Fs2nVj6IoDGb+vDeoPGHPYjox72Y4wcSTbEDV0D8mXTeKJAnKy8WY/K5ZyUyPaGxHFnP36ZVZw42EuDVNB3xglQII0mtmf9J4lJN0eL5eKdz4ecxez4RAn8Jigt3uU9HUC3M/R/qU8Nquje+E5rP22xzjFXIJ5EbR9vCWRUoLkPw22y9o54pks+8HD/oNdyCnYyWu/JFWgMf1Hsd+keCsQU5Mz+pIKTuiYMwlk84xGoaYs3Q8SR2SgGz+MpnWvKuEJ81OAEKWlC3/uku3DWHloDqqXGXZ5onisOD9wygoeC2D+jJAf107HwsTH4yccfg6dnjoM+pMMXGN8cEGMQ0FSnIU+8bAbYgKoalkqRCxbAZTYVlZlfcELi28ojf22BdoONX/r3jbkFaRxtNHIxMz+T5mEX/2Kn7lwrb+KmmRB9fXVB+HBLF3r/FIESz1A3Y+5sAROzKUayBbVAcAErBU0WTDmsO6iX6k0ZpXuTGGa+qKrA/qXP7Uhx/obz7k/IvWQFfTXeVua+okokr19RtRfwcR6fxelunCEFXRSPYW2rd9jPL89KMpEYOi2DSnlSYBu3DTdqBYC9xq4dR1RXXyaIi7oFaRxoPC1sv63C972XGYCudknG/cVpXcx13kgHy6XdyiGcz0P176nEylUG/bnS2yogCi7ubeWdzZGhfrr19utvkESKZXF6HvTBusTHJwat5bUxKM0bi6NnY3GjzdtQfMKSuLhUsSuvVNoeKxEUHB5W/dgNkBekOTZpfj9Jpsp2CNeVirx29M5VvwKIugNAbwVkkQWP7cvu/e2Zy7R7T43ci356eZyuLLbWc6Uw3Y7tCXefue22SHcKtzBOWvMHEEFs0xPJcl3Ksm0iWGZJ4gzQyangEZnVUcVFcnpmEVUfd7pYFCd9vvnSKETEasgXFRr7/SWok0UqVayGKkFeo0Z2TB5tKpLtpTErvU0mPTzdqpZCGx9G2e8cPAES70crFn6VXtRbayJKalPsCN9ariRWQ/WQ3WmC0q09VfJgcoiL1a9hLcu\"
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
				    \"interfaceOrderList\": \"[
				        {
				            \\\"interfaceOrderLineList\\\": [
				                {
				                    \\\"lineId\\\": \\\"3@1066800\\\",
				                    \\\"productName\\\": \\\"\\\\u7EAF\\\\u751F\\\\uFF08500ml*12\\\\u542C\\\\uFF09\\\",
				                    \\\"marketPrice\\\": \\\"90.0000000\\\",
				                    \\\"qtyReq\\\": \\\"1.0000000\\\",
				                    \\\"dealPrice\\\": \\\"90.0000000\\\",
				                    \\\"orderId\\\": \\\"3@1066801\\\"
				                }
				            ],
				            \\\"id\\\": \\\"3@1066801\\\",
				            \\\"corpid\\\": \\\"102\\\",
				            \\\"orderNum\\\": \\\"A10000022533\\\",
				            \\\"customerName\\\": \\\"\\\\u53F0\\\\u513F\\\\u5E84\\\\u529E\\\\u4E8B\\\\u5904\\\",
				            \\\"province\\\": \\\"\\\\u8FBD\\\\u5B81\\\\u7701\\\",
				            \\\"city\\\": \\\"\\\\u5927\\\\u8FDE\\\\u5E02\\\",
				            \\\"district\\\": \\\"\\\\u4E2D\\\\u5C71\\\\u533A\\\",
				            \\\"address\\\": \\\"\\\\u8363\\\\u6C11\\\\u885734\\\\u53F7\\\",
				            \\\"businessName\\\": \\\"\\\\u53F0\\\\u513F\\\\u5E84\\\\u529E\\\\u4E8B\\\\u5904\\\",
				            \\\"orderStatus\\\": \\\"\\\\u9000\\\\u6B3E\\\\u4E2D\\\",
				            \\\"orderTime\\\": \\\"2017-09-2717: 17: 39\\\",
				            \\\"orderAmount\\\": \\\"60.0000000\\\",
				            \\\"payType\\\": \\\"\\\\u5728\\\\u7EBF\\\\u652F\\\\u4ED8\\\",
				            \\\"payTime\\\": \\\"2017-09-2716: 26: 06\\\",
				            \\\"allDiscountAmount\\\": \\\"30.0000000\\\",
				            \\\"customerComments\\\": \\\"\\\",
				            \\\"gightGroups\\\": \\\"\\\",
				            \\\"couponAmount\\\": \\\"30.0000000\\\",
				            \\\"orderComments\\\": \\\"\\\",
				            \\\"startRow\\\": 0,
				            \\\"endRow\\\": 0
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