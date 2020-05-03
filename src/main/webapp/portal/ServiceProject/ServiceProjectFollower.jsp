<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<title>项目跟进</title>
<style type="text/css">
.bodyFirstDev {
	margin-top: 50px;
}

.forumListBody {
	padding-top:5px;
	width: 98%;
	/* margin-left: 20%; */
	background: #FFF;
	border-style: solid solid none solid;
	border-right-width: 1px;
	border-left-width: 1px;
	border-top-width: 1px;
	border-top-color: rgb(228, 230, 235);
	border-right-color: rgb(228, 230, 235);
	border-left-color: rgb(228, 230, 235);
	min-height: 100%;
}

.formrow {
	width: 98%;
	margin-top: 5px;
	margin-bottom: 5px;
	display: table;
}

.forumForm {
	padding-top: 10px;
	padding-bottom: 10px;
	display: table;
	width: 90%;
	/* margin-left: 20%;
	margin-right: 20%; */
	padding-left: 40px;
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
	width: 60px;
	height: 60px;
	margin-left: 7px;
	margin-bottom: 9px;
}

.imgDevbox {
	border-style: solid solid solid solid;
	border-width: 1px;
	border-color: rgb(228, 230, 235);
	
	width: 100px;
	float: left;
	height: 100px;
	position: relative;
	margin-left: 10px;
}
.cancelImgIcon{
position: absolute;
left: 80px;
}
.img-upload{
width: 100px;
height: 100px;
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

.selfDefinebodyback1 {
	margin-left: 10px;
	min-height: 100%;
}
.selfDefinebodyback2 {
	margin-left: 0px;
	min-height: 100%;
}

.showDiv{
	padding :10px;
	width : 70%;
	hight : 25%;
}


ul{
/**padding-right: 40px;**/
padding-left:0px;
width:100%;
}
.thread-item {
	background-color: #fff;
	margin-top:5px;
	border-radius: 2px;
	
    position: relative;
    border-bottom: 1px dotted #e4e6eb;
    border-bottom-width: 1px;
    border-bottom-style: dotted;
    border-bottom-color: rgb(228, 230, 235);
    overflow: hidden;
    padding: 5px 10px;
}
.topic-bg {
    /* background: url(http://tb2.bdstatic.com/tb/static-hottopic/img/bang_bg_4aa39ca.jpg) no-repeat top center; */
	padding-top:1px;
	min-height:100%;
}
.forumheader{
    font-size: 10px;
    color: #469ce7;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 200;
    cursor:pointer;
    margin-top: 2px;
    margin-bottom: 2px;
}

.forumheader1{
    font-size: 11px;
    color: #469ce7;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 200;
    margin-top: 2px;
    margin-bottom: 2px;
    margin-left: 2px;
    float: left;
}
.forumheader2{
    font-size: 11px;
    color: #469ce7;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 200;
    margin-top: 2px;
    margin-bottom: 2px;
    margin-left: 2px;
    float: right;
}

.forumfooter{
	float:right;
	margin-right:20px;
}
.forumfooterl{
	float:left;
	margin-left:20px;
}
.forumfooterr{
	float:right;
	margin-right:20px;
}

.forumcontent{
    /* text-indent:2em; */
    margin-top: 0;
    margin-bottom: 0;
    margin-left: 20px;
    word-break: break-all;
    word-wrap: break-word;
    padding-top: 0;
    padding-bottom: 0;
    line-height: 15px;
}
.tbui_aside_float_bar{
    position: fixed;
    left: 80%;
    top:330px;
    bottom: 100px;
    margin-left: 498px;
    z-index: 1005;
    list-style: none;
    margin: 0;
    padding: 0;
    box-sizing: content-box;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    -webkit-padding-start: 40px;
    font-family: "Microsoft YaHei", 微软雅黑, Arial, Helvetica, sans-serif;
    font-size: 12px;
    box-sizing: content-box;
}
.float_bar_li{
	display: list-item;
    text-align: -webkit-match-parent;
    box-sizing: content-box;
    list-style: none;
    color: #333;
}
.float_bar_li_a1{
	background-image: url(http://tb2.bdstatic.com/tb/static-common/widget/aside_float_bar/aside_float_bar_z_2971581.png);
	background-position: -220px 0px;
    display: inline-block;
    width: 45px;
   	height: 45px;
   	text-decoration: none;
   	background-color: transparent;
}
.float_bar_li_a2{
	    background-image: url(http://tb2.bdstatic.com/tb/static-common/widget/aside_float_bar/aside_float_bar_z_2971581.png);
	    background-position: 0px 0px;
        display: inline-block;
    	width: 45px;
   	 	height: 45px;
   	 	text-decoration: none;
   	 	background-color: transparent;
}
.float_bar_li_a3{
	    background-image: url(http://tb2.bdstatic.com/tb/static-common/widget/aside_float_bar/aside_float_bar_z_2971581.png);
	    background-position: -220px 100px;
        display: inline-block;
    	width: 45px;
   	 	height: 45px;
   	 	text-decoration: none;
   	 	background-color: transparent;
}
.float_bar_li_a1:hover{
background-position:-220px -55px;
}
.float_bar_li_a2:hover {
 background-position: -165px -110px;
}
.float_bar_li_a3:hover{
background-position: -220px 45px;
}
.img20{
width:20px;
height:20px;
margin-left:7px;
margin-bottom:9px;
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
.small_picture{
display:inline;
vertical-align: middle;
}
a:hover {
text-decoration:underline;
}
</style>
</head>
<body class="easyui-layout " fit="true" border="false">
	<div style="align:center"><p id="tit"></p></div>
	<div data-options="region:'center'" class="selfDefinebodyback1"
		collapsible="true" border="false"
		style=" padding: 10px;">
		
		 <div id="bigImg" >
			<img id="popUpImg"/>
 		</div>
	 <div class="easyui-layout" data-options="fit:true" border="false" >
			 <div id="forumBodyFirstDiv" data-options="region:'south'" collapsible="false"  border="false" style="width:100%;height:100%;padding:0px;">
				    <div class="topic-bg" >
				    	<div class="forumListBody">
					    	 <div style="border-top-width: 10px;margin-top: 0px; width:100%;padding-top: 0px;" id="searchForumDiv">
					    
					    	</div> 
					    	<div id="forumList" style="height:auto;">
					    	</div>
						</div>

				    </div>
			 </div>
	 
	
		
		</div>
		
	</div>

<!-- ------------------------------------------------------------------------------------------------------- -->
	<div data-options="region:'south'" class="selfDefinebodyback2"
		collapsible="false" border="false"
		style="width: 100%; height: 200px; padding: 0px;">
		<div class="bodyFirstDev">
			<div class="forumForm">
				<form id="forum-form" method="post" enctype="multipart/form-data">
					<!-- <div class="formrow">
						<span style="float: left; text-align: right; width: 8%;">跟进时间：</span>
						<input type="text" id="noteTitle" name="dt"
							style="width: 80%; margin-bottom: 10px; border-width: 1px;" />
					</div> -->
					
					<div class="formrow">
						<div style="float: left; text-align: right; width: 8%;"><nobr>跟进内容：</nobr></div>
						<textarea id="note" name="description" 
							style="width: 80%; height: 60px; padding-right: 0px; padding-left: 0px; "></textarea>
					</div>
					
					<!-- <div class="formrow" style="padding-left: 7%;">
						<div id="imgForm"></div>
					</div> -->

					<div class="formrow"
						style="display: inline-block; text-align: right; width: 80%;">
						<button type="button" onclick="addForum()"
							class="selfDefineButton sD_blue">新增跟进</button>
						<button type="button" class="selfDefineButton sD_green"
							onclick="addForumAtt()">添加附件</button>
					</div>
					
					<div class="formrow" > <!-- style="padding-left: 7%;" -->
						<div id="imgForm"></div>
					</div>
				</form>
			</div>
			<div></div>
		</div>
	</div>
<script type="text/javascript">
var totalPage;
var currentPage = 1;//当前页
/* var tmp = ${param.title};
var title = decodeURI(tmp);

$('tit').html(title); */
 
$.post('${AppContext.ctxPath}/action/portal/flowUp/queryProjByExamplePage',
		{sort:'created',order:'desc',serviceId:'${param.serviceId}',pageFlag:false},
		function(data){
			if(data.success){
				totalPage = data.total;
				var row=data.rows;
				var html='<ul>';
				var tmp;
				/* 	var _st;
				var output; */
				for(var i=0;i<row.length;i++){
					/** 构造图片html代码**/
					var imgHtml=row[i].description;
					var haveImg = row[i].attachmentPath;
					var imgFlag;
					/* if(row[i].attachmentPath!=null){
						if (haveImg.indexOf('empty.') <= 0){
							imgHtml = '<div class="replyContent"  >';
							imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img  src="'+row[i].attachmentPath+'"  class="img200"/></a></div>';
							imgHtml +='</div>';
						}else{
							imgHtml = '<div class="replyContent"  >';
							imgHtml +='</div>';
						}
					} */
					
					if(row[i].attachmentList!=null){
						imgHtml = '<div class="replyContent" id="div-' + row[i].id + '" >';
						for(var j=0;j<row[i].attachmentList.length;j++){
							imgFlag = isImgFlag(row[i].attachmentList[j].attachmentPath);
							if (imgFlag == true){
								//imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img src="'+row[i].attachmentList[j].smallurl+'" class="img200"/><img src="'+row[i].attachmentList[j].attachmentPath+'" style="display:none;" /></a></div>';
								imgHtml = imgHtml+'<div class="small_picture"><a target="_blank" href="'+row[i].attachmentList[j].attachmentPath+'"><img src="'+row[i].attachmentList[j].smallurl+'" class="img200"/></a></div>';
							
							}
						};
						
						for(var j=0;j<row[i].attachmentList.length;j++){
							imgFlag = isImgFlag(row[i].attachmentList[j].attachmentPath);
							if (imgFlag == false){
								/* imgHtml = imgHtml+'<p id="attach" class="forumheader" visible="false">附件：</p>'; */
								imgHtml = imgHtml+'<p id="attach" class="forumheader"><div class="small_picture"><a  href="'+ row[i].attachmentList[j].attachmentPath +'">附件:'+row[i].attachmentList[j].attachmentOriginal+'</a></div></p>';
							}
						};
						
						imgHtml +='</div>';
						
					}
					/**构造图片html代码结束**/
					/**构造编辑按钮html代码**/
					var editHtml='';
					if(row[i].createdBy==appCtx.userId){
						editHtml = '&nbsp;&nbsp;<a class="fa fa-pencil" style="cursor:pointer;" onclick="gotoContentPage(&quot;${AppContext.ctxPath}/portal/forum/UpdateForum.jsp?id='+row[i].id+'&quot;)">编辑</a>'
								 +'&nbsp;&nbsp;<a class="fa fa-times imgClose" style="cursor:pointer;" onclick="delForum(&quot;'+row[i].id+'&quot;)">删除</a>';
					}
					var noteContent='';
					if(row[i].simpleNote!=null&&row[i].simpleNote.length>50){
						noteContent = row[i].simpleNote.substring(0,50)+'...'; 
					}else{
						noteContent = row[i].simpleNote;
					}
					tmp = row[i].description;
					/* for (var i = tmp.length - 1; i >= 0; i--) {
		                if (i == tmp.length - 20) { _st += tmp[i] + "<br/>"; } 
		                else if (i == tmp.length - 40) { _st += tmp[i] + "<br/>"; } 
		                else { _st += tmp[i]; }
		            }
		            for (var i = _st.length - 1; i >= 0; i--) {
		                output += _st[i];
		            } */
		            /* row[i].description */
		            if (tmp == null){
		            	tmp = " ";
		            }
					html=html+'<li class="thread-item">'
					    /* +"<div><p class='forumheader1'>"+"跟进人："+ row[i].emp +"　　　　　　　跟进时间："+ row[i].dt +"</p></div>" */
					    +"<div><p class='forumheader1' display:inline;'>"+"跟进人："+ row[i].emp + "</p><p class='forumheader2 style='display:inline;'>"+"跟进时间："+ row[i].dt+"</p></div>"
					    /* +"<div><p class='forumheader2'>"+"跟进人："+row[i].emp+"</p></div>" */
					    +"<div style='padding-top:10px'>"+ appendCntP(tmp) +"</div>"
					    +imgHtml
					    +'<div><span class="forumfooterr">'
					    /* +'<a href=\"javascript:void(0);\" onclick="delFlowUp(\''+row[i].id+'\')">删除</a>' */
					    	+'</span></div>'
					    +'</li>'
				}
				$('#forumList').html(html);
				$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1,haveBigUrl:true});
			}else{
			}
		});


function appendCntP(contentStr){
	if(!contentStr){
		contentStr = '';
	}
	var resultHtml = '<div style="margin-top: 10px">';
	var cntStrs = contentStr.split('\n');
	for (var i = 0; i < cntStrs.length; i++) {
		var str = cntStrs[i];
		str = str.replace(/\s/g,'&nbsp');
		resultHtml += '<p class="forumcontent">' + str + '</p>';
	}
	resultHtml += '</div>';
	console.info(resultHtml);
	return resultHtml;
}

function forumListRefresh(){
	currentPage = 1;//当前页置为1
	/* var searchParam;
	var searchValue = $('#searchForum').val().trim(); 
	if(searchValue!=null||''==searchValue){
		searchParam = 'description';
	}else{
		searchParam = '';
	} */
	var searchParam = '';
	var searchValue = '';
	$.post('${AppContext.ctxPath}/action/portal/flowUp/queryByExamplePage',
			{sort:'created',order:'desc',serviceId:'${param.serviceId}',pageFlag:false,searchParam:searchParam,searchValue:searchValue},
			function(data){
				if(data.success){
					totalPage = data.total
					var row=data.rows;
					var html='<ul>';
					var tmp;
					for(var i=0;i<row.length;i++){
						var imgHtml='';
						var haveImg = row[i].attachmentPath;
						/* if(row[i].attachmentPath!=null){
							if (haveImg.indexOf('empty.') <= 0){
								imgHtml = '<div class="replyContent"  >';
								imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img  src="'+row[i].attachmentPath+'"  class="img200"/></a></div>';
								imgHtml +='</div>';
							}else{
								imgHtml = '<div class="replyContent"  >';
								imgHtml +='</div>';
							}
						} */
						if(row[i].attachmentList!=null){
							imgHtml = '<div class="replyContent" id="div-' + row[i].id + '" >';
							for(var j=0;j<row[i].attachmentList.length;j++){
								imgFlag = isImgFlag(row[i].attachmentList[j].attachmentPath);
								if (imgFlag == true){
									/* imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img src="'+row[i].attachmentList[j].smallurl+'" class="img200"/><img src="'+row[i].attachmentList[j].bigurl+'" style="display:none;" /></a></div>'; */
									imgHtml = imgHtml+'<div class="small_picture"><a target="_blank" href="'+row[i].attachmentList[j].attachmentPath+'"><img src="'+row[i].attachmentList[j].smallurl+'" class="img200"/></a></div>';
								}
							};
							
							for(var j=0;j<row[i].attachmentList.length;j++){
								imgFlag = isImgFlag(row[i].attachmentList[j].attachmentPath);
								if (imgFlag == false){
									/* imgHtml = imgHtml+'<p id="attach" class="forumheader" visible="false">附件：</p>'; */
									imgHtml = imgHtml+'<p id="attach" class="forumheader"><div class="small_picture"><a  href="'+ row[i].attachmentList[j].attachmentPath +'">附件:'+row[i].attachmentList[j].attachmentOriginal+'</a></div></p>';
								}
							};
							
							imgHtml +='</div>';
							
						}
						var noteContent='';
						if(row[i].simpleNote!=null&&row[i].simpleNote.length>50){
							noteContent = row[i].simpleNote.substring(0,50)+'...'; 
						}else{
							noteContent = row[i].simpleNote;
						}
						tmp = row[i].description;
						/* for (var i = tmp.length - 1; i >= 0; i--) {
			                if (i == tmp.length - 20) { _st += tmp[i] + "<br/>"; } 
			                else if (i == tmp.length - 40) { _st += tmp[i] + "<br/>"; } 
			                else { _st += tmp[i]; }
			            }
			            for (var i = _st.length - 1; i >= 0; i--) {
			                output += _st[i];
			            } */
			            /* row[i].description */
			            if (tmp == null){
			            	tmp = " ";
			            }
						/* html=html+'<li class="thread-item">'
						    +"<div><p class='forumheader1' display:inline;'>"+"跟进人："+ row[i].emp + "</p><p class='forumheader2 style='display:inline;'>"+"跟进时间："+ row[i].dt+"</p></div>"
						    +'<div><p class="forumcontent">'+tmp+'</p></div>'
						    +imgHtml
						    +'<div><span class="forumfooterr">'
						    	+'</span></div>'
						    +'</li>' */
			            html=html+'<li class="thread-item">'
					    /* +"<div><p class='forumheader1'>"+"跟进人："+ row[i].emp +"　　　　　　　跟进时间："+ row[i].dt +"</p></div>" */
					    +"<div><p class='forumheader1' display:inline;'>"+"跟进人："+ row[i].emp + "</p><p class='forumheader2 style='display:inline;'>"+"跟进时间："+ row[i].dt+"</p></div>"
					    /* +"<div><p class='forumheader2'>"+"跟进人："+row[i].emp+"</p></div>" */
					    +"<div style='padding-top:10px'>"+ appendCntP(tmp) +"</div>"
					    +imgHtml
					    +'<div><span class="forumfooterr">'
					    /* +'<a href=\"javascript:void(0);\" onclick="delFlowUp(\''+row[i].id+'\')">删除</a>' */
					    	+'</span></div>'
					    +'</li>'
					}
					if(row.length>0){
						$('#forumList').html(html);
						$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1,haveBigUrl:true});
					}else{
						$('#forumList').html('<ul><li class="thread-item"><div><p class="forumcontent">获取不到数据.</p></div></li></ul>');
						
					}
				}else{
					alert(data.result);
				}
			});
}

function forumListNestPage(){
	if(currentPage<totalPage){
		currentPage++;
		$.post('${AppContext.ctxPath}/action/portal/forum/forumList',
				{rows:20,page:currentPage},
				function(data){
					if(data.success){
						totalPage = data.totalPage;
						var row=data.rows;
						var html='<ul>';
						for(var i=0;i<row.length;i++){
							var imgHtml='';
							if(row[i].attList!=null){
								imgHtml = '<div class="replyContent"  >';
								for(var j=0;j<row[i].attList.length;j++){
									imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img src="'+row[i].attList[j].attachmentPath+'" class="img200" /></a></div>';
								}
								imgHtml +='</div>';
							}
							
							
							var noteContent='';
							if(row[i].simpleNote!=null&&row[i].simpleNote.length>50){
								noteContent = row[i].simpleNote.substring(0,50)+'...'; 
							}else{
								noteContent = row[i].simpleNote;
							}
							html=html+'<li class="thread-item">'
							    +"<div><a class='forumheader' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/forum/ForumDetail.jsp?forumId="+row[i].id+"\")'>"+row[i].noteTitle+"</a></div>"
							    +'<div>'+ appendCntP(tmp) +'</div>'
							    +imgHtml
							    +'<div><span class="forumfooter">'
							    	+row[i].userName+'&nbsp;&nbsp;'
							    	+row[i].created+"&nbsp;&nbsp;来自于&nbsp;&nbsp;"
							    	+row[i].platform+"&nbsp;&nbsp;"
							    	+'<span class="fa fa-commenting-o">&nbsp;&nbsp;'+row[i].replayNum+'</span>'
							    	+'</span></div>'
							    +'</li>'
						}
						if(row.length>0){
							$('#forumList').append(html);
							$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1});
						}else{
							/* $('#forumList').append('<ul><li><div><p class="forumcontent">已经是最后一条了</p></div></li></ul>'); */
						}
					}else{
						alert(data.result);
					}
				});
	}else{
	}
}

$('#forumBodyFirstDiv').scroll(
		function(){
					var scrolllength = $('#forumBodyFirstDiv').scrollTop();//滚动距离
					var targetDivLength = $('#forumBodyFirstDiv').height();//元素高度
					if(scrolllength>=targetDivLength){
						//forumListNestPage();/** 请求下一页**/
			       	}  
});

function forumIdFormatter(val, row) {
	if (val != null) {
		return "<a href='###' class='easyui-tooltip' title='"
				+ val
				+ "' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/forum/ForumDetail.jsp?forumId="+row.id
				+ "\")'>" + val + "</a>";
	}
}

/* function addForum(){  
	$.post('${AppContext.ctxPath}/action/portal/forum/generateForumId',null,function(data){
		if (data.success) {
			var url = "${AppContext.ctxPath}/portal/forum/NewForum.jsp?"
					+ "id=" + data.row.id;
			window.top.quickEnter('论坛', '论坛', 'BBS_MANAGE', url);
		} else {
			alert(data.message);
		}
	});
}  */

// 新增项目跟进 
/* function addFlowUp(){
	
	$.post(
		'${AppContext.ctxPath}/action/portal/flowUp/insert',
		{
			optyId : optyId,
			dt : row.dt,
			description : row.description, //项目跟进内容
			type : row.type,
			orgId : appCtx.orgId,
			postnId : appCtx.postnId,
			empId : appCtx.userId
		},
		function(data) {
			if (data.success) {
				
			} else {
				alert(data.message);
			}
		});
	} */

	/** 删除项目跟进 */
	function delFlowUp(id) {
		$.post('${AppContext.ctxPath}/action/portal/flowUp/deleteById',{id:id},function(data) {
			if (data.success) {
				forumListRefresh();//刷新当前页
				//$dataOptyFlowUpgrid.datagrid('reload');
			} else {
				$.messager.alert("警告", data.result, 'error');
			}
		});
	}


var record;//新增项目跟进后返回的数据
var headId;
var headName;


var imgNum = 1;
var imgCount = 1;
var nestImg = 'img' + imgNum;
var nestImgInput = 'imgInput' + imgNum;
var nestImgDiv = 'imgDiv' + imgNum;


function addForum() {
	$.post('${AppContext.ctxPath}/action/portal/flowUp/insert', {
		serviceId : "${param.serviceId}",
		dt : appCtx.sysdate(),
		description : $('#note').val(),
		type : 'TUDO_CD_FLOW_UP',
		orgId : appCtx.orgId,
		postnId : appCtx.postnId,
		empId : appCtx.userId
	}, function(data) {
		 if (!data.success) {
			if (data.result.indexOf('值太大') > 0) {
				$.messager.alert('提示', "跟进说明超过250字！");
			} else {
				
				$.messager.alert('提示', data.result);
			}

		} else {
			record = data.newRow;
			headId = record.id;
			headName = record.description;
			if(imgCount>1){
				uploadAttachment();//添加照片
			}else{
				forumListRefresh();
			}
			
			/* window.parent.closeAddOptyWin('close'); */
			forumListRefresh(); 
			clearForm();
			
		}  
	});
}
function addForumAtt() {
	
	var attr = 'addAttr1' + nestImg;
	var html = '<div class="imgDevbox" style="display:none;" id="'+nestImgDiv+'">'
			+ '<div class="cancelImgIcon"><a class="fa fa-times imgClose" onclick="$(&quot;#'
			+ nestImgDiv
			+ '&quot;).remove();"></a></div>'
			/* + '<div style="width:210px;"><a class="fa fa-times imgClose" onclick="delAtt('+nestImgDiv+')"></a></div>' */
			+ '<img id="'+nestImg+'"  src="" class="img-upload"/>'
			/* + '<img id="'+nestImg+'"  src="" class="img20"/>' */
			+ '<p id='+attr+' visible="false"></p>'
			+ '<input id="'
			+ nestImgInput
			/* + '" type="file" name="uploadAttachment" multiple="multiple" accept="image/*" style="display:none;" onchange="preImg(this.id,&quot;' */
			+ '" type="file" name="uploadAttachment" multiple="multiple" accept="MIME_type" style="display:none;" onchange="preImg(this.id,&quot;'
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
	/* var f = document.getElementById(sourceId).files; 
	var size = f[0].size; */
	var imgPre = document.getElementById(targetId);
	imgPre.src = url;
	$('#' + outTargetId).css("display", "");
	var urlTmp = document.getElementById(sourceId).value;
	var imgFlag = isImgFlag(urlTmp);
	/* if (imgFlag == true){
		if (size >= 2 * 1024 *1024){
			$.messager.alert('注意','上传图片大小不要超过2M');
			return;
		}
	} */
	if (imgFlag == false){
		/* $('#' + targetId).removeClass().addClass("img20");  */
		$('#' + targetId).hide();
		$('#addAttr1'+targetId).html(getFileName(urlTmp));
		$('#addAttr1'+targetId).visible = true;
	}
	
}

function clearForm() {
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
			
			if (data.success) {
				$.messager.progress('close');
				//更新项目跟进
				optyFollowUpAttachment(data.entity.id, record.id);
				forumListRefresh();
			} else {
				if (data.result == null) {
					data.result = "上传失败！";
				}
				$.messager.alert("警告", data.result);
				/* errFun(data.result, that); */
			}
		}
	};
	$("#forum-form").ajaxSubmit(options);
	
}

/**
 * 更新项目跟进的附件ID
 */
function optyFollowUpAttachment(attachmentId, optyFollowId) {
	if (!attachmentId || !optyFollowId) {
		$.messager.alert('警告', '获附件ID失败！');
		return;
	}
	$.post('${AppContext.ctxPath}/action/portal/flowUp/update', {
		id : optyFollowId,
		dt : record.dt,
		attachmentId : attachmentId
	}, function(data) {
		if (data.success) {
			$.messager.alert("提示", "上传成功！");
		} else {
			$.messager.alert('警告', data.result);
			/* errFun(data.result, that); */
		}
	});
}

function isImgFlag(url){
	var extStart = url.lastIndexOf(".");
	var ext = url.substring(extStart,url.length).toUpperCase();
	if (ext != ".BMP" && ext != ".PNG" && ext != ".GIF" && ext != ".JPG" && ext != ".JPEG") {
        return false;
    } else {
    	return true;
    }
}

function getFileName(url){
	var extStart = url.lastIndexOf("\\");
	var ext = url.substring(extStart,url.length);
	ext = ext.replace('\\','');
	return ext;
}

function showAttach(){
	$('#attach').attr("visible", true);
}
</script>
</body>
</html>