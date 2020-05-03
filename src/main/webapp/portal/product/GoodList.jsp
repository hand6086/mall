<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>

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

<body >
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north'" border="false" style="width: 100%; height: 50%; padding: 0px;">
			<fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">产品筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<ul id="prodGroupKeyfilter" data-toggle="keyfilter"
						data-title="产品系列" data-filter-filed="prodMatSeries"
						data-table-Id="prod-table">
					</ul>
				</div>
			</fieldset>
			<table id="prod-table"  keyFilterDiv="keyFilter" fit="true">
				<thead>
					<tr>
						<th field="prodImagePath" width="100px" formatter="imageFormatter">产品图片</th> 
						<th field="prodCode" width="100px" editor="{type:'textbox'}" sortable="true">产品编码</th>
						<th field="prodName" width="100px" defaultSearch="true" editor="{type:'textbox'}">产品名称</th>
						<th field="factoryPrice" width="100px" currency="CNY" editor="{type:'textbox'}">出厂价</th>
						<th field="price" width="100px" currency="CNY" editor="{type:'textbox'}">销售价</th>
						<th field="promoPrice" width="100px" currency="CNY" editor="{type:'textbox'}">促销价</th>
						<th field="prodModelName" width="150px"  editor="{type:'picklistbox',options:{title:'选择产品型号',completeFun:prodModelPickListComplete,tableUrl:'${AppContext.ctxPath}/portal/product/picklist/ProdModelPickList.jsp'}}">产品型号</th>
						<th field="prodUnit" width="100px" lov="PROD_UNIT" editor="{type:'combobox',
																  options:{valueField:'val',
																  textField:'name',
																  data:getLovArray('PROD_UNIT'),
																  editable:false,required:true}}">单位</th>
						<th field="prodMatSeries" width="100px" lov="PROD_MAT_SERIES" editor="{type:'combobox',
																  options:{valueField:'val',
																  textField:'name',
																  method:'post',
																  data:getLovArray('PROD_MAT_SERIES'),
																  editable:false,
																		required:true}}">产品系列</th>
					    <th field="prodGoodType" width="80px" lov="PROD_GOOD_TYPE" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('PROD_GOOD_TYPE'),
																		editable:false,
																		required:true}}" sortable="true">产品类型</th>
						<th field="isEffective" width="50px" lov="S_IF" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('S_IF'),
																		editable:false,
																		required:true}}" sortable="true">是否有效</th>
																		
					    <th field="topCate" width="80px" lov="PRODUCT_TOP_CATEGORY" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('PRODUCT_TOP_CATEGORY'),
																		onSelect:selectTopCate,
																		editable:false,
																		required:false}}" >一级分类</th>
					    <!-- <th field="secCate" width="80px" lov="PRODUCT_SEC_CATEGORY" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('PRODUCT_SEC_CATEGORY'),
																		editable:false,
																		required:false}}" sortable="true">二级分类</th> -->
					    <th field="secCate" width="80px" lov="PRODUCT_SEC_CATEGORY" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		onBeforeLoad:beforLoadSecCate,
																		url:'${AppContext.ctxPath}/action/portal/product/queryProdCategory',
																		editable:false,
																		required:false}}" sortable="true">二级分类</th>
						
						<th field="comments" width="100px" editor="{type:'textbox'}">产品描述</th>
						
						<th field="tagName" width="140px" editor="{
										type:'mvgPickbox',
										options:{
											title:'标签',completeFun:tagMvgPickComplete,
											mvgMapperName:'productTag',
											tableId:'prod-table',
											optionsLeft:{
												tableUrl:'${AppContext.ctxPath}/portal/product/mvgPick/TagLeftMvgPick.jsp',
												initParam:tagMvgPickParam
											}
										}
									}">标签</th>
								
						<th field="tagId" hidden="true">标签ID</th>
						<th field="prodDetails" width="100px" formatter="prodDetailsFormatter">详细信息</th>
									
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'center'" border="false" style="width: 100%; height: 50%; padding: 0px;">
			<table id="goodsItem-table" fit="true">
				<thead>
					<tr>
						<th field="prodCode" width="100px">产品编码</th>
						<th field="prodName" width="200px"  editor="{type:'picklistbox',options:{title:'选择产品',
	   			   																		     completeFun:prodPickListComplete,
	   			   																		     tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp',
		   			   																		 required:true}}">产品名称</th>
						<th field="goodsAttr1" width="100px" lov="GOODS_COLOR" editor="{type:'combobox',
																				options:{valueField:'val',
																					textField:'name',
																					data:getLovArray('GOODS_COLOR'),
																					editable:false,
																					required:false}}">颜色</th>
						<th field="goodsAttr2" width="100px" lov="GOODS_MATERIAL" editor="{type:'combobox',
																					options:{valueField:'val',
																							textField:'name',
																							data:getLovArray('GOODS_MATERIAL'),
																							editable:false,
																							required:false}}">材质</th>
						<th field="goodsAttr3" width="100px" lov="GOODS_SPECIFICATION" editor="{type:'combobox',
																					options:{valueField:'val',
																							textField:'name',
																							data:getLovArray('GOODS_SPECIFICATION'),
																							editable:false,
																							required:false}}">规格</th>
						<th field="goodsAttr4" width="100px" editor="{type:'validatebox'}">备用字段4</th>
						<th field="goodsAttr5" width="100px" editor="{type:'validatebox'}">备用字段5</th>
						<th field="goodsAttr6" width="100px" editor="{type:'validatebox'}">备用字段6</th>
						<th field="goodsAttr7" width="100px" editor="{type:'validatebox'}">备用字段7</th>
						<th field="goodsAttr8" width="100px" editor="{type:'validatebox'}">备用字段8</th>
						<th field="goodsAttr9" width="100px" editor="{type:'validatebox'}">备用字段9</th>
						<th field="goodsAttr10" width="100px" editor="{type:'validatebox'}">备用字段10</th>
		
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<div id="prod-details"></div>
	<script type="text/javascript">
		getLovOfList("[PROD_UNIT,PROD_MAT_SERIES,S_IF,PRODUCT_TOP_CATEGORY,PRODUCT_SEC_CATEGORY,PROD_GOOD_TYPE,GOODS_COLOR,GOODS_MATERIAL,GOODS_SPECIFICATION]");
		$datagrid = $('#prod-table');
		$dataItemGrid = $('#goodsItem-table');
		$dataItemGrid.hdatagrid({
			title:'商品属性',
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			buttonExport : true,
			buttonImport : true,
			parentGridId : 'prod-table',
		    parentGridField : 'id',
		    linkGridField : 'headId',
			url:'${AppContext.ctxPath}/action/portal/goodsItem/queryByExamplePage',
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/goodsItem/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/goodsItem/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/goodsItem/deleteById', {
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
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName,
					headId : $datagrid.datagrid('getSelected').id
				};
			}
		});
		/**
		 * 产品picklist回调事件
		 */
	 	function prodPickListComplete(selectRow){
	 		$dataItemGrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
	 		return selectRow.prodName;
	 	};
	 	
	 	
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			newDefaultValue:true,
			subGridIds: ['goodsItem-table'],
			url:'${AppContext.ctxPath}/action/portal/product/queryGoodsByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="productId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/product/batchUpdate",
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/product/upsert',{
					row_status  	: row.row_status,
					id              : row.id,
					prodImgId       : row.prodImgId,
					prodCode        : row.prodCode,
					prodName        : row.prodName,
					prodMatSeries   : row.prodMatSeries,
					prodVolume      : row.prodVolume,
					prodUnit        : row.prodUnit,
					prodModelId     : row.prodModelId,
					prodModelName   : row.prodModelName,
					factoryPrice    : row.factoryPrice,
					price           : row.price,
					promoPrice      : row.promoPrice,
					isEffective     : row.isEffective,
					prodGoodType	: row.prodGoodType,
					comments        : row.comments,
					topCate		    : row.topCate,
					secCate			: row.secCate,
					tagId			: row.tagId,
					prodBrand		: row.prodBrand,
					prodStandard	: row.prodStandard,
					prodStyle		: row.prodStyle,
					prodSpace		: row.prodSpace,
				},function(data){
					if (!data.success) {
						errFun(data.result,that);
					} else {
						successFun(that, data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
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
			},
			onLoadSuccess:function(data){
				//调用图片展示组件
				$('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
		   }
		});

		$('#prodGroupKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/PROD_MAT_SERIES'
		});
		
		function imageFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.prodImagePath +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		/* 产品型号picklist关闭刷新 */
		function prodModelPickListComplete(selectRow){
			var row = $datagrid.datagrid('getSelected');
			if(row.id == 'noMatchId' || row.id == null || row.id == ''){
				row.prodModelId = selectRow.id
				return selectRow.modelName;
			}else{
				$.post('${AppContext.ctxPath}/action/portal/product/prodModelUpdate',{
					preObjId:row.id,
					rearObjId:selectRow.id
				},
				function(data){
					if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}	
					$datagrid.datagrid('reload');
				});
			}
		}
		
		/**
		 * 产品详细信息跳转
		 */
		function prodDetailsFormatter(val,row,index){
			if(row.row_status == 'NEW'){
				return '';
			}
			return '<a href="${AppContext.ctxPath}/portal/product/ProdDetailsEdit.jsp?id='+row.id+'" target="_blank">查看</a>';
		}
		
		$(".file").change(function(){
			var row = $datagrid.datagrid('getSelected');
			$('#productId').val(row.id);
			if($('#productId').val()){
				var options = {
		   			url:'${AppContext.ctxPath}/action/portal/product/uploadImg',
		   			type:'post',
		   			dataType:'json',
		   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
		   			success : function(data) {
		   					if(data.success){
		   						$datagrid.datagrid('reload');
		   				  	}
		   			}
		   		};
		   		$('#form').ajaxSubmit(options);
			}
		})
		
		function beforLoadSecCate(param){
			var topCate = $datagrid.hdatagrid('getCurrentRow').topCate;
			param.parentVal=topCate;
			param.cateType='PRODUCT_SEC_CATEGORY';
	 	}	
	 
		function selectTopCate(selectRow){
			/* alert(selectRow.val); */
			$datagrid.hdatagrid('getCurrentRow').secCate = '';
			$datagrid.hdatagrid('getCurrentRow').topCate = selectRow.val;
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'secCate'}).target).combobox('reload');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'secCate'}).target).combobox('setValue','');
		}
		
		/**
		 * 标签mvgPick 按【确定】后执行的方法
		 */
		function tagMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.tagId = rightRowsMvg.id;
				currentRow.tagName = rightRowsMvg.tagName;
			}
			return currentRow.tagName;
		}
		/**
		 * 标签mvgPick 列表数据初始化参数
		 */
		function tagMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
		}
	</script>
</body>
</html>