<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <table id="pic-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="isDisplay" width=20% lov="Is_Display" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('Is_Display'),
																		editable:false}}">是否显示</th>
				<th field="displaySeq" width=20%  editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">显示顺序</th>
				<th field="tAttr01" width=20% lov="PIC_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('PIC_TYPE'),
																		editable:false,
																		required:true}}">图片类型</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	    $datagrid = $('#pic-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/goodsPic/queryByExamplePage',
			onBeforeLoad:function(param){
				if(!goodsId){
		    		param.prodId = "noMatchId";
		    	}else{
		    		param.prodId=goodsId;
		    	}
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				if(row.row_status == 'NEW'){
					row.prodId=goodsId;
				}
				$.post("${AppContext.ctxPath}/action/portal/goodsPic/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/goodsPic/deleteById', {
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
			onInitNewData:function(that){
				return {
					isDisplay:'Y',
				};
			},
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="goodsSeriesId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
 
			}, 
		});
		
		$(".fileProdImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.prodId == null){
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
			$('#goodsSeriesId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/goods/uploadImgUpdate',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						$datagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
		
		
	</script>
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
</body>
</html>