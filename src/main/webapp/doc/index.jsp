<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>Link CRM文档管理</title>  
    <link rel="stylesheet" href="css/pintuer.css">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/jquery.js"></script>   
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">

  <div class="logo margin-big-left fadein-top">
    <h1><img src="images/y.jpg" class="radius-circle rotate-hover" height="50" alt="" />接口文档管理</h1>
  </div>
</div>
<div class="leftnav" style="overflow:auto;height:90%;">
  <div class="leftnav-title"><strong><span class="icon-list"></span>模块列表</strong></div>
 
  <h2><span class="icon-user"></span>认证</h2>
  <ul style="display:none">
    <li><a href="user/tokenQuery.jsp" target="right"><span class="icon-caret-right"></span>认证查询</a></li>
	
  </ul>
   <h2><span class="icon-database"></span>订单</h2>
  <ul style="display:none">
    <li><a href="order/orderQuery.jsp" target="right"><span class="icon-caret-right"></span>订单单条查询</a></li>
    <li><a href="order/orderBatchQueryCount.jsp" target="right"><span class="icon-caret-right"></span>订单批量查询（数量）</a></li>
	<li><a href="order/orderBatchQuery.jsp" target="right"><span class="icon-caret-right"></span>订单批量查询</a></li>
	<li><a href="order/orderUpdateLogistics.jsp" target="right"><span class="icon-caret-right"></span>订单更新物流信息</a></li>
	
  </ul>  
 <h2><span class="icon-car"></span>物流</h2>
  <ul style="display:none">
    <li><a href="logistics/logisticsCompany.jsp" target="right"><span class="icon-caret-right"></span>物流公司查询</a></li>
  </ul>  
  
  <h2><span class="icon-search"></span>系统参数</h2>
  <ul style="display:none">
    <li><a href="system/returnCode.jsp" target="right"><span class="icon-caret-right"></span>返回状态码</a></li>
  </ul> 
  
<!--   <h2><span class="icon-glass"></span>物流</h2>
  <ul style="display:none">
    <li><a href="shopCartAdd.html" target="right"><span class="icon-caret-right"></span>物流公司查询</a></li>
  </ul> 
  
  <h2><span class="icon-search-minus"></span>物流</h2>
  <ul style="display:none">
    <li><a href="shopCartAdd.html" target="right"><span class="icon-caret-right"></span>物流公司查询</a></li>
  </ul>  -->
 <!--  <h2><span class="icon-camera"></span>物流</h2>
  <h2><span class="icon-pencil"></span>物流</h2>
  <h2><span class="icon-fast-forward"></span>物流</h2>
  <h2><span class="icon-arrow-left"></span>物流</h2>
  <h2><span class="icon-eye-slash"></span>物流</h2>
  <h2><span class="icon-bar-chart-o"></span>物流</h2>
  <h2><span class="icon-sign-in"></span>物流</h2>
  <h2><span class="icon-database"></span>物流</h2>
  <h2><span class="icon-paw"></span>物流</h2>
  <h2><span class="icon-microphone"></span>物流</h2>
  <h2><span class="icon-terminal"></span>物流</h2>
  <h2><span class="icon-eye-slash"></span>物流</h2>
  <h2><span class="icon-fast-forward"></span>物流</h2> -->
  
  
 
  
  
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
  <iframe scrolling="auto" rameborder="0" src="welcome.html" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
</div>
</body>
</html>