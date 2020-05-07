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
.td-content input{
	width:180px;
}
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
	<table id="product-table" width="98%" height="200px">
			<thead>
				<tr>
					<th field="productName" width="280px" editor="{type:'textbox'}">商品名称</th>
					<th field="province" width="100px" editor="{type:'combobox',options:{
																				valueField:'areaName',
																				textField:'areaName',
																				method:'get',
																				url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
																				editable:false,
																				onSelect:selectedProvince,
																				onLoadSuccess : loadProvinceSuccess}}">省/直辖市</th>
					<th field="city" width="100px"  editor="{type:'combobox',options:{
																				valueField:'areaName',
																				textField:'areaName',
																				method:'get',
																				url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
																				onBeforeLoad:beforeSelectCity,
																				onSelect:selectedCity,
																				editable:false}}">市</th>
					<th field="district" width="100px" editor="{type:'combobox',options:{
																				valueField:'areaName',
																				textField:'areaName',
																				method:'get',
																				url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
																				onBeforeLoad:beforeSelectDistrict,
																				onSelect:selectedDistrict,
																				editable:false}}">区/县</th>

					<th field="price" width="100px" editor="{type:'numberbox',options:{
																					min:0,
																					precision:2}}">价格</th>
					<th field="comments" width="180px" editor="{type:'textbox'}">描述</th>
				</tr>
			</thead>
		</table>

	   <table id="product-detail-table" width="98%" height="55%" singleSelect="true" rownumbers="true" pagination="true">
		   <thead>
		   <tr>
			   <th field="productPicId" width="150px" >图片Id</th>
			   <th field="productPic" width="300px" formatter="linePathFormatter">图片</th>
			   <th field="productPicType" width="150px" lov="PRODUCT_PIC_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('PRODUCT_PIC_TYPE'),

																			editable:false}}">图片类型</th>
			   <th field="seq" width="200px" editor="{type:'textbox'}" >排序</th>
			   <th field="comments" width="200px" editor="{type:'textbox'}">说明</th>
		   </tr>
		   </thead>
	   </table>

	</div>

	<script type="text/javascript">
		var procutName = null;
	    $datagrid = $('#product-table');
		$subdatagrid = $('#product-detail-table');
		$datagrid.hdatagrid({
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
			nowrap:false,
			striped:true,
			border:false,
			subGridIds: ['product-detail-table'],
			url:'${AppContext.ctxPath}/action/portal/product/queryByExamplePage',
			onBeforeLoad:function(param){
				if(procutName != null && procutName != ''){
		    		param.procutName = procutName;
				}
			},
			

			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/product/upsert",row,
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
						$.post('${AppContext.ctxPath}/action/portal/product/deleteById', {
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
			}
		});

		$subdatagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:true,
			newDefaultValue:false,
			title:'商品明细',
			oauthFlag:true,
			border:false,
			pageSize: 10,
			pageList: [5,10,15],
			url:'${AppContext.ctxPath}/action/portal/productDetail/queryByExamplePage',
			parentGridId : 'product-table',
			parentGridField : 'id',
			linkGridField : 'productId',
			onLoadSuccess: function (data) {
				//调用图片展示组件
				$('div.small_pic a').fancyZoom();
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				row.productId = $datagrid.datagrid('getSelected').id;
				$.post("${AppContext.ctxPath}/action/portal/productDetail/upsert",row,
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
						$.post('${AppContext.ctxPath}/action/portal/productDetail/deleteById', {
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
				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="productId" name="productId"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			}
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
			$('#productId').val(row.id);
			var options = {
				url:'${AppContext.ctxPath}/action/portal/productDetail/uploadImg',
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

		
		function linePathFormatter(val,row){
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A + row.productPic + imgUrl_B;
			}
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}



		//初始化选择城市

		function beforeSelectCity(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			if(province == null || province == ''){
				param.parentAddrName='noMatchId';
			}else{
				param.parentAreaName=province;
			}
		}

		//初始化选择区/县
		function beforeSelectDistrict(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			var city = $datagrid.hdatagrid('getCurrentRow').city;
			if(province == null || province == ''){
				param.parentAreaName2='noMatchId';
			}else{
				param.parentAreaName2=province;
			}
			if(city == null || city == ''){
				param.parentAreaName='noMatchId';
			}else{
				param.parentAreaName=city;
			}
		}


		//选择省份
		function selectedProvince(selectRow){
			//alert(selectRow.id);
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.areaName;
			$datagrid.hdatagrid('getCurrentRow').city = '';
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').provinceId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').cityId = '';
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('setValue','');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');

		}
		function loadProvinceSuccess(){

		}
		//城市
		function selectedCity(selectRow){
			$datagrid.hdatagrid('getCurrentRow').city = selectRow.areaName;
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
		}
		function selectedDistrict(selectRow){
			$datagrid.hdatagrid('getCurrentRow').districtId = selectRow.id;
		}

		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}

	</script>
</body>
</html>