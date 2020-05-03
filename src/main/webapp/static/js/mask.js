//启动mask控件
function startMask(content, target) {
	var _PageHeight = document.documentElement.clientHeight, _PageWidth = document.documentElement.clientWidth;
	//计算loading框距离顶部和左部的距离（loading框的宽度为300px，高度为88px）
	var _LoadingTop = _PageHeight > 88 ? (_PageHeight - 88 - 70) / 2 : 0, _LoadingLeft = _PageWidth > 300 ? (_PageWidth - 300 - 200) / 2
			: 0;
	if (content == null) {
		content = '<span style="font-size:14px;">正在加载数据...</span>';
	}
	//在页面未加载完毕之前显示的loading Html自定义内容
	var _LoadingHtml = '<div id="loadingDiv" style="position:absolute;left:0;width:100%;height:'
			+ _PageHeight
			+ 'px;top:0;background:#f7f7f7;opacity:0.1;filter:alpha(opacity=10);z-index:10000;">'
			+ '<div style="text-align:center; position: absolute; cursor1: wait; left: ' + _LoadingLeft + 'px; top:' + _LoadingTop + 'px;  width: 300px; height: 88px; line-height: 40px; padding:5px;background: #f7f7f7 scroll">'
			+ '<img src="/static/images/loading.gif" height="20" width="20"></img>'
			+ '<div><span">' + content + '</span></div>' + '</div>' + '</div>';
	//呈现loading效果
	if (target == 'firstPage') {
		document.write(_LoadingHtml);
	} else {
		$('#right').append(_LoadingHtml);
	}
}

function loadingIndexMask() {
	var content = '<span style="font-size:12px;">正在努力加载系统资源，请稍后...</span>';
	var _PageHeight = document.documentElement.clientHeight, _PageWidth = document.documentElement.clientWidth;
	//计算loading框距离顶部和左部的距离（loading框的宽度为300px，高度为88px）
	var _LoadingTop = _PageHeight > 88 ? (_PageHeight - 88) / 2 : 0, _LoadingLeft = _PageWidth > 300 ? (_PageWidth - 300) / 2
			: 0;

	if (content == null) {
	}
	//在页面未加载完毕之前显示的loading Html自定义内容
	var _LoadingHtml = '<div id="loadingDiv" style="position:absolute;left:0;width:100%;height:'
			+ _PageHeight
			+ 'px;top:0;background:#f7f7f7;opacity:1;filter:alpha(opacity=100);z-index:10000;">'
			+ '<div style="text-align:center; position: absolute; cursor1: wait; left: ' + _LoadingLeft + 'px; top:' + _LoadingTop + 'px;  width: 300px; height: 88px; line-height: 40px; padding:5px;background: #f7f7f7 scroll">'
			+ '<img src="/static/images/loading.gif" height="20" width="20"></img>'
			+ '<div>' + content + '</div>' + '</div>' + '</div>';
	//呈现loading效果
	//setTimeout("document.write(_LoadingHtml)",2000);
}

function loadingMask() {
	
	var _LoadingHtml = '<div id="loadingDiv" style="position:absolute;left:0;width:100%;height:100%;'
			+ 'top:0;background:#ebebeb;opacity:0.8;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:1000;"></div>';
	//呈现loading效果
	document.write(_LoadingHtml);
}



//结束mask控件
function stopMask() {
	var loadingMask = document.getElementById('loadingDiv');
	if(loadingMask != null){
		loadingMask.parentNode.removeChild(loadingMask);
	}
}
loadingIndexMask();
//监听加载状态改变
document.onreadystatechange = function() {
	if (document.readyState == "complete") {
		stopMask();
	}
}