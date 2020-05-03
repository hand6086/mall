<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
		<fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">资源筛选条件</span>
			</legend>
	
			<div class="row keyfilter-border">
				<ul id="moduleTypeKeyfilter" data-toggle="keyfilter"
					data-title="业务模块" data-filter-filed="moduleType"
					data-table-Id="attachment-table">
				</ul>
			</div>
		</fieldset>
		<table id="attachment-table" keyFilterDiv="keyFilter" fit="true">
			<thead>
				<tr>
					<th field="check" checkbox="true"></th>
					<th field="attachmentOriginal" width="120px" defaultSearch="true" formatter="attachmentOriginalFormatter">资源名称</th>
					<th field="moduleType" lov="ATTACHMENT_MODULE_TYPE" width="120px">业务模块</th>
					<th field="headCode" width="90px">业务对象编码</th>
					<th field="headName" width="120px">业务对象名称</th>
					<th field="documentType" lov="DOCUMENT_TYPE" width="120px">类型</th>
					<th field="attachmentSize" width="80px">大小（字节）</th>
					<th field="created" width="120px">上传时间</th>
					<th field="source" width="120px">上传终端</th>
					<th field="comments" width="150px" formatter="titleFormatter">备注</th>
				</tr>
			</thead>
		</table>
	</div>
    
	<script type="text/javascript">
	getLovOfList("[DOCUMENT_TYPE,ATTACHMENT_MODULE_TYPE]");
	$dataAttachmentgrid = $('#attachment-table');
	$dataAttachmentgrid.hdatagrid({
		singleSelect : false,
		toolbarShow:true,
		buttonSearch:true,
		oauthFlag:true,
		url:'${AppContext.ctxPath}/action/portal/attachment/queryLibrary',
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(90,'<a href="javascript:void(0)" id="btn_batchDownload" class="easyui-linkbutton" iconCls="icon-download" plain="true" onclick="batchDownload()">下载选中</a>',that);
		}
	});
	function batchDownload(){
		var selectRows = $dataAttachmentgrid.hdatagrid('getSelections');
		if(!selectRows || selectRows.length<=0){
			$.messager.alert("操作提示", "请至少选择一条数据！","warning");
			return;
		}
		var ids = "";
		for(var i=0; i<selectRows.length; i++){
			ids += selectRows[i].id+",";
		}
		
		$.post('${AppContext.ctxPath}/action/portal/attachment/downloadBatch', {ids:ids}, 
			function(data){
			if(data){
				if(data.success){
					//alert(data.url);
					window.open(data.url);
				}else{
					$.messager.alert("操作提示", "下载错误: "+data.result,"error");
				}
			}else{
				$.messager.alert("操作提示", "下载发生错误！","error");
			}
		});
	}
	function titleFormatter(val, row) {
		if (val != null) {
			return '<span class="easyui-tooltip" title="'+ val + '">' + val + '</span>';
		} else {
			return val;
		}
	}
	function attachmentOriginalFormatter(val, row) {
		if (val != null) {
			var content = row.attachmentPath;
			return "<a href='###' class='easyui-tooltip' title='"
			+ content + "' onclick='window.open(\"" + row.attachmentPath + "\")'>" + val + "</a>";
		}
	}
	$('#moduleTypeKeyfilter').keyFilter({
		remoteData:true,
		remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/ATTACHMENT_MODULE_TYPE'
	});
	</script>
</body>
</html>