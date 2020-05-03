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
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
   <table id="buttonImage-table" width="98%" height="347px">
		<thead>
			<tr>
				<th field="buttonCode" width=18% editor="{type:'textbox'}">按钮编号</th>
				<th field="buttonName" width=18% editor="{type:'textbox'}">按钮名称</th>
				<th field="comments" width=18% editor="{type:'textbox'}">说明</th>
				<th field="coverFlag" width=21% editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否全局覆盖</th>
				<th field="type" width=21% lov="TB_O2O_BUTTON_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_BUTTON_TYPE'),
																		editable:false,
																		required:true}}">类型</th>
				<th field="imageId" width=24% hidden="ture">图片Id</th>
			</tr>
		</thead>
	</table>
	
	<table id="buttonImageCity-table" width="98%" height="347px" singleSelect="true" rownumbers="true" pagination="true">
			<thead>
				<tr>
					<th field="cityName" width="20%" editor="{type:'picklistbox',options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市名称</th>
					<th field="comments" width="76%" editor="{type:'textbox'}">说明</th>
					<th field="imageId" width="57%" hidden="ture">图片Id</th>

			   </tr>
			</thead>
		</table>
		
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#buttonImage-table');
		$subdatagrid = $('#buttonImageCity-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			newDefaultValue:true,
			oauthFlag:false,
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    subGridIds: ['buttonImageCity-table'],
		    url:'${AppContext.ctxPath}/action/portal/button/queryByExamplePage',
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/button/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/button/deleteById', {
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
			onInitNewData : function(that){
				
				return{
					coverFlag:'Y'
					
				};
			},
			
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form2" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileButtonImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="buttonId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			}, 

		});
			
		$subdatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		buttonMenu:true,
		menuButtonCount : true,
		newDefaultValue:true,
		oauthFlag:true,
		striped:true,
		border:false,
		pageSize: 10,//每页显示的记录条数，默认为20 
	    pageList: [10,30,50],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/buttonCity/queryByExamplePage',
		parentGridId : 'buttonImage-table',
	    parentGridField : 'id',
	    linkGridField : 'headId',
		
	    onInsertOrUpdateAction:function(row,successFun,errFun,that){
			if(row.row_status == 'NEW'){
				row.headId = $datagrid.datagrid('getSelected').id;
			}
			$.post("${AppContext.ctxPath}/action/portal/buttonCity/upsert",row, 
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
					$.post('${AppContext.ctxPath}/action/portal/buttonCity/deleteById', {
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
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileCityImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="btCityId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file1' name='myfiles'/></a></form></div>",that);
		}, 
		
	});
		
	$(".fileCityImg").change(function(){
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
			$('#btCityId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/button/uploadImg',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						var file = $("#file1");
	   						file.after(file.clone().val(""));
	   						file.remove(); 
	   						$subdatagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
	
	$(".fileButtonImg").change(function(){
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
		$('#buttonId').val(row.id);
		var options = {
   			url:'${AppContext.ctxPath}/action/portal/button/uploadImg2',
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
   		$('#form2').ajaxSubmit(options);
	});
		
	function cityPicklistComplete(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
	}

	</script>
</body>
</html>