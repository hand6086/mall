<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.main-t {
	background-color: #FFF;
	padding: 20px 20px 80px;
	min-height: 450px;
	overflow: hidden;
}
.box-blue {
	background-color: #f1f8fb;
	padding: 20px;
}
.db {
    display: block !important;
}
.lite-gray, a.lite-gray:hover {
    color: #999 !important;
}
.f12 {
    font-size: 12px !important;
}
.lh30 {
    line-height: 30px !important;
}
.p10 {
	padding: 10px !important;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false" style="width: 1366px; height: 664px;">
	<div class="layout-panel" style="width: 1366px; left: 0px; top: 0px;">
		<div data-options="region:'center'" collapsible="false" border="false" style="padding: 0px; width: 1366px; height: 664px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
			<div class="main-t">
			   <div class="notifiCon">
				   	<div class="box-blue noticedes">
			            <span class="title" style="font-size: 20px">
			                 <span>[</span>
			                 <span id="anneType">${param.anneType}</span>
			                 <span>]</span>
			                 <span id="captions">${param.captions}</span>
			            </span>
			            <span class="f12 lh30 db lite-gray" id="publishDate">${param.publishDate}</span>
			        </div>
			        <div class="main clearfix">
			            <div class="p10">
			                <p id="contents" style="text-indent: 2em;"></p>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

var contents = "${param.contents}";
var attr1 = "${param.attr1}";
var attr2 = "${param.attr2}";
var attr3 = "${param.attr3}";
var attr4 = "${param.attr4}";
var attr5 = "${param.attr5}";
var attr6 = "${param.attr6}";
headerInfoInit();
/**
 * 初始化输入框的默认值 和 状态
 */
function headerInfoInit(){
	contents = contents+'<a href="###" onclick="window.top.quickEnter(\''+attr1+'\',\''+attr2+'\',\''+attr3+'\',\''+attr4+'\')">'+attr5+'</a>'+attr6;
	if(("${param.contents}") != 'undefined'){
		$('#contents').append(contents);
	}
}
</script>

</body>
</html>