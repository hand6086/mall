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
		<div id="p2" class="easyui-panel" title="公告内容" border="false" style="width:'$(window).width() - 18';height:100%;padding:0px;">
		    <form id="form" method="post" enctype="multipart/form-data">
				<table id="editorTable" border="0">
				    <tr>
				    	<td class="td-label">标题：&nbsp;</td>
				    	<td width="820">
				    		<input class="easyui-textbox" type="text" style="width:800px;" name="captions" id="captions" readonly onfocus="this.blur();"></input>
				    	</td>
				    </tr>
				    <tr>
				    	<td></td>
				    	<td></td>
				    </tr>
				    <tr>
				        <td class="td-label">内容：&nbsp;</td>
				        <td width="820" >
				        	<script type="text/plain" id="myEditor" name="contents" style="width:800px;height:240px;" >${result.contents}</script>
				        </td>
				    </tr>
				</table>
			</form>
			<div>
				<center>
				    <a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="close()">关闭</a>
				</center>
			</div>
		</div>
	</div>
</div>
    

<script type="text/javascript">

var initHeadId = getUrlParams("id");
initHeadId = 'QT-9GDHS';
$headerForm = $('#form');
headerInfoInit();

function headerInfoInit(){
	var url = '${AppContext.ctxPath}/action/portal/announce/queryById';
	$.post(url,{id:initHeadId},
		function(data){
			if(data){
				if(data.success){
					var entity = data.result;
					initHeadId = entity.id;
					$headerForm.form("load", entity);
					//初始化富文本控件
					var ue = UE.getEditor('myEditor');
					ue.ready(function() {
					    ue.setContent(entity.contents);//设置编辑器的内容
					    ue.setDisabled();
					}); 
					$(":enabled",$headerForm).attr('unselectable','on');
				}
			}
		});
}
</script>
</body>
</html>