<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>


<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<title>Insert title here</title>
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>
<style type="text/css">
.bodyFirstDev{
margin-top:50px;
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
	display: table;
}
.forumForm{
padding-top: 10px;
padding-bottom: 10px;
display: table;
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
.selfDefinebodyback{
	background: url(http://tb2.bdstatic.com/tb/static-hottopic/img/bang_bg_4aa39ca.jpg) no-repeat top center;
	margin:0px;
	min-height: 100%;
}
</style>
</head>

<body class="easyui-layout " data-options="fit:true" border="false">
 <div  data-options="region:'south'" class="selfDefinebodyback" collapsible="false"  border="false" style="width:100%;height:100%;padding:0px;">
	<div class="bodyFirstDev">
		<div class="forumForm">
			<form id="forum-form" method="post" enctype="multipart/form-data">
				<div class="formrow">
					<span style="float:left;text-align:right;width:8%;">标题&nbsp;&nbsp;</span>
					<input type="text"  id="noteTitle" name="noteTitle" style="width:91%;margin-bottom:10px;border-width:1px;"/>
					<input type="text"  id="modelId" name="modelId" style="display:none;"/>
					<input type="text"  id="modelType" name="modelType" style="display:none;"/>
					<input type="text"  id="id" name="id" style="display:none;"/>
				</div>
				<div class="formrow">
					<span style="float:left;text-align:right;width:8%;">所有人&nbsp;&nbsp;</span>
					<select name="publicFlag" id="publicFlag" ><option value='N'>否</option><option value='Y'>是</option></select>
				
					<input type="text" id="simpleNote" name="simpleNote" style="display:none;"/>
				</div>
				<div class="formrow">
					<span style="float:left;text-align:right;width:8%;">类型&nbsp;&nbsp;</span>
					<input name="topCategory" id="topCategory" size="25" class="easyui-combobox"
			       			    data-options="valueField:'val',
												textField:'name',
												url:'${AppContext.ctxPath}/action/portal/basic/list/FORUM_TOP_CATEGORY',
												editable:false,
												onSelect:function(){
													$('#secCategory').combobox('reload');
													$('#secCategory').combobox('setValue','');
												}"/>
	       			<input name="secCategory" id="secCategory" size="25" class="easyui-combobox"
	       			    data-options="valueField:'val',
										textField:'name',
										url:'${AppContext.ctxPath}/action/portal/basic/list/FORUM_SUB_CATEGORY',
										editable:false,
										onBeforeLoad:function(param){
											var topCategory = $('#topCategory').combobox('getValue');
											if(topCategory){
												param.parentVal=topCategory;
											}else{
												param.parentVal='noMatchId';
											}
										}"/>
				</div>
				<div class="formrow">
					<div style="float:left;text-align:right;width:8%;">内容&nbsp;&nbsp;</div>
					<!-- <textarea id="note" name="note"  style="width:91%;height:200px;padding-right: 0px;padding-left: 0px;"></textarea> -->
					<div style="width:91%;float:left;">
						<script type="text/plain" id="note" name="note" style="height:240px;width:100%" ></script>
					</div>
				</div>
				<div class="formrow" style="padding-left:7%;">
					<div id="imgForm" >
					</div>
				</div>
				<div class="formrow" style="display:inline-block;text-align:right;width:91%;">
					<button type="button" onclick="addForum()" class="selfDefineButton sD_blue">发布</button>
					<button type="button" class="selfDefineButton sD_green" onclick="addForumAtt()" >添加附件</button>
					<input id="fileInput" type="file" multiple="multiple" name="myfiles" style="display:none;" onchange="preImg(this.files)"/>
					<span hidden="true"><input id="peoMvg"/></span><!-- MVG隐藏编辑框 -->
					<button type="button" class="selfDefineButton sD_orange"  onclick="openPeoMvg()">选择参与人</button>
				</div>
			</form>	
		</div>
		<div></div>
	</div>
	</div>
<script>
var modelId=getUrlParams("modelId");
var modelType=getUrlParams("modelType");
var modelName=getUrlParams("modelName");
var id=getUrlParams("id");
var pushPeople;
var noteTitle;
if(id==null){
	$.messager.alert('提示',"获取不到ID，请重新操作;");
}else{
	$('#id').val(id);
}
if(modelType!=null){
	switch(modelType){
		case 'opty':noteTitle='针对商机"'+modelName+'"的讨论';break;
		case 'agreement_chn':noteTitle='针对国内合同"'+modelName+'"的讨论';break;
		case 'agreement_intel':noteTitle='针对国际合同"'+modelName+'"的讨论';break;
		default:noteTitle="";
	}
	$('#noteTitle').val(noteTitle);
	$('#modelType').val(modelType);
	$('#modelId').val(modelId);
}



var imgNum = 1;
var imgCount = 0;
var nestImg = 'img'+imgNum;
var nestImgInput = 'imgInput'+imgNum;
var nestImgDiv = 'imgDiv'+imgNum;
function addForumAtt(){
	$('#fileInput').trigger('click');    //触发文件弹出框
}

 function preImg(fileList) { 
	for( var i = 0 ; i < fileList.length ; i++ ){  
		var fileName = fileList[i].name;
		var extStart=fileName.lastIndexOf(".");
		var ext=fileName.substring(extStart,fileName.length).toUpperCase();
		if(ext!=".BMP"&&ext!=".PNG"&&ext!=".GIF"&&ext!=".JPG"&&ext!=".JPEG"){  //非图片格式
			$.messager.alert('提示',"请不要上传非图片文件!");
			return;
		}else{  //图片格式
			var html='<div class="imgDevbox" style="width:214px;float:left;display:none;" id="'+nestImgDiv+'">'
	    	+'<div style="width:210px;"><a class="fa fa-times imgClose" onclick="$(&quot;#'+nestImgDiv+'&quot;).remove();"></a></div>'
	        +'<img id="'+nestImg+'"  src="" class="img200"/>'
	    	+'</div>'
	    	$('#imgForm').append(html);
	    	var sourceId = fileList[i].id;
	    	var targetId = nestImg;
	    	var outTargetId = nestImgDiv;
	    	var url =  window.URL.createObjectURL(fileList[i]); 
	    	var imgPre = document.getElementById(targetId); 
	    	imgPre.src = url; 
	    	$('#'+outTargetId).css("display","");
		}
    	
        imgNum++;
    	imgCount++;
    	nestImg = 'img'+imgNum;
		nestImgInput = 'imgInput'+imgNum;
    	nestImgDiv = 'imgDiv'+imgNum; 
    }  	
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
            handler : function(){
            	pushPeople = window.parent.rightTable.datagrid('getRows');
            	window.parent.$('#mvgid').dialog('close');
            }    
        }]  
	});
}; */
var um = UM.getEditor('note',{
	customDomain:true,
	toolbar:[
	            'undo redo | bold italic underline strikethrough | forecolor backcolor | removeformat |',
	            'selectall cleardoc paragraph | fontfamily fontsize' ,
	            '| justifyleft justifycenter justifyright justifyjustify '
	        ]
});
function addForum(){
	if($('#publicFlag').val()!='Y'){//如果没有选择所有人，则判断一下是否选择了参与人
		if(pushPeople==null||pushPeople.length==0){
			$.messager.alert('请选择参与人','您未选择主题参与人，请选择参与人','warning');
			return;
		}
	}
	/* 字数限制 begin*/
	var mary = um.getContentTxt();
	if(mary.length>1000){
		$.messager.alert("操作提示", "内容不超过1000字，请检查！","warning");  
		return;
	}
	/* 字数限制 end*/
	if(mary.length>150){
		mary = mary.substring(0,150);
	}
	$('#simpleNote').val(mary);
	$.messager.confirm('确认操作？','确定发帖？',function(data){
		if(data){
			window.parent.operationprogress('进度提示', '正在发布...'); 
			var options = {
					url : '${AppContext.ctxPath}/action/portal/forum/forumInsert',
					type : 'post',
					dataType :'json',
					success : function(data) {
							if(data.success){
								window.parent.$.messager.progress('close');
								window.top.quickEnter('论坛','论坛','BBS_MANAGE');
						  	}else{
						  		$.messager.alert("操作提示", data.result,"error");
						  	}
					}
				};
			$('#forum-form').ajaxSubmit(options);
		}
	});
}


/* ----------------选择参与人MVG操作 start-------------------------------------------- */
var $peoMvg = $('#peoMvg');
function peoLeftMvgPickParam(){
	return {mvgParentId:id};
}
function peoMvgComplete(row){
	pushPeople = row;
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