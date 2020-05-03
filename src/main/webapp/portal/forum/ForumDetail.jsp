<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>

<title>论坛主题详情</title>
<style type="text/css">
.replytitle{
font-size: 14px;
font-weight: 700;
}
.small_picture{
display:inline;
}
.datagrid-body td{
border-width:0 0 0 0;
}
.replyContent{
white-space:pre-wrap;
font-size: 14px;
display:block;
text-indent:2em;
word-wrap:break-word;
word-break:break-all; 
}
.replyImgContent{
white-space:pre-wrap;
font-size: 14px;
display:block;
word-wrap:break-word;
word-break:break-all; 
}
.ui_btn_m, .ui_btn_m_disable {
    display: inline-block;
    padding: 0 15px;
    height: 28px;
    line-height: 28px;
    font-size: 14px;
    text-align: center;
    color: #fff;
    background: #398bfc;
    border-bottom-color: #3782f0;
    cursor: pointer;
    border:0px;
}
.ui_btn_m_default{
display: inline-block;
    padding: 0 15px;
    height: 28px;
    line-height: 28px;
    font-size: 14px;
    text-align: center;
    color: #fff;
    border-bottom-color: #3782f0;
    cursor: pointer;
    border:0px;
}


.thread-item {
    position: relative;
    overflow: hidden;
    padding: 10px 0;
}
.datagrid-header{
border-bottom-width: 0px;
}
.topic-bg {
    background: url(http://tb2.bdstatic.com/tb/static-hottopic/img/bang_bg_4aa39ca.jpg) no-repeat top center;
	padding-top:20px;
	min-height:100%;
}

.forumReplybody{
width:60%;
margin-left:20%;
margin-right:20%;
padding-left:4px;
padding-rigth:4px;
background: #FFF;
border-style:none solid none solid;
border-right-width:1px;
border-left-width:1px;
border-right-color:rgb(228, 230, 235);
border-left-color:rgb(228, 230, 235);
}
.forumReplySummitForm{
display: inline-block;
width:60%;
margin-left:20%;
margin-right:20%;
padding-left:4px;
padding-rigth:4px;
background: #FFF;
border-style:solid;
border-top-width:1px;
border-right-width:1px;
border-left-width:1px;
border-right-color:rgb(228, 230, 235);
border-left-color:rgb(228, 230, 235);
border-top-color:rgb(228, 230, 235);
border-bottom-color:rgb(228, 230, 235);
border-bottom-width: 1px;
}
.forumReplySummitButtonGroup{
display: inline-block;
width:60%;
margin-left:20%;
margin-right:20%;
padding-left:4px;
padding-rigth:4px;
background: #FFF;
border-style:none solid solid solid;
border-top-width:0px;
border-right-width:1px;
border-left-width:1px;
border-right-color:rgb(228, 230, 235);
border-left-color:rgb(228, 230, 235);
border-bottom-color:rgb(228, 230, 235);
}

.img200{
width:200px;
height:200px;
margin-left:7px;
margin-bottom:9px;
}
.img100{
width:100px;
height:100px;
margin-left:7px;
margin-bottom:9px;
}
.imgDevbox{
	border-style: solid solid solid solid;
    border-width: 1px;
    border-color: rgb(228, 230, 235);
}
.imgClose{
	float:right;
	font-size:14px;
}
.imgClose:hover{
color:red;
}
.selfDefineButton{
    display: inline-block;
    padding: 0 15px;
    height: 28px;
    line-height: 28px;
    font-size: 14px;
    text-align: center;
    color: #fff;
    border-bottom-color: #3782f0;
    cursor: pointer;
    border:0px;
}
.sD_green{
	background: #4cc304;
}
.sD_orange{
	background: #fc9439;
}
.sD_blue{
	background: #398bfc;
}
</style>
</head>
<body  >
 <div id="bigImg" >
		<img id="popUpImg"/>
 </div>
 <div class="easyui-layout" data-options="fit:true" border="false">
     <div data-options="region:'south'" collapsible="false"  border="false" style="width:100%;height:100%;padding:0px;">
	    <div class="topic-bg">
	    	<div class="forumReplybody">
			    <div style="padding:10px;20px;">
			    	<span id="noteTitle" style="margin-left:10px;font-weight: 400;font-size: 22px;font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;"></span>
			    </div>
				<div style="padding:0px 20px 10px 20px">
					<span id="noteUserName" class="fa fa-user" style="margin-left:10px;color:#469ce7;font-size: 12px;"></span>
					<span id="editButton"style="float:right;">
						<a class="fa fa-commenting-o" href="#answerForm" style="color:#469ce7;cursor:pointer;">回复</a>&nbsp;&nbsp;
			    		<a class="fa fa-mail-reply"  style="color:#469ce7;cursor:pointer;" onclick="gotoContentPage(&quot;${AppContext.ctxPath}/portal/forum/ForumList.jsp&quot;)">返回</a>
					</span>
			    </div>
				<div id="forumHeadReplyContent" style="padding:0px 20px 10px 20px">
					<p id="note" style="text-indent:2em;font-size:14px;"></p>
				</div>
				<div  style="padding:0px 20px 10px 20px">
					<span style="float:right;" id="noteCreated"></span>
				</div>
				<ul style="padding-left: 0px;margin-bottom:0px;margin-top:0px;">
						<li class="thread-item">
							<!-- <a class="fa fa-commenting-o" href="#answerForm" style="color:#469ce7;font-size: 14px;cursor:pointer;float:right;margin-right:20px;">回复</a>
							<a class="fa fa-mail-reply"  style="color:#469ce7;font-size: 14px;cursor:pointer;float:right;margin-right:20px;" onclick="gotoContentPage(&quot;${AppContext.ctxPath}/portal/forum/ForumList.jsp&quot;)">&nbsp;返回</a>
							 -->
						</li>
				</ul> 
					<div>
						<table id="forum-reply-table" class="easyui-datagrid">
								<thead>
									<tr>
										<th field="reply"  width="100%" formatter="replayFormatter" >内容</th>
									</tr>
								</thead>
						</table>
					</div>
				
			</div>
			<div id="answerForm" class="forumReplySummitForm">
				 <div style="padding:10px;">
					<form id="reply-form" method="post" enctype="multipart/form-data" >
						<div style="width:100%;">
						<script type="text/plain" id="reply" name="reply" style="height:240px;width:100%;" >
						</script>
						</div>
						<!--  <textarea  id="reply" name="reply" style="width:100%;height:100px;" ></textarea>-->
						<input id="noteId" name="noteId" type="text" style="display:none;" />
						<input id="moduleType" name="moduleType" type="text" style="display:none;"/>
						<div id="imgForm" style="display:inline;">
						
						</div>
					</form>
				 </div>
			</div>
			<div class="forumReplySummitButtonGroup">
				  	<div style='padding-left:10px;margin-top:5px;padding-right:10px;margin-bottom:10px;float:right;'>
						<button class="ui_btn_m" onclick="addReply()" >回帖</button>
						<button class="ui_btn_m_default" onclick="addForumReplyAtt()" >添加附件</button>
					</div>
			</div>
				
		</div>
	</div>
	
	
 </div>
<script type="text/javascript" >
var forumId = getUrlParams("forumId");
console.log(forumId);
var url="${AppContext.ctxPath}/action/portal/forum/getOneForum/"+forumId;
$('#noteId').val(forumId);
$('#forum-reply-table').hdatagrid({
	striped:false,
	border:false,
	rownumbers:false,
	showHeader:false,
	selectFirstRow:false,
	url:'${AppContext.ctxPath}/action/portal/forum/forumReplayList/'+forumId,
	onAddMoreButton:function(that,addButtonFun){
		
	},
	onDeleteAction:function(row,successFun,errFun,that) {
	},
	onLoadSuccess:function(data){
		$('div.small_picture a').fancyZoom({scaleImg: true, width:500,height:500,imgHeight:450,mulriple:1});
		if(data.total==0){//隐藏分页栏
			$(".datagrid-pager").css("display","none");
		}else{
			$(".datagrid-pager").css("display","");
		}
	}
	
	});
var um = UM.getEditor('reply',{
	customDomain:true,
	toolbar:[
	            'undo redo | bold italic underline strikethrough | forecolor backcolor | removeformat |',
	            'selectall cleardoc paragraph | fontfamily fontsize' ,
	            '| justifyleft justifycenter justifyright justifyjustify '
	        ]
});
$(function() {
	if(forumId==null){
		$.messager.alert("提示", '获取不到主题帖Id');
		return;
	}
	$.post(url, null, function(data) //回传函数
			{
				if (data.success) {
					console.log(data.result);
					var record = data.result;
					$('#noteTitle').html('<a style="cursor:pointer;" onclick="window.top.ForumOfModel.openForumLinkToModel(&quot;'+record.id+'&quot;,&quot;'+record.modelId+'&quot;,&quot;'+record.modelType+'&quot;)">'+record.noteTitle+'</a>');
					$('#note').html(record.note);
					$('#noteUserName').html('&nbsp;&nbsp;'+record.userName);
					$('#platform').html(record.platform);
					$('#noteCreated').html(record.created);
					$('#moduleType').val(record.modelType);
					var imgHtml='';
					if(record.attList!=null&&record.attList.length>0){
						for(var i=0;i<record.attList.length;i++){
							if(i==0){
								imgHtml = '<div class="replyImgContent">';	
							}
							imgHtml = imgHtml+'<div class="small_picture"><a style="width:100px;" href="'+'#bigImg'+'"><img src="'+record.attList[i].attachmentPath+'" class="img100" /></a></div>';
							if(i==record.attList.length-1){
								imgHtml = imgHtml+'</div>'
							}
						}
						$('#forumHeadReplyContent').append(imgHtml);
						$('div.small_picture a').fancyZoom({scaleImg: true, width:500,height:500,imgHeight:450,mulriple:1});
					}
					if(record.createdBy==appCtx.userId){
						$('#editButton').append('&nbsp;&nbsp;<a class="fa fa-pencil" style="cursor:pointer;color:#469ce7;" onclick="gotoContentPage(&quot;${AppContext.ctxPath}/portal/forum/UpdateForum.jsp?id='+record.id+'&quot;)">编辑</a>');
						$('#editButton').append('&nbsp;&nbsp;<a class="fa fa-times " style="cursor:pointer;color:#469ce7;" onclick="delForum(&quot;'+record.id+'&quot;)">删除</a>');
					}
				} else {
					$.messager.alert("警告", data.result);
				}
			});
	
});



function replayFormatter(val, row) {
	if (val != null) {
	var html;
	var imgHtml;
	//构造图片标签
	if(row.attList!=null){
		imgHtml = '<div class="replyImgContent"  >';
		for(var i=0;i<row.attList.length;i++){
			imgHtml = imgHtml+'<div class="small_picture"><a  style="width:100px;" href="'+'#bigImg'+'"><img src="'+row.attList[i].attachmentPath+'" class="img100" /></a></div>';
		}
		imgHtml +='</div>';
	} 
	if(imgHtml==null){
		html= '<div style="padding:10px 20px 0px 20px;">'
			  +'<div class="fa fa-user" style="forn-size:14px;margin-bottom:5px;margin-left:10px;">&nbsp;&nbsp;'+row.userName+'</div>'
			  +'<div class="replyContent"  >'+row.reply+'</div>'
		      + '<div style="float:rigth;text-align:right;">'+row.created+'</div>'
		      +'<ul style="padding:0px;margin:1px;"><li style="border-style:none none dotted none;border-bottom-width:1px;border-bottom-style=dotted;border-bottom-color:rgb(228, 230, 235);"></li></ul>'
		      +'</div>';
	}else{
		html= '<div  style="padding:10px 20px 0px 20px;">'
			  +'<div class="fa fa-user" style="forn-size:14px;margin-bottom:5px;margin-left:10px;">&nbsp;&nbsp;'+row.userName+'</div>'
			  +'<div class="replyContent"  >'+row.reply+'</div>'
			  + imgHtml
		      + '<div style="float:rigth;text-align:right;">'+row.created+'</div>'
		      +'<ul style="padding:0px;margin:1px;"><li style="border-style:none none dotted none;border-bottom-width:1px;border-bottom-style=dotted;border-bottom-color:rgb(228, 230, 235);"></li></ul>'
		      +'</div>';
	}
	return html;
	}else{
		return '';
	}
	
}

function addReply(){
	/* 字数限制 begin*/
	var mary = um.getContentTxt();
	if(mary.length>1000){
		$.messager.alert("操作提示", "内容不超过1000字，请检查！","warning");  
		return;
	}
	/* 字数限制 end*/
	var options = {
			url : '${AppContext.ctxPath}/action/portal/forum/forumReplyInsert',
			type : 'post',
			dataType :'json',
			success : function(data) {
					if(data.success){
						$('#imgForm').html("");//图片清空
						$('#forum-reply-table').hdatagrid("reload");
						um.setContent('');
						$.messager.alert('提示',"已发布！");
				  	}else{
				  		
				  		$.messager.alert('警告',data.result);
				  	}
			}
		};
	$('#reply-form').ajaxSubmit(options);
}


var imgNum = 1;
var imgCount = 1;
var nestImg = 'img'+imgNum;
var nestImgInput = 'imgInput'+imgNum;
var nestImgDiv = 'imgDiv'+imgNum;
function addForumReplyAtt(){
	/**
	if(imgCount>4){
		$.messager.alert('提示',"请不要上传超过4张图片。");
		return;
	}**/
	var html='<div class="imgDevbox" style="width:214px;float:left;display:none;" id="'+nestImgDiv+'">'
			+'<div style="width:210px;"><a class="fa fa-times imgClose" onclick="$(&quot;#'+nestImgDiv+'&quot;).remove();"></a></div>'
		    +'<img id="'+nestImg+'"  src="" class="img200"/>'
			+'<input id="'+nestImgInput+'" type="file" name="myfiles" style="display:none;" onchange="preImg(this.id,&quot;' + nestImg + '&quot;,&quot;'+nestImgDiv+'&quot;)"/>'
			+'</div>'
			$('#imgForm').append(html);
	
	imgNum++;
	imgCount++;
	$('#'+nestImgInput).trigger('click');
	nestImg = 'img'+imgNum;
	nestImgInput = 'imgInput'+imgNum;
	nestImgDiv = 'imgDiv'+imgNum;
	
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
/**文件预览方法**/
function preImg(sourceId, targetId,outTargetId) { 
	var url = getFileUrl(sourceId); 
	var imgPre = document.getElementById(targetId); 
	imgPre.src = url; 
	$('#'+outTargetId).css("display","");
} 

function delForum(id){
	$.messager.confirm('提示','是否删除整帖？',function(r){
		if(r){
			$.post('${AppContext.ctxPath}/action/portal/forum/forumDelete/'+id,null,
					function(data){
						if(data.success){
							//forumListRefresh();//刷新当前页
							gotoContentPage("${AppContext.ctxPath}/portal/forum/ForumList.jsp");
						}else{
							$.messager.alert("警告", data.result,'error');
						}
			});
		}
	});
	
}

</script>
</body>
</html>