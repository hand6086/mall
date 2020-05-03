<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page language="java" import="com.hand.core.util.AppConstants"%>
<%
	session.setAttribute("docAppUrl", AppConstants.docAppUrl);
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>O2O接口文档管理</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>   
</head>
<body>
<div class="header bg-main">

  <div class="logo margin-big-left fadein-top">
    <h1><img src="images/y.jpg" class="radius-circle rotate-hover" height="50" alt="" />接口文档管理</h1>
  </div>
</div>
<div class="leftnav" style="overflow:auto;height:85%;">

  <div class="leftnav-title"><strong><span class="icon-list"></span>模块列表</strong></div>
 
  <c:forEach items="${lnkDocMenuList}" var="menu">  
     <h2><span class="${menu.menuIcon}"></span>${menu.menuName}</h2>
     <ul style="display:none">
     <c:forEach items="${menu.menuLineList}" var="menuLine">  
     	<li><a href="/action/portal/lnkDocMenuLine/init?id=${menuLine.id}" target="right"><span class="icon-caret-right"></span>${menuLine.menuLineName}</a></li>
     </c:forEach> 
     </ul>
  </c:forEach>  
  
  
</div>
<script type="text/javascript">
$(function(){
  $(".leftnav h2").click(function(){
	  $(this).next().slideToggle(200);	
	  $(this).toggleClass("on"); 
	  
  })
  $(".leftnav ul li a").click(function(){
	    $("#a_leader_txt").text($(this).text());
  		$(".leftnav ul li a").removeClass("on");
		$(this).addClass("on");
  })
});


</script>
<ul class="bread">
  <li><a href="{:U('Index/info')}" target="right" class="icon-home"> 首页</a></li>
  <li><a href="##" id="a_leader_txt">欢迎使用</a></li>
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
</div>
</body>
</html>