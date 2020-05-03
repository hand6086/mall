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
<title>Insert title here</title>
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

.replyImgContent{
font-size: 14px;
display:block;
padding-left: 49px;
}
</style>
</head>

<body class="easyui-layout " data-options="fit:true" border="false">
 <div id="bigImg" >
		<img id="popUpImg"/>
 </div>
 <div  data-options="region:'south'" class="selfDefinebodyback" collapsible="false"  border="false" style="width:100%;height:100%;padding:0px;">
	<div class="bodyFirstDev">
		<div class="forumForm">
			<form id="forum-form" method="post" enctype="multipart/form-data">
				<div class="formrow">
					<span style="float:left;text-align:right;width:8%;">标题&nbsp;&nbsp;</span>
					<input type="text"  id="noteTitle" name="noteTitle" style="width:91%;margin-bottom:10px;"/>
					<input type="text"  id="modelId" name="modelId" style="display:none;"/>
					<input type="text"  id="id" name="id" style="display:none;"/>
					<input type="text" id="simpleNote" name="simpleNote" style="display:none;"/>
				</div>
				<div class="formrow">
					<span style="float:left;text-align:right;width:8%;">所有人&nbsp;&nbsp;</span>
					<select name="publicFlag" id="publicFlag" ><option value='Y'>是</option><option value='N'>否</option></select>
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
						<script type="text/plain" id="note" name="note" style="height:240px;width:100%;" ></script>
					</div>
				</div>
				<div class="formrow" style="padding-left:7%;">
					<div id="imgForm" >
					</div>
				</div>
				<div class="formrow" style="display:inline-block;text-align:right;width:91%;">
					<button type="button" onclick="editForum()" class="selfDefineButton sD_blue">发布</button>
					<button type="button" class="selfDefineButton sD_green" onclick="addForumAtt()" >添加附件</button>
					<span hidden="true"><input id="peoMvg"/></span><!-- MVG隐藏编辑框 -->
					<button type="button" class="selfDefineButton sD_orange"  onclick="openPeoMvg()">选择参与人</button>
				</div>
			</form>	
		</div>
		<div></div>
	</div>
	</div>
<script>
var id=getUrlParams("id");
var pushPeople;
var noteTitle;
if(id==null){
	$.messager.alert('提示',"获取不到ID，请重新操作;");
}else{
	$('#id').val(id);
}
var um = UM.getEditor('note',{
	customDomain:true,
	toolbar:[
	            'undo redo | bold italic underline strikethrough | forecolor backcolor | removeformat |',
	            'selectall cleardoc paragraph | fontfamily fontsize' ,
	            '| justifyleft justifycenter justifyright justifyjustify '
	        ]
});

$.post("${AppContext.ctxPath}/action/portal/forum/getOneForum/"+id,null,
		function(data){
			if(data.success){
				var record = data.result;
				$('#noteTitle').val(record.noteTitle);
				um.setContent(record.note);
				$('#modelId').val(record.modelId);
				$('#publicFlag').val(record.publicFlag);
				
				//加载一级和二级分类
				$('#topCategory').combobox('setValue',record.topCategory);
				$('#secCategory').combobox({url:'${AppContext.ctxPath}/action/portal/basic/list/FORUM_SUB_CATEGORY',})
				$('#secCategory').combobox('setValue',record.secCategory);
				
				/**构造图片html**/
				var imgHtml='';
				if(record.attList!=null&&record.attList.length>0){
					for(var i=0;i<record.attList.length;i++){
						imgHtml = imgHtml+'<div class="imgDevbox" style="width:214px;float:left;" id="'+record.attList[i].id+'">'
								+'<div style="width:210px;"><a class="fa fa-times imgClose" onclick="removeAttByServer(&quot;'+record.attList[i].id+'&quot;)"></a></div>'
					    		+'<img src="'+record.attList[i].attachmentPath+'" class="img200"/>'
								+'</div>'
					}
					$('#imgForm').append(imgHtml);
					$('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true,width:500,height:500,imgHeight:450,mulriple:1});
				}
				/**构造图片html结束**/
			}else{
				$.messager.alert('错误',data.result,'warning');
			}
		});



var imgNum = 1;
var imgCount = 1;
var nestImg = 'img'+imgNum;
var nestImgInput = 'imgInput'+imgNum;
var nestImgDiv = 'imgDiv'+imgNum;

/**点击添加附件触发方法**/
function addForumAtt(){
	/**if(imgCount>4){
		$.messager.alert('提示',"请不要上传超过4张图片。");
		return;
	}**/
	var html='<div class="imgDevbox" style="width:214px;float:left;display:none;" id="'+nestImgDiv+'">'
			+'<div style="width:210px;"><a class="fa fa-times imgClose" onclick="$(&quot;#'+nestImgDiv+'&quot;).remove();"></a></div>'
		    +'<img id="'+nestImg+'"  src="" class="img200" />'
			+'<input id="'+nestImgInput+'" type="file" name="myfiles" style="display:none;" onchange="preImg(this.id,&quot;' + nestImg + '&quot;,&quot;'+nestImgDiv+'&quot;)"/>'
			+'</div>'
			$('#imgForm').append(html);
	imgNum++;
	imgCount++;
	$('#'+nestImgInput).trigger('click');//打开弹出框
	nestImg = 'img'+imgNum;
	nestImgInput = 'imgInput'+imgNum;
	nestImgDiv = 'imgDiv'+imgNum;
}

/**不同浏览器下获取文件输入框本地文件url方法**/
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

/**触发弹出参与人方法**/
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

/**打开主题链接方法**/
function openForumLinkToModel(modelId,modelType){
	if(modelId==null){
		$.messager.alert('Warning','Parameter modelId is null');
		return;
	}
	if(modelType==null){
		$.messager.alert('Warning','Parameter modelType is null');
		return;
	}
	switch(modelType){
		case 'opty':window.top.quickEnter('论坛','论坛','BBS_MANAGE','${AppContext.ctxPath}/portal/opty/optyDetailReadOnlyForForum.jsp?optyId='+modelId);break;
		case 'agreement_chn':window.top.quickEnter('论坛','论坛','BBS_MANAGE','${AppContext.ctxPath}/portal/agreement/DomesticAgrOnlyReadForForum.jsp?id='+modelId);break;
		case 'agreement_intel':window.top.quickEnter('论坛','论坛','BBS_MANAGE','${AppContext.ctxPath}/portal/agreement/IntlAgrOnlyReadForForum.jsp?id='+modelId);break;
		default:$.messager.alert('Warning','模块未知！');
	}
}

/**发布方法**/
function editForum(){
	if($('#id').val()==null){
		$.messager.alert('提示',"获取不到ID，请重新操作;");
		return;
	}
	var mary = um.getContentTxt();
	if(mary.length>100){
		mary = mary.substring(0,100);
	}
	$('#simpleNote').val(mary);
	if($('#publicFlag').val()!='Y'){//如果没有选择所有人，则判断一下是否选择了参与人
		if(pushPeople==null||pushPeople.length==0){
			$.messager.alert('请选择参与人','您未选择主题参与人，请选择参与人','warning');
			return;
		}
	}
	$.messager.confirm('确认操作？','确定发帖？',function(r){
		if(r){
			window.parent.operationprogress('进度提示', '发布中...'); 
			var options = {
					url : '${AppContext.ctxPath}/action/portal/forum/forumUpdate',
					type : 'post',
					dataType :'json',
					success : function(data) {
							window.parent.$.messager.progress('close');
							if(data.success){
								window.top.quickEnter('论坛','论坛','BBS_MANAGE');
						  	}else{
								window.parent.operationtip(data.message, 'error');
						  	}
					}
				};
			$('#forum-form').ajaxSubmit(options);
		}
	});
}

/**删除数据库里的附件**/
function removeAttByServer(id){
	$.post('${AppContext.ctxPath}/action/portal/attachment/deleteById',{id:id},function(data){
		if(data.success){
			$('#'+id).remove();
		}else{
			$.messager.alert("错误", data.result,"error");
		}
	})
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