<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<style type="text/css">
ul{
/**padding-right: 40px;**/
padding-left:0px;
width:100%;
}
.thread-item {
	background-color: #fff;
	margin-top:12px;
	border-radius: 2px;
	
    position: relative;
    border-bottom: 1px dotted #e4e6eb;
    border-bottom-width: 1px;
    border-bottom-style: dotted;
    border-bottom-color: rgb(228, 230, 235);
    overflow: hidden;
    padding: 10px 20px;
}
.topic-bg {
    background: url(http://tb2.bdstatic.com/tb/static-hottopic/img/bang_bg_4aa39ca.jpg) no-repeat top center;
	padding-top:20px;
	min-height:100%;
}
.forumListBody{
	width:60%;
	margin-left:20%;
	/*background: #FFF;
	border-style:none solid none solid;
	border-right-width:1px;
	border-left-width:1px;
	border-right-color:rgb(228, 230, 235);
	border-left-color:rgb(228, 230, 235);**/
}
.forumheader{
    font-size: 22px;
    color: #469ce7;
    font-family: "Microsoft YaHei", Arial, Helvetica, sans-serif, 宋体;
    font-weight: 400;
    cursor:pointer;
}
.forumfooter{
	float:right;
	margin-right:20px;
}

.forumcontent{
    text-indent:2em;
}
.tbui_aside_float_bar{
    position: fixed;
    left: 80%;
    top:150px;
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
.img200{
width:100px;
height:100px;
margin-left:7px;
margin-bottom:9px;
}
.selfDefineButton{
    display: inline-block;
    padding: 0 0;
    height: 28px;
    line-height: 28px;
    font-size: 14px;
    text-align: center;
    color: #fff;
    border-bottom-color: #3782f0;
    cursor: pointer;
    border:0px;
    float: right;
    border-radius: 2px;
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
}
a:hover {
text-decoration:underline;
}
</style>
</head>
<body >
 <div id="bigImg" >
		<img id="popUpImg"/>
 </div>
 <div class="easyui-layout" data-options="fit:true" border="false" >
 <div id="forumBodyFirstDiv" data-options="region:'south'" collapsible="false"  border="false" style="width:100%;height:100%;padding:0px;">
	    <div class="topic-bg" >
	    	<div class="forumListBody">
		    	<div style="border-top-width: 10px;margin-top: 0px; width:100%;padding-top: 10px;" id="searchForumDiv">
		    		<div style=" width:100%;">
			    		 <input style="width:89%;height: 24px;border-radius: 2px;border: 1px solid #ccc;"id="searchForum" type="text" onfocus="this.select()" />
			    		 <button class="selfDefineButton sD_blue" style="width:10%;" type="button" onclick="forumListRefresh()">搜索</button>
		    		</div>
		    	</div>
		    	<div id="forumList" style="height:auto;">
		    	</div>
			</div>
			<ul class="tbui_aside_float_bar">
				<li class="float_bar_li"><a class="float_bar_li_a3" onclick="addForum()"></a></li>
				<li class="float_bar_li"><a class="float_bar_li_a1" onclick="forumListRefresh()" href="#searchForumDiv"></a></li>
				<li class="float_bar_li"><a class="float_bar_li_a2"  href="#searchForumDiv"></a></li>
			</ul>
	    </div>
 </div>
	
	</div>
	<script type="text/javascript">
	var totalPage;
	var currentPage = 1;//当前页
	$.post('${AppContext.ctxPath}/action/portal/forum/forumList',
			{rows:20,page:currentPage},
			function(data){
				if(data.success){
					totalPage = data.totalPage;
					var row=data.rows;
					var html='<ul>';
					for(var i=0;i<row.length;i++){
						/** 构造图片html代码**/
						var imgHtml='';
						if(row[i].attList!=null){
							imgHtml = '<div class="replyContent"  >';
							for(var j=0;j<row[i].attList.length&&j<4;j++){
								imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img  src="'+row[i].attList[j].attachmentPath+'"  class="img200"/></a></div>';
							}
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
						html=html+'<li class="thread-item">'
						    +"<div><a class='forumheader' onclick='gotoContentPage(\"${AppContext.ctxPath}/portal/forum/ForumDetail.jsp?forumId="+row[i].id+"\")'>"+row[i].noteTitle+"</a>"
						    + (row[i].topCategory ? "<span style='float:right;height: 30px;line-height: 30px;'>" + getLovShowName('FORUM_TOP_CATEGORY',row[i].topCategory) + ' - ' + getLovShowName('FORUM_SUB_CATEGORY',row[i].secCategory) + "</span>"  : "")
						    + "</div>"
						    +'<div><p class="forumcontent">'+(noteContent==null?'':noteContent)+'</p></div>'
						    +imgHtml
						    +'<div><span class="forumfooter">'
						    	+row[i].userName+'&nbsp;&nbsp;'
						    	+row[i].created+"&nbsp;&nbsp;来自于&nbsp;&nbsp;"
						    	+row[i].platform+"&nbsp;&nbsp;"
						    	+'<span class="fa fa-commenting-o">&nbsp;&nbsp;'+row[i].replayNum+'</span>'
						    	+'</span></div>'
						    +'</li>'
					}
					$('#forumList').html(html);
					//$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:600,height:600,imgHeight:550,mulriple:1});
					$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1});
					
				
				}else{
				}
			});
	
	
	function forumListRefresh(){
		currentPage = 1;//当前页置为1
		var searchParam;
		var searchValue = $('#searchForum').val().trim();
		if(searchValue!=null||''==searchValue){
			searchParam = 'noteTitle';
		}else{
			searchParam = '';
		}
		$.post('${AppContext.ctxPath}/action/portal/forum/forumList',
				{rows:20,page:currentPage,searchParam:searchParam,searchValue:searchValue},
				function(data){
					if(data.success){
						totalPage = data.totalPage;
						var row=data.rows;
						var html='<ul>';
						for(var i=0;i<row.length;i++){
							var imgHtml='';
							if(row[i].attList!=null){
								imgHtml = '<div class="replyContent"  >';
								for(var j=0;j<row[i].attList.length&&j<4;j++){
									imgHtml = imgHtml+'<div class="small_picture"><a  href="'+'#bigImg'+'"><img src="'+row[i].attList[j].attachmentPath+'"  class="img200"/></a></div>';
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
							    +'<div><p class="forumcontent">'+(noteContent==null?'':noteContent)+'</p></div>'
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
							$('#forumList').html(html);
							$('div.small_picture a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1});
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
									for(var j=0;j<row[i].attList.length&&j<4;j++){
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
								    +'<div><p class="forumcontent">'+(noteContent==null?'':noteContent)+'</p></div>'
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
								$('#forumList').append('<ul><li><div><p class="forumcontent">已经是最后一条了</p></div></li></ul>');
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
							forumListNestPage();/** 请求下一页**/
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
	
	function addForum(){
		$.post('${AppContext.ctxPath}/action/portal/forum/generateForumId',null,function(data){
			if (data.success) {
				var url = "${AppContext.ctxPath}/portal/forum/NewForum.jsp?"
						+ "id=" + data.row.id;
				window.top.quickEnter('论坛', '论坛', 'BBS_MANAGE', url);
			} else {
				alert(data.message);
			}
		});
	}
	
	function delForum(id){
		$.post('${AppContext.ctxPath}/action/portal/forum/forumDelete/'+id,null,
				function(data){
					if(data.success){
						forumListRefresh();//刷新当前页
					}else{
						$.messager.alert("警告", data.result,'error');
					}
		});
	}
	</script>
</body>
</html>