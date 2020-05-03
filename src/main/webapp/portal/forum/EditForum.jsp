<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%@ include file="/portal/header.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Insert title here</title>
<style type="text/css">
.btn-btnyellow-xinlang{
	display: inline-block;
    height: 28px;
    line-height: 29px;
    width: 60px;
    font-size: 14px;
    background: #469ce7;
    border: 1px solid #fbbd9e;
    box-shadow: none;
    cursor: default;
    padding: 0 10px 0 10px;
    white-space: nowrap;
}
.bodyFirstDev{
min-height:100%;
}
.forumListBody{
	width:60%;
	margin-left:20%;
	background: #FFF;
	border-style:none solid none solid;
	border-right-width:1px;
	border-left-width:1px;
	border-right-color:rgb(228, 230, 235);
	border-left-color:rgb(228, 230, 235);
	min-height:100%;
}
.formrow{
	width:90%;
	margin-top:5px;
	margin-bottom:5px;
	display: inline-block;
}
.forumForm{
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
.ui_btn_m_orange{
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
    background: #fc9439;
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
.img200{
width:200px;
height:200px;
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
.selfDefinebodyback{
background: url(http://tb2.bdstatic.com/tb/static-hottopic/img/bang_bg_4aa39ca.jpg) no-repeat top center;
}
	

</style>
</head>
<body>
	<div class="bodyFirstDev">
		<div class="forumForm">
			<form id="forum-form" method="post" enctype="multipart/form-data">
				<div class="formrow">
					<lable>标题</lable>
					<input type="text"  id="noteTitle" name="noteTitle" style="width:80%;margin-bottom:10px;"/>
					<input type="text"  id="modelId" name="modelId" style="display:none;"/>
					<input type="text"  id="modelType" name="modelType" style="display:none;"/>
					<input type="text"  id="id" name="id" style="display:none;"/>
				</div>
				<div class="formrow">
					<span>内容</span>
					<textarea id="note" name="note"  style="width:80%;height:200px;"></textarea>
				</div>
				
				<div id="imgForm" style="display:inline;"></div>
				<div class="formrow">
					<button type="button" onclick="addForum()" class="selfDefineButton sD_blue">发布</button>
					<button type="button" class="selfDefineButton sD_green" onclick="addForumAtt()" >添加附件</button>
					<span hidden="true"><input id="peoMvg"/></span><!-- MVG隐藏编辑框 -->
					<button type="button" class="selfDefineButton sD_orange"  onclick="openPeoMvg()">选择参与人</button>
				</div>
			</form>	
		</div>
	</div>
<script>
var modelId=getUrlParams("modelId");
var modelType=getUrlParams("modelType");
var modelName=getUrlParams("modelName");
var id=getUrlParams("id");
var noteTitle;
if(id==null){
	$.messager.alert('提示',"获取不到ID，请重新操作;");
}
$('#noteTitle').val(modelName);
$('#modelType').val(modelType);
$('#modelId').val(modelId);
$('#id').val(id);
$('#note').val("");//让页面初次加载完毕点击textarea时候光标定位于首位
function addForum(){
	if($('#id').val()==null){
		$.messager.alert('提示',"获取不到ID，请重新操作;");
		return;
	}
	var options = {
			url : '${AppContext.ctxPath}/action/portal/forum/forumUpdate',
			type : 'post',
			dataType :'json',
			success : function(data) {
					if(data.success){
						alert("成功");
				  	}else{
				  		alert("失败");
				  	}
			}
		};
	$('#forum-form').ajaxSubmit(options);
}

/* function showPeo(){
	window.parent.$('#mvgid').dialog({
	    title: '选择参与人',
	    width: '75%',     
        height: '75%',   
	    closed: false,
	    cache: false,
	    href: '${AppContext.ctxPath}/portal/forum/ForumPeople.jsp?id='+id,
	    modal: true,
	    buttons : [{    
            text : '确定',    
            iconCls : 'icon-ok',
            width: '100px',
            handler : function() {  
            }    
        }]  
	});
}; */


var imgNum = 1;
var imgCount = 1;
var nestImg = 'img'+imgNum;
var nestImgInput = 'imgInput'+imgNum;
var nestImgDiv = 'imgDiv'+imgNum;
function addForumAtt(){
	if(imgCount>4){
		$.messager.alert('提示',"请不要上传超过4张图片。");
		return;
	}
	var html='<div class="imgDevbox" style="width:214px;float:left;" id="'+nestImgDiv+'">'
			+'<div style="width:210px;"><a class="fa fa-times imgClose" ></a></div>'
		    +'<img id="'+nestImg+'"  src="" class="img200"/>'
			+'<input id="'+nestImgInput+'" type="file" name="myfiles" style="display:none;" onchange="preImg(this.id,&quot;' + nestImg + '&quot;)"/>'
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
function preImg(sourceId, targetId) { 
	var url = getFileUrl(sourceId); 
	var imgPre = document.getElementById(targetId); 
	imgPre.src = url; 
} 


/* ----------------选择参与人MVG操作 start-------------------------------------------- */
var $peoMvg = $('#peoMvg');
function peoLeftMvgPickParam(){
	return {mvgParentId:id};
}
function peoMvgComplete(row){
}
function openPeoMvg(){
	$peoMvg.mvgPick({
		title:'选择参与人',
		width:'1200px',
		mvgMapperName:'forumPeople',
		mvgParentId:id,
		completeFun:peoMvgComplete,
		optionsLeft:{
			tableUrl:'${AppContext.ctxPath}/portal/forum/mvgPick/PeopleLeftMvgPick.jsp',
			initParam:peoLeftMvgPickParam
		},
		optionsRight:{
			radio:false,//不显示单选框列
			checkbox:true
		}
	});
	$peoMvg.textbox('options').icons[0].handler();
}
/* ----------------选择参与人MVG操作 end-------------------------------------------- */
</script>
</body>
</html>