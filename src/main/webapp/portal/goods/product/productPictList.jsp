<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>

<body>
	<div  class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
   <table id="pic-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="linePath" width="150px" formatter="linePathFormatter">商品图片</th>
				
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
				<th field="prodId" hidden="true">商品ID</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<script type="text/javascript">
		var prodId = "${param.prodId}";
	    $datagrid = $('#pic-table');
		$datagrid.hdatagrid({
			updateable:${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)},
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)},
			buttonDelete:${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)},
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/goodsPic/queryByExamplePage',
			onBeforeLoad:function(param){
				if(!prodId){
		    		param.prodId = "noMatchId";
		    	}else{
		    		param.prodId = prodId;
		    	}
				param.brandQuery = '1';
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				if(row.row_status == 'NEW'){
					row.prodId = prodId;
				}
				$.post("${AppContext.ctxPath}/action/portal/goodsPic/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
						window.parent.$picdatagrid.hdatagrid('reload');
					}
				});
			},
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
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
 				if(${param.goodsStatus == 'EDIT' || 'REFUSED' == param.goodsStatus || ('APPROVED' == param.goodsStatus && 'WAIT_FOR_SALES'==param.saleStatus)}){
 					addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="goodsSeriesId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);	
 				}
			}, 
		});
		
		$(".fileProdImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.prodId == null){
				$.messager.alert("错误", "没有选中任何产品信息！");
				return;
			};
			
			$('#goodsSeriesId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/goods/uploadImgUpdate',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						$datagrid.datagrid('reload');
	   						$.messager.alert("错误", "图片上传成功");
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
		
		function linePathFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A + row.linePath +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		
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