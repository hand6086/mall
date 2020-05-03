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
						data-filter-filed="areaType" data-table-Id="areaManager-table">
				</ul>
				</div> 
		</fieldset> 
			<table id="areaManager-table" keyFilterDiv="keyFilter"fit="true">
				<thead>
					<tr>
						<th field="areaName" width="80px" editor="{type:'textbox', options:{required:true}}">区域名称</th>
						<th field="areaType" width="80px"  lov="TB_O2O_AREA_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																required:'true',
																data:getLovArray('TB_O2O_AREA_TYPE'),
																editable:false}}">区域类型</th>
						<th field="areaCode" width="100px"editor="{type:'textbox', options:{required:false}}">区域编码</th>
						<th field="isO2OArea" width="80px"lov="TB_O2O_JUDGE_TYPE"editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false}}">是否O2O平台区域</th>
						<th field="parentAreaName" width="110px"editor="{type:'picklistbox',options:{title:'选择父区域',
															completeFun:parentAreaPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ParentAreaNamePickList.jsp'}}">父区域名称</th>
						<th field="parentAreaType" width="80px"lov='TB_O2O_AREA_TYPE'>父区域类型</th>
						<th field="actualCity" width="100px"editor="{type:'picklistbox',options:{title:'选择真实城市',
															completeFun:actualCityPickListComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ActualCityPickList.jsp'}}">真实城市</th>
						<th field="actualCityType" width="110px"lov='TB_O2O_AREA_TYPE'>真实城市区域类型</th>
						<th field="orgOnName" width="100px"editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:organizationCityPickListComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/OrganizationPickList.jsp'}}">对应组织</th>
						<th field="isO2ODistrict" width="105px"lov="TB_O2O_JUDGE_TYPE"editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false}}">是否地配区域</th> 
					</tr>
				</thead>
			</table>
		</div>					
	</div>  

	<script type="text/javascript">
		$('.easyui-layout').layout(); 
		$datagrid = $('#areaManager-table');
		$datagrid
				.hdatagrid({
					updateable : true,    
					toolbarShow:true,	//显示工具栏
					buttonSearch:true,	//搜索框功能
					buttonExport:true,
					buttonDelete:false,
					buttonCopy:true,
					buttonMenu:true,
					buttonNew : true,
					oauthFlag:true,
					pagination:true,
					menuButtonCount : true,
					striped:true,
					title:'',
					border:false,
					pageSize: 15,//每页显示的记录条数，默认为10 
					pageList: [5,10,15],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/areaManager/queryByExamplePage',

					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="productId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
					},
					/* 			onInsertAction : function(row,successFun,errFun,that) {
					 delete row.children;
					 $.post('${AppContext.ctxPath}/action/portal/accnt/insert', row, function(data) {
					 if (!data.success) {
					 errFun(data.result,that);
					 }else{
					 successFun(that, data);
					 }
					 });
					 },
					 onUpdateAction : function(row,successFun,errFun,that) {
					 delete row.children;
					 $.post('${AppContext.ctxPath}/action/portal/accnt/update', row, function(data) {
					 if (!data.success) {
					 errFun(data.result,that);
					 }else{
					 successFun(that, data);
					 }
					 });
					 }, */
			/* 		 onUpdateAction:function(row,successFun,errFun,that) {
						$.post('${AppContext.ctxPath}/action/portal/areaManager/update', row, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					}, */
					onInsertOrUpdateAction : function(row, successFun, errFun,that) {
						$.post('${AppContext.ctxPath}/action/portal/areaManager/upsert',
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
								$.post('${AppContext.ctxPath}/action/portal/areaManager/deleteById',
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
	   			url:'${AppContext.ctxPath}/action/portal/areaManager/uploadImg',
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
		
		//对应组织picklist
		function organizationCityPickListComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgOnName = selectRow.orgOnName;
			$datagrid.hdatagrid('getCurrentRow').attr05 = selectRow.orgId;
			return selectRow.orgOnName;
		}
	</script>
</body>
</html>