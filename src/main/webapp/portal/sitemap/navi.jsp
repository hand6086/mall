<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/portal/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.css?version=<%=version%>" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap-theme.css?version=<%=version%>" />


<script src="${AppContext.ctxPath}/static/bootstrap/js/bootstrap.min.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.form.js?version=<%=version%>"></script>
<style type="text/css">
.kuaisu{ width:100%; margin:0 auto; overflow:hidden;  height:38px; }
.dangqian_juti{ padding:0 30px; overflow:hidden; color:#7a8094; font-size:14px;}
.dangqian_juti_left{ height:38px; line-height:38px; width:50%; float:left;}
.dangqian_juti_right{ height:38px; line-height:38px; width:50%; float:right; text-align:right;}
.head_notice_div { 
    width:38px; 
    position:relative; 
    float:right;
} 
.head_notice_img { 
    width:21px; 
    height:28px; 
	margin-top:3px;
    /*border:1px solid #000; */
    background:url(${AppContext.ctxPath}/static/images/bell_28.png) no-repeat center;
} 
.contain {
	width: 100%;
}

.a {
	float: left;
	width: 25%
}

.b {
	float: left;
	width: 25%
}

.c {
	float: left;
	width: 25%
}

.d {
	float: left;
	width: 25%
}

.highlight {
	background: green;
	font-weight: bold;
	color: white;
}

.search {
	margin-top: 10px;
	margin-bottom: 10px;
}

.search-input {
	padding-left: 5px;
	height: 30px;
	width: 300px;
	font-size: 14px !important;
	border: 1px solid #469ce7;
}

.btn-search {
	display: inline-block;
	margin-bottom: 0;
	font-weight: normal;
	text-align: center;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	background-image: none;
	border: 1px solid transparent;
	white-space: nowrap;
	padding: 7px 12px;
	line-height: 1.42857143;
	border-radius: 4px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	margin-top: -2px;
}

.btn-primary {
	color: #ffffff;
	background-color: #469ce7;
}

.btn-primary:focus, .btn-primary.focus {
	color: #ffffff;
	background-color: #286090;
	border-color: #122b40;
}

.btn-primary:hover {
	color: #ffffff;
	background-color: #286090;
	border-color: #204d74;
}
.panel-body{
	border:0px;
	padding:0;
}

.modal-line{
	margin:15px 0;
	overflow:hidden;
}
.form-input{
	font-size:14px !important;
}
.img200 {
	width: 110px;
	height: 110px;
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

</style>
<body class="easyui-layout">
	<div align="center"
		style="height: 93px; width: 100%; overflow: hidden; width: 1206px;"
		data-options="region:'north'" border="false">
		<div class="kuaisu">
			<div class="dangqian_juti">
				<div class="dangqian_juti_left"
					style="font-size: 12px !important; padding-top: 8px;"></div>
				<div class="dangqian_juti_right" style="font-size: 12px !important;">
					<div style="float: right">
						${AppContext.fstName} 欢迎您! <a href="javascript:;"
							onclick="window.parent.mainFrameContent('切换职位','${AppContext.ctxPath}/portal/basic/ChangePostn.jsp')"
							style="color: rgb(122, 128, 148);"> <i class="fa fa-refresh"
							aria-hidden="true"
							style="vertical-align: middle; margin-left: 14px; margin-right: 3px;"></i>${UserContext.postnName}</a>
						<a href="" onclick="" style="color: rgb(122, 128, 148);"
							data-toggle="modal" data-target="#myModal"> <i
							class="fa fa-smile-o fa-lg" aria-hidden="true"
							style="margin-left: 14px; margin-right: 3px;"></i>反馈
						</a> <a href="javascript:;"
							onclick="window.parent.mainFrameContent('修改密码','${AppContext.ctxPath}/portal/user/UserChangePassword.jsp')"
							style="color: rgb(122, 128, 148);"> <img
							src="${AppContext.ctxPath}/static/css/img/11.png"
							style="vertical-align: middle; margin-left: 14px;">修改密码
						</a> <a href="${AppContext.ctxPath}/portal/j_spring_security_logout"
							style="color: rgb(122, 128, 148);"> <img
							src="${AppContext.ctxPath}/static/css/img/13.png"
							style="vertical-align: middle; margin-left: 14px;"><span
							style="margin-right: 5px;">退出登录<span /></a>
					</div>

					<div class="head_notice_div">
						<a href="javascript:void(0)" title="查看系统消息"
							onclick="window.parent.quickEnter('公告', '系统提示', 'ANNOUNCE_MANAGE', '${AppContext.ctxPath}/portal/message/notice.jsp')">
							<div class="head_notice_img" id="head_notice_img"></div>
						</a>
					</div>
				</div>
			</div>

		</div>
		<div style="width: 100%; height: 0px; border: 1px solid #e0ecff;"></div>
		<form onsubmit="highlight(this.s.value);return false;" style="margin-top:10px;">
			<span>站内导航 </span> <input class="search-input" placeholder="请输入关键内容"
				name="s" id="s" />
			<button type="submit" class="btn-search btn-primary"
				style="height: 35px; width: 80px;">搜索</button>
		</form>
	</div>
	<div id="content" class="contain" data-options="region:'center'" border="false">
		<div class="a">
			<ul>
				<c:forEach var="m" items="${menuList}" begin="0"
					end="${menuList.size()/4 }" step="1">
					<li><h3>
							<a href="javascript:void(0);"
								onclick="window.top.getmenuitem('${m.menuType}','${m.text}')">${m.text }</a>
						</h3></li>
					<c:forEach var="submenu" items="${sList}">
						<c:if test="${m.id == submenu.parentMenuId }">
							<ul>
								<li><a href="javascript:void(0);"
									onclick="window.top.quickEnter('${m.text}', '${submenu.text}', '${submenu.menuType}', '${submenu.menuUrl}')">${submenu.text }</a></li>
							</ul>
						</c:if>
					</c:forEach>
				</c:forEach>
			</ul>
		</div>
		<div class="b">
			<ul>
				<c:forEach var="m" items="${menuList}"
					begin="${(menuList.size()/4)+1 }" end="${2*(menuList.size()/4) }"
					step="1">
					<!-- 一级菜单 -->
					<li><h3>
							<a href="javascript:void(0);"
								onclick="window.top.getmenuitem('${m.menuType}','${m.text}')">${m.text }</a>
						</h3></li>
					<c:forEach var="submenu" items="${sList}">
						<c:if test="${m.id == submenu.parentMenuId }">
							<ul>
								<li><a href="javascript:void(0);"
									onclick="window.top.quickEnter('${m.text}', '${submenu.text}', '${submenu.menuType}', '${submenu.menuUrl}')">${submenu.text }</a></li>
							</ul>
						</c:if>
					</c:forEach>
				</c:forEach>
			</ul>
		</div>
		<div class="c">
			<ul>
				<c:forEach var="m" items="${menuList}"
					begin="${2*(menuList.size()/4)+1 }" end="${3*(menuList.size()/4) }"
					step="1">
					<li><h3>
							<a href="javascript:void(0);"
								onclick="window.top.getmenuitem('${m.menuType}','${m.text}')">${m.text }</a>
						</h3></li>
					<c:forEach var="submenu" items="${sList}">
						<c:if test="${m.id == submenu.parentMenuId }">
							<ul>
								<li><a href="javascript:void(0);"
									onclick="window.top.quickEnter('${m.text}', '${submenu.text}', '${submenu.menuType}', '${submenu.menuUrl}')">${submenu.text }</a></li>
							</ul>
						</c:if>
					</c:forEach>
				</c:forEach>
			</ul>
		</div>

		<div class="d">
			<ul>
				<c:forEach var="m" items="${menuList}"
					begin="${3*(menuList.size()/4)+1 }" end="${4*(menuList.size()/4) }"
					step="1">
					<li><h3>
							<a href="javascript:void(0);"
								onclick="window.top.getmenuitem('${m.menuType}','${m.text}')">${m.text }</a>
						</h3></li>
					<c:forEach var="submenu" items="${sList}">
						<c:if test="${m.id == submenu.parentMenuId }">
							<ul>
								<li><a href="javascript:void(0);"
									onclick="window.top.quickEnter('${m.text}', '${submenu.text}', '${submenu.menuType}', '${submenu.menuUrl}')">${submenu.text }</a></li>
							</ul>
						</c:if>
					</c:forEach>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog" style="width:450px;">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" onclick="clearForm()"><span aria-hidden="true" style="font-size:22px;">&times;</span><span class="sr-only">Close</span></button>
	        <h4 class="modal-title" id="myModalLabel">信息反馈</h4>
	      </div>
	      <div class="modal-body" style="padding:10px 30px;">
	        <form role="form" id="feedbackForm" method="post">
			  <div class="modal-line">
			    <input type="text" class="form-control form-input" id="callName" name="callName" placeholder="怎么称呼您">
			  </div>
			  <div class="modal-line">
			    <input type="text" class="form-control form-input" id="phoneNumber" name="phoneNumber" placeholder="请留下您的手机号码">
			  </div>
			  <div class="modal-line">
			    <textarea class="form-control form-input easyui-validatebox" data-options="required:true" rows="6" id="suggest" name="suggest" missingMessage="该输入项为必输项" placeholder="如您有关于产品的任何问题，欢迎反馈给我们，我们将在第一时间回复。"></textarea>
			  </div>
			  <div class="modal-line">
				<button type="button" class="btn btn-success btn-xs" onclick="addForumAtt()">添加图片</button>
				<div id="imgForm"></div>
			  </div>
	 	      <div class="modal-line">
		      	<button type="button" class="btn btn-info btn-lg btn-block form-input" onclick="saveFeedbackInfo()">提交</button>
		      </div>
			</form>
	      </div>
	    </div>
	  </div>
	</div>

	<script type="text/javascript">
 	$feedbackForm = $("#feedbackForm");   //反馈表单
 	
		function encode(s) {
			return s.replace(/&/g, "&").replace(/</g, "<").replace(/>/g, ">")
					.replace(/([\\\.\*\[\]\(\)\$\^])/g, "\\$1");
		}
		function decode(s) {
			return s.replace(/\\([\\\.\*\[\]\(\)\$\^])/g, "$1").replace(/>/g,
					">").replace(/</g, "<").replace(/&/g, "&");
		}
		function highlight(s) {
			if (s.length == 0) {
				$.messager.alert("提示", "搜索关键词未填写！");
				return false;
			}
			s = encode(s);
			var obj = document.getElementsByTagName("body")[0];
			var t = obj.innerHTML.replace(
					/<span\s+class=.?highlight.?>([^<>]*)<\/span>/gi, "$1");
			obj.innerHTML = t;
			var cnt = loopSearch(s, obj);
			t = obj.innerHTML
			var r = /{searchHL}(({(?!\/searchHL})|[^{])*){\/searchHL}/g
			t = t.replace(r, "<span class='highlight'>$1</span>");
			obj.innerHTML = t;
		}
		function loopSearch(s, obj) {
			var cnt = 0;
			if (obj.nodeType == 3) {
				cnt = replace(s, obj);
				return cnt;
			}
			for (var i = 0, c; c = obj.childNodes[i]; i++) {
				if (!c.className || c.className != "highlight")
					cnt += loopSearch(s, c);
			}
			return cnt;
		}
		function replace(s, dest) {
			var r = new RegExp(s, "g");
			var tm = null;
			var t = dest.nodeValue;
			var cnt = 0;
			if (tm = t.match(r)) {
				cnt = tm.length;
				t = t.replace(r, "{searchHL}" + decode(s) + "{/searchHL}")
				dest.nodeValue = t;
			}
			return cnt;
		}
 /* 反馈功能代码 start */
        //清空表单
  		function clearForm() {
  			imgNum = 1;//重置照片计数
  			$("#imgForm").empty();//清除div内容 
  			$('#feedbackForm')[0].reset();
  		}
  		
  		//添加图片事件
  		var imgNum = 1;
  		var nestImg = 'img' + imgNum;
  		var nestImgInput = 'imgInput' + imgNum;
  		var nestImgDiv = 'imgDiv' + imgNum;
  		function addForumAtt() {
  			var html = '<div class="imgDevbox" style="width:125px;float:left;display:none;" id="'+nestImgDiv+'">'
  					+ '<div style="width:117px;"><a class="fa fa-times imgClose" onclick="$(&quot;#'
  					+ nestImgDiv
  					+ '&quot;).remove();"></a></div>'
  					+ '<img id="'+nestImg+'"  src="" class="img200"/>'
  					+ '<input id="'
  					+ nestImgInput
  					+ '" type="file" name="uploadAttachment" accept="image/gif,image/jpeg,image/jpg,image/png,image/bmp" style="display:none;" onchange="preImg(this.id,&quot;'
  					+ nestImg
  					+ '&quot;,&quot;'
  					+ nestImgDiv
  					+ '&quot;)"/>'
  					+ '</div>'
  			$('#imgForm').append(html);
  			imgNum++;
  			$('#' + nestImgInput).trigger('click');
  			nestImg = 'img' + imgNum;
  			nestImgInput = 'imgInput' + imgNum;
  			nestImgDiv = 'imgDiv' + imgNum;
  		}	

  		//获取文件url
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
  		}	
		
		//提交保存反馈信息
   		var headId;
   		var headName;
   		function saveFeedbackInfo(){
    			var isPass = $feedbackForm.form('validate');
   			if(!isPass){
   				$.messager.alert("提示", "请先输入您的建议再提交！");
   				return isPass;
   			}
   			$.post('${AppContext.ctxPath}/action/portal/appSuggest/insert', {
   				callName   :$("#callName").val(),
   				phoneNumber:$("#phoneNumber").val(),
   				suggest    :$("#suggest").val(),
   				origin     :"CRM",
   				empId      :appCtx.userId
   			}, function(data) {
   				if (!data.success) {
   					window.parent.operationtip(data.result,'error');
   				} else {
   					record = data.newRow;
   					headId = record.id;
   					headName = "信息反馈图片";
   					if(imgNum>1){
   						uploadAttachment();//添加照片						
   					}
   					$('#myModal').modal('hide');
   					clearForm();		
					$.messager.alert("操作提示", "提交成功！");			
   				}
   			});
   		} 
   		
   	/**
   		添加图片
   	 */
    	function uploadAttachment() {
   		var options = {
   			url : '${AppContext.ctxPath}/action/portal/attachment/insertWithFiles',
   			type : 'post',
   			data : {
   				headId : headId,
   				moduleType : "feedback",
   				headCode : headId,
   				headName : headName
   			},
   			dataType : 'json',
   			contentType : "application/vnd.ms-excel;charset=utf-8",
   			success : function(data) {
   				if (data.success) {
   					//successFun(that, data);	
   				} else {
   					if (data.result == null) {
   						data.result = "上传失败！";
   					}
   					$.messager.alert("警告", data.result);
   				}
   			}
   		}; 
   		$("#feedbackForm").ajaxSubmit(options); 		
   	}	 
  	/* 反馈功能代码 end */
	</script>

</body>
</html>