<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/partner/static/css/dmsCommon.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.min.css">
<title>知识库</title>
<style type="text/css">
a{text-decoration:none!important;}
* {
	overflow: auto;
}
p {
white-space: pre-wrap!important;
}
span {
white-space: pre-wrap!important;
}
.lh30 {
    line-height: 20px !important;
}
.collup{
	padding-left:1%;
}
.collup span{
	margin-left:10px;
	color:#999999;
}
.collup .marleft{
	margin-left:45%;
	margin-bottom:0;
}
.collup .ml{
	margin-left:5%;
}

</style>

<body>
	<div id="bigImg" >
		<img id="popUpImg"/>
 	</div>
 	<div class="easyui-layout" data-options="fit:true" border="false">
 		<div data-options="region:'center'" collapsible="false" border="false">
 			<div class="easyui-panel" title="" border="false" fit="true">
				<div id="myTabContent" class="tab-content">
					<div class="main-t" style="height: 100%;width: 950px;margin: 20px auto;padding: 0px;">
						<div class="notifiCon">
						<div class="box-blue noticedes">
							<span class="title" id="title" style="font-size: 20px"></span>
							<!-- <span class="f12 lh30 db lite-gray" id="author"></span>
							<span class="f12 lh30 db lite-gray" id="type"></span> -->
							<div class="collup">
								<span class="f12 lh30 lite-gray" id="author"></span>
								<span class="f12 lh30 lite-gray" id="type"></span>
								<span class="f12 lh30 marleft glyphicon glyphicon-heart"  id="collectIcon" onclick="collect()"></span>
								<span class="f12 lh30 lite-gray glyphicon" id="collectNum"></span>
								<span class="f12 lh30 glyphicon glyphicon-thumbs-up" id="thumbUpIcon" style="margin-left:20px;position:re;" onclick="thumbUp()"></span>
								<span class="f12 lh30 lite-gray glyphicon"  id="thumbUpNum"></span>
							</div>
						</div>
						<div class="main clearfix">
							<div class="p10">
								<p id="contentp">
								
								</p>
							</div>	
						</div>
						<div id="attachment"></div>
						</div>
						<div><span id="shareUrl"></span></div>
						<div class="control-box btn-submit">
					           <!-- <a class="ui-btn ui-btn-default cancel" href="javascript:void(0)" onclick="goBack()">返回</a> -->
					    </div>
					    <div id="value" hidden><%=request.getParameter("id")%></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
	var id = document.getElementById("value").innerText;
	var collNum=0;
	var upNum=0;
	var knowId='';
	var isColl,isUp;
	//var items = [];//消息行信息
	$(function () {
		initData();
    });
	
	function initData(){
		$.post('${AppContext.ctxPath}/action/portal/knowledge/queryById',
				{id : id},
				function(data){
					if(data.success){
						//modalAlert(data.success);
						//modalAlert(data.result.id);
						//window.location.reload();
						isColl=data.result.isColl;//判断当前用户是否收藏
						isUp = data.result.isThumbUp;//判断当前用户是否点赞
						knowId=data.result.id;
						upNum=data.result.thumbUpNum;
						collNum=data.result.collNum
						//console.info(data);
						
						if (data.result.content == null){
							data.result.content = ''
						 }
						 if (data.result.title == null){
							 data.result.title = ''
						 }
						 if (data.result.author == null){
							 data.result.author = ''
						 }
						 if (data.result.type == null){
							 data.result.type = ''
						 }
						 if (collNum == null){
							 collNum = 0;
						 }
						 if (upNum == null){
							 upNum = 0;
						 }
						 
						 
						 if(isColl && isColl=="Y"){
							 $("#collectIcon").css("color","#ff0000");
						 }else{
							 $("#collectIcon").css("color","#999999");
						 }		
						 if(isUp && isUp=="Y"){
							 $("#thumbUpIcon").css("color","#ff0000");
						 }else{
							 $("#thumbUpIcon").css("color","#999999");
						 }						 
						var a = getLovArray('KNOWLEDGE_TYPE');
						var knowledgeType = '';
						for(var i=0;i<a.length;i++){
							if(a[i].val == data.result.type){
								knowledgeType=a[i].name;
							}
						}
						
						document.getElementById("contentp").innerHTML=data.result.content;
						document.getElementById("title").innerHTML=data.result.title;
						document.getElementById("author").innerHTML="作者："+data.result.author;
						document.getElementById("type").innerHTML="类型："+knowledgeType
										+ (data.result.secondaryType ? " - " + getLovShowName('KNOWLEDGE_SECONDARY_TYPE',data.result.secondaryType) : "");
						document.getElementById("collectNum").innerHTML=collNum;
						document.getElementById("thumbUpNum").innerHTML=upNum;
						getAttachments(id);
						$("#shareUrl").text(window.location.href);
					}
					else{
						//modalAlert(data.result);
						$.messager.alert("错误", data.result, "error");
					}
		});
	}
	
	/**
	 * 根据记录ID获取附件信息
	 */
	function getAttachments(headId){
		$.post('${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage', {
			headId : headId,
			pageFlag : false
		}, function(data) {
				if (data.success) {
					showAttachmentList(data.rows);
				} else {
					$.messager.alert("警告",data.result,"warning");
				}
		});
	}

	/**
	 * 附件数据拼接H5标签在前台页面展示
	 */
	function showAttachmentList(rows){
		if(rows != null && rows.length > 0){
			var temp = '';
			for(var i = 0; i < rows.length; i++){
				temp = temp +
						'<tr><td class="td-label">附件：&nbsp;</td><td class="td-content"><div>' +
						'<a href="###" onclick="window.open(\'' + rows[i].attachmentPath + '\')">' + rows[i].attachmentOriginal + '</a>' +
						'&nbsp;&nbsp;&nbsp;&nbsp;' +
						'</div></td></tr>';
			}
			$trs = $(temp);
			$table = $("#attachment");  
		    $table.html($trs);
		}
	}
	
	function collect(){
		if(isColl && isColl=="Y"){
			$.post("${AppContext.ctxPath}/action/portal/knowledgeColl/delete",{knowId:knowId},
					function(data){
				initData();
			});
		}else{
			$.post("${AppContext.ctxPath}/action/portal/knowledgeColl/insert",{knowId:knowId},
					function(data){
				//console.info(data);
				initData();
			});
		}
		//initData();
		//window.location.reload(false);
	}
	
	function thumbUp(){
		$.post("${AppContext.ctxPath}/action/portal/knowledgeColl/addOrDelThumbUp",{knowId:knowId},
			function(data){
				initData();
		});
	}
	
	function goBack(){
		window.location.href='${AppContext.ctxPath}/portal/knowledge/dialog/knowledgeReadOnly.jsp?id='+id;
	}
	//document.getElementById('contentp').innerHTML=contents;
	</script>
</body>
</html>