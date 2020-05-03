<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Link CRM</title>
<%@ include file="/portal/header.jsp"%>
<style>


</style>

<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta
		content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0, width=device-width"
		name="viewport">
		<meta content="telephone=no" name="format-detection">
		<meta content="email=no" name="format-detection">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="black" name="apple-mobile-web-app-status-bar-style">

		<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">

		<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/header.css?version=<%=version%>" />
		<link rel="stylesheet" href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.min.css?version=<%=version%>">
		<link rel="stylesheet" href="${AppContext.ctxPath}/static/css/navigation.css?version=<%=version%>">
		<script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/org/cometd.js?version=<%=version%>"></script>
    	<script type="text/javascript" src="${AppContext.ctxPath}/static/cometd/jquery/jquery.cometd.js?version=<%=version%>"></script>
		<script 	src="${AppContext.ctxPath}/static/bootstrap/js/bootstrap.min.js?version=<%=version%>"></script>
		<script type="text/javascript" src="${AppContext.ctxPath}/static/easyui/extension/datagrid-dnd.js?version=<%=version%>"></script>
</head>

<!--1. 在整个页面创建布局面板-->
<body class="easyui-layout"
	style="overflow: hidden; background: #e8eaed; width: 100%; height: 100%;">
	<div class="header">
		<div class="header_juti">
			<div class="header_juti_left">
				<a onclick="getmenuitem('navi')"><div
						style="width: 100%; height: 100%;"></div></a>
			</div>
			<!--下拉菜单显示-->
			<div id="caidan" class="header_juti_right" style="overflow-x: auto;">
				<div style="width: 3200px;">
					<ul class="caidan">
						<li><a href="###" class="ma_selected"
							onclick="getmenuitem('home')"><div class="icorn imageInfo">
									<i class="fa fa-home" aria-hidden="true"></i>
								</div> <font style="line-height: 15px;">首页</font></a></li>
						<c:forEach items="${menuList}" var="menu">
							<li><a class="ma"
								onclick="getmenuitem('${menu.menuType}', '${menu.text}')"><div
										class="icorn imageInfo">
										<i class="fa ${menu.menuIcon}" aria-hidden="true"></i>
									</div> <font style="line-height: 15px;">${menu.text}</font></a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="header_juti_right1">
				<button class="moreMenu"
					style="width: 45%; height: 75%; background: url(${AppContext.ctxPath}/static/css/img/10_1.png) no-repeat right center;"
					onclick="moveMainMenuLeft()"></button>
				<button class="moreMenu"
					style="width: 45%; height: 75%; background: url(${AppContext.ctxPath}/static/css/img/10.png) no-repeat right center;"
					onclick="moveMainMenuRight()"></button>
				
			</div>
		</div>
	</div>

	<!--二级显示-->
	<!--二级显示-->
	<div class="erji ">
		<div class="select-css" style="width:1px">
		<nav class="navbar navbar-default" style="width:10%" role="navigation">
		<div class="navbar-header"></div>
		<div  style="text-align: center;">
			<ul class="nav navbar-nav " id="security-ul" style="display: inline-block;float: none; z-index:100">
			</ul>
		</div>
		</nav>
		
		</div> 
		<nav class="navbar navbar-default" style="width:90%" role="navigation">
		<div class="navbar-header"></div>
		<div  id="example-navbar-collapse" style="text-align: center;">
			<ul class="nav navbar-nav " id="nav-ul" style="display: inline-block;float: none;">

			</ul>
		</div>
		</nav>
	</div>


	<div class="weizhi">
		<div style="width: 100%; height: 0px; border: 0px solid #e0ecff"></div>
		<div class="rukou" style="border: 1px solid #cccccc">
			<iframe id="mainFrame" scrolling="no" frameborder="0" src=""
				style="width: 100%; height:100%;padding-bottom: 20px;"></iframe>
		</div>

		<div class="banquan" style="font-size: 12px !important">版权所有 ©
			1996–2017 上海汉得信息技术股份有限公司 保留全部权利 黔ICP备16004808号</div>
	</div>

	<div id="picklistid"></div>
	<div id="mvgid"></div>
	<div id="exportdataid"></div>
	<div id="addobjectid"></div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="sortMenu()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="cancelSort()">取消</a>
	</div>
	<div id="dlg" class="easyui-dialog" style="width:400px;height:500px;padding:0"
			closed="true" cache="false" title="页面排序" buttons="#dlg-buttons">
			<table id="menu-datagrid" class="easyui-datagrid" style="width:100%;height:100%" data-options="
						rownumbers:true,
						singleSelect:true,
						striped:true,
						onLoadSuccess:function(){
							$(this).datagrid('enableDnd');
						}">
			<thead>
				<tr>
					<th data-options="field:'text',width:200">页面</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<script type="text/javascript">
	if(window != top){//防止首页嵌套在子页面
		top.location.href =window.location.href;
	}
	/** 一级菜单横向滚动 */
	 var view = document.getElementById('caidan');
	 view.addEventListener("wheel", function(eve){
		 if (eve.preventDefault) {
			    eve.preventDefault();
			  }
			  this.scrollLeft += 8*eve.deltaY;
	 }, false);
	 
	var allMenus = [];//所有一级菜单下的二级菜单缓存[{url:'', rows:[]}, {url:'', rows:[]},...]
	var thisMenu = {};//当前一级菜单下的二级菜单{url:'', rows:[]}
	var thisSortMenu = {};//当前主菜单下的二级菜单(保存菜单临时顺序){url:'', rows:[]}
	var thisMenuUrl = "";//请求当前一级菜单下的二级菜单列表的url
	var showMenuNum = 7;//当前页面展示的二级菜单数量
	
	
	/* $(function(){
		if(window != top){//防止首页嵌套在子页面
			top.location.href =window.location.href;
		}
	}); */
	/**
	* @subtitle 二级菜单
	* @url 二级菜单URL
	* @subItemList 安全性菜单（三级）
	*/
		function mainFrameContent(subtitle, url, subItemList, menu) {
		if(!menu){
			menu = {};
		}
			$("#security-ul").find("*").remove();
			if (subItemList != null && subItemList.length > 0) {
				$("#security-ul").find("*").remove();
				//下拉菜单项头 
					var str1 = '<li class="dropdown" ><a id="dropdown-security-link" class="dropdown-toggle" data-toggle="dropdown">安全性<b class="caret"></b></a>'
						+'<ul class="dropdown-menu" id="security-sub-ul"></ul></li>';
					$("#security-ul").append(str1);
				//插入下拉菜单 
				for (var i = 0; i < subItemList.length; i++){
					var str = "<li id='"+subItemList[i].oauthType+"' index='"+i+"'><a id='security-link-"+subItemList[i].oauthType+"' href='###' title='"+subItemList[i].text+"'>"+subItemList[i].text+"</a></li>";
					$("#security-sub-ul").append(str);
				}
				
				//添加监听,安全性菜单
				for(var i=0; i<subItemList.length; i++){
					var secItem = subItemList[i];
					$("#"+secItem.oauthType).click(function(e, args){
						var index =  $(this).attr("index");
						secItem = subItemList[index];
						$('#security-ul > li').removeClass("active");
						$('#security-sub-ul > li').removeClass("active");
						$(this).addClass("active");
						
						//设置安全性下拉显示名称
						var oauthType = $(this).attr("id");
						$("#dropdown-security-link").html( $("#security-link-"+oauthType).text()+'<b class="caret">' );
						$("#dropdown-security-link").addClass("dropdown-item-selected");
						
						//根据菜单配置，设置页面可见性
						if(menu.readonlyFlag == "Y"){//只读标记为Y,则增删改标记都设为N
							window.readonlyFlag = "Y"
							window.addFlag = "N";
							window.editFlag = "N";
							window.deleteFlag = "N";
						}else{
							if(secItem.readonlyFlag == "Y"){//安全性菜单只读标记为Y
								window.readonlyFlag = "Y"
								window.addFlag = "N";
								window.editFlag = "N";
								window.deleteFlag = "N";
							}else{
								window.readonlyFlag = "N";
								window.addFlag = secItem.addFlag;
								window.editFlag = secItem.editFlag;
								window.deleteFlag = secItem.deleteFlag;
							}
						}
						window.exportFlag = secItem.exportFlag;
						
						var url = secItem.menuUrl;
						if (url == null || url == 'null' || url == '') {
							url = $('#mainFrame').attr('src');
						}
						setCookie("oauth", oauthType);
						top.oauth=oauthType;
						$('#mainFrame').attr('src', url);
					});
				}
				var $dropdownLi = $('li.dropdown');
				$dropdownLi.mouseover(function() {
					$(this).addClass('open');
				}).mouseout(function() {
					$(this).removeClass('open');
				}); 
				$("#"+subItemList[0].oauthType).trigger('click');
				//$('#mainFrame').attr('src', subItemList[0].menuUrl); 
			} else {
				if(menu.readonlyFlag == "Y"){
					window.readonlyFlag = "Y"
					window.addFlag = "N";//只读，作用于子页面
					window.editFlag = "N";
					window.deleteFlag = "N";
				}else{
					window.readonlyFlag = "N";
					window.addFlag = menu.addFlag;
					window.editFlag = menu.editFlag;
					window.deleteFlag = menu.deleteFlag;
				}
				window.exportFlag = menu.exportFlag;
				
				$('#subMenuItem').css('display', 'none');
				$('#mainFrame').attr('src', url);
				setCookie("oauth", "");
				top.oauth="";
			}
		}

		/**
		根据点击的一级菜单加载显示二级菜单
		@input 一级菜单编码
		@text 一级菜单名称
		*/
		function getmenuitem(input, text) {
			var requestURL = '${AppContext.ctxPath}/action/portal/menu/noMatchId';
			thisMenuUrl = requestURL;
			thisMenu = {};
			thisSortMenu = {};
			if (input == 'navi') {
				
				mainFrameContent('首页', '${AppContext.ctxPath}/action/portal/menu/siteMap');
				changMenuSeleted('首页');
				initPageMenu([]);
				return;
			} 
			if (input == 'home') {
				mainFrameContent('首页', '${AppContext.ctxPath}/action/portal/home/mainjsp');
				changMenuSeleted('首页');
				initPageMenu([]);
				return;
			} else {
				requestURL = '${AppContext.ctxPath}/action/portal/menu/manageInit/'
						+ input;
			}
			var cacheFlag = false;
			for(var i=0; i<allMenus.length; i++){//在缓存中查询当前菜单是否已加载
				if(allMenus[i].url == requestURL){
					thisMenu = allMenus[i];
					thisMenuUrl = requestURL;
					//initPageMenu(thisMenu.rows);
					$(window).trigger("resize", "reload");
					cacheFlag = true;
				}
			}
			if(!cacheFlag){//菜单尚未加载 
				$.post(requestURL, {}, function(data){
				 	if(data.rows){
				 		//initPageMenu(data.rows);
				 		thisMenu = {};
				 		thisMenu.url=requestURL;//缓存菜单列表
				 		thisMenu.rows = data.rows;
				 		thisMenuUrl = requestURL;
				 		allMenus.push(thisMenu);
				 		$(window).trigger("resize", "reload");
				 	}
				 });
			}
			//切换1级菜单选中状态
			//changMenuSeleted(text);
		}

		/**
		* 绘制二级菜单 
		* @pages 二级菜单对象
		* @activePage 需要选中的菜单，无则默认选中第一项
		*/
		function initPageMenu(pages, activePage) {
			var pagesShow = [];
			var pagesHide = [];
			var showNum = 7;
			if(showMenuNum != null){
				showNum = showMenuNum
			}
			//菜单过多时分为隐藏菜单与显示菜单
			for(var i=0; i<pages.length; i++){
				if(i<showNum || pages.length == 1){
	 				pagesShow.push(pages[i]);
	 			}else{
	 				pagesHide.push(pages[i]);
	 			}
	 		}
			$("#nav-ul").find("*").remove();//清空原菜单
			//显示菜单 
			for(var i=0; i<pagesShow.length; i++){
				var pageItem = pagesShow[i];
				var str = "<li id='"+pageItem.id+"'><a href='###' title='"+pageItem.text+"'>"+pageItem.text+"</a></li>";
				$("#nav-ul").append(str);
			}
			//下拉菜单项头 
			if(pagesHide.length >0 ){
				var str1 = '<li class="dropdown" ><a id="dropdown-page-link" class="dropdown-toggle" data-toggle="dropdown">更多页面<b class="caret"></b></a>'
					+'<ul class="dropdown-menu" id="sub-ul"></ul></li>';
				$("#nav-ul").append(str1);
			}
			//插入下拉菜单 
			for(var i=0; i<pagesHide.length; i++){
				var pageItem = pagesHide[i];
				var str = "<li id='"+pageItem.id+"' class='hiddenMenu'><a id='link-"+pageItem.id+"' href='###' title='"+pageItem.text+"'>"+pageItem.text+"</a></li>";
				$("#sub-ul").append(str);
			}
			//页面排序
			if(pagesHide.length>0){
				var sortCfgStr = "<li class='divider'></li><li id='sortCfg' onClick='menuSortCfg()'><a href='###'>页面排序</a></li>";
				$("#sub-ul").append(sortCfgStr);
				//$("#menu-datagrid").datagrid("loadData", thisSortMenu);
			}
			//添加监听
			for(var i=0; i<pages.length; i++){
				var pageItem = pages[i];
				$("#"+pageItem.id).click(function(e, args){
					$('#nav-ul > li').removeClass("active");
					$('#sub-ul > li').removeClass("active");
					//$(this).siblings().removeClass("active");//同辈元素移除 'active'
					$(this).addClass("active");
					
					var id = $(this).attr("id");
					if( $(this).hasClass("hiddenMenu") ){//如果是隐藏菜单则把名称显示到可见菜单栏
						$("#dropdown-page-link").html( $("#link-"+id).text()+'<b class="caret">' );
						$("#dropdown-page-link").addClass("dropdown-item-selected");
					}
					else{
						$("#dropdown-page-link").html("更多页面<b class='caret'>");
						$("#dropdown-page-link").removeClass("dropdown-item-selected");
					}
					
					for(var j=0; j<pages.length; j++){
						if(id == pages[j].id){
							if(args=='notReload'){
								break;
							}
							if($('#mainFrame').attr('src') != pages[j].menuUrl){ //若需要选中的页面已经是当前页面则不重新加载
								mainFrameContent(pages[j].text, pages[j].menuUrl,
										pages[j].subMenus, pages[j]);
								break;
							}
							else if(!args){//点击同一页面菜单也重新加载页面
								mainFrameContent(pages[j].text, pages[j].menuUrl,
										pages[j].subMenus, pages[j]);
								break;
							}
						}
					}
				});
			}
			var $dropdownLi = $('li.dropdown');
			$dropdownLi.mouseover(function() {
				$(this).addClass('open');
			}).mouseout(function() {
				$(this).removeClass('open');
			}); 
			//选中第一项或指定项
			if(pages.length>0 && !activePage){
				mainFrameContent(pages[0].text, pages[0].menuUrl,
						pages[0].subMenus, pages[0]);
				//$("#"+pages[0].id).addClass("active");
				$("#"+pages[0].id).trigger("click", "notReload");
			}
			else if(activePage){
				$("#"+activePage.id).trigger("click", "notReload");
			}
		}
		/* 打开排序对话框 */
		function menuSortCfg(){
			if(!thisSortMenu.url || thisSortMenu.url != thisMenu.url){
				thisSortMenu.rows = [];
				for(var i=0; i<thisMenu.rows.length; i++){
					thisSortMenu.rows[i] = thisMenu.rows[i];
				}
				thisSortMenu.url = thisMenu.url;
				thisSortMenu.total = thisMenu.rows.length;
				$("#menu-datagrid").datagrid('loadData', thisSortMenu);
			}
			$('#dlg').dialog('open');
		}
		/**
		确定排序
		*/
		function sortMenu(){
			var activePage = {};
			for(var i=0; i<thisSortMenu.rows.length; i++){
				//thisMenu.rows[i] = thisSortMenu.rows[i];
				if($("#"+thisSortMenu.rows[i].id).hasClass("active")){
					activePage = thisSortMenu.rows[i];
				}
				thisMenu.rows[i] = thisSortMenu.rows[i];//排序后列表保存到全局
			}
			/* //排序后列表保存到全局，写两个循环更好理解
			for(var i=0; i<thisSortMenu.rows.length; i++){
				 thisMenu.rows[i] = thisSortMenu.rows[i];
			} */
			initPageMenu(thisMenu.rows, activePage);//重绘菜单 
			$(window).trigger("resize");
			$('#dlg').dialog('close');
		}
		/*  取消排序 */
		function cancelSort(){
			for(var i=0; i<thisMenu.rows.length; i++){
				thisSortMenu.rows[i] = thisMenu.rows[i];
			}
			$("#menu-datagrid").datagrid('loadData', thisSortMenu);
			$('#dlg').dialog('close');
		}
		setTimeout(function() {
			getmenuitem('home');
		}, 100);

		setTimeout(function() {
			getmenuitem('home');
		}, 100);

		$(document).ajaxComplete(function(event, xhr, settings) {
			if (xhr.responseText.substring(0, 8) == '正在跳转到登录页') {
				window.top.location.href = '/login.jsp';
			}
		});
		
		var ForumOfModel=new Object();
		ForumOfModel.forumId='';
		ForumOfModel.modelId='';
		ForumOfModel.modelType='';
		ForumOfModel.openForumLinkToModel=function(forumId,modelId,modelType){
			if(modelId==null){
				$.messager.alert('Warning','Parameter modelId is null');
				return;
			}
			if(modelType==null){
				$.messager.alert('Warning','Parameter modelType is null');
				return;
			}
			if(forumId==null){
				$.messager.alert('Warning','Parameter forumId is null');
				return;
			}
			this.forumId = forumId;
			this.modelId = modelId;
			this.modelType = modelType;
			switch(modelType){
				case 'opty':window.top.quickEnter('论坛','论坛','BBS_MANAGE','${AppContext.ctxPath}/portal/opty/optyDetailReadOnlyForForum.jsp?optyId='+modelId);break;
				case 'agreement_chn':window.top.quickEnter('论坛','论坛','BBS_MANAGE','${AppContext.ctxPath}/portal/agreement/DomesticAgrOnlyReadForForum.jsp?id='+modelId);break;
				case 'agreement_intel':window.top.quickEnter('论坛','论坛','BBS_MANAGE','${AppContext.ctxPath}/portal/agreement/IntlAgrOnlyReadForForum.jsp?id='+modelId);break;
				default:$.messager.alert('Warning','模块未知！');
			}
		};
		ForumOfModel.modelDetailGoBackToForum = function(){
			gotoContentPage("${AppContext.ctxPath}/portal/forum/ForumDetail.jsp?forumId="+this.forumId);
		};
		
		
		

		/**
		 *@modelId {String} 要发起讨论的对象id
		 *@modeltype {String} 要发起讨论的对象类型
		 **/
		function gotoNewForum(modelId, modelType, modelName) {
			if (modelId == null) {
				alert("调用方法gotoNewForum参数modelId为空");
				return;
			}
			if (modelType == null) {
				alert("调用方法gotoNewForum参数modelType为空");
				return;
			}
			if (modelName == null) {
				alert("调用方法gotoNewForum参数modelName为空");
				return;
			}
			$.post('${AppContext.ctxPath}/action/portal/forum/generateForumId',
							{
								modelId : modelId,
								modelType : modelType,
							},
							function(data) {
								if (data.success) {
									var url = "${AppContext.ctxPath}/portal/forum/NewForum.jsp?modelId="
											+ modelId
											+ "&modelType="
											+ modelType
											+ "&modelName="
											+ modelName + "&id=" + data.row.id;
									quickEnter('论坛', '论坛', 'BBS_MANAGE', url);
								} else {
									alert(data.message);
								}
							});

		}

		 /**
			* 点击页面链接,跳转到页面并切换一级菜单与二级菜单的选中状态
			* @text 一级菜单名称
			* @subTitle 二级菜单名称
			* @input 一级菜单编码 notNull
			* @url 跳转页面的相对url
			*/
			function quickEnter(text, subTitle, input, url) {
				if (input == null || input == '')
					return;
				if(!subTitle && ! url){
					getmenuitem(input, text);
					return ; 
				}
				var requestURL = '${AppContext.ctxPath}/action/portal/menu/manageInit/'
						+ input;
				var cacheFlag = false;
				thisMenu = {};
				for(var i=0; i<allMenus.length; i++){//在缓存中查询当前菜单是否已加载
					if(allMenus[i].url == requestURL){
						thisMenu = allMenus[i];
						thisMenuUrl = requestURL;
						//initPageMenu(thisMenu.rows);
						cacheFlag = true;
					}
				}
				if(!cacheFlag){//菜单尚未加载 
					$.ajax({
						async:false,
						url:requestURL,
						method:'POST',
						dataType:'json',
						success: function(data){
							if(data.rows){
						 		//initPageMenu(data.rows);
						 		thisMenu.url=requestURL;//缓存菜单列表
						 		thisMenu.rows = data.rows;
						 		thisMenuUrl = requestURL;
						 		allMenus.push(thisMenu);
							}
						}
					});
				}
				var subMenuRows = [];
				subMenuRows = thisMenu.rows;
				var successFlag = false;//定位跳转页面成功
				if(url != null){ //优先比较url是否与二级菜单页面对应url是否相同
					for(var i=0; i< subMenuRows.length; i++){
						if(subMenuRows[i].menuUrl == url.substring(0,url.indexOf("?")) ){//去除参数比较
							initPageMenu(subMenuRows, subMenuRows[i]);
							$(window).trigger("resize");
							mainFrameContent(subMenuRows[i].text, url, subMenuRows[i].subMenus, subMenuRows[i]);
							successFlag = true;
							break;
						}
					}
				}
				if(subTitle != null && !successFlag){ //根据url无法定位具体菜单时，根据菜单名称定位
					for(var i=0; i< subMenuRows.length; i++){
						if(subMenuRows[i].text == subTitle){
							initPageMenu(subMenuRows, subMenuRows[i]);//绘制菜单并选中
							$(window).trigger("resize");//
							if(url != null){
								mainFrameContent(subMenuRows[i].text, url, subMenuRows[i].subMenus, subMenuRows[i]);//跳转页面
								successFlag = true;
							}else{
								mainFrameContent(subMenuRows[i].text, subMenuRows[i].menuUrl, subMenuRows[i].subMenus, subMenuRows[i]);
								successFlag = true;
							}
							//successFlag = true;
							break;
						}
					}
				}else if(url != null){
					mainFrameContent(null, url);
					successFlag = true;
				}
					
				//切换1级菜单选中状态
				if(successFlag){
					changMenuSeleted(text);
				}else{
					$.messager.alert("警告", "无法打开页面，页面不存在或者当前账号无权查看", "warning");
				}
			}
		 /**
		 * 清除内存中保存的菜单列表信息，使得下次从服务器重新获取菜单信息
		 */
		function clearMenuCache(){
			allMenus = [];
			$.messager.alert("操作提示", "清除缓存成功！","info");
		}
		$(function() {
			/* var cometd = $.cometd;
			cometd.configure({
				url : "http://"+appCtx.serverName+":"+appCtx.serverPort+"/cometd"
			});
			//连接建立
			function _connectionEstablished() {
				//alert("CometD Connection Established");
			}
			//连接断开 
			function _connectionBroken() {
				//alert("CometD Connection Broken");
			}
			//连接关闭
			function _connectionClosed() {
				//alert("CometD Connection Closed");
			}
			var _connected = false;
			
			// 连接建立或者断开 
			function _metaConnect(message) {
				if (cometd.isDisconnected()) {
					_connected = false;
					_connectionClosed();
					return;
				}

				var wasConnected = _connected;
				_connected = message.successful === true;
				if (!wasConnected && _connected) {
					_connectionEstablished();
				} else if (wasConnected && !_connected) {
					_connectionBroken();
				}
			}
			//握手后
			function _metaHandshake(handshake) {
				if (handshake.successful === true) {
					cometd.batch(function() {
						//订阅系统推送的消息 
						cometd.subscribe('/push/pushNotice', function(message) {
							var data = message.data;
							if(data.total == "0") return;
							$noticePoint = $(".head_notice_point");
							var count = $noticePoint.text();
							if(count == "99+"){
								
							}else if (!count || isNaN(count)) {
								count = data.total;
							} else {
								count = parseInt(count, 10)
										+ parseInt(data.total, 0);
							}
							if (parseInt(count, 10) > 99) {
								count = "99+";
							}
							$noticePoint.text(count);
							$noticePoint.css("display", "inline");
							var message = data.oneNote;
							if(message.length>100){
								message= message.substr(0, 99)+"...";
							}
							message = "<div style='word-wrap:break-word;position:relative; width:270px;height:130px'>"+message+
									"<div style='right:0px; top:80px; position:absolute;width:300px,height:20px' >"+
									"<a href='javascript:void(0)' onclick=\"quickEnter('公告', '系统提示', 'ANNOUNCE_MANAGE', '${AppContext.ctxPath}/portal/message/notice.jsp')\">查看详情>></a></div></div>";
							$.messager.show({
								title : '您有'+data.total+'条新系统信息',
								width: '300px',
								height: '150px',
								msg : message,
								timeout : 5000,
								showType : 'slide'
							});
							
						});
						//发送客户端相关信息到服务端
						cometd.publish('/subscribe/pushNotice', {
							userId : appCtx.userId
						});
					});
				}
			}
			cometd.addListener('/meta/handshake', _metaHandshake);//握手监听器
			cometd.addListener('/meta/connect', _metaConnect);//连接状态监听器 

			cometd.handshake({
			    ext: {
			        "com.crm.authn": {
			            userId: appCtx.userId,
			            ssid: appCtx.ssid
			        }
			    }
			});//握手
			
			//页面关闭或刷新时关闭连接
			$(window).unload(function() {
				cometd.disconnect(true);
			});
			//jq 的unload貌似在火狐中不生效
	        window.onbeforeunload=function(){
	            cometd.disconnect(true);
	        } 
			//页面大小变化时重新绘制菜单
			*/
			$(window).resize(function(event, args){
				var width = $(window).width();
				var activePage;
				for(var i=0; i<thisMenu.rows.length; i++){
					if($("#"+thisMenu.rows[i].id).hasClass("active")){
						activePage = thisMenu.rows[i];
						break;
					}
				}
				if(width >= 1500 && (showMenuNum != 7 || args) ){
					showMenuNum = 7;
					initPageMenu(thisMenu.rows, activePage);
				}else if(width>=1200 && width<1500 && (showMenuNum != 5 || args) ){
					showMenuNum = 5;
					initPageMenu(thisMenu.rows, activePage);
				}else if(width>=900 && width<1200 && (showMenuNum != 3 || args) ){
					showMenuNum = 3;
					initPageMenu(thisMenu.rows, activePage);
				}else if(width>=768 && width<900 && (showMenuNum != 1 || args)){
					showMenuNum = 1;
					initPageMenu(thisMenu.rows, activePage);
				}else if(width<768 && (showMenuNum != 0 || args) ){
					showMenuNum = 0;
					initPageMenu(thisMenu.rows, activePage);
				}
			});
		});

		


	</script>
</body>

</html>