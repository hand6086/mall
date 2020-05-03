<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Link CRM</title>
<%@ include file="/portal/header.jsp"%>
<%@ include file="/portal/publicHome.jsp"%>
<meta charset="utf-8" />
</head>
<link rel="stylesheet"
	href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.min.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/font/css/font-awesome.min.css">
<script src="${AppContext.ctxPath}/static/bootstrap/js/bootstrap.min.js?version=<%=version%>"></script>
<link rel="stylesheet"
	href="${AppContext.ctxPath}/portal/home/css/home1.css?version=<%=version%>">
		<!--1. 在整个页面创建布局面板-->
		<body class="easyui-layout"
			style="overflow: hidden; width: 100%; height: 100%;" id="my-body">
			<div class="link-left">
				<div class="link-left-top title-logo" onclick="getmenuitem('navi')"></div>
				<div class="link-left-wrapper">
					<div class="link-left-inner link-left-nav">
						<li class="menu-item-0-li" onclick="getmenuitem('home', '首页')"
							li-text="首页">
							<div class="menu-item-0-text">
								 <i class="glyphicon glyphicon-home"
									aria-hidden="true"></i>
								<span>首页</span>
							</div> 							
							<c:forEach items="${menuList}" var="menu">
								<li class="menu-item-0-li"
									onclick="getmenuitem('${menu.menuType}', '${menu.text}')"
									li-text="${menu.text}">
									<div class="menu-item-0-text">
										 <i
											class="glyphicon ${menu.menuIcon}" aria-hidden="true"></i>
										<span>${menu.text}</span>
									</div>
								</li>
							</c:forEach>
					</div>
				</div>
				<div class="link-left-foot" title="收起菜单"
					onclick="changMenuBarStatus('compress')">
					<i class="fa fa-navicon nav-compress" aria-hidden="true"
						style="line-height: 30px;"></i>
				</div>
			</div>
			<div class="link-left-1">
				<div class="link-left-top title-logo" onclick="getmenuitem('navi')"></div>
				<div class="link-left-1-expend" title="展开菜单"
					onclick="changMenuBarStatus('expand')">
					<i class="fa fa-navicon" aria-hidden="true"
						style="line-height: 30px;"></i>
				</div>
				<div class="link-left-wrapper">
					<div class="link-left-1-inner link-left-nav">
						<li class="menu-item-0-li-small" onclick="getmenuitem('home', '首页')"
							li-text="首页">
							<div class="menu-item-0-icon" data-toggle="tooltip"
								data-placement="right" title="首页">
								<i class="glyphicon glyphicon-home" aria-hidden="true"></i>
							</div> 							
							<c:forEach items="${menuList}" var="menu">
								<li class="menu-item-0-li-small"
									onclick="getmenuitem('${menu.menuType}', '${menu.text}')"
									li-text="${menu.text}" data-toggle="tooltip"
									data-placement="right" title="${menu.text}">
									<div class="menu-item-0-icon">
										<i class="glyphicon ${menu.menuIcon}" aria-hidden="true"></i>
									</div>
								</li>
							</c:forEach>
					</div>
				</div>
			</div>
			<div class="link-right">
				<div class="link-right-north">
				 	<!--二级菜单-->
					<div class="menu-item-1-div">
						<ul id="menu-item-1-ul">
						</ul>						
					</div>
					<div class="login-user-div" id="" style="color: rgb(122, 128, 148);">					
						<div class="dropdown">							
							<div class="security-menu-div" id="security-menu-div">		
							<!-- </div>	 -->
							<div class="filter">
								<i class="iconfont icon-shaixuan1" style="color:#5897fb"></i>
								<span class="filter-type" id="security-menu-selected-text"></span>
							</div>
							<span class="line"></span> 
							<ul class="dropdown-content dropdown-content1" id="security-menu-select">
	    						
	  						</ul> 				 
						</div>				
						</div>			
						<div class="dropdown">
							<span data-toggle="tooltip" data-placement="bottom" >
								<span class="user-icon"></span>
								<span class="user-name">${AppContext.storeName}</span>
							</span>
							<div class="dropdown-content">
	    						<div id="list1" class="dropdown-list"><i class="fa fa-exchange"></i>${UserContext.postnName}
	    						</div>
	    						<div id="list2" class="dropdown-list"
	    						onclick="window.parent.mainFrameContent('修改密码','${AppContext.ctxPath}/portal/user/UserChangePassword.jsp')">
	    							<i class="glyphicon glyphicon-cog"></i>修改密码
	    						</div>
	    						<div id="list3" class="dropdown-list"
	    						onclick="window.parent.mainFrameContent('服务请求','${AppContext.ctxPath}/portal/serviceRequestNew/mainNew.jsp')"><i class="glyphicon glyphicon-pencil"></i>反馈</div>
	    						<div id="list4" class="dropdown-list">
	    							<a href="${AppContext.ctxPath}/j_spring_security_logout" style="color: rgb(122, 128, 148);">
	    								<i class="glyphicon glyphicon-off"></i>退出登录
    								</a>
   								</div>
	  						</div> 	
						</div>										
					</div>
				</div>
				<div class="link-right-center">
					<div style="height: 100%;position:relative;">
						<iframe scrolling="auto" frameborder="0" id="mainFrame" src=""
							style="width: 100%; height: 100%;padding-bottom:0px;"></iframe>
						<div id="loading-div" style="padding-bottom:20px;"><img src="${AppContext.ctxPath}/static/images/loading1.gif" alt="正在加载" /></div>
					</div>								
				</div>
			</div>
			
			<script src="${AppContext.ctxPath}/portal/home/js/home1.js?version=<%=version%>"></script>

		</body>
</html>