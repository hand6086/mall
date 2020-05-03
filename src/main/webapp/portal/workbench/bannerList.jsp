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
			<table id="bannerManagement-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="cityName" width="120px" editor="{type:'picklistbox',options:{title:'选择城市',
																completeFun:cityPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp',
																required:true}}">城市</th>
						<th field="name" width="160px" editor="{type:'textbox'}">名称</th>
						<th field="imageUrl" width="160px" formatter="imageFormatter">Banner图片</th>
						<th field="targetId" width="140px">编码</th>
						<th field="tAttr01" width="100px" lov="TB_O2O_HOMEPAGE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_HOMEPAGE_TYPE'),
																			editable:false}}">类型</th>
						<th field="campaignName" width="180px" editor="{type:'picklistbox',options:{title:'选择活动',
																completeFun:campaignPicklistComplete,
																onBeforeOpenDialog:onBeforeOpenDialog,
																initParam:initPickCampaignParam,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oCampaignPickList.jsp'}}">活动名称</th>
						<th field="campaignCode" width="140px">活动编码</th>
						<th field="merchandiseName" width="180px" editor="{type:'picklistbox',options:{title:'选择商品',
																completeFun:merchandisePicklistComplete,
																onBeforeOpenDialog:onBeforeOpenDialog,
																initParam:initPickMerchandiseParam,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oMerchandisePickList.jsp'}}">商品名称</th>
						<th field="merchandiseCode" width="140px">商品编码</th>
						<th field="buttonId" hidden="true" noSearch="true" width="140px" editor="{type:'textbox'}">促销按钮Id</th>
						<th field="buttonName" width="140px" editor="{type:'combobox',options:{
																	method:'get',
																	url:'${AppContext.ctxPath}/action/portal/button/buttonList',
																	valueField:'buttonName',
																	textField:'buttonName',
																    editable:false, //不可编辑状态
																    panelHeight: 'auto',//自动高度适合
																    cache: false,
																    onBeforeLoad : function(param) {param.source='fast shopping';},
																    onSelect:selectButton
																    }}">促销按钮</th>
						<th field="url" width="140px" editor="{type:'textbox'}">外部链接</th>
						<th field="isDisplay" width="70px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否显示</th>
						<th field="sequence" width="70px"  editor="{type:'numberbox',options:{
																					min:0,
																					precision:0}}">显示顺序</th>
						<th field="startTime" width="140px" mark="date" editor="{type:'datetimebox',options:{showSeconds:true}}">开始时间</th>
						<th field="endTime" width="140px" mark="date" editor="{type:'datetimebox',options:{showSeconds:true}}">结束时间</th>
				   </tr>
				</thead>
			</table>
			<div id="bigImg" style="display: none;">
				<img id="popUpImg"/>
			</div>
		</div>
	</div>
   	
	<script type="text/javascript">
		$subdatagrid = $('#bannerManagement-table');
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
		    url:'${AppContext.ctxPath}/action/portal/banner/queryByExamplePage',
		    
		    onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
	        
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/banner/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/banner/deleteById', {
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
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileBannerImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="bannerId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
 				addButtonFun(91,'<a href="javascript:void(0)" id="selectCityBtn" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="selectCityWindow()">批量复制</a>',that);
 			}, 

		});
		
		function cityPicklistComplete(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		function merchandisePicklistComplete(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').merchandiseId = selectRow.id;
			return selectRow.o2oDisplayName;
		}
		
		function campaignPicklistComplete(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').campaignId = selectRow.id;
			return selectRow.name;
		}
		
		function imageFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.imageUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		$(".fileBannerImg").change(function(){
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
			$('#bannerId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/banner/uploadImg',
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
	   				  	}else{
	   				     	window.parent.operationtip('图片上传失败！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
		
		function onBeforeOpenDialog() {
			var row = $subdatagrid.hdatagrid('getCurrentRow');
			if('' == row.cityId || null == row.cityId){
				window.parent.operationtip('请先选择城市！', 'info');
				return false;
			}else{
				return true;
			}
		}
		
		function initPickCampaignParam() {
			var row = $subdatagrid.hdatagrid('getCurrentRow');
			return {cityId:row.cityId};
		}
		
		function initPickMerchandiseParam() {
			var districtId = $subdatagrid.hdatagrid('getCurrentRow').cityId;
			return {districtId:districtId,attr1:'campaign'};
		}
		
		//选择类型
		function selectButton(selectRow){
			var editIndex = $subdatagrid.hdatagrid('getCurrentRowIndex');
			$subdatagrid.hdatagrid('getEditor',{index:editIndex,field:'buttonId'}).target.textbox('setValue', selectRow.id);
		}
		
		function selectCityWindow()
		{
			$('#selectCityBtn').multiSelect({
				title:'添加城市菜单',
				initParam:function(){},
				tableUrl:'${AppContext.ctxPath}/portal/workbench/campaign/citySelect.jsp',
				completeFun:function(selectedRow){
					var records = [];
					var bannerRow = $subdatagrid.hdatagrid('getSelected');
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						var row = {
								name : bannerRow.name,
								tAttr01 : bannerRow.tAttr01,
								isDisplay : bannerRow.isDisplay,
								sequence : bannerRow.sequence,
								startTime : bannerRow.startTime,
								endTime : bannerRow.endTime,
								url : bannerRow.url,
								merchandiseId : bannerRow.merchandiseId,
								cityId : selectedRow[i].id,
								buttonId : bannerRow.buttonId,
								image : bannerRow.image,
						}
						records.push(row);
					}
					
					$.ajax({	
						type: "POST",
			            url: "${AppContext.ctxPath}/action/portal/banner/batchInsert",
			            data: JSON.stringify(records),
			            dataType: "json",	
			            contentType: 'application/json', 
			            success:function(data){
							if(data.success){
								$subdatagrid.hdatagrid("reload");
							}else{
								$.messager.alert("警告",data.result);
							}
						}
					});
				}
			});
		}
		
	</script>
</body>
</html>