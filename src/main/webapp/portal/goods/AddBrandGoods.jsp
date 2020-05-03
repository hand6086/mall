<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 95%;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}

.table-block tr{
	height:40px;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}

</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" border="false" style="width:100%;height:100%;">
			<form id="brandGoodsForm" method="post">
				<table class="form-table">
					<tr>
						<td>
							<h2 style="margin-bottom: 10px;">商品基本信息</h2>
							<fieldset style="width: 100%"><legend></legend></fieldset>
							<table class="form-table">
								<tr>
									<td>
										<table class="table-block" >
											<tr>
												<td class="td-label"><label>商品名称 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-validatebox" id="o2oDisplayName" name="o2oDisplayName" data-options="required:true"/>
								         		</td>
								         		
								         		<td class="td-label"><label>商品69码 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-validatebox" id="productCode" name="productCode"/>
								         		</td>
												
								         		
								         		<td class="td-label"><label>商品分类 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-combobox" id="goodsTypeId" name="goodsTypeId"/>
								         		</td>
											</tr>							
											<tr>
												<td class="td-label"><label>产地 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-validatebox" id="prduceAddr" name="prduceAddr" data-options="required:true"/>
								         		</td>
								         		
								         		<td class="td-label"><label>商品品牌：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-validatebox" id="brand" name="brand" data-options="required:true"/>
								         		</td>
											</tr>
											
											<tr>
												<td class="td-label"><label>包装方式 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-validatebox" id="o2oStorageMethod" name="o2oStorageMethod" data-options="required:true"/>
								         		</td>
								         		
								         		<td class="td-label"><label>包装数量 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-numberbox" id="packageCount" name="packageCount" data-options="required:true"/>
								         		</td>
											</tr>
											<tr>
												<td class="td-label"><label>48小时发货时间承诺：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-combobox" id="timePromise" name="timePromise" value="N" data-options="required:true"/>
								         		</td>
								         		
								         		<td class="td-label"><label>7天无理由退换货：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-combobox" id="noReasonReturnGoods" value="N" name="noReasonReturnGoods" data-options="required:true"/>
								         		</td>
								         		
								         		<td class="td-label"><label>假一赔十 ：</label></td>
								         		<td class="td-content">
								         			<input class="easyui-combobox" id="compensateGoods" value="N" name="compensateGoods" data-options="required:true"/>
								         		</td>
											</tr>
											
										</table>
									</td>
								</tr>
							</table>
							<fieldset style="width: 100%;margin-bottom: 10px;"><legend></legend></fieldset>
					</td>
				</tr>
				
				<tr>	
					<td>
						<h2 style="margin-bottom: 10px;">商品规格属性 &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" onclick="openProdNormsWin()" class="easyui-linkbutton add" plain="true">添加</a></h2>  
					</td>
				</tr>
				<tr>
					<td>
						<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:150px;padding:0px;" fit="true">
						    <table id="prod-norms-table" singleSelect="true" rownumbers="false" pagination="true" fit="false" height="100%">
							<thead>
								<tr>
									<th field="prodNormName" width="50%" >参数名称</th>
									<th field="prodNormVal" width="50%" >参数值</th>
									<th field="prodId" hidden="true">商品ID</th>
							   	</tr>
							</thead>
						</table>
						</div>
					</td>
				</tr>
				
				
				<tr>	
					<td>
						<table class="table-block" >
							<tr>
				         		<td>
									<h2 style="margin-bottom: 10px;margin-top:10px;">商品图片 &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" onclick="openProdPicWin()" class="easyui-linkbutton add" plain="true">添加</a></h2>  
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:300px;padding:0px;" fit="true">
						    <table id="pic-table" singleSelect="true" rownumbers="false" pagination="true" fit="false" height="100%">
							<thead>
								<tr>
									<th field="linePath" width="250px" formatter="linePathFormatter">商品图片</th>
									<th field="isDisplay" width=25% lov="Is_Display">是否显示</th>
									<th field="displaySeq" width=25% >显示顺序</th>
									<th field="tAttr01" width=20% lov="PIC_TYPE">图片类型</th>
									<th field="prodId" hidden="true">商品ID</th>
							   	</tr>
							</thead>
						</table>
						</div>
					</td>
				</tr>
				
				<tr>	
					<td>
						<h2 style="margin-bottom: 10px;">商品销售信息</h2>
						<fieldset style="width: 100%"><legend></legend></fieldset>
						<table class="table-block" >
							<tr>
								<td class="td-label"><label>市场价 ：</label></td>
				         		<td class="td-content">
				         			<input class="easyui-numberbox" id="originalPrice" name="originalPrice" data-options="required:true,precision:2"/>
				         		</td>
				         		
				         		<td class="td-label"><label>库存 ：</label></td>
				         		<td class="td-content">
				         			<input class="easyui-numberbox" id="goodsStock" name="goodsStock" data-options="required:true"/>
				         		</td>
							</tr>							
							<tr>
								<td class="td-label"><label>一口价 ：</label></td>
				         		<td class="td-content">
				         			<input class="easyui-numberbox" id="historyPrice" name="historyPrice" data-options="required:true,precision:2"/>
				         		</td>
								<td class="td-label"><label>商品卖点说明 ：</label></td>
				         		<td class="td-content">
				         			<input class="easyui-validatebox" id="goodsComments" name="goodsComments" data-options="required:true"/>
				         		</td>
							</tr>
							<tr>
								<td class="td-label"><label>店铺排位 ：</label></td>
				         		<td class="td-content">
				         			<input class="easyui-numberbox" id="shopOrder" name="shopOrder" data-options="required:true"/>
				         		</td>
				         		
				         		<td class="td-label"><label>运费模板：</label></td>
				         		<td class="td-content">
				         			<input id="templateId" hidden="true" name="templateId"/>
				         			<input class="easyui-picklistbox" id="templateName" name="templateName"/>
				         		</td>
							</tr>
						</table>
						<fieldset style="width: 100%;margin-bottom: 10px;"><legend></legend></fieldset>
					</td>
				</tr>
				</table>
				
				<input id="id" name="id" hidden/>
			</form>
			<div>
				<center>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-save" id="id-save" plain="true" onclick="saveBrandGoods()">保存</a>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-ok" id="id-ok" plain="true" onclick="commitBrandGoods()">提交</a>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-cancel" id="id-cancell" plain="true" onclick="cancel()">取 消</a>
				</center>
			</div>
		</div>
	</div>
	
	<!-- 商品规格弹出框 -->
    <div id="prodNormsWin" class="easyui-dialog" title="商品规格参数" 
    	data-options="modal:true,
    		closed:true,
    		resizable:false,
    		minimizable:false,
    		maximizable:false,
    		buttons:[{text:'确定',handler:function(){
    		$prodNormsWin.dialog('close');
    		$prodNormsWinForm.attr('src','')}}]" style="width:80%;height:80%">
    		<iframe src="" id="prodNormsWinForm" name="prodNormsWinForm" width="100%" height="98%" frameborder="0"></iframe>
    </div>
    
    <!-- 商品图片弹出框 -->
    <div id="prodPicWin" class="easyui-dialog" title="商品图片" 
    	data-options="modal:true,
    		closed:true,
    		resizable:false,
    		minimizable:false,
    		maximizable:false,
    		buttons:[{text:'确定',handler:function(){
    		$prodPicWin.dialog('close');
    		$prodPicWinForm.attr('src','')}}]" style="width:80%;height:80%">
    		<iframe src="" id="prodPicWinForm" name="prodPicWinForm" width="100%" height="94%" frameborder="0"></iframe>
    		<h5 style="text-align: center;font-size: 14px !important;font-weight: 800 !important;font-family: '微软雅黑' !important;color: red;">为保证显示效果，请维护白底的商品图片</h5>
    </div>
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<script type="text/javascript">
	var prodId = "";
	var goodsStatus = "";
	var saleStatus = "";
	var storeDisplay="";
	$prodNormsWin = $("#prodNormsWin");
	$prodNormsWinForm = $("#prodNormsWinForm");
	$prodPicWin = $("#prodPicWin");
	$prodPicWinForm = $("#prodPicWinForm");
	$compensateGoods = $("#compensateGoods");// 假一赔十
	$noReasonReturnGoods = $("#noReasonReturnGoods");//7天无理由退换货
	$timePromise = $("#timePromise");//发货时间承诺
	$goodsTypeId = $("#goodsTypeId");// 商品分类
	$templateName = $("#templateName");// 模板
	$goodsStatus = $("#goodsStatus");// 商品状态 
	$brandGoodsForm = $("#brandGoodsForm");
	var row_status = "";
	
	function addInfoInit(refreshDatagrid){
		$.post("${AppContext.ctxPath}/action/portal/goods/getNewId",{},
			function(data){
				if(data){
					if(data.success){
						prodId=data.id;
						$('#id').val(data.id);
						$goodsStatus.combobox('setValue', '编辑中');
						row_status = "NEW";
						
						goodsStatus = 'EDIT';
						
						// 加载规格属性信息
						$promsdatagrid = $('#prod-norms-table');
						$promsdatagrid.hdatagrid({
							newDefaultValue:true,
							pageSize: 5,//每页显示的记录条数，默认为20 
						    pageList: [5,10,30],//可以设置每页记录条数的列表 
						    url:'${AppContext.ctxPath}/action/portal/prodNorms/queryByExamplePage',
							onBeforeLoad:function(param){
								param.prodId = prodId;
							},
						});
						
						
						$picdatagrid = $('#pic-table');
						$picdatagrid.hdatagrid({
							newDefaultValue:true,
							pageSize: 5,//每页显示的记录条数，默认为20 
						    pageList: [5,10,30],//可以设置每页记录条数的列表 
						    url:'${AppContext.ctxPath}/action/portal/goodsPic/queryByExamplePage',
							onBeforeLoad:function(param){
								param.prodId = prodId;
								param.brandQuery = '1';
							},
							onLoadSuccess: function (data) {
					            //调用图片展示组件
					            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
					        },
						});
							
					}else{
						alert("获取ID失败！");
					}
				}
			});
		if(refreshDatagrid){
		}
	}
	
	function datailInfoInit(goodsId, refreshDatagrid){
		if(!goodsId){
			$.messager.alert("错误","参数错误, 无法获取商品id", "error");
			return;
		}else if(goodsId == "current"){
			goodsId = initGoodsId;
		}
		initGoodsId = goodsId;
		var obj = {};
		$.post("${AppContext.ctxPath}/action/portal/goods/queryById",{id:initGoodsId,brandQuery:'1'},
			function(data){
				if(data){
					if(data.success){
						obj = data.result;
						row_status = "UPDATE";
						$brandGoodsForm.form("load", obj);
						prodId=obj.id;
						// 判断是否为编辑状态
						if('EDIT' != obj.goodsStatus && 'REFUSED' != obj.goodsStatus && !('APPROVED' == obj.goodsStatus && 'WAIT_FOR_SALES' == obj.saleStatus)){
							$('#id-save').attr("hidden", true);
							$('#id-ok').attr("hidden", true);
						}
						goodsStatus = obj.goodsStatus;
						saleStatus = obj.saleStatus;
						
						
						// 加载规格属性信息
						$promsdatagrid = $('#prod-norms-table');
						$promsdatagrid.hdatagrid({
							newDefaultValue:true,
							pageSize: 5,//每页显示的记录条数，默认为20 
						    pageList: [5,10,30],//可以设置每页记录条数的列表 
						    url:'${AppContext.ctxPath}/action/portal/prodNorms/queryByExamplePage',
							onBeforeLoad:function(param){
								param.prodId = prodId;
							},
						});
						
						$picdatagrid = $('#pic-table');
						$picdatagrid.hdatagrid({
							newDefaultValue:true,
							pageSize: 5,//每页显示的记录条数，默认为20 
						    pageList: [5,10,30],//可以设置每页记录条数的列表 
						    url:'${AppContext.ctxPath}/action/portal/goodsPic/queryByExamplePage',
							onBeforeLoad:function(param){
								param.prodId = prodId;
								param.brandQuery = '1';
							},
							onLoadSuccess: function (data) {
					            //调用图片展示组件
					            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
					        },
						});
					}
				}
			});
		if(refreshDatagrid){
		}
	}
	
	
	function saveBrandGoods(){
		var home_pic_flag = false; // 商品主页图
		var banner_pic_flag = false;//商品轮播图
		var contraction_pic_flag = false;//商品缩略图
		var options = {
				url : '${AppContext.ctxPath}/action/portal/goods/upsert',
				type : 'post',
				dataType :'json',
				data: {row_status : row_status, goodsStatus:'EDIT'},
				beforeSubmit: function() {
					var result = $brandGoodsForm.form('validate');
					return result;
				},  
				success : function(data) {
					if (data.success) {
						window.parent.closeAddBrandGoodsWin('ok');
						window.parent.$datagrid.hdatagrid('reload');
						window.parent.operationtip('保存成功！', 'info');
					} else {
						$(".save").attr("disabled", false);
					}
				}
			};
		// 查询图片
		$.post("${AppContext.ctxPath}/action/portal/goodsPic/queryByExamplePage",
			{prodId:prodId,pageFlag:false},
			function(data){
				if(data){
					if(data.success){
						if(data.rows != null && data.rows.length > 0){
							for(var i = 0; i < data.rows.length; i++){
								if('home_pic' == data.rows[i].tAttr01){
									home_pic_flag = true;
								}
								if('banner_pic' == data.rows[i].tAttr01){
									banner_pic_flag = true;
								}
								if('contraction_pic' == data.rows[i].tAttr01){
									contraction_pic_flag = true;
								}
							}
						}
						
						if(home_pic_flag == false){
							window.parent.operationtip('请维护商品主页图！', 'error');
							return;
						}
						if(banner_pic_flag == false){
							window.parent.operationtip('请维护商品轮播图！', 'error');
							return;
						}
						if(contraction_pic_flag == false){
							window.parent.operationtip('请维护商品缩率图！', 'error');
							return;
						}
						$brandGoodsForm.ajaxSubmit(options);
					} 
				}
			});
		
	}
	//提交的函数
	function commitBrandGoods(){
		var home_pic_flag = false; // 商品主页图
		var banner_pic_flag = false;//商品轮播图
		var contraction_pic_flag = false;//商品缩略图
		
		var options = {
				url : '${AppContext.ctxPath}/action/portal/goods/upsert',
				type : 'post',
				dataType :'json',
				data: {row_status : row_status, goodsStatus:'PENDING',storeDisplay:'Y'},
				beforeSubmit: function() {
					var result = $brandGoodsForm.form('validate');
					return result;
				},  
				success : function(data) {
					if (data.success) {
						window.parent.closeAddBrandGoodsWin('ok');
						window.parent.$datagrid.hdatagrid('reload');
						window.parent.operationtip('提交成功！', 'info');
					} else {
						$(".save").attr("disabled", false);
					}
				}
			};
		
		// 查询图片
		$.post("${AppContext.ctxPath}/action/portal/goodsPic/queryByExamplePage",
			{prodId:prodId,pageFlag:false},
			function(data){
				if(data){
					if(data.success){
						if(data.rows != null && data.rows.length > 0){
							for(var i = 0; i < data.rows.length; i++){
								if('home_pic' == data.rows[i].tAttr01){
									home_pic_flag = true;
								}
								if('banner_pic' == data.rows[i].tAttr01){
									banner_pic_flag = true;
								}
								if('contraction_pic' == data.rows[i].tAttr01){
									contraction_pic_flag = true;
								}
							}
						}
						
						if(home_pic_flag == false){
							window.parent.operationtip('请维护商品主页图！', 'error');
							return;
						}
						if(banner_pic_flag == false){
							window.parent.operationtip('请维护商品轮播图！', 'error');
							return;
						}
						if(contraction_pic_flag == false){
							window.parent.operationtip('请维护商品缩率图图！', 'error');
							return;
						}
						
						$brandGoodsForm.ajaxSubmit(options);
					}
				}
			});
	}
	
	$templateName.picklist({
		title:'选择模板',
		completeFun:function(selectRow){
			$('#templateId').val(selectRow.id);
			return selectRow.name;
		},
		tableUrl:'${AppContext.ctxPath}/portal/goods/product/freightPickList.jsp'
	});
	
	
	function openProdNormsWin(){
		$prodNormsWinForm.attr("src","");
		$prodNormsWinForm.attr("src","${AppContext.ctxPath}/portal/goods/product/prodNorms.jsp?prodId="+prodId +"&goodsStatus="+goodsStatus+"&saleStatus="+saleStatus);
		$prodNormsWin.dialog('open');
	}
	
	function openProdPicWin(){
		$prodPicWinForm.attr("src","");
		$prodPicWinForm.attr("src","${AppContext.ctxPath}/portal/goods/product/productPictList.jsp?prodId="+prodId+"&goodsStatus="+goodsStatus+"&saleStatus="+saleStatus);
		$prodPicWin.dialog('open');
	}
	
	
	$goodsTypeId.combobox({ 
	    method:'get',
	    url:'/action/portal/classify/brandClassifyList',
		valueField:'id',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$compensateGoods.combobox({ 
	    method:'get',
		data:getLovArray('CUS_FAKE_PRO'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$noReasonReturnGoods.combobox({ 
	    method:'get',
		data:getLovArray('CUS_RETURN_PRO_7'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$timePromise.combobox({ 
	    method:'get',
		data:getLovArray('DE_TIME_COMMITMENT'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	
	$goodsStatus.combobox({ 
	    method:'get',
		data:getLovArray('PRO_STATUS'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	

	
	/*
	* 关闭窗口
	*/
	function cancel(){
		window.parent.closeAddBrandGoodsWin();
	}
	
	function linePathFormatter(val,row)
	{   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A + row.linePath +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
	
	</script>

</body>
</html>