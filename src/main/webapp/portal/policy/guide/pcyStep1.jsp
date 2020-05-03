<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<link href="${AppContext.ctxPath}/static/icheck/skins/square/_all.css?version=<%=version%>" rel="stylesheet">
<script src="${AppContext.ctxPath}/static/icheck/icheck.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.js?version=<%=version%>"></script>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/portal/policy/guide/lnk-policy-guide.css?version=<%=version%>">
<style type="text/css">
.context{padding-top: 10px;width: 1100px;margin: 0 auto;}
.step-form {width: 100%;}
.step-form .item{margin-bottom: 30px;}
.step-form .text-input{width: 500px;}
.step-form .item .title-div{display: inline-block;text-align: right;width: 65px;height: 25px;line-height: 25px;}
.step-form .item .text-div{display: inline-block;vertical-align: top;margin-left: 5px;width: 700px;}
.step-form .item .select-item{display: inline-block;width: 24%;}
.div-pcyImg {height: 200px;line-height: 200px;mtext-align: center;overflow: hidden;border: solid 1px #eee;}
.div-pcyImg img {vertical-align: middle;margin: 0 auto;width:auto;height:auto;max-width:100%;max-height:100%;}
#guide-step{margin-left: -100px;}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div region="center" border="false">
			<div class="context">
				<div id="guide-step"></div><!-- 步骤条 -->
				<form class="step-form" method="post">
					<div style="width: 100%;">
						<div class="item">
							<div class="title-div">
								<label>政策名称 : </label>
							</div>
							<div class="text-div">
								<input class="easyui-textbox text-input" type="text" id="pcyName" name="pcyName" style="height: 26px;"/>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>首单 : </label>
							</div>
							<div class="text-div">
								<input class="iCheck" type="checkbox" name="isOneTime" value="Y"></input>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>政策大类 : </label>
							</div>
							<div class="text-div majorType-div">
								<!-- 备份用于静态网页调试 -->
								<!-- <div class="select-item">
									<label><input class="iCheck" type="radio" name="majorType" value="1"/> 当单政策</label>
								</div> -->
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>政策类型 : </label>
							</div>
							<div class="text-div subType-div">
								<!-- 备份用于静态网页调试 -->
								<!-- <div class="select-item">
									<label><input class="iCheck" type="radio" name="subType" value="1"/> 特价</label>
								</div> -->
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>开始时间 : </label>
							</div>
							<div class="text-div">
								<input class="easyui-datebox text-input" type="text" name="startTime" style="height: 26px;"/>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>结束时间 : </label>
							</div>
							<div class="text-div">
								<input class="easyui-datebox text-input" type="text" name="endTime" style="height: 26px;"/>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>是否推荐 : </label>
							</div>
							<div class="text-div">
								<div class="select-item">
									<label><input class="iCheck" type="radio" name="isRcmd" value="Y"/> 是</label>
								</div>
								<div class="select-item">
									<label><input class="iCheck" type="radio" name="isRcmd" value="N"/> 否</label>
								</div>
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>推荐方式 : </label>
							</div>
							<div class="text-div">
								<div class="select-item">
									<label><input class="iCheck" type="radio" name="isTop" value="Y"/> 置顶</label>
								</div>
								<div class="select-item">
									<label><input class="iCheck" type="radio" name="isTop" value="N"/> 随机</label>
								</div>
							</div>
						</div>
						<div class="item" style="width: 700px;padding-left: 10px;">
							<div style="background-color: #eee;height: 35px;">
								<div style="display: inline-block;height: 100%;width:120px;background-color: #ddd;">
									<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-uploadImg" 
										style="width: 100%;height: 100%;" plain="true" onclick="$('#fileInput').trigger('click');"> 图片上传</a>
								</div>
								<span id="fileNameShowBox" style="margin-left: 5px;"></span>
							</div>
							<div class="div-pcyImg">
								<img id="pcyImg" alt="" src="">
								<input type="hidden" name="imgId" id="imgId" style="display:none;"/><!-- 政策图片ID -->
							</div>
						</div>
						<div class="item">
							<div class="title-div">
								<label>政策说明 : </label>
							</div>
							<div style="width: 700px;padding-left: 10px;">
								<input class="easyui-textbox text-input" data-options="multiline:true" type="text" name="comments" style="width: 100%;height: 150px;"/>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div region="south" border="false" style="height:40px;">
			<div style="width: 100%; height: 40px;line-height:40px; text-align:right; background:#e8f1ff;">
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-cancel" 
						onclick="prevOpt()" style="width: 100px;margin-right: 20px;">取 消</a> 
				<a href="javascript:void(0)" class="easyui-linkbutton step-opt" iconCls="icon-redo" 
						onclick="nextOpt()" style="width: 100px;margin-right: 20px;">下一步</a>
			</div>
		</div>
		<div style="display: none;">
			<form method="post" class="uploadAttachmentForm" enctype="multipart/form-data" >
				<input type="file" accept="image/jpeg,image/png,image/bmp" id="fileInput" name="uploadAttachment" onchange="preImg(this.id,'pcyImg')"/>
			</form>
		</div>
	</div>
<script type="text/javascript">
$(function() {
	iCheckInit();
});
var ajaxCount = 2;//记录未执行完成ajax数量
var $form = $('.step-form');
var policy = window.parent.$guideWinFram.wholePolicy;
createStepFlow('guide-step', 1);
majorTypeInitTag();
subTypeInitTag();

/**
 * 取消
 */
function prevOpt(){
	window.parent.closeGuide("CANCEL");
}
/**
 * 下一步
 */
function nextOpt(){
	$('.step-opt').linkbutton('disable');//锁住按钮，防止重复点击
	if(uploadAttachment()){
		saveObj(policy);
		window.parent.$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep2.jsp");
	}
}
/**
 * 保存并返回对象值
 */
function saveObj(obj){
	var elements = $form.serializeArray();
	$.each(elements, function() {
		obj[this.name] = this.value;
    });
	obj.attachmentOriginal = $('#fileNameShowBox').text();
	if(!$('input[name=isOneTime]').prop('checked')){
		obj.isOneTime = 'N';
	}
	return obj;
}
/**
 * 初始化html[政策大类]
 */
function majorTypeInitTag(){
	$.post('${AppContext.ctxPath}/action/portal/basic/listOfVal/types',{
		types : JSON.stringify('[PCY_MAJOR_TYPE]')
	},function(data){
		if (data.success) {
			var tagHtml = "";
			for (var i = 0; i < data.rows.length; i++) {
				var row = data.rows[i];
				tagHtml += '<div class="select-item"><label>'
					+' <input class="iCheck" type="radio" name="majorType" value="'+row.val+'"/> '+row.name+'</label></div>';
			}
			$(".majorType-div").append(tagHtml);
		}
		ajaxCount--;
		ajaxFinished();
	});
}
/**
 * 初始化html[政策类型]
 */
function subTypeInitTag(){
	$.post('${AppContext.ctxPath}/action/portal/basic/listOfVal/types',{
		types : JSON.stringify('[PCY_SUB_TYPE]')
	},function(data){
		if (data.success) {
			var tagHtml = "";
			for (var i = 0; i < data.rows.length; i++) {
				var row = data.rows[i];
				tagHtml += '<div class="select-item"><label>'
					+' <input class="iCheck" type="radio" name="subType" value="'+row.val+'"/> '+row.name+'</label></div>';
			}
			$(".subType-div").append(tagHtml);
		}
		ajaxCount--;
		ajaxFinished();
	});
}
/**
 * 判断是否执行完所有ajax，如果是则执行公共回调方法
 */
function ajaxFinished(){
	if(ajaxCount > 0){
		//do nothing
	} else {
		$form.form("load", policy);
		$('#pcyImg').attr('src', policy.imagePath);
		$('#fileNameShowBox').text(policy.attachmentOriginal);
		iCheckInit();
	}
}

/**
 * 上传附件
 */
function uploadAttachment(){
	//验证上传的文件是否为空
	if($('#fileInput').val().length <= 0){
		return true;
	}
	
	//验证政策ID是否为空
	var headId = policy.id;;
	if(!headId){
		$.messager.alert("警告","获取政策ID失败。");
		return false;
	}
	
	//验证上传的文件是否为图片
	var fileName = $('#fileInput').val().toLocaleLowerCase();//获取文件名称，并且将字母转换为小写
	var nameArray = fileName.split('.');
	var fileType = nameArray.length >= 2 ? nameArray[nameArray.length-1] : '';
    if(fileType != "jpeg" && fileType != "jpg" && fileType != "png" && fileType != "bmp"){
         $.messager.alert("警告", "文件类型错误，只允许上传图片。");
         return false;
    }
    
    var resultFlag = true;//上传附件结果标志
	var options = {
			url:'${AppContext.ctxPath}/action/portal/attachment/insert',
			type:'post',
			async:false,
			data : formatRequest({
						headId 		: headId,
						moduleType 	: 'Policy Img'
					}),
			dataType : 'json',
			success : function(data) {
				resultFlag = data.success;
				if (data.success) {
					$('#imgId').val(data.newRow.id);
					policy.imagePath = data.newRow.attachmentPath;
				} else {
					$.messager.alert("警告", data.result);
					$('.step-opt').linkbutton('enable');//解锁按钮
				}
		}
	};
	$('.uploadAttachmentForm').ajaxSubmit(options);
	return resultFlag;
}

/**文件预览方法**/
function preImg(sourceId, targetId) {
	var url = getFileUrl(sourceId);
	if(!url){
		url = '';
	}
	$('#' + targetId).attr('src', url);
	var fileName = $('#' + sourceId).val();
	if(!fileName){
		fileName = '';
	}
	$('#fileNameShowBox').text(fileName);
}
function getFileUrl(sourceId) {
	var url;
	if (navigator.userAgent.indexOf("MSIE")>=1) { // IE 
	url = document.getElementById(sourceId).value; 
	} else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox 
	url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
	} else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome 
	url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
	} 
	return url; 
}
</script>
</body>
</html>
