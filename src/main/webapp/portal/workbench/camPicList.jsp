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
			<table id="campaign-table" width="98%" height="370px" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="cityName" width="120px" editor="{type:'picklistbox',options:{title:'选择城市',
																completeFun:cityPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp',
																required:true}}">城市</th>
						<th field="name" width="120px" editor="{type:'textbox'}">名称</th>
						<th field="code" width="120px">编码</th>
						<th field="status" width="100px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_STATUS'),
																			editable:false}}">状态</th>
						<th field="shareType" width="100px" lov="TB_O2O_SHARE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_SHARE_TYPE'),
																			editable:false}}">分享方式</th>
						<th field="shareTheme" width="120px" editor="{type:'textbox'}">分享标题</th>
						<th field="URL" width="120px" editor="{type:'textbox'}">URL</th>
						<th field="shareNotes" width="120px" editor="{type:'textbox'}">分享说明</th>
						<th field="type" width="120px" lov="TB_O2O_SHEET_TYPE">类型</th>
						
				   </tr>
				</thead>
			</table>
			
			<table id="campPicLine-table" width="98%" height="370px" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="lineType" width="100px" LOV="TB_O2O_CAM_LINE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_CAM_LINE_TYPE'),
																			onBeforeLoad:beforeSelectShare,
																			editable:false}}">类型</th>
						<th field="picUrl" width="160px" formatter="imageFormatter">图片</th>
						<th field="prodName" width="120px" editor="{type:'picklistbox',options:{title:'选择商品',
																completeFun:merchandisePicklistComplete,
																onBeforeOpenDialog:onBeforeOpenDialog,
																initParam:initPickMerchandiseParam,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp'}}">商品名称</th>
						<th field="prodCode" width="120px">商品编码</th>
						<th field="promotionName" width="120px" editor="{type:'picklistbox',options:{title:'选择秒杀产品',
																completeFun:secKillPicklistComplete,
																initParam:initPickCouponParam,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oSecKillPickList.jsp'}}">秒杀名称</th>
						<th field="promotionCity" width="120px">秒杀城市</th>
						<th field="promotionStartTime" width="120px" mark="date" >秒杀开始时间</th>
						<th field="promotionEndTime" width="120px" mark="date">秒杀结束时间</th>
						<th field="displaySeq" width="100px" editor="{type:'numberbox',options:{
																					min:0,
																					precision:0}}">显示顺序</th>
						<th field="status" width="120px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_STATUS'),
																			editable:false}}">状态</th>
						
				   </tr>
				</thead>
			</table>
			<div id="bigImg" style="display: none;">
				<img id="popUpImg"/>
			</div>
		</div>
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
	<script type="text/javascript">
		$addWin = $("#addWin");
		$addWinFram = $("#addWinFram");
		$addLineWin = $("#addLineWin");
		$addLineWinFram = $("#addLineWinFram");
	    $camDatagrid = $('#campaign-table');
		$linDatagrid = $('#campPicLine-table');
		$camDatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			/* buttonImport:true, */
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			subGridIds: ['campPicLine-table'],
			url:'${AppContext.ctxPath}/action/portal/campaign/queryByExamplePage',
		    onBeforeLoad:function(param){
				param.type='Single Pic Type';
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/campaign/upsert",row, 
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

			onInitNewData:function(that){
				return {
					type : 'Single Pic Type',
					status: 'Active',
					shareType : 'Screenshot'
				};
			},
			
			onDblClickRow: function(index, row){//行不可编辑判断，true为只读
				$camDatagrid.hdatagrid('getEditor', {
					index : index,
					field : 'cityName'
				}).target.textbox('disable');
				return false;
			},
			
			
			onChangeSelectedItem:function(row,that){
				if(row.status == 'Active'){
					$("#btn_camadd").linkbutton({text:'无效'});
				} else{
					$("#btn_camadd").linkbutton({text:'有效'});
				}
			},
			
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(22,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddWin()">批量新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_camadd" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileCampImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="campId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			}, 
			
		});
		
		$linDatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			/* buttonCopy:true, */
			buttonExport:true,
			/* buttonImport:true, */
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			url:'${AppContext.ctxPath}/action/portal/camPic/queryByExamplePage',
		    parentGridId : 'campaign-table',
		    parentGridField : 'id',
		    linkGridField : 'camId',
			
		    onLoadSuccess: function (data) {
		        //调用图片展示组件
		        $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
		    },
		    
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
		    	row.camId=$camDatagrid.datagrid('getSelected').id;
				$.post("${AppContext.ctxPath}/action/portal/camPic/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/camPic/deleteById', {
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
					$("#btn_linadd").linkbutton({text:'无效'});
				} else{
					$("#btn_linadd").linkbutton({text:'有效'});
				}
			},
			
 			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_linadd" class="easyui-linkbutton" onClick="linInvalid()" iconCls="icon-undo" plain="true">失效</a>',that);
				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form2" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileLineImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="lineId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file1' name='myfiles'/></a></form></div>",that);
			}, 
			//新建数据时初始化
			onInitNewData : function(that) {
				return {
					status : "Active",
					displaySeq : 1,
				};
			},
			
		});
		
		$(".fileCampImg").change(function(){
			var row = $camDatagrid.datagrid('getSelected');
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
	   						$camDatagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
		
		$(".fileLineImg").change(function(){
			var row = $linDatagrid.datagrid('getSelected');
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
			$('#lineId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/campaign/uploadImg2',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						var file = $("#file1");
	   						file.after(file.clone().val(""));
	   						file.remove(); 
	   						$linDatagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form2').ajaxSubmit(options);
		});
		//失效
 		function Invalid(){
			var row = $camDatagrid.datagrid('getSelected');
			if(row.status=="Inactive"){
				$camDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
			}else{
				$camDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
			}
			var index = $camDatagrid.hdatagrid('getRowIndex', row);
            $camDatagrid.datagrid('selectRow',index);
		} 
		
		//失效
 		function linInvalid(){
			var row = $linDatagrid.datagrid('getSelected');
			if(row.status=="Inactive"){
				$linDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
			}else{
				$linDatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
			}
			var index = $linDatagrid.hdatagrid('getRowIndex', row);
            $linDatagrid.datagrid('selectRow',index);
		} 
		
		function merchandisePicklistComplete(selectRow){
			$linDatagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
			return selectRow.o2oDisplayName;
		}
		
		function beforeSelectShare(param){
 			param.parentVal="Single Pic Type";
		}
		
		function secKillPicklistComplete(selectRow){
			$linDatagrid.hdatagrid('getCurrentRow').promotionId = selectRow.id;
			return selectRow.name;
		}

		function cityPicklistComplete(selectRow){
			$camDatagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		function onBeforeOpenDialog() {
			var row = $camDatagrid.hdatagrid('getCurrentRow');
			if('' == row.cityId || null == row.cityId){
				window.parent.operationtip('请先选择城市！', 'info');
				return false;
			}else{
				return true;
			}
		}
		
		function initPickMerchandiseParam() {
			var districtId = $camDatagrid.hdatagrid('getCurrentRow').cityId;
			return {districtId:districtId,attr1:'campaign'};
		}
		
		function initPickCouponParam() {
			var cityId = $camDatagrid.hdatagrid('getCurrentRow').cityId;
			return {cityId:cityId,type:'Second Kill'};
		}
		
		function imageFormatter(val,row){   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.picUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		function openAddWin(){
			$addWin.css("display", "block");
			$addWinFram.attr("src", "${AppContext.ctxPath}/portal/workbench/campaign/addcampaign.jsp?type=Single Pic Type");
		}
		
		function closeAddWin(operate, newId ,type){
			$addWin.css("display", "none");
			$addWinFram.attr("src","");
			if(operate == "ok" && newId && type){
				openAddLineWin(newId,type,0);
				return;
			}else{
				$camDatagrid.hdatagrid('reload');
			}
		}
		
		function openAddLineWin(campaignId , type, i){
			if(!campaignId && !type){
				$.messager.show("错误", "参数错误，无法获取参数", "error");
				return;
			}
			i = Number(i) + Number(1);
			$addLineWinFram.attr("src","");
			$addLineWinFram.attr("src", "${AppContext.ctxPath}/portal/workbench/campaign/addcampaignLine.jsp?campaignId="+campaignId+"&type="+type+"&i="+i);
			$addLineWin.css("display", "block");
		}
		
	   function closeAddLineWin(operate, newId , type , i){
		    $addLineWin.css("display", "none");
			$addLineWinFram.attr("src","");
			if(operate == "ok"){
				$camDatagrid.hdatagrid('reload');
			}
			if(operate == "next" && newId && type){
				openAddLineWin(newId,type,i);
				return;
			}
		}
	</script>
</body>
</html>