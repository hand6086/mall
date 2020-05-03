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

<!-- <body class="easyui-layout" data-options="fit:true" border="false"> -->
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
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
	
	<table id="prod-table"  keyFilterDiv="keyFilter"   height="100%" width="$(window).width() - 18" >
	<thead>
		<tr>
			<th field="prodImagePath" width="100px" formatter="imageFormatter">产品图片</th> 
			<th field="prodCode" width="100px" editor="{type:'textbox'}" sortable="true"  formatter="prodNumFormatter">产品编码</th>
			<th field="prodName" width="100px" defaultSearch="true" editor="{type:'textbox'}">产品名称</th>
			<th field="prodModelName" width="150px"  editor="{type:'picklistbox',options:{title:'选择产品型号',completeFun:prodModelPickListComplete,tableUrl:'${AppContext.ctxPath}/portal/product/picklist/ProdModelPickList.jsp'}}">产品型号</th>
			<th field="prodUnit" width="100px" lov="PROD_UNIT" editor="{type:'combobox',
													  options:{valueField:'val',
													  textField:'name',
													  data:getLovArray('PROD_UNIT'),
													  editable:false,
															required:true}}">单位</th>
			<th field="prodMatSeries" width="100px" lov="PROD_MAT_SERIES" editor="{type:'combobox',
													  options:{valueField:'val',
													  textField:'name',
													  method:'post',
													  data:getLovArray('PROD_MAT_SERIES'),
													  editable:false,
															required:true}}">产品系列</th>
		    <th field="prodBrand" width="100px" lov="PROD_BRAND" editor="{type:'combobox',
													  options:{valueField:'val',
													  textField:'name',
													  data:getLovArray('PROD_BRAND'),
													  editable:false}}">品牌</th>
		    <th field="prodStandard" width="100px" editor="{type:'textbox'}">产品规格</th>
		    <th field="prodStyle" width="100px" lov="PROD_STYLE" editor="{type:'combobox',
													  options:{valueField:'val',
													  textField:'name',
													  data:getLovArray('PROD_STYLE'),
													  editable:false}}">风格</th>
			<th field="prodColor" width="100px" lov="COLOR" editor="{type:'combobox',
													  options:{valueField:'val',
													  textField:'name',
													  method:'post',
													  data:getLovArray('COLOR'),
													  editable:false,}}">产品颜色</th>
		    <th field="prodSpace" width="100px" lov="PROD_SPACE" editor="{type:'combobox',
													  options:{valueField:'val',
													  textField:'name',
													  data:getLovArray('PROD_SPACE'),
													  editable:false}}">空间</th>
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
			<th field="cumulateSale" width="100px">累计销量</th>
						
		</tr>
	</thead>
</table>
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<!-- 	
		<div data-options="region:'center',split:true" border="false">
			<div class="easyui-tabs" data-options="fit:true" border="false"
				style="height: 300px; width: 100%;">
				<div title="产品展示图片">
					<table id="prod-pic-table" fit="true"
						style="height: 300px; width: 100%;">
						<thead>
							<tr>
								<th field="attachmentOriginal" width="20%" formatter="imageFormatterPic">附件名称</th>
								<th field="attachmentSize" width="20%">大小（字节）</th>
								<th field="created" width="20%">上传时间</th>
								<th field="comments" width="30%">备注</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		 -->
	</div>
</div>
	<!-- 弹出窗 -->
    <div id="popWin" class="crmWin" style="width:100%; height:100%">
    <iframe src=""  id="popWinFram" name=popWinFram width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
	<script type="text/javascript">
		$popWin = $("#popWin");
		$popWinFram = $("#popWinFram");
		$datagrid = $('#prod-table');
		//$datagridpic = $('#prod-pic-table');
		getLovOfList("[PROD_UNIT,PROD_MAT_SERIES,S_IF,PRODUCT_TOP_CATEGORY,PRODUCT_SEC_CATEGORY,PROD_GOOD_TYPE]");
		
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
			url:'${AppContext.ctxPath}/action/portal/product/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="productId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
			},
			onChangeSelectedItem:function(row){
				//$datagridpic.hdatagrid("changeParentItemAndParams",{headId:row.id});
			},
			/* buttonBatchEdit : true,
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
			}, */				
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
					prodColor			: row.prodColor,
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
		/*
		$datagridpic.hdatagrid({
			toolbarShow:true,
			buttonDelete:true,
			url:'${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(39,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openUploadAttachment(\'payClctActual\')">新建</a>',that);
				addButtonFun(39,'<div style = "width:78px;display:inline-block"> <form id="formPic" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton filePic" iconCls="icon-add" plain="true">上传图片 <input type="hidden"  id="parentProdId" name="headId"/><input type="hidden" name="moduleType" value="noType"/>'+"<input type='file' id='filePic' name='uploadAttachment'/></a></form></div>",that);
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/attachment/deleteById', {
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
		*/
		
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
		
		function imageFormatterPic(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.attachmentPath +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		/* 产品型号picklist关闭刷新 */
		function prodModelPickListComplete(selectRow){
			/* var row = $datagrid.datagrid('getSelected');
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
			} */

			$datagrid.hdatagrid('getCurrentRow').prodModelId = selectRow.id;
			return selectRow.modelName;
		}
		
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
		
		/**
		 * 产品详细信息跳转
		 */
		function prodDetailsFormatter(val,row,index){
			if(row.row_status == 'NEW'){
				return '';
			}
			return '<a href="${AppContext.ctxPath}/portal/product/ProdDetailsEdit.jsp?id='+row.id+'" target="_blank">查看</a>';
		}
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
		});
		
		$(".filePic").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alter("请选中要上传的产品信息！");
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
		});
	/* 
		function selectSecCate(selectRow){
			
		} 
	 */
	 
		function prodNumFormatter(val, row) {
			if (val != null) {
				var content = "产品编号:" + row.prodCode + "\n产品名称:" + row.prodName;
			    return "<a class='easyui-tooltip' title='"
			    		+content+
			    		"' href='javascript:void(0)' onclick='windowShow(\""+row.id+"\")'>" + val + "</a>";
			}
		}
		/**
		* 点击表格行超链接，弹出窗口
		* @id 产品id
		*/
		function windowShow(id){
 			if(id){
				$.post("${AppContext.ctxPath}/action/portal/product/queryById", {id:id}, function(data){
					if(data.success){
						var product = data.result;
						$popWinFram.attr("src", "${AppContext.ctxPath}/portal/product/ProductDetail.jsp");
						$popWinFram[0].onload = function() {
							$popWinFram[0].contentWindow.prodInfoInit(id, data.result);//等待窗口加载完毕
						}
						$popWin.css("display", "block");
					}
				});
				
			}else{
				$.messager.alert("错误", "请传入正确参数", "error");
			} 
			/* $("#editWin2").css("display", "block");
			if(!$("#editWinFram2").attr("src"))
				$("#editWinFram2").attr("src", "${AppContext.ctxPath}/portal/order/InterSaleOrderInfoNew2.jsp"); */
		}
		/**
		* 关闭弹出窗口
		*/
		function popWinClose(operate,prod){
			$popWin.css("display", "none");
			if(operate == "CANCEL"){
				return;
			}
			if(!prod){
				$.messager.alert("警告", "获取新数据失败，请刷新数据", "warning");
				return;
			}
			if(operate == "NEW"){
				//$datagrid.datagrid('rejectChanges');
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.datagrid('getRowIndex', row);
				$datagrid.datagrid('insertRow',{index: index, row: prod});	
				$datagrid.datagrid('acceptChanges');
				$datagrid.datagrid("selectRow", index);
			}else if(operate == "UPDATE"){
				//关闭编辑窗口时刷新编辑后数据
				//$datagrid.datagrid('rejectChanges');
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.hdatagrid('getRowIndex', row);
				$datagrid.datagrid('updateRow', {index: index, row:prod});
				$datagrid.datagrid('acceptChanges');
			}else{
				$.messager.alert("警告", "无法识别操作，刷新数据失败！", "warning");
			}
		}
	</script>
</body>
</html>