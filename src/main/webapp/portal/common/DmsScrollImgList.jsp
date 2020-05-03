<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>

<style type="text/css" >
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
</style>

<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" border="false" fit="true">
		<table id="scrollImg-table" fit="true">
			<thead>
				<tr>
					<th field="imgCode" width="100px">编号</th>
					<th field="imgUrl" width="100px" formatter="imageFormatter">图片</th>
					<th field="created" width="150px">创建时间</th>
					<th field="seq" width="100px" editor="{type:'numberbox',
														options:{min:0,
																required:true}}">顺序</th>
					<th field="forwardUrl" width="200px" editor="{type:'validatebox'}">点击后的跳转地址</th>
					<th field="activeFlag" width="60px"
						editor="{type:'checkbox',options:{on:'Y',off:'N'}}">有效</th>

				</tr>
			</thead>
		</table>
	</div>
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg" />
	</div>

	<script type="text/javascript">
		$datagrid = $('#scrollImg-table');
		$datagrid.hdatagrid({
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			url:'${AppContext.ctxPath}/action/portal/scrollImg/queryByExamplePage',
			onBeforeLoad:function(param){
				param.appType = 'DMS';
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<div style = "width:200px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileImg" iconCls="icon-uploadImg" plain="true">上传图片(建议大小1200 x 310) <input type="hidden" id="entityId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfile'/></a></form></div>",that);
			},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/scrollImg/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
							dataType:"json",
							contentType: "application/json",
							success: function(data){
								if(data.success){
									successFun(that, data);
								}else{
									errFun(that, data);
								}
							},
							error: function(xhr, code, msg){
								errFun(that, "msg");
							}
						});
					},				
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/scrollImg/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/scrollImg/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName,
					appType	: 'DMS',
					activeFlag : 'Y'
				};
			}
		});
		
		function imageFormatter(val,row,index)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.imgUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		$(".fileImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alert("没有选中任何行信息！");
				return;
			};
			$('#entityId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/scrollImg/imgIdUpdate',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						$datagrid.datagrid('reload');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
	</script>
</body>
</html>
