<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
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
			<table id="campaign-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="classifyName" width="100px" hidden="true" onSearch="true" editor="{type:'combobox',options:{
																			valueField:'name',
																			textField:'name',
																			method:'get',
																			url:'${AppContext.ctxPath}/action/portal/classify/classifyList',
																			editable:false,
																			onSelect:selectedClassify,
																			panelHeight: 'auto',//自动高度适合
																			required:true}}">分类名称</th>
						<th field="name" width="180px" formatter="nameFormatter" editor="{type:'textbox'}">承接页名称</th>
						<th field="code" width="140px" >承接页编码</th>
						<th field="status" width="100px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_STATUS'),
																			editable:false}}">状态</th>
						<th field="type" width="160px" lov="TB_O2O_SHEET_TYPE">承接页类型</th>
						<th field="shareType" width="100px" lov="TB_O2O_SHARE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('TB_O2O_SHARE_TYPE'),
																		editable:false}}">分享方式</th>
						<th field="shareUrl" width="160px" formatter="imageFormatter">分享图片</th>
						<th field="shareTheme" width="160px" editor="{type:'textbox'}">分享标题</th>
						<th field="url" width="160px" editor="{type:'textbox'}">URL</th>
						<th field="shareNotes" width="160px" editor="{type:'textbox'}">分享说明</th>
				   </tr>
				</thead>
			</table>
		</div>
	</div>
	<div id="bigImg" style="display: none;">
			<img id="popUpImg"/>
	</div>
   	<!-- 弹出窗 1-->
    <div id="addWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="addWinFram" name="addWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
   	<!-- 弹出窗2 -->
    <div id="addLineWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="addLineWinFram" name="addLineWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
    <!-- 弹出窗3 -->
    <div id="detailWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="detailWinFram" name="detailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
   	
	<script type="text/javascript">
		$addWin = $("#addWin");
		$addWinFram = $("#addWinFram");
		$addLineWin = $("#addLineWin");
		$addLineWinFram = $("#addLineWinFram");
		$detailWin = $("#detailWin");
		$detailWinFram = $("#detailWinFram");
	    $datagrid = $('#campaign-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/campaign/queryByExamplePage',
		    onBeforeLoad:function(param){
		    	param.source = 'brand';
			},
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
	        
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/campaign/brandUpsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/campaign/deleteById', {
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
			
			onChangeSelectedItem:function(row,that){
				if(row.status == 'Active'){
					$("#btn_camadd").linkbutton({text:'无效'});
				} else{
					$("#btn_camadd").linkbutton({text:'有效'});
				}
			},
			
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddWin()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_camadd" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileCampImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="campId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
 			}, 
			
		});
		
		//选择分类
		function selectedClassify(selectRow){
			$datagrid.hdatagrid('getCurrentRow').classifyId = selectRow.id;
		}
		
		function imageFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.shareUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		$(".fileCampImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alter("没有选中任何产品信息！");
				return;
			};
			var files = document.getElementById("file").files; 
			var size = files[0].size;
			if (size >= 1 * 1024 *1024){
				$.messager.alert('注意','上传图片大小不要超过1M');
				return;
			}
			$('#campId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/campaign/uploadImg',
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
 		
 		function openAddWin(){
			$addWin.css("display", "block");
			$addWinFram.attr("src", "${AppContext.ctxPath}/portal/brandWorkbench/campaign/addcampaign.jsp");
		}
		
		function closeAddWin(operate, newId ,type){
			$addWin.css("display", "none");
			$addWinFram.attr("src","");
			if(operate == "ok" && newId && type){
				openAddLineWin(newId,type,0);
				return;
			}else{
				$datagrid.hdatagrid('reload');
			}
		}
		
		function nameFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openDetailWin(\""+row.id+"\",\""+row.type+"\")'>"+val+"</a>";
		     }
		}
		
		function openAddLineWin(campaignId , type, i){
			if(!campaignId && !type){
				$.messager.show("错误", "参数错误，无法获取参数", "error");
				return;
			}
			i = Number(i) + Number(1);
			$addLineWinFram.attr("src","");
			$addLineWinFram.attr("src", "${AppContext.ctxPath}/portal/brandWorkbench/campaign/addcampaignLine.jsp?campaignId="+campaignId+"&type="+type+"&i="+i);
			$addLineWin.css("display", "block");
		}
		
	   function closeAddLineWin(operate, newId , type , i){
		    $addLineWin.css("display", "none");
			$addLineWinFram.attr("src","");
			if(operate == "ok"){
				$datagrid.hdatagrid('reload');
			}
			if(operate == "next" && newId && type){
				openAddLineWin(newId,type,i);
				return;
			}
		}
		function openDetailWin(campaignId,type){
			if(!campaignId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			if(!type){
				$.messager.show("错误", "参数错误，无法获取类型", "error");
				return;
			}
			$detailWinFram.attr("src","");
			if( !$detailWinFram.attr("src") ){
				$detailWinFram.attr("src", "${AppContext.ctxPath}/portal/brandWorkbench/campaign/campaignDetail.jsp?campaignId="+campaignId+"&type="+type);
				$detailWinFram[0].onload = function() {
					$detailWinFram[0].contentWindow.campaignInfoInit(campaignId, "reload");//等待窗口加载完毕
				}
			}else{
				$detailWinFram[0].contentWindow.campaignInfoInit(campaignId, "reload");
			}
			$detailWin.css("display", "block");
		}
		
	   function closeDetailWin(){
			$detailWin.css("display", "none");
			$detailWinFram.attr("src","");
			$datagrid.hdatagrid('reload');
			/* var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);
			$.post("${AppContext.ctxPath}/action/portal/campaign/queryById", {id: row.id}, function(data){
				if(data.success){
					$datagrid.datagrid('updateRow', {index : index, row:data.result})
					$datagrid.datagrid('acceptChanges');
				}else{
					$.messager.show("错误", "更新数据错误: "+data.result, "error");
				}
			}); */
		}
 		
	</script>
</body>
</html>