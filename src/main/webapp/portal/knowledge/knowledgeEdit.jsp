<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
 <%@ include file="/portal/header.jsp" %>
 
<%-- <link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue7/themes/default/_css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue7/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
 <script type="text/javascript" src="${AppContext.ctxPath}/static/ue7/_examples/editor_api.js?version=<%=version%>" charset="utf-8"></script>
 <script type="text/javascript" src="${AppContext.ctxPath}/static/ue7/lang/zh-cn/zh-cn.js?version=<%=version%>"></script> --%>
 
<script type="text/javascript" charset="utf-8" src="${AppContext.ctxPath}/static/ue/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="${AppContext.ctxPath}/static/ue/ueditor.all.js"> </script>
 <script type="text/javascript" charset="utf-8" src="${AppContext.ctxPath}/static/ue/lang/zh-cn/zh-cn.js"></script>
 <script type="text/javascript" src="${AppContext.ctxPath}/static/js/jquery.form.js?version=<%=version%>"></script>
<style type="text/css">
.td-label{
	width:90px;
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
#editorTable {
	width: 1000px;
	margin: 30px auto;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;">
		<div id="p2" class="easyui-panel" title="" border="false" style="width:'$(window).width() - 18';height:100%;padding:0px;">
		    <div id="heading" style="margin-left:15%;padding-left:5.6%;font-size:19px;color:#29303F;margin-top:40px;margin-bottom:-20px;border-bottom:1px solid #DFDFE0;width:20%;">添加知识</div>
		    <form id="headerForm" method="post" enctype="multipart/form-data">
				<center>
				<table id="editorTable" border="0">
				    <tr>
				    	<td class="td-label">标题：&nbsp;</td>
				    	<td width="820">
				    		<input class="easyui-textbox" type="text" style="width:800px;" id="title" name="title" data-options="required:true"></input>
				    	</td>
				    </tr>
				    <tr>
			       		<td class="td-label"><label>作者：&nbsp;</label></td>
			       		<td class="td-content">
			       			<input name="author" class="easyui-textbox" id="author" disabled="disabled"/>
			       		</td>
				    </tr>
				    <tr>
				    	<td class="td-label"><label>类型：&nbsp;</label></td>
			       		<td class="td-content">
			       			<input name="type" id="type" size="25" class="easyui-combobox"
			       			    data-options="valueField:'val',
												textField:'name',
												required:true,
												url:'${AppContext.ctxPath}/action/portal/basic/list/KNOWLEDGE_TYPE',
												editable:false,
												onSelect:function(){
													$('#secondaryType').combobox('reload');
													$('#secondaryType').combobox('setValue','');
												}"/>
			       			<input name="secondaryType" id="secondaryType" size="25" class="easyui-combobox"
			       			    data-options="valueField:'val',
												textField:'name',
												editable:false,
												required:true,
												onBeforeLoad:function(param){
													var type = $('#type').combobox('getValue');
													if(type){
														param.parentVal=type;
													}else{
														param.parentVal='noMatchId';
													}
												}"/>
			       		</td>
				    </tr>
				    <tr>
				        <td class="td-label">内容：&nbsp;</td>
				        <td width="820">
				        	<div id="contentHtml">
				        		<script type="text/plain" id="myEditor" name="content" style="width:800px;height:300px;" ></script>
				        	</div>
				        </td>
				    </tr>
				    <tr>
				        <td class="td-label">操作：&nbsp;</td>
				        <td width="820" >
							<a href="javascript:void(0)" id="btn_add" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRow()">添加附件</a>
				        </td>
				    </tr>
				</table>
				<input type="hidden" name="id"/>
				<input type="hidden" id="rowstatus" name="row_status" />
				</center>
				<div style="margin-bottom: 20px;">
					<center>
					    <a href="###" style="background-color: #e0ecff; width: 100px;" id="icon-redo" class="easyui-linkbutton" iconCls="icon-no" plain="true" onclick="goBack()">取消</a>
					    &nbsp;&nbsp;&nbsp;
					    <a href="###" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="submitForm()">提交</a>
					</center>
				</div>
			</form>
		</div>
	</div>
</div>
    

<script type="text/javascript">
//$(document).ready(function() { 
	console.info("++++++++++++++++++++++====");
	var initHeadId = getUrlParams("id");
	//console.info(initHeadId);
	var row_status = '';//当前页面的操作状态
	if(initHeadId == null || initHeadId == 'noMatchId'){
		row_status = 'NEW';//【新建】状态
	} else {
		row_status = 'UPDATE';//【更新】状态
		$("#heading").text("修改知识");
	}
	$headerForm = $("#headerForm");
	//headerFormTagInit();
	headerInfoInit();
//}); 

/**
 * 初始化表单标签
 */
function headerFormTagInit(){
	var formUrl = '${AppContext.ctxPath}/action/portal/knowledge/upsert';
	$headerForm.form({
		url : formUrl,
		onSubmit : function(){
			$(this).find('input[name=row_status]').val(row_status);
			return $headerForm.form('validate');
		}
	});
}
/**
 * 初始化输入框的默认值 和 状态
 */
function headerInfoInit(){
//console.info("+++++++++++++++++headerInfoInit");
	var url = '';
	if(row_status == 'NEW'){//判断是否为新建
		url = '${AppContext.ctxPath}/action/portal/knowledge/preDefaultValue';
	} else {
		url = '${AppContext.ctxPath}/action/portal/knowledge/queryById';
	}
	$.post(url,{id:initHeadId},
		function(data){
			if(data){
				if(data.success){
					var entity = data.result;
					initHeadId = entity.id;
					$headerForm.form("load", entity);
					console.info(entity);
					//加载知识库二级分类
					$('#secondaryType').combobox({url:'${AppContext.ctxPath}/action/portal/basic/list/KNOWLEDGE_SECONDARY_TYPE',})
					$('#secondaryType').combobox('setValue',entity.secondaryType);
					getAttachments(initHeadId);
					//如果来源为APP端，则将内容设置为纯文本,否则为富文本
					if(entity.source == 'APP'){
						//清除富文本标签,并且加入纯文本标签textbox
						$('#contentHtml').empty();
						$('#contentHtml').append('<input name="content" style="width:800px;height: 340px;"/>');
						//初始化textbox
						var $contentTextbox = $('input[name=content]','#contentHtml');
						$contentTextbox.textbox({
							multiline:true
						});
						$contentTextbox.textbox('setValue',entity.content);
					} else {
						//初始化富文本控件
						var ue = UE.getEditor('myEditor');
						ue.ready(function() {
						    ue.setContent(entity.content);//设置编辑器的内容
						}); 
						/*  var um = UM.getEditor('myEditor');
						um.ready(function() {
						    um.setContent(entity.content);//设置编辑器的内容
						}); */
					}
				}
			}
		});
}
var headerUpdateFlag = false;//按钮锁标志，防止按钮被重复点击
function submitForm(){
	if(headerUpdateFlag){
		return;
	}
	if(!window.parent.checkFilesSize()){//检测是否包含空文件，否的话才提交
		window.parent.operationtip('保存失败,请删除空的文件!','error');
		return;
	}
	
	$("input[id='rowstatus']").attr("value",row_status);   //更新或新增操作
	headerUpdateFlag = true;
	var options = {
			url : '${AppContext.ctxPath}/action/portal/knowledge/upsert',
			type : 'post',
			dataType :'json',
			beforeSubmit: function() {
				var result = $headerForm.form('validate');
				return result;
			},  
			success : function(data) {
				if(data.success){
					//window.parent.operationtip('保存成功！',"info");
					messageShow("操作提示","保存成功！",800);
					headerUpdateFlag = false;
			  	} else {
					window.parent.operationtip(data.result,"error");
					headerUpdateFlag = false;
				}
				setTimeout(function(){
					goBack();
				},888);
			}
		};
	$('#headerForm').ajaxSubmit(options);
	headerUpdateFlag = false;
}
/**
 * 返回公告List页面
 */
function goBack(){
	//gotoContentPage('${AppContext.ctxPath}/portal/knowledge/knowledgeList.jsp');
	window.close();
}

/**
 * 添加附件
 */
function addRow(){
    var $tr = $("<tr>"+  
    "<td class='td-label'>附件：&nbsp;</td>"+  
    "<td class='td-content'><input type='hidden' name='method' value='upload'/><input type='file' id='file' name='uploadAttachment'/>&nbsp;&nbsp;<a href='###' onclick=\"deleteRow(this)\">删除</a></td>"+  
    +"</tr>");  
      
    var $table = $("#editorTable");  
    $table.append($tr); 
}

function deleteRow(obj){
	$(obj).parent().parent().remove();
}

/**
 * 删除附件
 */
function deleteFile(id, obj){
	$.messager.confirm("操作提示", "您确实要删除此文件吗？", function(data){
		if(data)
		{
			$.post('${AppContext.ctxPath}/action/portal/attachment/deleteById', {
				id : id
			}, function(data) {
					if (!data.success) {
						window.parent.operationtip(data.result,'error');
					} else {
						$(obj).parent().parent().parent().hide();
					}
			});
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
				$.messager.alert("警告",data.result);
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
					'<a href="###" onclick="deleteFile(\'' + rows[i].id + '\', this)">删除</a>' +
					'</div></td></tr>';
		}
		$trs = $(temp);
		$table = $("#editorTable");  
	    $table.append($trs);
	}
}

function getUrlParams(field){
	//var url = window.top.$('#mainFrame').attr('src');
	var url = window.location.href;
	var params = GetRequest(url);
	if(typeof field === undefined || field == null){
		return params;
	}else{
		if(params == null){
			return params;
		}else{
			return params[field];
		}
	}
}

function messageShow(title,msg,time){
	$.messager.show({
		title:title,
		msg:msg,
		showType:'null',
		timeout:time,
		style:{
			right:'',
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		}
	});

}
</script>
</body>
</html>