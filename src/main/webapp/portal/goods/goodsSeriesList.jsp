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
   <table id="goodsSeries-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="code" width=20%>编码</th>
				<th field="name" width=20% editor="{type:'textbox'}">系列名称</th>
				<th field="status" width=20% lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_STATUS'),
																		editable:false}}">状态</th>
				<th field="channelType" width=10% lov="CHANNEL_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('CHANNEL_TYPE'),
																		editable:false,
																		disabled:true}}">所属频道</th>
				<th field="notes" width=20%  editor="{type:'textbox'}">备注</th>
			</tr>
		</thead>
	</table>
	</div>
	<script type="text/javascript">
	    $datagrid = $('#goodsSeries-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:false,
			buttonExport:true,
			newDefaultValue:true,
			url:'${AppContext.ctxPath}/action/portal/goodsSeries/queryByExamplePage',
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goodsSeries/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/goodsSeries/deleteById', {
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
					status : 'Active',
					channelType:'fast shopping',
				};
			},
 			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">无效</a>',that);
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="goodsSeriesId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
 			}, 
			/**
			 * 切换行，或加载数据成功后，触发选中行信息
			 */
			onChangeSelectedItem:function(row,that){
				if(row.status == 'Active'){
					$("#btn_add").linkbutton({text:'无效'});
				} else{
					$("#btn_add").linkbutton({text:'有效'});
				}
			},
		});
		
		$(".fileProdImg").change(function(){
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
			$('#goodsSeriesId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/goodsSeries/uploadImg',
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
		
		//失效
		function Invalid(){
			var row = $datagrid.datagrid('getSelected');
			if(row.status=="Inactive"){
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
			}else{
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
			}
			var index = $datagrid.hdatagrid('getRowIndex', row);
            $datagrid.datagrid('selectRow',index);
		}
		
	</script>
</body>
</html>