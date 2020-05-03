<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/ue/themes/default/css/ueditor.css">
<script type="text/javascript" charset="utf-8" src="${AppContext.ctxPath}/static/ue/ueditor.config.js"></script>
 <script type="text/javascript" charset="utf-8" src="${AppContext.ctxPath}/static/ue/ueditor.all.js"> </script>
 <script type="text/javascript" charset="utf-8" src="${AppContext.ctxPath}/static/ue/lang/zh-cn/zh-cn.js"></script>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 1100px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
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
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
</style>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;" title="">
		<div id="p1" class="easyui-panel" title="" border="false" style="width:'$(window).width() - 18';padding:0px;">
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>基础信息</legend>
							<table class="table-block" >
		       	<tr>
		       		<td width="120" class="td-label"><label>公告类型：</label></td>
		       		<td width="100">
		       			<input id="temp_anneType" name="temp_anneType" size="25" class="easyui-combobox td-input" 
		       			    data-options="valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('ANNE_TYPE'),
											editable:false,
											onSelect:function(record){
												affterAnneType();
										}"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>公告发布时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_publishDate" name="temp_publishDate" size="25" class="easyui-datetimebox td-input"  />
		       		</td>
		       		<td width="120" class="td-label"><label>有效开始时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_startDate" name="temp_startDate" size="25" class="easyui-datetimebox td-input"  />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>发布对象：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_anneReader" name="temp_anneReader" size="25" class="easyui-combobox td-input" 
		       			    data-options="valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('ANNE_OBJECT'),
											editable:false,
											onSelect:function(record){
											
										}"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>公告状态：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_anneStatus" name="temp_anneStatus" size="25" disabled value="NEW" class="easyui-combobox td-input" data-options="valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('ANNE_STATUS'),
											editable:false,
											onSelect:function(record){
										}"/>
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>有效结束时间：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="temp_endDate" name="temp_endDate" size="25" class="easyui-datetimebox td-input"  />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>公告图片：&nbsp;</label></td>
					<td class="td-content">
						<div>
							<section class="img-section" >
								<div class="z_photo upimg-div clear" >
									 <section class="z_file fl">
									 	<form>
											<img id="announceImg" src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
											<input type="file" name="file" id="imageUrl" class="file" multiple />
									  	</form>
									 </section>
								 </div>
							 </section>
						</div>
						<span style="padding-left:20px;">建议尺寸：宽1125×高300</span>
					</td>
		       	</tr>
		    </table>
		    </fieldset>
		    </td>
		    </tr>
		    </table>
		</div>
		<div id="p2" class="easyui-panel" title="公告内容" border="false" style="width:'$(window).width() - 18';height:700px;padding:0px;">
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
							<input id="publishDate" name="publishDate" type="hidden" value=""></input>
							<input id="orgId" name="orgId" type="hidden" value=""></input>
							<input id="announceImgId" hidden="true" name="announceImgId">
							<input id="announceId" name="id" type="hidden" value="${result.id}"></input>
						</td>
				    </tr>
				    <tr>
				    	<td class="td-label">标题：&nbsp;</td>
				    	<td width="820">
				    		<input class="easyui-textbox" type="text" style="width:800px;" name="captions" value="${result.captions }" id="captions" data-options="required:true"></input>
				    	</td>
				    </tr>
				    <tr>
				    	<td></td>
				    	<td></td>
				    </tr>
				    <tr>
				        <td class="td-label">内容：&nbsp;</td>
				        <td width="820">
				        	<div id="myEditor" name="contents" style="width:800px;height:440px;" >${result.contents}</div>
				        </td>
				    </tr>
				    <tr>
				        <td class="td-label">操作：&nbsp;</td>
				        <td width="820" >
							<a href="javascript:void(0)" id="btn_add" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRow()">添加附件</a>
				        </td>
				    </tr>
				    <c:if test="${list.size() > 0}">
					    <tr>
					        <td class="td-label">附件：&nbsp;</td>
					        <td width="820">
					        	<c:forEach items="${list}" var="attachment">
									<div>
									<a href="${AppContext.ctxPath}/action/portal/announce/downloadFile/${attachment.id}">${attachment.attachmentOriginal}</a>
										&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="###" onclick="deleteFile('${attachment.id}', this)">删除</a>
									</div>
								</c:forEach>
					        </td>
					    </tr>
				    </c:if>
				    	  
				</table>
			</form>
			<div>
				<center>
				    <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAnne()">保存</a>
					    &nbsp;&nbsp;&nbsp;
					    <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="javascript:window.parent.closeAnnounceWin()">返回</a>
				</center>
			</div>
			<br/>
		</div>
	</div>
</div>


<script type="text/javascript">

 var ue;
 var row;
var initHeadId = "${param.id}";

var row_status = '';//当前页面的操作状态
if(initHeadId == null || initHeadId == 'noMatchId'){
	row_status = 'NEW';//【新建】状态
} else {
	row_status = 'UPDATE';//【更新】状态
}
$headerForm = $('#form');
headerInfoInit();
 //初始化操作
 function init(editRow){
     console.log(editRow);
     row_status = 'UPDATE';//【更新】状态
     row = editRow;
     if(row.createdBy != appCtx.userId){
         $('#btn_submit').hide();
     }
     if(row.anneStatus === 'PUBLISHED'){
         $('#temp_anneType').combobox({ disabled: true });
         $('#temp_publishDate').datebox({ disabled: true });
         $('#temp_startDate').datebox({ disabled: true });
         $('#temp_endDate').datebox({ disabled: true });
         $('#temp_anneReader').combobox({ disabled: true });  //发布对象
         $('input').attr('readonly',true);
     }
     $("#announceId").val(row.id);
     // $('#temp_anneStatus').val(getLovShowName('ANNE_STATUS',row.anneStatus));
     $('#temp_orgName').val(row.orgName);
     $('#captions').textbox('setValue',row.captions);
     $('#temp_anneReader').combobox('setValue',row.anneReader);
     $('#temp_anneType').combobox('setValue',row.anneType);
     $('#temp_startDate').datetimebox('setValue',row.startDate);
     $('#temp_endDate').datetimebox('setValue',row.endDate);
     $('#temp_publishDate').datetimebox('setValue',row.publishDate);
     $('#temp_anneStatus').combobox('setValue',row.anneStatus);
	 $('#announceImg').attr('src',row.path);
     affterAnneType();
 };



$(document).ready(function() {
	$('#temp_anneStatus').val(getLovShowName('ANNE_STATUS','${result.anneStatus}'));
	$('#temp_orgName').val('${result.orgName}');
	$('#temp_anneReader').combobox('setValue','${result.anneReader}');
	$('#temp_anneType').combobox('setValue','${result.anneType}');
	$('#temp_startDate').datetimebox('setValue','${result.startDate}');
	$('#temp_endDate').datetimebox('setValue','${result.endDate}');
	affterAnneType();
});
function affterAnneType(){
	if($('#temp_anneType').combobox('getText') == '公告' && (!row || (row.anneStatus !== 'PUBLISHED'))){
		$('#temp_anneReader').combobox('enable');
		
	} else{
		$('#temp_anneReader').combobox('disable');
		$('#temp_orgName').textbox('disable');
		//清空内容
		$('#temp_anneReader').combobox('setValue','');
		$('#temp_orgName').textbox('setValue','');
	}
}

function getInputValue(){
 	$('#anneStatus').val($('#temp_anneStatus').combobox('getText'));
	$('#anneReader').val($('#temp_anneReader').combobox('getText'));
	$('#anneType').val($('#temp_anneType').combobox('getText'));
	$('#startDate').val($('#temp_startDate').datetimebox('getValue'));
	$('#endDate').val($('#temp_endDate').datetimebox('getValue'));
	$('#publishDate').val($('#temp_publishDate').datetimebox('getValue'));
}
function saveAnne(){
	$('#anneStatus').val('New');
	var anneType = $('#temp_anneType').combobox('getText');
	if(window.parent.checkFilesSize()){//检测是否包含空文件，否的话才提交
		var options = {
			url : '${AppContext.ctxPath}/action/portal/announce/'+(row_status === 'UPDATE'?'announceUpdate':'announceInsert'),
			type : 'post',
			dataType :'json',
			success : function(data) {
				if(data.success){
					window.parent.operationtip('保存成功！',"info");
					window.parent.closeAnnounceWin();
			  	} else {
					window.parent.operationtip(data.result,"error");
				}
			}
		};
		getInputValue();
		$headerForm.ajaxSubmit(options);
	} else {
		window.parent.operationtip('保存失败,请删除空的文件!','error');
	}
}
function brandAnnounceInit(){
	
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

function deleteFile(id, obj){
	$.messager.confirm("操作提示", "您确实要删除此文件吗？", function(data){
		if(data)
		{
			$.post('${AppContext.ctxPath}/action/portal/announce/delAttach/' + id, function(data){
				if(data.success){
					$(obj).parent().parent().hide();
					window.parent.operationtip('保存成功！','info');
				}else{
					window.parent.operationtip('失败！','error');
				}
			});
		}
	});
}

function downloadFile(id, obj){
			$.post('${AppContext.ctxPath}/action/portal/announce/downloadFile/' + id, function(data){
				if(data.success){
					window.parent.operationtip('下载成功！','info');
				}else{
					window.parent.operationtip('下载失败！','error');
				}
			});

}
function headerInfoInit(){
	var url = '';
	if(row_status == 'NEW'){//判断是否为新建
		url = '${AppContext.ctxPath}/action/portal/announce/preDefaultValue';
	} else {
		url = '${AppContext.ctxPath}/action/portal/announce/editQueryById';
	}
	$.post(url,{id:initHeadId},
		function(data){
			if(data){
				if(data.success){
					var entity = data.result;
					initHeadId = entity.id;
					entity.row_status = row_status;
					if(row_status == 'NEW'){
						entity.anneStatus = 'NEW';
					}
					$headerForm.form("load", !!row?row:entity);

					//初始化富文本控件
					//var ue = UE.getEditor('myEditor');
					!ue && (ue = UE.getEditor('myEditor',{
						autoHeightEnabled: false,//关闭自动增长高度
						initialFrameHeight:300,//设置宽度
						autoFloatEnabled:false //固定工具栏
					}));
					ue.ready(function() {
					    ue.setContent(entity.content);//设置编辑器的内容
						//显示公告内容
						!!row && ue.setContent(row.contents);
					});
                    if (data.list != undefined && data.list.length != 0) {
                        $(data.list).each(function(index,attachment){
                            var $tr = $("<tr>" +
                                "<td width='80'>附件</td>" +
                                "<td width='820'>" +
                                "<a href='###' class='easyui-tooltip' onclick='window.open(\"" + attachment.attr1 + "\")'>"+attachment.attachmentOriginal+"</a>" +
                                "&nbsp;&nbsp;&nbsp;&nbsp;" +
                                "<a href=\"###\" onclick=\"deleteFile(\'"+attachment.id+"\', this)\">删除</a></td>" +
                                +"</tr>");
                            var $table = $("#editorTable");
                            $table.append($tr);
                        });
                    }
				}
			}
		});
}

$('#imageUrl').BobImage({
	upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
    initImgUrl : '',
    width : '150px',
    height : '150px',
	myComplete : function (success, result, message){
		// 自定义操作
		$('#announceImgId').val(result.id);
	},
	myRemove : function(){
		$('#announceImgId').val('');
	}
});
</script>
</body>