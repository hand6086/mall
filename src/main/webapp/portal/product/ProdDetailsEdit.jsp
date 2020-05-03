<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
	<title>产品详细信息</title>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>
<style type="text/css">
</style>

<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'center'" collapsible="false" border="false">
		<div class="easyui-panel" title="" border="false" fit="true">
		    <form id="headerForm" method="post" enctype="multipart/form-data">
				<div class="content" style="height: 100%;width: 1150px;margin: 20px auto;padding: 0px;">
					<div id="contentHtml"></div>
					<script type="text/plain" id="myEditor" name="prodDetails" style="width:100%;height:100%;" ></script>
				</div>
				<input type="hidden" name="id"/>
				<div id="opt-controll" style="margin-bottom: 20px;display: none;">
					<center>
					    <a href="###" style="background-color: #e0ecff; width: 100px;" id="icon-redo" class="easyui-linkbutton" 
					    	iconCls="icon-undo" plain="true" onclick="headerInfoInit()">还原</a>
					    &nbsp;&nbsp;&nbsp;
					    <a href="###" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" 
					    	iconCls="icon-ok" plain="true" onclick="submitForm()">保存</a>
					</center>
				</div>
				<div id="um-controll" style="margin-bottom: 20px;">
					<div style="width: 100%;height: 1px;margin: 20px auto;border: solid #f5f5f5 1px;"></div>
					<center>
						<a href="###" style="background-color: #e0ecff; width: 150px;" class="easyui-linkbutton" 
							iconCls="icon-ok" plain="true" onclick="umOpen()">打开编辑模式</a>
					</center>
				</div>
			</form>
		</div>
	</div>
</div>
    

<script type="text/javascript">
var initHeadId = '${param.id}';
var product = null;
$headerForm = $("#headerForm");
headerFormTagInit();
headerInfoInit();
/**
 * 初始化表单标签
 */
function headerFormTagInit(){
	var formUrl = '${AppContext.ctxPath}/action/portal/product/prodDetailsUpdate';
	$headerForm.form({
		url : formUrl,
		onSubmit : function(){
			return true;
		}
	});
}
/**
 * 初始化输入框的默认值 和 状态
 */
function headerInfoInit(){
	var url = '${AppContext.ctxPath}/action/portal/product/queryById';
	$.post(url,{id:initHeadId},
		function(data){
			if(data){
				if(data.success){
					product = data.result;
					$headerForm.form("load", product);
					if($('#contentHtml').length > 0){//判断选择器是否为空
						$('#contentHtml').append(product.prodDetails);
					}
				}
			}
		});
}
function umOpen(){
	$('#contentHtml').remove();
	$('#opt-controll').css('display','');
	$('#um-controll').css('display','none');
	var um = UM.getEditor('myEditor');
	um.ready(function() {
		var content = product.prodDetails ? product.prodDetails : '';
	    um.setContent(content);//设置编辑器的内容
	});
}
var headerUpdateFlag = false;//按钮锁标志，防止按钮被重复点击
function submitForm(){
	if(headerUpdateFlag){
		return;
	}
	headerUpdateFlag = true;//按钮加锁
	$headerForm.form("submit",{
		success : function(data){
			var data = eval('(' + data + ')'); // change the JSON string to javascript object
			if (data.success) {
				window.parent.operationtip('保存成功！','info');
			} else {
				window.parent.operationtip(data.result,'error');
			}
			headerUpdateFlag = false;//按钮解锁
		}
	});
}
</script>
</body>
</html>