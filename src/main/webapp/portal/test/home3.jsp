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

<meta charset="utf-8" />
</head>
<link rel="stylesheet"
	href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.min.css?version=<%=version%>">
	<link rel="stylesheet" type="text/css"
		href="${AppContext.ctxPath}/partner/static/select2/css/select2.css?version=<%=version%>">
		<script
			src="${AppContext.ctxPath}/partner/static/select2/js/select2.full.min.js?version=<%=version%>"></script>
		<script
			src="${AppContext.ctxPath}/partner/static/bootstrap/js/bootstrap.min.js?version=<%=version%>"></script>

		<style>
.tooltip {
	border-style: none;
	background: rgba(255, 255, 255, 0);
}

.link-left {
	width: 180px;
	height: 100%;
	*position: fixed;
	*left: 0px;
	overflow: hidden;
	background-color: #253544;
	float: left;
	display: inline-block;
}

.link-left-1 {
	width: 50px;
	height: 100%;
	*position: relative;
	*left: 0px;
	overflow: hidden;
	background-color: #253544;
	float: left;
	display: none;
}

.link-left-1-inner-div {
	position: absolute;
	top: 50%;
	background-color: #253544;
}

.link-left-inner {
	height: 100%;
	width: 120%;
	overflow-x: hidden;
	overflow-y: auto;
}

.link-left-1-inner {
	height: 100%;
	width: 140%;
	overflow-x: hidden;
	overflow-y: auto;
}

.link-left-1>.title-logo {
	width: 45px;
	height: 25px;
	margin: 7px 0px 0px 3px;
}

.link-left-1-expend {
	position: absolute;
	height: 30px;
	width: 46px;
	top: 45px;
	left: 2px;
	*border-bottom: 1px solid #ccc;
	color: white;
	text-align: center;
	cursor: pointer;
	background-color: #3e4f5f;
	font-size: 20px;
	border-bottom: 1px solid grey;
	line-height: 30px;
}

.link-right {
	height: 100%;
	min-width: 500px;
	*margin-left: 200px;
	overflow-y: hidden;
	overflow-x: hidden;
	*padding: 0 10px 0 10px;
}

.link-right-north {
	height: 60px;
	padding: 15px 0;
	padding-left: 130px;
}

.link-right-center {
	height: 100%;
	padding: 15px;
	background-color: #ddd;
	padding-bottom: 60px;
}

.menu-item-0 {
	cursor: pointer;
	font-size: 18px;
}

.footer {
	bottom: 0px;
	position: absolute;
	width: 100%;
	text-align: center;
}

.selected-item {
	color: #fff;
	background-color: #469ce7;
}

.select2-selection--single {
	height: 30px !important;
	border: 1px solid #e0e0e0 !important;
	border-radius: 0 !important;
}

.security-menu-div {
	display: inline;
	position: relative;
	left: -120px;
	margin-left: -100%;
}

.link-left-top, .link-left-foot {
	position: absolute;
	width: 180px;
	left: 0;;
	z-index: 20;
	text-align: center;
}

.link-left-wrapper {
	box-sizing: border-box;
	padding-top: 90px;
	padding-bottom: 20px;
	height: 100%;
} /* 这里的height怎样才能自适应？absolute属性会穿过foot*/
.link-left-nav {
	*position: relative;
	overflow-y: auto;
}

.link-left-foot {
	position: absolute;
	height: 30px;
	width: 180px;
	*bottom: 0px;
	border-bottom: 1px solid grey;
	color: white;
	font-size: 20px;
	line-height: 30px;
	cursor: pointer;
	top: 60px;
	background-color: #3e4f5f;
}

.title-logo {
	height: 50px;
	width: 89px;
	float: left;
	margin: 7px 0px 0px 10px;
	background: url(/static/resource/logo.png) no-repeat center 0;
	background-size: 100% 100%;
	cursor: pointer;
}

.menu-item-0-icon {
	*color: #ccc;
	font-size: 18px;
	display: inline-block;
	width: 30px;
	height: 30px;
	*display: none;
	padding-top: 5px;
}

.menu-item-0-li {
	padding-left: 30px;
}

.menu-item-0-li-selected, .menu-item-0-li:hover {
	padding-left: 32px;
	background-color: #3e4f5f;
	color: #469ce7;
}

.menu-item-0-li-small {
	padding-left: 10px;
	padding-top: 5px;
	color: white;
	cursor: pointer;
}

.menu-item-0-li-small-selected, .menu-item-0-li-small:hover {
	padding-left: 12px;
	background-color: #3e4f5f;
	color: #469ce7;
}

.menu-item-0-text {
	display: inline-block;
	font-size: 14px;
	line-height: 30px;
	*border-bottom: 1px solid #999;
	width: 120px;
	color: #fff;
	cursor: pointer;
	white-space: nowrap;
}

.menu-item-0-li-selected>.menu-item-0-text {
	color: #469ce7;
}

.menu-item-0-text:hover {
	color: #469ce7;
}

.menu-item-0-text-selected {
	color: #469ce7;
}

.menu-item-1-div {
	width: 100%;
	height: 50px;
	float: left;
	overflow-x: hidden;
	overflow-y: hidden;
	text-align: center;
}

.menu-item-1-div ul {
	display: inline-block;
}

.menu-item-1-div li {
	float: left;
	min-width: 60px;
	width: auto;
	text-align: center;
	height: 45px;
	line-height: 30px;
	font-size: 16px;
	cursor: pointer;
	margin: 0px 20px;
}

.menu-item-1-div li:hover {
	border-bottom: 4px solid #469ce7;
	color: #469ce7;
}

.menu-item-1-li-selected {
	border-bottom: 4px solid #469ce7;
	color: #469ce7;
}

#security-menu-select {
	width: 120px;
}
</style>
		<!--1. 在整个页面创建布局面板-->
		<body class="easyui-layout"
			style="overflow: hidden; width: 100%; height: 100%;" id="my-body">
			<div class="link-left">
				<div class="link-left-top title-logo" onclick="getmenuitem('navi')"></div>
				<div class="link-left-wrapper">
					<div class="link-left-inner link-left-nav">

						<li class="menu-item-0-li" onclick="getmenuitem('home')"
							li-text="首页">

							<div class="menu-item-0-text">
								<span class="menu-item-0-icon"> <i class="fa fa-home"
									aria-hidden="true"></i>
								</span>首页
							</div> <c:forEach items="${menuList}" var="menu">
								<li class="menu-item-0-li"
									onclick="getmenuitem('${menu.menuType}', '${menu.text}')"
									li-text="${menu.text}">
									<%-- <div class="menu-item-0-icon">
						<i class="fa ${menu.menuIcon}" aria-hidden="true"></i>
					</div> --%>
									<div class="menu-item-0-text">
										<span class="menu-item-0-icon"> <i
											class="fa ${menu.menuIcon}" aria-hidden="true"></i>
										</span> ${menu.text}
									</div>
								</li>
							</c:forEach>
					</div>
				</div>
				<div class="link-left-foot" title="收起菜单"
					onclick="changMenuBarStatus('compress')">
					<i class="fa fa-long-arrow-left" aria-hidden="true"
						style="line-height: 30px;"></i>
				</div>
			</div>

			<div class="link-left-1">
				<div class="link-left-top title-logo" onclick="getmenuitem('navi')"></div>
				<div class="link-left-1-expend" title="展开菜单"
					onclick="changMenuBarStatus('expand')">
					<i class="fa fa-long-arrow-right" aria-hidden="true"
						style="line-height: 28px;"></i>
				</div>
				<div class="link-left-wrapper">
					<div class="link-left-1-inner link-left-nav">

						<li class="menu-item-0-li-small" onclick="getmenuitem('home')"
							li-text="${menu.text}">
							<div class="menu-item-0-icon" data-toggle="tooltip"
								data-placement="right" title="首页">
								<i class="fa fa-home" aria-hidden="true"></i>
							</div> <c:forEach items="${menuList}" var="menu">
								<li class="menu-item-0-li-small"
									onclick="getmenuitem('${menu.menuType}', '${menu.text}')"
									li-text="${menu.text}" data-toggle="tooltip"
									data-placement="right" title="${menu.text}">
									<div class="menu-item-0-icon">
										<i class="fa ${menu.menuIcon}" aria-hidden="true"></i>
									</div>
								</li>
							</c:forEach>
					</div>
				</div>
			</div>

			<div class="link-right">
				<div class="link-right-north">
					<div class="security-menu-div" id="security-menu-div">
						<select class="select2 security-menu-select"
							id="security-menu-select">
						</select>
					</div>

					<div class="menu-item-1-div">
						<ul id="menu-item-1-ul">
						</ul>

					</div>
					<div></div>
				</div>
				<div class="link-right-center">
					<!-- <div><a href="###">客户：</a><a href="###">经销商</a></div> -->
					<div style="height: 100%; border: 1px solid #cccccc;">
						<iframe scrolling="no" frameborder="0" id="mainFrame" src=""
							style="width: 100%; height: 100%; padding-bottom: 20px;"></iframe>
					</div>
				</div>
			</div>
			<div class="footer" style="font-size: 12px !important">版权所有 ©
				1996–2017 上海汉得信息技术股份有限公司 保留全部权利 黔ICP备16004808号</div>

			<script type="text/javascript">
				if (window != top) {//防止首页嵌套在子页面
					top.location.href = window.location.href;
				}
				var allMenus = [];//所有一级菜单下的二级菜单缓存[{url:'', rows:[]}, {url:'', rows:[]},...]
				var thisMenus = [];//当前一级菜单下的二级菜单{url:'', rows:[]}
				var securityMenus = [];//当前页安全性菜单数组
				var thisMenuUrl = "";//请求当前一级菜单下的二级菜单列表的url

				/**
				 * 跳转页面及设置安全性
				 * @subtitle 二级菜单
				 * @url 二级菜单URL
				 * @subItemList 安全性菜单（三级）
				 */
				function mainFrameContent(subtitle, url, subItemList, menu) {
					if (!url) {
						return;
					}
					if (!menu) {
						menu = {};
					}
					securityMenus = !subItemList || !subItemList.length ? null
							: subItemList;
					if (!securityMenus) {
						securityMenus = (!menu.subMenus || !menu.subMenus.length) ? null
								: menu.subMenus;
					}
					$("#security-menu-select").empty();
					if (!securityMenus) {
						$("#security-menu-div").hide();
						if (menu.readonlyFlag == "Y") {
							window.readonlyFlag = "Y"
							window.addFlag = "N";//只读，作用于子页面
							window.editFlag = "N";
							window.deleteFlag = "N";
						} else {
							window.readonlyFlag = "N";
							window.addFlag = menu.addFlag;
							window.editFlag = menu.editFlag;
							window.deleteFlag = menu.deleteFlag;
						}
						window.exportFlag = menu.exportFlag;
						$('#mainFrame').attr('src', url);
						top.oauth = "";
					} else {
						$("#security-menu-div").show();
						var str = "";
						for (var i = 0; i < securityMenus.length; i++) {
							var securityMenu = securityMenus[i];
							str += "<option value='' index='"+i+"' id='"+securityMenu.id+"'>"
									+ securityMenu.text + "</option>"
						}
						$("#security-menu-select").append(str);
						$("#security-menu-select").trigger("change");
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
					if (input == 'navi') {
						$("#menu-item-1-ul").empty();
						changeMenuItem1Nav('hide');
						mainFrameContent('首页',
								'${AppContext.ctxPath}/action/portal/menu/siteMap');
						changMenuSeleted('首页', true);
						return;
					}
					if (input == 'home') {
						$("#menu-item-1-ul").empty();
						changeMenuItem1Nav("hide")
						mainFrameContent('首页',
								'${AppContext.ctxPath}/action/portal/home/mainjsp');
						changMenuSeleted('首页');
						return;
					} else {
						requestURL = '${AppContext.ctxPath}/action/portal/menu/manageInit/'
								+ input;
					}
					var cacheFlag = false;
					for (var i = 0; i < allMenus.length; i++) {//在缓存中查询当前菜单是否已加载
						if (allMenus[i].url == requestURL) {
							thisMenus = allMenus[i].rows;
							thisMenuUrl = requestURL;
							cacheFlag = true;
							initMenuItem(thisMenus);
						}
					}
					if (!cacheFlag) {//菜单尚未加载 
						$.post(requestURL, {}, function(data) {
							if (data.rows) {
								//initPageMenu(data.rows);
								thisMenus = [];
								//缓存菜单列表
								thisMenus = data.rows;
								thisMenuUrl = requestURL;
								allMenus.push({
									url : requestURL,
									rows : thisMenus
								});
								initMenuItem(thisMenus);
							}
						});
					}
					changMenuSeleted(text);
				}

				function initMenuItem(pages, activePage, loadPageFlag) {
					$("#menu-item-1-ul").empty();
					var str = "";
					for (var i = 0; i < pages.length; i++) {
						var page = pages[i];
						str += '<li id="'+page.id+'" crm-url="'+page.url+'" index="' +i+ '">'
								+ page.text + '</li>'
					}
					if (pages.length) {
						changeMenuItem1Nav();
					} else {
						changeMenuItem1Nav("hide");
					}
					$("#menu-item-1-ul").append(str);
					resetMenuItemWidth();
					/** 添加监听 */
					$("#menu-item-1-ul li")
							.click(
									function() {
										var id = $(this).attr("id");
										var url = "";
										var menu = {};
										for (var i = 0; i < thisMenus.length; i++) {
											if (id == thisMenus[i].id) {
												url = thisMenus[i].menuUrl;
												menu = thisMenus[i];
												break;
											}
										}
										if (url) {
											$(this).siblings().removeClass(
													"menu-item-1-li-selected");
											$(this).addClass(
													"menu-item-1-li-selected");
											mainFrameContent("", url,
													menu.subMenus, menu);
										}
									});

					if (activePage && activePage.id) {
						if (loadPageFlag == false) {
							//不触发页面加载，但触发选中效果
							$("#" + activePage.id).siblings().removeClass(
									"menu-item-1-li-selected");
							$("#" + activePage.id).addClass(
									"menu-item-1-li-selected");
						} else {
							$("#" + activePage.id).trigger("click");
						}
					} else {
						if (pages && pages.length) {
							$("#" + pages[0].id).trigger("click");
						}
					}
				}
				function resetMenuItemWidth() {
					var width = 0;
					$.each($(".menu-item-1-div li"), function(index, li) {
						console.log($(li).width());
						width += $(li).width() + 40;
					});
					$(".menu-item-1-div ul").css("width", width + 100);
				}

				function clearMenuCache() {
					allMenus = [];
					$.messager.alert("操作提示", "清除缓存成功！", "info");
				}

				function changeMenuItem1Nav(status) {

					if (status == "hide") {
						$(".link-right-north").css("display", "none");
						$(".link-right-center").css("padding-bottom", "0");
					} else {
						$(".link-right-north").css("display", "");
						$(".link-right-center").css("padding-bottom", "60px");
					}
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
					var requestURL = '${AppContext.ctxPath}/action/portal/menu/manageInit/'
							+ input;
					//thisMenus = [];
					var cacheFlag = false;
					for (var i = 0; i < allMenus.length; i++) {//在缓存中查询当前菜单是否已加载
						if (allMenus[i].url == requestURL) {
							thisMenus = allMenus[i].rows;
							thisMenuUrl = requestURL;
							cacheFlag = true;
							//initMenuItem(thisMenus);
						}
					}
					if (!cacheFlag) {//菜单尚未加载 
						$.ajax({
							async : false,
							url : requestURL,
							method : 'POST',
							dataType : 'json',
							success : function(data) {
								if (data.rows) {
									//缓存菜单列表
									thisMenus = data.rows;
									thisMenuUrl = requestURL;
									allMenus.push({
										url : requestURL,
										rows : thisMenus
									});
								}
							}
						});
					}

					var subMenuRows = [];
					subMenuRows = thisMenus;
					var successFlag = false;//定位跳转页面成功
					if (url != null) { //优先比较url是否与二级菜单页面对应url是否相同
						for (var i = 0; i < subMenuRows.length; i++) {
							if (subMenuRows[i].menuUrl == url.substring(0, url
									.indexOf("?"))) {//去除参数比较
								initMenuItem(subMenuRows, subMenuRows[i], false);
								mainFrameContent(subMenuRows[i].text, url,
										subMenuRows[i].subMenus, subMenuRows[i]);
								successFlag = true;
								break;
							}
						}
					}
					if (subTitle != null && !successFlag) { //根据url无法定位具体菜单时，根据菜单名称定位
						for (var i = 0; i < subMenuRows.length; i++) {
							if (subMenuRows[i].text == subTitle) {
								initMenuItem(subMenuRows, subMenuRows[i], false);//绘制菜单并选中
								if (url != null) {
									mainFrameContent(subMenuRows[i].text, url,
											subMenuRows[i].subMenus,
											subMenuRows[i]);//跳转页面
									successFlag = true;
								} else {
									mainFrameContent(subMenuRows[i].text,
											subMenuRows[i].menuUrl,
											subMenuRows[i].subMenus,
											subMenuRows[i]);
									successFlag = true;
								}
								//successFlag = true;
								break;
							}
						}
					} else if (url != null) {
						mainFrameContent(null, url);
						successFlag = true;
					}

					//切换1级菜单选中状态
					if (successFlag) {
						changMenuSeleted(text, true);
					} else {
						$.messager.show("警告", "无法打开页面，页面不存在或者当前账号无权查看",
								"warning");
					}
				}
				function changMenuBarStatus(status) {
					if (status == "compress") {
						//收起
						var text = $(".menu-item-0-li-selected")
								.attr("li-text");
						$('.link-left').hide();//css('display', 'none');
						$('.link-left-1').show();//css('display', 'inline-block');
						changMenuSeleted(text, true);
					} else if (status == "expand") {
						//展开
						var text = $(".menu-item-0-li-small-selected").attr(
								"li-text");
						$('.link-left').show();//css('display', 'none');
						$('.link-left-1').hide(); //css('display', 'inline-block');
						changMenuSeleted(text, true);
					}
				}
				/**
				 * 修改一级菜单选中状态 
				 * @text 一级菜单名称
				 * @scrollFlag 是否滚动到指定位置
				 */
				function changMenuSeleted(text, scrollFlag) {
					$(".menu-item-0-li").removeClass("menu-item-0-li-selected");
					$(".menu-item-0-li-small").removeClass(
							"menu-item-0-li-small-selected");
					var num = 0;
					$.each($(".menu-item-0-li"), function(index, ele) {
						if ($(ele).attr("li-text") == text) {
							$(ele).addClass("menu-item-0-li-selected");
							num = index;
							return false;
						}
					});
					$.each($(".menu-item-0-li-small"), function(index, ele) {
						if ($(ele).attr("li-text") == text) {
							$(ele).addClass("menu-item-0-li-small-selected");
							return false;
						}
					});
					if (scrollFlag == true) {
						$(".link-left-nav")[0].scrollTop = num * 35;
						$(".link-left-nav")[1].scrollTop = num * 35;
					}
				}
				$(function() {
					//resetMenuItemWidth();
					//设置一级菜单横向滚动
					var view = $(".menu-item-1-div")[0];
					view.addEventListener("wheel", function(eve) {
						if (eve.preventDefault) {
							eve.preventDefault();
						}
						this.scrollLeft += 8 * eve.deltaY;
					}, false);

					$("#security-menu-select").select2({
						minimumResultsForSearch : Infinity,//去除搜索框
					});
					$("[data-toggle='tooltip']").tooltip();
					$("#security-menu-div").hide();
					$("#security-menu-select")
							.change(
									function() {
										var index = $(this).find(
												"option:selected")
												.attr("index");
										var index1 = $(
												"#menu-item-1-ul .menu-item-1-li-selected")
												.attr("index");
										var menu = thisMenus[index1];
										var securityMenu = securityMenus[index];

										//根据菜单配置，设置页面可见性
										if (menu.readonlyFlag == "Y") {//只读标记为Y,则增删改标记都设为N
											window.readonlyFlag = "Y"
											window.addFlag = "N";
											window.editFlag = "N";
											window.deleteFlag = "N";
										} else {
											if (securityMenu.readonlyFlag == "Y") {//安全性菜单只读标记为Y
												window.readonlyFlag = "Y"
												window.addFlag = "N";
												window.editFlag = "N";
												window.deleteFlag = "N";
											} else {
												window.readonlyFlag = "N";
												window.addFlag = securityMenu.addFlag;
												window.editFlag = securityMenu.editFlag;
												window.deleteFlag = securityMenu.deleteFlag;
											}
										}
										window.exportFlag = securityMenu.exportFlag;
										var url = securityMenu.menuUrl;
										if (url == null || url == 'null'
												|| url == '') {
											url = $('#mainFrame').attr('src');
										}
										top.oauth = securityMenu.oauthType;
										$('#mainFrame').attr('src', url);
									});

					setTimeout(function() {
						getmenuitem('home');
					}, 300);
				});
			</script>
		</body>
</html>