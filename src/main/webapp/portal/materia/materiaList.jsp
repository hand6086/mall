<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
   
    <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="materiatTpeKeyfilter" data-toggle="keyfilter"
				data-title="类型" data-filter-filed="type"
				data-table-Id="materia-table">
			</ul>
		</div>
	</fieldset>
	
	<table id="materia-table" style="height:100%;width:100%" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="url" width="100px" formatter="attachmentOriginalFormatter">图片</th>
				<th field="created" width="120px" >创建时间</th>
				<th field="mediaId" width="350px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">素材ID</th>
				<th field="updateTime" width="120px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">最后更新时间</th>
				<th field="name" width="100px" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">文件名称</th>
				<th field="type" width="100px" lov="MATERIA_TYPE" defaultSearch="false" editor="{type:'validatebox',options:{required:false}}">类型</th>

			</tr>
		</thead>
	</table>
	
	</div>
	<!-- ------------------------上传永久素材弹出框：开始----------------------------  -->
	<div id="upload_attachment">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<form method="post" class="uploadAttachmentForm" style="text-align:center;margin-top: 30px;" enctype="multipart/form-data" >
					<input type='file' name='uploadAttachment' style="display: none;"/>
					文件：
					<input id="openFile" class="easyui-textbox" data-options="buttonText:'浏览',
									         							  buttonIcon:'icon-search',
									         							  prompt:'请选择文件...',
									         							  editable:false,
									         							  width:'200px',
									         							  height:'30px',
									         							  onClickButton: function(){
									         							  	$('#upload_attachment input[name=uploadAttachment]').click();
																		}"/>
					<br/><br/>类型：
					<input id="type" name="type" class="easyui-combobox" type="text"  data-options=" width:'200px', height:'30px'" />	
					<br/><br/>标题：
					<input disabled id="title" name="title" class="easyui-textbox" type="text"  data-options=" width:'200px', height:'30px'" />
					<br/><br/>描述：
					<input disabled id="introduction" name="introduction" class="easyui-textbox" type="text"  data-options=" width:'200px', height:'30px'" />	         							  
				</form>
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
				<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="uploadAttachment()">上传</a>
				<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="$uploadAttachmentDiv.window('close')">取消</a>
			</div>
		</div>
	</div>
	<!-- ------------------------上传附件弹出框：结束----------------------------  -->
	<script type="text/javascript">
		getLovOfList("[MATERIA_TYPE]");
		$uploadMatreiaDiv = $('#upload_materia');
		$typeCombobox = $('#type');
		$datagrid = $('#materia-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			//updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			//buttonNew : true,
			buttonDelete : true,
			//buttonCopy : true,
			buttonExport : true,
			//buttonImport : true,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/materia/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/materia/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/materia/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/materia/deleteById', {
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
			onChangeSelectedItem:function(row){
				//$datagrid.hdatagrid("changeParentItemAndParams",{MateriaId:row.id});
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
					postnName : appCtx.postnName
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment()">上传永久素材</a>',that);
				addButtonFun(2,'<a href="javascript:void(0)" id="btn_download" class="easyui-linkbutton" iconCls="icon-download" plain="true" onclick="downloadMateria()">下载选中</a>',that);
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="ansyMateria()" iconCls="icon-reload" plain="true">素材同步</a>',that);
			},
			/**
			 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
			 */
			//readOnlyCondition: function(row, that){
			//	return false;
			//},
		});
		//初始化 客户状态 下拉列表
		$typeCombobox.combobox({
			data : getLovArray('MATERIA_TYPE'),
			valueField : 'val',
			textField : 'name',
			editable : false, //不可编辑状态
			cache : false,
			onSelect : function(value) {
				console.log('value:'+value.val);
				if(value.val == 'video'){
					$('#title').textbox('enable');
					$('#introduction').textbox('enable');
				}else{
					$('#title').textbox('disable');
					$('#introduction').textbox('disable');
				}
			}
		});
		
		function ansyMateria() {
			operationprogress('进度提示', '正在同步...');
			$.get('${AppContext.ctxPath}/action/portal/materia/ansyMateria',
					function(data) {
						/* console.log(data); */
						if (!data.success) {
							$.messager.alert("操作提示", data.result, "error");
						} else {
							$.messager.progress('close');
							$datagrid.datagrid('reload');
							$.messager.alert("操作提示","已同步" + data.total + "条记录", "info");
						}
					});
		}

		$('#materiatTpeKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/MATERIA_TYPE'
		});
		
		function attachmentOriginalFormatter(val, row) {
			/* if (val != null) {
				var content = row.url;
				return "<a href='###' class='easyui-tooltip' title='"
				+ content + "' onclick='window.open(\"" + row.url + "\")'>" + val + "</a>";
			} */
			if (val)
				return "<img height='46' width='46' src='"+val+"'>";
			return "<img height='46' width='46' src='${AppContext.ctxPath}/static/images/404.jpg'>";
		}
		
		$uploadAttachmentDiv = $('#upload_attachment');
		function openUploadAttachment(){
			$uploadAttachmentDiv.dialog({
				title:'上传永久素材',
				iconCls:'icon-add',
			    width:'400px',
			    height:'400px',
			    closable:false,
			    minimizable:false,
			    collapsible:false,
			    modal:true,
			    closed:true
			});
			clearDiv();
			$uploadAttachmentDiv.window('open');
		}
		
		/**
		 * 清空弹出框内容
		 */
		function clearDiv(){
			$('input[name=uploadAttachment]',$uploadAttachmentDiv).val('');
			$('#type',$uploadAttachmentDiv).combobox('setValue','');
			$('#openFile',$uploadAttachmentDiv).textbox('setValue', '');
			$('#title',$uploadAttachmentDiv).textbox('setValue', '');
			$('#title',$uploadAttachmentDiv).textbox('disable');
			$('#introduction',$uploadAttachmentDiv).textbox('setValue', '');
			$('#introduction',$uploadAttachmentDiv).textbox('disable');
		}
		$('input[name=uploadAttachment]',$uploadAttachmentDiv).change(function(){
			var fileName = $('input[name=uploadAttachment]',$uploadAttachmentDiv).val();
			$('#openFile').textbox('setValue', fileName);
		});
		function uploadAttachment(){
			var typeValue = $('#type',$uploadAttachmentDiv).combobox('getValue');
			console.log(typeValue);
			
			var fileName = $("#openFile").val();
	   		console.log(fileName);
	   		var fileext=fileName.substring(fileName.lastIndexOf("."),fileName.length)  
	   		fileext=fileext.toLowerCase();  
			console.log(fileext);
   		    if (fileext!='.mp3' && fileext!='.wma' && fileext!='.wav'&& fileext!='.amr'
   		    	&& fileext!='.jpg'&& fileext!='.gif'&& fileext!='.bmp'&& fileext!='.png'&& fileext!='.jpeg'
   		    			&& fileext!='.mp4'){  
   		        alert("对不起，导入文件只能是图片、视频、声音！");  
   		        return;  
   		    }
   		    
   			 $.messager.progress();
   			 
			var options = {
	   				url:'${AppContext.ctxPath}/action/portal/materia/addEverMateriaNoNews',
	   				type:'post',
					data : "",
					dataType : 'json',
					contentType : "application/octet-stream;charset=utf-8",
					success : function(data) {
						if (data.success) {
							$.messager.progress('close');
							$.messager.alert("提示", "上传成功！");
							//$dataAttachmentgrid.datagrid('reload');
							$uploadAttachmentDiv.window('close');
						} else {
							if (data.result == null) {
								data.result = "上传失败！";
							}
							$.messager.alert("警告", data.result);
						}
					}
				};
				$('.uploadAttachmentForm', $uploadAttachmentDiv).ajaxSubmit(options);
		}
		
		function downloadMateria(){
			var selectRow = $datagrid.datagrid('getSelected');
			console.log(selectRow);
			if(!selectRow){
				$.messager.alert("操作提示", "请选择一条数据！","warning");
				return;
			}
			if(selectRow.url){
				window.open(selectRow.url);
				console.log(selectRow.url);
				return;
			}
			var mediaId = selectRow.mediaId;
			var type = selectRow.type;
			var name = selectRow.name;
			$.post('${AppContext.ctxPath}/action/portal/materia/downloadMateria', 
				{
				mediaId : mediaId,
				type : type,
				name : name
				}, 
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
			/* var ids = "";
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
			}); */
		}
	</script>
</body>
</html>
