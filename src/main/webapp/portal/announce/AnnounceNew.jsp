<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/umeditor.css?version=<%=version%>">
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/third-party/template.min.js?version=<%=version%>"></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.config.js?version=<%=version%>" charset="utf-8" ></script>
<script type="text/javascript" src="${AppContext.ctxPath}/static/ue/umeditor.min.js?version=<%=version%>" charset="utf-8" ></script>
<style type="text/css">
#typeTable{
	
	width:1000px;
	margin: 20px auto;
}
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
}
.td-input{
	width:180px;
	height:20px;
}
#form {
	width: 1000px;
	margin: 30px auto;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;" title="">
		<div id="p1" class="easyui-panel" title="" border="false" style="width:'$(window).width() - 18';padding:0px;">
			<table id="typeTable">
		       	<tr>
		       		<td width="120" class="td-label"><label>公告类型：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_anneType" name="temp_anneType" size="25" class="easyui-combobox td-input" 
		       			    data-options="valueField:'name',
											textField:'name',
											method:'get',
											data:getLovArray('ANNE_TYPE'),
											editable:false,
											onSelect:function(record){
												affterAnneType();
										}"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>限制营销渠道：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_isLimited" name="temp_isLimited" size="25" class="easyui-combobox td-input" 
		       			    data-options="valueField:'name',
											textField:'name',
											method:'get',
											data:getLovArray('IS_LIMITED'),
											editable:false,
											onSelect:function(record){
												affterIsLimited();
										}"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>有效开始时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_startDate" name="temp_startDate" size="25" class="easyui-datetimebox td-input"  />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>发布对象：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_anneReader" name="temp_anneReader" disabled size="25" class="easyui-combobox td-input" 
		       			    data-options="valueField:'name',
											textField:'name',
											method:'get',
											data:getLovArray('ANNE_OBJECT'),
											editable:false,
											onSelect:function(record){
											
										}"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>营销渠道：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_orgName" name="temp_orgName" class="easyui-textbox" editable="false"
		       				data-options="buttonText:'',
		       							  buttonIcon:'icon-search',
		       							  prompt:'选择营销渠道...',
		       							  onClickButton: function(){
		       							  	openOrgMvgDialog();
									}" 
						style="width:185px;height:24px;">
						<input id="temp_orgId" name="temp_orgId" type="hidden"></input>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>有效结束时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_endDate" name="temp_endDate" size="25" class="easyui-datetimebox td-input"  />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>公告状态：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_anneStatus" name="temp_anneStatus" disabled size="25" class="easyui-validatebox td-input" value="新建" />
		       		</td>
		       		
		       	</tr>
		    </table>
		</div>
		<div id="p2" class="easyui-panel" title="公告内容" border="false" style="width:'$(window).width() - 18';height:100%;padding:0px;">
		    <form id="form" method="post" enctype="multipart/form-data">
				<table id="editorTable" border="0">
				    <tr>
				    	<td width="80"></td>
				    	<td width="820">
							<input id="anneStatus" name="anneStatus" type="hidden" value=""></input>
							<input id="anneReader" name="anneReader" type="hidden" value=""></input>
							<input id="anneType" name="anneType" type="hidden" value=""></input>
							<input id="startDate" name="startDate" type="hidden" value=""></input>
							<input id="endDate" name="endDate" type="hidden" value=""></input>
							<input id="isLimited" name="isLimited" type="hidden" value=""></input>
							<input id="orgId" name="orgId" type="hidden" value=""></input>
							<input id="announceId" name="id" type="hidden" value="${announceId}"></input>
						</td>
				    </tr>
				    <tr>
				    	<td class="td-label">标题：&nbsp;</td>
				    	<td width="820">
				    		<input class="easyui-textbox" type="text" style="width:800px;" name="captions" id="captions" data-options="required:true"></input>
				    	</td>
				    </tr>
				    <tr>
				    	<td></td>
				    	<td></td>
				    </tr>
				    <tr>
				        <td class="td-label">内容：&nbsp;</td>
				        <td width="820">
				        	<script type="text/plain" id="myEditor" name="contents" style="width:800px;height:240px;" ></script>
				        </td>
				    </tr>
				    <tr>
				        <td class="td-label">操作：&nbsp;</td>
				        <td width="820" >
							<a href="javascript:void(0)" id="btn_add" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRow()">添加附件</a>
				        </td>
				    </tr>
				</table>
			</form>
		
			<div>
				<center>
				    <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAnne()">保存</a>
				    &nbsp;&nbsp;&nbsp;
				    <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="publishAnne()">发布</a>
				</center>
			</div>
		</div>
	</div>
</div>
    

<script type="text/javascript">
$(document).ready(function() { 
	$('#temp_isLimited').combobox('disable');
	$('#temp_anneReader').combobox('disable');
	$('#temp_orgName').textbox('disable');
}); 
function affterAnneType(){
	if($('#temp_anneType').combobox('getText') == '公告'){
		$('#temp_isLimited').combobox('enable');
		$('#temp_anneReader').combobox('enable');
		
	} else{
		$('#temp_isLimited').combobox('disable');
		$('#temp_anneReader').combobox('disable');
		$('#temp_orgName').textbox('disable');
		//清空内容
		$('#temp_isLimited').combobox('setValue','');
		$('#temp_anneReader').combobox('setValue','');
		$('#temp_orgName').textbox('setValue','');
	}
}
function affterIsLimited(){
	if($('#temp_isLimited').combobox('getText') == '是'){
		$('#temp_orgName').textbox('enable');
	} else{
		$('#temp_orgName').textbox('disable');
		$('#temp_orgName').textbox('setValue','');
	}
}

function openOrgMvgDialog(index) {
	orgOfAnneMvg('营销渠道', '${AppContext.ctxPath}/action/portal/announce/anneOrgMvgInit/' + '${announceId}',  orgMvgComplete);
}
function orgMvgComplete(selectRow) {
	if(selectRow){
		$('#temp_orgId').val(selectRow.orgId);
		$('#temp_orgName').textbox('setValue',selectRow.text);
	}
}

function getInputValue(){
	$('#orgId').val($('#temp_orgId').val());
	$('#anneReader').val($('#temp_anneReader').combobox('getText'));
	$('#anneType').val($('#temp_anneType').combobox('getText'));
	$('#startDate').val($('#temp_startDate').datetimebox('getValue'));
	$('#endDate').val($('#temp_endDate').datetimebox('getValue'));
	$('#isLimited').val($('#temp_isLimited').combobox('getText'));
}

var form = $("#form");
var um = UM.getEditor('myEditor');

function formSubmit() {
	if(window.parent.checkFilesSize()){//检测是否包含空文件，否的话才提交
		var options = {
			url : '${AppContext.ctxPath}/action/portal/announce/publish',
			type : 'post',
			dataType :'json',
			success : function(data) {
				if(data.success){
					window.parent.operationtip(data.result,'info');
					window.location.href="${AppContext.ctxPath}/action/portal/announce/manageInit"
			  	} else {
					window.parent.operationtip(data.result,'error');
				}
			}
		};
		getInputValue();
		form.ajaxSubmit(options);
	} else {
		window.parent.operationtip('发布失败,请删除空的文件!','error');
	}
}
function saveAnne(){
	var title = $("#captions");
	if ($.trim(title.val()) == '' || $.trim(title.val()) == null){
		$.messager.alert('请注意','请输入公告标题。');
		title.focus();
	}else{
		$('#anneStatus').val('新建');
		if(window.parent.checkFilesSize()){//检测是否包含空文件，否的话才提交
			var options = {
				url : '${AppContext.ctxPath}/action/portal/announce/announceUpdate',
				type : 'post',
				dataType :'json',
				success : function(data) {
					if(data.success){
						window.parent.operationtip('保存成功！',"info");
				  	} else {
						window.parent.operationtip(data.result,"error");
					}
				}
			};
			getInputValue();
			form.ajaxSubmit(options);
		} else {
			window.parent.operationtip('保存失败,请删除空的文件!','error');
		}
	}
}

function publishAnne(){
	var title = $("#captions");
	if ($.trim(title.val()) == '' || $.trim(title.val()) == null){
		$.messager.alert('请注意','请输入公告标题。');
		title.focus();
	}else{
		window.parent.operationconfirmToDo('确定发布公告？',formSubmit);
	}
}
function addRow(){
    var $tr = $("<tr>"+  
    "<td width='80'>附件</td>"+  
    "<td width='820'><input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/>&nbsp;&nbsp;<a href='###' onclick=\"deleteRow(this)\">删除</a></td>"+  
    +"</tr>");  
      
    var $table = $("#editorTable");  
    $table.append($tr); 
}

function deleteRow(obj){
	$(obj).parent().parent().remove();
}

</script>
</body>
</html>