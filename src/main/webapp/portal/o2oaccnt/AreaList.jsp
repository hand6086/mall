<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
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
  <div  class="easyui-layout" border="false" fit="true">		
		<div data-options="region:'north',split:true" title="" border="false"  style="width: 100%;" fit="true">
			 <fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速筛选</span>
				</legend>

				<div class="row keyfilter-border">
					<ul id="areaTypeKeyfilter" data-toggle="keyfilter" data-title="区域类型"
						data-filter-filed="areaType" data-table-Id="area-table">
				</ul>
				</div> 
			</fieldset> 
			<table id="area-table" keyFilterDiv="keyFilter"fit="true">
				<thead>
					<tr>
						<th field="areaName" width="80px" >区域名称</th>
						<th field="areaType" width="80px" lov="TB_O2O_AREA_TYPE">区域类型</th>
						<th field="areaCode" width="100px">区域编码</th>
						<th field="isO2OArea" width="80px"lov="TB_O2O_JUDGE_TYPE"editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false}}">是否O2O平台区域</th>
						<th field="parentAreaName" width="80px">父区域名称</th>
						<th field="parentAreaType" width="80px"lov='TB_O2O_AREA_TYPE'>父区域类型</th>
						<th field="actualCity" width="100px">真实城市</th>
						<!-- <th field="actualCityType" width="80px">真实城市区域类型</th>
						<th field="orgOnName" width="100px">对应组织</th>
						<th field="isO2ODistrict" width="105px">是否地配区域</th> -->
					</tr>
				</thead>
			</table>
		</div>					
	</div>  

	<script type="text/javascript">
		$('.easyui-layout').layout(); 
		$datagrid = $('#area-table');
		$datagrid
				.hdatagrid({
					updateable : true,    
					toolbarShow:true,	//显示工具栏
					buttonSearch:true,	//搜索框功能
					buttonExport:true,
					buttonDelete:false,
					buttonMenu:true,
					oauthFlag:true,
					pagination:true,
					menuButtonCount : true,
					striped:true,
					title:'',
					border:false,
					pageSize: 15,//每页显示的记录条数，默认为10 
					pageList: [5,10,15],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/area/queryByExamplePage',
					
					/* onAddMoreButton:function(that,addButtonFun){
						addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="productId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
					}, */
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input id="productId" name="id"/>'+"<input  name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
					},
					/*onInsertAction : function(row,successFun,errFun,that) {
					 delete row.children;
					 $.post('${AppContext.ctxPath}/action/portal/accnt/insert', row, function(data) {
					 if (!data.success) {
					 errFun(data.result,that);
					 }else{
					 successFun(that, data);
					 }
					 });
					 },	
				 	onUpdateAction:function(row,successFun,errFun,that) {
							$.post('${AppContext.ctxPath}/action/portal/area/update', row, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								}else{
									successFun(that, data);
								}
							});
					},*/
					 onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/area/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					}, 
					onDeleteAction : function(row, successFun, errFun, that) {
						$.messager.confirm("操作提示",'是否确定删除信息？',
						function(data) {
							if (data) {
								$.post('${AppContext.ctxPath}/action/portal/area/deleteById',
								{id : row.id},
								function(data) {
									if (!data.success) {
										errFun(data.result,that);
									} else {successFun(that);
									}
								});
							}
						});
					}
				});

		$(".fileProdImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alert("没有选中任何产品信息！");
				return;
			};
			$('#productId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/area/uploadImg',
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
		
		/* $(".filePic").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alert("请选中要上传的产品信息！");
			}else{
				$('#parentProdId').val(row.id);
				var options = {
		   			url:'${AppContext.ctxPath}/action/portal/attachment/insert',
		   			type:'post',
		   			dataType:'json',
		   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
		   			success : function(data) {
	   					if(data.success){
	   						//$datagridpic.datagrid('reload');
	   				  	}
		   			}
		   		};
		   		$('#formPic').ajaxSubmit(options);
			}
		}); */
		//快速筛选区域类型
		 $('#areaTypeKeyfilter').keyFilter({		   
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_O2O_AREA_TYPE'
	  	 }); 
		//父区域名称picklist
		function parentAreaPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').parentAreaName = selectRow.parentAreaName;
			$datagrid.hdatagrid('getCurrentRow').parentId = selectRow.id;
			return selectRow.parentAreaName;
		}
		//真实名字picklist
		function actualCityPickListComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').actualCity = selectRow.actualCity;
			$datagrid.hdatagrid('getCurrentRow').attr04 = selectRow.id;
			return selectRow.actualCity;
		}
	</script>
</body>
</html>