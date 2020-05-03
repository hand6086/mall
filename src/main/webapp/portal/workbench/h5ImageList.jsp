<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
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
  <div data-options="region:'north',split:true" fit="true" border="false">
   <table id="h5Image-table"			
   			singleSelect="true" rownumbers="true"  pagination="true" fit="true">

		<thead>
			<tr>
				<th field="imgCode" width="100px" editor="{type:'textbox'}">编号</th>
				<th field="type" width="140px" lov="TB_O2O_H5_IMAGE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_H5_IMAGE_TYPE'),
																		editable:false}}">图片类型</th>
				<th field="comments" width="200px" editor="{type:'textbox'}">说明</th>
				<th field="h5Title" width="180px" editor="{type:'textbox'}">H5分享标题</th>
				<th field="h5Text" width="400px" editor="{type:'textbox'}">H5分享正文</th>
				
			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#h5Image-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			buttonExport : false,
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/h5Image/queryByExamplePage',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/h5Image/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/h5Image/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			
			

 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileH5Img" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="h5Id" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			}, 

		});
		
		$(".fileH5Img").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alter("没有选中任何产品信息！");
				return;
			};
			/* 判断产品上传图片大小
			var files = document.getElementById("file").files; 
			var size = files[0].size;
			if (size >= 2 * 1024 *1024){
				$.messager.alert('注意','上传图片大小不要超过2M');
				return;
			}
			 */
			$('#h5Id').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/h5Image/uploadImg',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						var file = $("#file");
	   						file.after(file.clone().val(""));
	   						file.remove(); 
	   						$datagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
	</script>
</body>
</html>