<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>

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
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
		<table id="popupImage-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="cityName" width="120px" editor="{type:'picklistbox',options:{title:'选择城市',
																completeFun:cityPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp',
																required:true}}">城市</th>
						<th field="imageComments" width="130px" editor="{type:'textbox'}">说明</th>
						<th field="objectType" width="120px" lov="TB_O2O_PUSH_OBJ_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_PUSH_OBJ_TYPE'),
																			editable:false}}">弹窗对象</th>
						<th field="linePath" width="150px" formatter="linePathFormatter">弹窗图片</th>
						<th field="displayFlag" width="100px" editor="{type:'checkbox', options:{on:'Y', off:'N',editable:false}}">是否显示</th>
						<th field="startTime" width="140px" mark="date" editor="{type:'datetimebox',options:{showSeconds:true}}">开始时间</th>
						<th field="endTime" width="140px" mark="date" editor="{type:'datetimebox',options:{showSeconds:true}}">结束时间</th>
						<th field="sequence" width="100px" editor="{type:'numberbox',options:{
																					min:0,
																					precision:0}}">显示顺序</th>
				   </tr>
				</thead>
		</table>
		<div id="bigImg" style="display: none;">
			<img id="popUpImg"/>
		</div>
	</div>
</div> 	
	<script type="text/javascript">
		$subdatagrid = $('#popupImage-table');
		$subdatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonCopy:true,
			buttonDelete:true,
			newDefaultValue:true,
			border:false,
			pageSize: 25, 
		    pageList: [10,25,50],
		    url:'${AppContext.ctxPath}/action/portal/popup/queryByExamplePage',
		    
		    onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
	        
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/popup/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/popup/deleteById', {
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
			
			onDblClickRow: function(index, row){//行不可编辑判断，true为只读
				$subdatagrid.hdatagrid('getEditor', {
					index : index,
					field : 'cityName'
				}).target.textbox('disable');
				return false;
			},
			
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton filePopupImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="popupId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			}, 

		});
		
		function linePathFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.linePath +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		$(".filePopupImg").change(function(){
			var row = $subdatagrid.datagrid('getSelected');
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
			$('#popupId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/popup/uploadImg',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						var file = $("#file");
	   						file.after(file.clone().val(""));
	   						file.remove();
	   						$subdatagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
		
		function cityPicklistComplete(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
	</script>
</body>
</html>