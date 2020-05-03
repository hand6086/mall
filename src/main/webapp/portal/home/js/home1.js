if (window != top) {// 防止首页嵌套在子页面
	top.location.href = window.location.href;
}
var allMenus = [];// 所有一级菜单下的二级菜单缓存[{url:'', rows:[]}, {url:'', rows:[]},...]
var thisMenus = [];// 当前一级菜单下的二级菜单{url:'', rows:[]}
var securityMenus = [];// 当前页安全性菜单数组
var showMenuNum = 7;// 当前页面展示的二级菜单数量
var thisSortMenu = {};// 当前主菜单下的二级菜单(保存菜单临时顺序){url:'', rows:[]}
var thisMenuUrl = "";// 请求当前一级菜单下的二级菜单列表的url
var $mainFrameDiv = $("#mainFrameDiv");
var $mainFrame = $("#mainFrame");
/**
 * 跳转页面及设置安全性
 * 
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
	securityMenus = !subItemList || !subItemList.length ? null : subItemList;
	if (!securityMenus) {
		securityMenus = (!menu.subMenus || !menu.subMenus.length) ? null
				: menu.subMenus;
	}
	$("#security-menu-select").empty();
	if (!securityMenus) {
		$("#security-menu-div").hide();
		var windowFlagObj = getMenuFlag(menu);
		$.extend(window, windowFlagObj);
		// $('#mainFrame').attr('src', url);

		if (windowFlagObj.openNewpageFlag == "Y") {
			openNewPage(menu);
		} else {
			changeFrameSrc(url);
		}
		top.oauth = "";
	} else {
		$("#security-menu-div").show();
		var str = "";
		for (var i = 0; i < securityMenus.length; i++) {
			var securityMenu = securityMenus[i];
			/*
			 * str += "<option value='' index='"+i+"'
			 * id='"+securityMenu.id+"'>" + securityMenu.text + "</option>"
			 */
			str += '<li id="' + securityMenu.id
					+ '" class="filter-list" index="' + i + '">'
					+ securityMenu.text + '</li>';
		}
		$("#security-menu-select").append(str);
		$("#security-menu-select").children().first().trigger("click");
	}
}

/**
 * 根据点击的一级菜单加载显示二级菜单
 * 
 * @input 一级菜单编码
 * @text 一级菜单名称
 */
function getmenuitem(input, text) {
	var requestURL = appCtx.ctxPath+'/action/portal/menu/noMatchId';
	thisMenuUrl = requestURL;
	if (input == 'navi') {
		$("#menu-item-1-ul").empty();
		changeMenuItem1Nav('hide');
		mainFrameContent('首页',
				appCtx.ctxPath+'/action/portal/menu/siteMap');
		changMenuSeleted('首页', true);
		thisMenus = [];
		return;
	}
	if (input == 'home') {
		$("#menu-item-1-ul").empty();
		changeMenuItem1Nav("hide")
		mainFrameContent('首页',
				appCtx.ctxPath+'/action/portal/home/mainjsp');
		changMenuSeleted('首页', true);
		thisMenus = [];
		return;
	} else {
		requestURL = appCtx.ctxPath+'/action/portal/menu/manageInit/'
				+ input;
	}
	var cacheFlag = false;
	for (var i = 0; i < allMenus.length; i++) {// 在缓存中查询当前菜单是否已加载
		if (allMenus[i].url == requestURL) {
			thisMenus = allMenus[i].rows;
			thisMenuUrl = requestURL;
			cacheFlag = true;
			// initMenuItem(thisMenus);
			changeMenuItem1Nav();
			$(window).trigger("resize", "reload");
		}
	}
	if (!cacheFlag) {// 菜单尚未加载
		$.post(requestURL, {}, function(data) {
			if (data.rows) {
				// initPageMenu(data.rows);
				thisMenus = [];
				// 缓存菜单列表
				thisMenus = data.rows;
				thisMenuUrl = requestURL;
				allMenus.push({
					url : requestURL,
					rows : thisMenus
				});
				// initMenuItem(thisMenus);
				changeMenuItem1Nav();
				$(window).trigger("resize", "reload");
			}
		});
	}
	changMenuSeleted(text);
}
/**
 * 初始化二级菜单栏
 * 
 * @pages 二级菜单对象
 * @activePage 选中的菜单项，默认选中第一项
 */
function initMenuItem(pages, activePage, loadPageFlag) {
	var pagesShow = []; // 显示菜单列表
	var pagesHide = []; // 隐式菜单列表
	var showNum = 7; // 默认显示菜单栏数
	if (showMenuNum != null) {
		showNum = showMenuNum
	}
	// 菜单过多时分为隐式菜单与显示菜单
	for (var i = 0; i < pages.length; i++) {
		if (i < showNum || pages.length == 1) {
			pagesShow.push(pages[i]);
		} else {
			pagesHide.push(pages[i]);
		}
	}
	// 先清空原菜单
	$("#menu-item-1-ul").empty();
	// 显示菜单
	for (var i = 0; i < pagesShow.length; i++) {
		var pageItem = pagesShow[i];
		var str = '<li id="' + pageItem.id + '" crm-url="' + pageItem.url
				+ '" index="' + i + '">' + pageItem.text + '</li>'
		$("#menu-item-1-ul").append(str);
	}
	// 下拉菜单项头
	if (pagesHide.length > 0) {
		var str1 = '<li class="dropdown" ><span id="dropdown-page-link">更多页面</span>'
				+ '<span class="more-arrow"></span>'
				+ '<ul class="dropdown-menu more-menu" id="menu-item-1-more-ul"></ul></li>';
		$("#menu-item-1-ul").append(str1);
	}
	// 插入下拉菜单
	for (var i = 0; i < pagesHide.length; i++) {
		var pageItem = pagesHide[i];
		var str = '<li id="' + pageItem.id + '" crm-url="' + pageItem.url
				+ '" index="' + (i + pagesShow.length) + '">' + pageItem.text
				+ '</li>';
		$("#menu-item-1-more-ul").append(str);
	}
	if (pages.length) {
		changeMenuItem1Nav();
	} else {
		changeMenuItem1Nav("hide");
	}
	$("#menu-item-1-ul li").not(".dropdown");
	if (activePage && activePage.id) {
		if (loadPageFlag == false) {
			// 不触发页面加载，但触发选中效果
			$("#" + activePage.id).trigger("click", false);
		} else {
			$("#" + activePage.id).trigger("click");
		}
	} else {
		if (pages && pages.length) {
			$("#" + pages[0].id).trigger("click");
		}
	}
}

/*
 * 跟据菜单项数量设置容器UL的宽度
 */
function resetMenuItemWidth() {
	var width = 0;
	$.each($(".menu-item-1-div li"), function(index, li) {
		width += $(li).width() + 40;
	});
	$(".menu-item-1-div ul").css("width", width + 100);
}

/*
 * 清除菜单缓存
 */
function clearMenuCache() {
	allMenus = [];
	$.messager.alert("操作提示", "清除缓存成功！", "info");
}

/**
 * @modelId {String} 要发起讨论的对象id
 * @modeltype {String} 要发起讨论的对象类型
 */
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
	$
			.post(
					appCtx.ctxPath+'/action/portal/forum/generateForumId',
					{
						modelId : modelId,
						modelType : modelType,
					},
					function(data) {
						if (data.success) {
							var url = appCtx.ctxPath+"/portal/forum/NewForum.jsp?modelId="
									+ modelId
									+ "&modelType="
									+ modelType
									+ "&modelName="
									+ modelName
									+ "&id="
									+ data.row.id;
							quickEnter('论坛', '论坛', 'BBS_MANAGE', url);
						} else {
							alert(data.message);
						}
					});

}

/*
 * 设置二级菜单父容器的显示or隐藏状态
 */
function changeMenuItem1Nav(status) {

	if (status == "hide") {
		$(".link-right-north").hide();
		// $(".link-right-north").css("display", "none");
		$(".link-right-center").css("padding-bottom", "0");
	} else {
		$(".link-right-north").show();
		// $(".link-right-north").css("display", "block");
		$(".link-right-center").css("padding-bottom", "60px");
	}
}

/**
 * 点击页面链接,跳转到页面并切换一级菜单与二级菜单的选中状态
 * 
 * @text 一级菜单名称
 * @subTitle 二级菜单名称
 * @input 一级菜单编码 notNull
 * @url 跳转页面的相对url
 */
function quickEnter(text, subTitle, input, url) {
	if (input == null || input == '')
		return;
	if (!subTitle && !url) {
		getmenuitem(input, text);
		return;
	}
	var requestURL = appCtx.ctxPath+'/action/portal/menu/manageInit/'
			+ input;
	// thisMenus = [];
	var cacheFlag = false;
	for (var i = 0; i < allMenus.length; i++) {// 在缓存中查询当前菜单是否已加载
		if (allMenus[i].url == requestURL) {
			thisMenus = allMenus[i].rows;
			thisMenuUrl = requestURL;
			cacheFlag = true;
			// initMenuItem(thisMenus);
		}
	}
	if (!cacheFlag) {// 菜单尚未加载
		$.ajax({
			async : false,
			url : requestURL,
			method : 'POST',
			dataType : 'json',
			success : function(data) {
				if (data.rows) {
					// 缓存菜单列表
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
	var successFlag = false;// 定位跳转页面成功
	if (url != null) { // 优先比较url是否与二级菜单页面对应url是否相同
		for (var i = 0; i < subMenuRows.length; i++) {
			if (subMenuRows[i].menuUrl == url.substring(0, url.indexOf("?"))) {// 去除参数比较
				initMenuItem(subMenuRows, subMenuRows[i], false);
				mainFrameContent(subMenuRows[i].text, url,
						subMenuRows[i].subMenus, subMenuRows[i]);
				successFlag = true;
				break;
			}
		}
	}
	if (subTitle != null && !successFlag) { // 根据url无法定位具体菜单时，根据菜单名称定位
		for (var i = 0; i < subMenuRows.length; i++) {
			if (subMenuRows[i].text == subTitle) {
				initMenuItem(subMenuRows, subMenuRows[i], false);// 绘制菜单并选中
				if (url != null) {
					mainFrameContent(subMenuRows[i].text, url,
							subMenuRows[i].subMenus, subMenuRows[i]);// 跳转页面
					successFlag = true;
				} else {
					mainFrameContent(subMenuRows[i].text,
							subMenuRows[i].menuUrl, subMenuRows[i].subMenus,
							subMenuRows[i]);
					successFlag = true;
				}
				// successFlag = true;
				break;
			}
		}
	} else if (url != null) {
		mainFrameContent(null, url);
		successFlag = true;
	}

	// 切换1级菜单选中状态
	if (successFlag) {
		changMenuSeleted(text, true);
	} else {
		$.messager.alert("警告", "无法打开页面，页面不存在或者当前账号无权查看", "warning");
	}
}

function changMenuBarStatus(status) {
	if (status == "compress") {
		// 收起
		var text = $(".menu-item-0-li-selected").attr("li-text");
		$('.link-left').hide();// css('display', 'none');
		$('.link-left-1').show();// css('display', 'inline-block');
		changMenuSeleted(text, true);
	} else if (status == "expand") {
		// 展开
		var text = $(".menu-item-0-li-small-selected").attr("li-text");
		$('.link-left').show();// css('display', 'none');
		$('.link-left-1').hide(); // css('display', 'inline-block');
		changMenuSeleted(text, true);
	}

	$(window).trigger("resize");
}

/**
 * 修改一级菜单选中状态
 * 
 * @text 一级菜单名称
 * @scrollFlag 是否滚动到指定位置
 */
function changMenuSeleted(text, scrollFlag) {
	$(".menu-item-0-li").removeClass("menu-item-0-li-selected");
	$(".menu-item-0-li-small").removeClass("menu-item-0-li-small-selected");
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

/*
 * 加载完毕后显示
 */
$mainFrame[0].onload = function() {
	$("#loading-div").hide();
}

/** 页面加载 */
function changeFrameSrc(url) {
	$("#loading-div").show();
	$mainFrame.attr("src", url);
}

function openNewPage(menu, securityMenu) {
	var obj = {};
	obj.menuName_1 = menu.parentMenuName;
	obj.menuName_2 = menu.text;
	obj.menuName_3 = securityMenu ? securityMenu.text : "";
	obj.url = menu.menuUrl;
	obj.url = securityMenu && securityMenu.menuUrl ? securityMenu.menuUrl
			: obj.url;

	var windowObj = getMenuFlag(menu, securityMenu);
	obj.windowObj = windowObj;
	if (windowObj.openNewpageFlag == "Y") {
		var val = JSON.stringify(obj);
		var $form = $("<form  id='openNewpageForm' method='post' action='"+appCtx.ctxPath+"/portal/newPage/NewPage.jsp'  target='_blank'  hidden>"
				+ "<input name='obj' value='" + val + "' >" + "</form>");
		$form.appendTo($("body"));
		$form.submit();
		$form.empty();
		$form.remove();
		changeFrameSrc(appCtx.ctxPath+"/portal/newPage/NewPageTip.jsp");
	}
}
$(function() {
	$("[data-toggle='tooltip']").tooltip();
	$("#security-menu-div").hide();
	$("body")
			.on(
					"click",
					"#menu-item-1-ul li",
					function(event, args) {// 点击二级菜单
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
							if ($(this).parent("ul").hasClass("dropdown-menu")) { // 点击的是下拉列表里的菜单
								$("#menu-item-1-ul li").removeClass(
										"menu-item-1-li-selected");
								$("#menu-item-1-ul li.dropdown").addClass(
										"menu-item-1-li-selected");

								$("#dropdown-page-link").text($(this).text());
								$(this).siblings().removeClass(
										"more-menu-li-selected");
								$(this).addClass("more-menu-li-selected");
							} else {
								$(this).siblings().removeClass(
										"menu-item-1-li-selected");
								$(this).addClass("menu-item-1-li-selected");

								$("#dropdown-page-link").text("更多菜单");
								$("#menu-item-1-more-ul li").removeClass(
										"more-menu-li-selected");
							}
							if (args === false) {
								// 不重新加载菜单
							} else {
								mainFrameContent("", url, menu.subMenus, menu);
							}
						}
					}).on(
					"click",
					"#security-menu-select .filter-list",
					function() { // 选中安全性菜单
						var index = $(this).attr("index");
						var index1 = $(
								"#menu-item-1-ul .menu-item-1-li-selected")
								.attr("index");
						if (!index1) {
							index1 = $(".more-menu-li-selected").attr("index");
						}
						var menu = thisMenus[index1];
						var securityMenu = securityMenus[index];

						var windowFlagObj = getMenuFlag(menu, securityMenu);
						$.extend(window, windowFlagObj);

						var url = securityMenu.menuUrl;
						if (url == null || url == 'null' || url == '') {
							url = $mainFrame.attr('src');
						}
						top.oauth = securityMenu.oauthType;
						// $mainFrame.attr('src', url);
						$("#security-menu-selected-text").text(
								securityMenu.text);
						if (windowFlagObj.openNewpageFlag == "Y") {
							openNewPage(menu, securityMenu);
						} else {
							changeFrameSrc(url);
						}
					});


	setTimeout(function() {
		getmenuitem('home');
	}, 300);

	/*
	 * 监控可视窗口的大小变化状态，来改变二级显示菜单的数量
	 */
	$(window).resize(
			function(event, args) {

				var width = 85;// $(window).width();
				var activePage;
				if (!thisMenus.length) {
					return;
				}
				if (!args) {
					// 获取选中的菜单
					var index = $(".menu-item-1-li-selected",
							$("#menu-item-1-ul")).attr("index");
					index = !index && index != 0 ? $(".more-menu-li-selected",
							$("#menu-item-1-more-ul")).attr("index") : index;
					activePage = thisMenus[index];
				}
				$(".menu-item-1-div").show();
				var containerWidth = $(".menu-item-1-div").width();
				for (var i = 0; i < thisMenus.length; i++) {
					var $menu = $("#" + thisMenus[i].id);
					if ($menu.parent().attr("id") == "menu-item-1-ul") {
						width += $("#" + thisMenus[i].id).outerWidth(true);
					} else {
						var minWidth = thisMenus[i].text.length * 15;
						minWidth = minWidth > 60 ? minWidth : 60;
						var marginRight = 25;
						width += minWidth + marginRight;
					}
					if (width > containerWidth) {
						if (showMenuNum != i) {
							showMenuNum = i;
						}
						break;
					}
				}

				initMenuItem(thisMenus, activePage, false);
			}).trigger("resize");
});