<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />

<%@ include file="/portal/header.jsp" %>
<!-- @插件 -->
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/at/css/jquery.atwho.min.css?version=<%=version%>"> 
<script src="${AppContext.ctxPath}/static/at/js/jquery.atwho.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/at/js/jquery.caret.min.js?version=<%=version%>"></script>
</head>
<body>
<center>
<h3>@消息发送</h3>
<textarea rows="10" cols="100"  id="inputor" class="inputor"></textarea><br/>
<button id="btn-submit">发送</button>
<!-- <button id="show" onclick="show()">show</button> -->
</center>
</body>
<script src="${AppContext.ctxPath}/static/js/at_config.js"></script>
<script type="text/javascript">

function show(){
	//var message = "你好管理员，有用户反馈信息，请查看,+++Ss%#@%$%^%%^%&^&**&(+_?<~sdakdjakdjkshfkhdsjkfasklfhjashfksdhfksjfhjddddddddddfffddddddddddddddddddddddddddddddddddddddddddddddddddddd你好管理员，有用户反馈信息，请查看你好管理员，有用户反馈信息，请查看你好管理员，有用户反馈信息，请查看你好管理员，有用户反馈信息，请查看你好管理员，有用户反馈信息，请查看" ;
	var message = "春江潮水连海平海上明月共潮生滟滟随波千万里何处春江无月明江流宛转绕芳甸月照花林皆似霰空里流霜不觉飞汀上白沙看不见江天一色无纤尘皎皎空中孤月轮江畔何人初见月江月何年初照人人生代代无穷已江月年年望相似不知江月待何人但见长江送流水白云一片去悠悠青枫浦上不胜愁谁家今夜扁舟子何处相思明月楼可怜楼上月徘徊应照离人妆镜台玉户帘中卷不去捣衣砧上拂还来此时相望不相闻愿逐月华流照君鸿雁长飞光不度鱼龙潜跃水成文昨夜闲潭梦落花可怜春半不还家江水流春去欲尽江潭落月复西斜斜月沉沉藏海雾碣石潇湘无限路不知乘月几人归落月摇情满江树";
	//alert(message.length);
	if(message.length>100){
		message= message.substr(0, 99)+"...";
	}
	message = "<div style='word-wrap:break-word;position:relative; width:270px;height:130px'>"+message+"<div style='right:0px; top:80px; position:absolute;width:300px,height:20px' ><a href='javascript:void(0)'>查看详情>></a></div></div>";
	$("#showBox").text(message);
	$.messager.show({
		title : '您有100条新系统信息',
		width: '300px',
		height: '150px',
		msg : message,
		timeout : 5000,
		showType : 'slide'
	});
}
$(function(){

	$inputor = $('.inputor').atwho(at_config);
	$("#btn-submit").click(function(){
		var msgContent = $("#inputor").val();
		if(!msgContent){
			$.messager.alert("警告","请输入内容");
			return;
		}
		$.ajax({
			data : {
				'msgContent' : msgContent,
				'msgType':'消息',
				'msgTitle':'@消息'
			},
			dataType : 'json',
			url : "${AppContext.ctxPath}/action/portal/message/atUserMsg",
			method : 'post',
			success : function(data){
				if(!data.success){
					$.messager.alert("警告","失败："+data.result);
				}else{
					$.messager.alert("提示","消息发送成功！");
					 $("#inputor").val("");
				}
			},
			error : function(){
				$.messager.alert("警告","消息发送失败！");
			}
		});
	});
	
	
});
</script>
</html>
