<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>新建线索跟进</title>
<%@ include file="/portal/header.jsp"%>

<style type="text/css">
.bodyFirstDev {
	margin-top: 50px;
}

.forumListBody {
	width: 60%;
	margin-left: 20%;
	background: #FFF;
	border-style: none solid none solid;
	border-right-width: 1px;
	border-left-width: 1px;
	border-right-color: rgb(228, 230, 235);
	border-left-color: rgb(228, 230, 235);
	min-height: 100%;
}

.formrow {
	width: 90%;
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 100px;
	display: table;
}

.forumForm {
	padding-top: 10px;
	padding-bottom: 10px;
	display: table;
	width: 60%;
	margin-left: 20%;
	margin-right: 20%;
	padding-left: 4px;
	padding-rigth: 4px;
	background: #FFF;
	border-style: solid;
	border-top-width: 1px;
	border-right-width: 1px;
	border-left-width: 1px;
	border-right-color: rgb(228, 230, 235);
	border-left-color: rgb(228, 230, 235);
	border-top-color: rgb(228, 230, 235);
	border-bottom-color: rgb(228, 230, 235);
	border-bottom-width: 1px;
}

.img200 {
	width: 200px;
	height: 200px;
	margin-left: 7px;
	margin-bottom: 9px;
}

.imgDevbox {
	border-style: solid solid solid solid;
	border-width: 1px;
	border-color: rgb(228, 230, 235);
}

.imgClose {
	float: right;
	font-size: 14px;
}

.imgClose:hover {
	color: red;
}

.selfDefineButton {
	display: inline-block;
	padding: 0 15px;
	height: 28px;
	line-height: 28px;
	font-size: 14px;
	text-align: center;
	color: #fff;
	border-bottom-color: #3782f0;
	cursor: pointer;
	border: 0px;
}

.sD_green {
	background: #4cc304;
}

.sD_orange {
	background: #fc9439;
}

.sD_blue {
	background: #398bfc;
}

.selfDefinebodyback {
	margin: 0px;
	min-height: 100%;
}
</style>
</head>

<body class="easyui-layout " data-options="fit:true" border="false">
	<div data-options="region:'south'" class="selfDefinebodyback"
		collapsible="false" border="false"
		style="width: 100%; height: 100%; padding: 0px;">
		<div class="bodyFirstDev">
			<div class="forumForm">
				<form id="forum-form" method="post" enctype="multipart/form-data">
					<div class="formrow" style="visibility:hidden">
						<span style="float: left; text-align: right; width: 8%;">跟进时间</span>
						<input type="text" id="noteTitle" name="dt"
							style="width: 80%; margin-bottom: 10px; border-width: 1px;"/>
					</div>
					
					<div class="formrow">
						<div style="text-align: right; width: 8%;">跟进说明</div>
						<textarea id="note" name="description"
							style="width: 80%; height: 200px; padding-right: 0px; padding-left: 0px;"></textarea>
					</div>
					
					<div class="formrow" style="padding-left: 0px;">
						<div id="imgForm"></div>
					</div>

					<div class="formrow"
						style="display: inline-block; text-align: right; width: 80%;">
						<button type="button" onclick="addForum()"
							class="selfDefineButton sD_blue">新增</button>
						<button type="button" class="selfDefineButton sD_green"
							onclick="addForumAtt()">添加附件</button>
					</div>
				</form>
			</div>
			<div></div>
		</div>
	</div>
	<script>
		/* var modelId = getUrlParams("modelId");
		var modelType = getUrlParams("modelType");
		var modelName = getUrlParams("modelName");
		var id = getUrlParams("id");
		var pushPeople;
		var noteTitle;
 */
		var record;//新增线索跟进后返回的数据
		var headId;
		var headName;


		$('#noteTitle').datetimebox({
			showSeconds : false
		});
		
		/* 跟进时间 */
		var date = new Date();
		var dateForm = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
		$('#noteTitle').datetimebox('setValue',dateForm);
		
		var imgNum = 1;
		var imgCount = 1;
		var nestImg = 'img' + imgNum;
		var nestImgInput = 'imgInput' + imgNum;
		var nestImgDiv = 'imgDiv' + imgNum;
		function addForumAtt() {
			/* if (imgCount > 3) {
				$.messager.alert('提示', "请不要上传超过3张图片。");
				return;
			} */
			
			var attr = 'addAttr1' + nestImg;
			
			var html = '<div class="imgDevbox" style="width:214px;float:left;display:none;" id="'+nestImgDiv+'">'
					+ '<div style="width:210px;"><a class="fa fa-times imgClose" onclick="removeImg(\''+nestImgDiv+'\')"></a></div>'
					+ '<img id="'+nestImg+'"  src="" class="img200"/>'
					
					+ '<p id='+attr+' visible="false"></p>'
					
					+ '<input id="'
					+ nestImgInput
					+ '" type="file" name="uploadAttachment" multiple="multiple" style="display:none;" onchange="preImg(this.id,&quot;'
					+ nestImg
					+ '&quot;,&quot;'
					+ nestImgDiv
					+ '&quot;)"/>'
					+ '</div>'
			$('#imgForm').append(html);

			imgNum++;
			imgCount++;
			$('#' + nestImgInput).trigger('click');
			nestImg = 'img' + imgNum;
			nestImgInput = 'imgInput' + imgNum;
			nestImgDiv = 'imgDiv' + imgNum;
		}

		function getFileUrl(sourceId) {
			var url;
			if (navigator.userAgent.indexOf("MSIE") >= 1) { // IE 
				url = document.getElementById(sourceId).value;
			} else if (navigator.userAgent.indexOf("Firefox") > 0) { // Firefox 
				url = window.URL.createObjectURL(document
						.getElementById(sourceId).files.item(0));
			} else if (navigator.userAgent.indexOf("Chrome") > 0) { // Chrome 
				url = window.URL.createObjectURL(document
						.getElementById(sourceId).files.item(0));
			}
			return url;
		}
		/**文件预览方法**/
		function preImg(sourceId, targetId, outTargetId) {
			var url = getFileUrl(sourceId);
			var imgPre = document.getElementById(targetId);
			imgPre.src = url;
			$('#' + outTargetId).css("display", "");
			
			var urlTmp = document.getElementById(sourceId).value;
			var imgFlag = isImgFlag(urlTmp);
			if (imgFlag == false){
				$('#' + targetId).hide();
				$('#addAttr1'+targetId).html(getFileName(urlTmp));
				$('#addAttr1'+targetId).visible = true;
			}
		}

		/**
			获取附件名称
		*/
		function getFileName(url){
			var extStart = url.lastIndexOf("\\");
			var ext = url.substring(extStart,url.length);
			ext = ext.replace('\\','');
			return ext;
		}
		
		/**
		是否为照片格式附件
		*/
		function isImgFlag(url){
			var extStart = url.lastIndexOf(".");
			var ext = url.substring(extStart,url.length).toUpperCase();
			if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG") {
		        return false;
		    } else {
		    	return true;
		    }
		}
		
		/** 
			新增线索跟进 
		 */
		function addForum() {
			
			if($("#note").val().length==0||$("#note").val()==null||$("#note").val()==''){
				$.messager.alert("操作提示", "请输入线索跟进信息！","warning");  
				return;
			}
			
			$.post('${AppContext.ctxPath}/action/portal/flowUp/insert', {
				clueId : "${param.clueId}",
				dt : $("#noteTitle").datetimebox('getValue'),
				description : $("#note").val(),
				type : 'TUDO_CD_FLOW_UP',
				orgId : appCtx.orgId,
				postnId : appCtx.postnId,
				empId : appCtx.userId
			}, function(data) {
				if (!data.success) {
					if (data.result.indexOf('值太大') > 0 || data.result.indexOf('value too large') > 0 ) {
						$.messager.alert('提示', "跟进说明超过250字！");
					} else {
						$.messager.alert('提示', data.result);
					}

				} else {
					/* window.parent.$.messager.progress('close'); */
					record = data.newRow;
					headId = record.id;
					headName = "线索跟进图片";
					/* alert(imgCount); */
					if(imgCount>1){
						window.parent.operationprogress('进度提示', '正在上传附件...'); 
						uploadAttachment();//添加照片
						
					}else{
						window.parent.forumListRefresh();
					}
					clearForm();
					window.parent.closeAddClueWin('close');
					
				}
			});

		}


		function clearForm() {
			imgCount = 1;//重置照片计数
			$("#imgForm").empty();//清除div内容
			$('#forum-form')[0].reset();
		}

		/**
			添加图片
		 */
		function uploadAttachment() {
			/* alert('uploadAttachment'); */
			$.messager.progress();
			var options = {
				url : '${AppContext.ctxPath}/action/portal/attachment/insertWithFiles',
				type : 'post',
				data : {
					headId : headId,
					moduleType : "Opportunity-FollowUp",
					headCode : headId,
					headName : headName
				},
				dataType : 'json',
				contentType : "application/vnd.ms-excel;charset=utf-8",
				success : function(data) {
					/* console.info("11111111111111111111111"); */
					if (data.success) {
						//更新线索跟进
						/* clueFollowUpAttachment(data.entity.id, record.id); */
						$.messager.progress('close');
						window.parent.forumListRefresh();
						window.parent.$.messager.progress('close');
					} else {
						if (data.result == null) {
							data.result = "上传失败！";
						}
						$.messager.alert("警告", data.result);
						/* errFun(data.result, that); */
					}
				}
			};
			/* console.info("jalskdjflkasjsdlfjalsdjfladjslfkjla"); */
			$("#forum-form").ajaxSubmit(options);
			
		}
		
		/**
		 * 更新线索跟进的附件ID
		 */
		function clueFollowUpAttachment(attachmentId, clueFollowId) {
			if (!attachmentId || !clueFollowId) {
				$.messager.alert('警告', '获附件ID失败！');
				return;
			}
			$.post('${AppContext.ctxPath}/action/portal/flowUp/update', {
				id : clueFollowId,
				dt : record.dt,
				attachmentId : attachmentId
			}, function(data) {
				if (data.success) {
					/* $.messager.alert("提示", "上传成功！"); */
				} else {
					$.messager.alert('警告', data.result);
					/* errFun(data.result, that); */
				}
			});
		}
		
		/** 移除图片imgCount相应减少 */
		function removeImg(divId){
			$('#'+ divId).remove();
			imgCount--;
		}
		
	</script>
</body>
</html>