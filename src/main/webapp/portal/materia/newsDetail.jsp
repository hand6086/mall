<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/news1.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/news2.css">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/partner/static/css/dmsCommon.css">
<style type="text/css">
.main-t {
    background-color: #FFF;
    padding: 20px 400px 80px;
    min-height: 650px;
    overflow: hidden;
}
.rich_media_meta_list {
    line-height: 20px;
    font-size: 0;
    margin-top: 8px;
}
.rich_media_meta_list em {
    font-style: normal;
}
.rich_media_meta_text {
    color: #8c8c8c;
}
.rich_media_meta {
 	max-width: none;
    //display: inline-block;
    vertical-align: middle;
    margin-right: 8px;
    margin-bottom: 10px;
    font-size: 16px;
}
a {
    color: #607fa6;
    text-decoration: none;
}
</style>
</head>
<body >
 <div id="myTabContent" class="tab-content">
		<div class="main-t">
			<div class="notifiCon">
			<div class="box-blue noticedes">
				<!-- <span class="title" id="title" style="font-size: 20px"></span>
				<span class="f12 lh30 db lite-gray" id="time"></span>
				<div>liucan</div> -->
				<span class="title" id="title" style="font-size: 20px"></span>
				<div class="rich_media_meta_list">
				    <em id="time" class="rich_media_meta rich_media_meta_text"></em>
				    <em id="author" class="rich_media_meta rich_media_meta_text">于秋</em>
				</div>
			</div>
			<div class="main clearfix">
				<div class="p10">
					<p id="contentp"></p>
				</div>	
			</div>
			</div>
			<div class="control-box btn-submit">
				   <a target="_blank" class="media_tool_meta meta_primary" id="js_view_source" href="">阅读原文</a>
		           <!-- <a class="ui-btn ui-btn-default cancel" href="./announce.jsp">返回</a> -->
		    </div>
		    <div id="value" hidden><%=request.getParameter("id")%></div>
		</div>
	</div>
	
	
	<script type="text/javascript">
	var id = document.getElementById("value").innerText;
	//var items = [];//消息行信息
	$(function () {
		$.post('${AppContext.ctxPath}/action/portal/newsItem/queryById',
				{id : id},
				function(data){
					if(data.success){
						//modalAlert(data.success);
						//modalAlert(data.result.id);
						//window.location.reload();
						if (data.result.title == null){
							data.result.title = ''
						 }
						 if (data.result.content == null){
							 data.result.content = ''
						 }
						 if (data.result.lastUpdated == null){
							 data.result.lastUpdated = ''
						 }
						document.getElementById("contentp").innerHTML=data.result.content;
						document.getElementById("title").innerHTML=data.result.title;
						document.getElementById("time").innerHTML=data.result.lastUpdated;
						document.getElementById("author").innerHTML=data.result.author;
						document.getElementById("js_view_source").href=data.result.contentSourceUrl;
						
					}
					else{
						modalAlert(data.result);
					}
		});
    });
	
	//document.getElementById('contentp').innerHTML=contents;
	</script>
</body>
</html>