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
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:180px;
}
</style>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
<body>
	<div  class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
   <fieldset class="x-fieldset" id="goodsKeyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速查询</span>
		</legend>
		<div class="row keyfilter-border">
	   		<table class="form-table">
			    <tr>
	   				<td class="td-label"><label>商品名称：</label></td>
					<td class="td-input">
						<input  class="easyui-validatebox" name="o2oDisplayName" type="text" id="o2oDisplayName" size="25" />
					</td>
					
					<td class="td-label"><label>商品69码：</label></td>
					<td class="td-input">
						<input  class="easyui-validatebox" name="productCode" type="text" id="productCode" size="25" />
					</td>
					
					<td class="td-label"><label>商品分类：</label></td>
					<td class="td-input">
						<input  class="easyui-combobox" name="goodsType" type="text" id="goodsType" size="25" />
					</td>
	   			</tr>
			    <tr>
					<td class="td-label"><label>状态：</label></td>
					<td class="td-input">
						<input  class="easyui-combobox" name="goodsStatus" type="text" id="goodsStatus" size="25" />
					</td>
					
					<td class="td-label"><label>销售状态：</label></td>
					<td class="td-input">
						<input  class="easyui-combobox" name="saleStatus" type="text" id="saleStatus" size="25" />
					</td>
	   			</tr>
	   		</table>
	   	</div>
	</fieldset>
   <table id="brand-goods-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="goodsKeyFilter">
		<thead>
			<tr>
				<th field="productCode" width="100px">商品69码</th>
				<th field="linePath" width="150px" formatter="linePathFormatter">商品图片</th>
				<th field="o2oDisplayName" width="100px" formatter="goodsNameFormatter">商品名称</th>
				<th field="goodsType" width="100px">商品分类</th>
				<th field="goodsEvaluate" width="100px">商品评价</th>
				<th field="o2oStorageMethod" width="100px">包装方式</th>
				<th field="originalPrice" width="100px">市场价</th>
				<th field="historyPrice" width="100px">一口价</th>
				<th field="storeDisplay" width="100px"lov="S_IF"
					editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('S_IF'),
																editable:false}}">店铺内是否展示</th>
				<th field="goodsStock" width="100px">库存</th>
				<th field="goodsStatus" width="100px" LOV="PRO_STATUS">状态</th>
				<th field="shopOrder" width="100px">店铺排位</th>
				<th field="saleStatus" width="100px" LOV="SALE_STATUS">销售状态</th>
				<th field="approvalResult" width="100px">审批结果</th>
				<th field="created" width="100px">创建时间</th>
				<th field="approvalTime" width="100px">审批时间</th>
				<th field="marketTime" width="100px">上架时间</th>
				<th field="lastUpdated" width="100px">最后更新时间</th>
				<th field="createdBy" width="100px">创建人</th>
				<th field="approvalBy" width="100px">审批人</th>
				<th field="publishBy" width="100px">发布人</th>
				<th field="lastUpdatedBy" width="100px">最后更新人</th>
				<th field="o2oShareUrl" width="100px">商品URL</th>
				<th field="unMarketTime" width="100px">自动下架日期</th>
				<th field="channelType" width="100px" lov="CHANNEL_TYPE" <%--editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('CHANNEL_TYPE'),
																		editable:false,
																		disabled:true}}"--%>>所属频道</th>
			</tr>
		</thead>
	</table>
	</div>
	</div>
   	<!-- 弹出窗1 -->
    <div id="brandGoodsDetailWin" class="crmWin" style="width:100%;height:100%">
    	<iframe src="" id="brandGoodsDetailWinFram" name="brandGoodsDetailWinFram" width="100%" height="100%" frameborder="0"></iframe>
    </div>
    <div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
	<script type="text/javascript">
		var o2oDisplayName = null;
		var productCode = null;
		var goodsType = null;
		var goodsStatus = null;
		var saleStatus = null;
		
		$brandGoodsDetailWin = $("#brandGoodsDetailWin");
		$brandGoodsDetailWinFram = $("#brandGoodsDetailWinFram");
	    $datagrid = $('#brand-goods-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:false,
			buttonNew:false,
			buttonDelete:false,
			buttonExport:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			nowrap:false,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/goods/queryByExamplePage',
			onBeforeLoad:function(param){
				param.channelType = 'brand';
				if(o2oDisplayName != null && o2oDisplayName != ''){
		    		param.o2oDisplayName = o2oDisplayName;
				}
				if(productCode != null && productCode != ''){
		    		param.productCode = productCode;
				}
				if(goodsType != null && goodsType != ''){
		    		param.goodsType = goodsType;
				}
				if(goodsStatus != null && goodsStatus != ''){
		    		param.goodsStatus = goodsStatus;
				}
				if(saleStatus != null && saleStatus != ''){
		    		param.saleStatus = saleStatus;
				}
			},
            onUpdateAction : function(row,successFun,errFun,that) {
                $.post('${AppContext.ctxPath}/action/portal/goods/update', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/goods/deleteById', {
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
			onSelect:function(index, row){
				buttonHandle(row.goodsStatus, row.saleStatus);
			},
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
			onInitNewData:function(that){
				return {
					vodLockedFlag: 'Y',
					vodLockedBy : appCtx.username,
					vodLockedDate : appCtx.sysdate(),
					channelType:'brand'
				};
			},
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="goodsSearch()" iconCls="icon-search" plain="true">查询</a>',that);
				addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="goodsClean()" iconCls="icon-reload" plain="true">重置</a>',that);
 				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add_id" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddBrandGoodsWin()">新建</a>',that);
 				addButtonFun(22,'<a href="javascript:void(0)" id="btn_ok_id" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="updateInfo(\'PENDING\')">提交</a>',that);
 				addButtonFun(26,'<a href="javascript:void(0)" id="btn_clear_id" class="easyui-linkbutton" iconCls="icon-clear" plain="true" onclick="updateInfo(\'EDIT\')">撤回</a>',that);
 				addButtonFun(24,'<a href="javascript:void(0)" id="btn_redo_id" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="updateSaleInfo(\'SELLING\')">上架</a>',that);
 				addButtonFun(25,'<a href="javascript:void(0)" id="btn_undo_id" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="updateSaleInfo(\'WAIT_FOR_SALES\')">下架</a>',that);
 				addButtonFun(25,'<a href="javascript:void(0)" id="btn_inactive_id" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="updateSaleInfo(\'INACTIVE\')">失效</a>',that);	
			}
		});
		
		function openAddBrandGoodsWin(){
			$brandGoodsDetailWin.css("display", "block");
			$brandGoodsDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/AddBrandGoods.jsp");
			$brandGoodsDetailWinFram[0].onload = function() {
				$brandGoodsDetailWinFram[0].contentWindow.addInfoInit("reload");
			}
		}
		
		function closeAddBrandGoodsWin(operate, newAccntId){
			$brandGoodsDetailWinFram.attr("src", "");
			$brandGoodsDetailWin.css("display", "none");
			
			
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);

			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/goods/queryById", {id: row.id}, function(data){
					if(data.success){
						$datagrid.datagrid('updateRow', {index : index, row:data.result})
						$datagrid.datagrid('acceptChanges');
						
						var nowRow = $datagrid.datagrid('getSelected');
						buttonHandle(nowRow.goodsStatus, nowRow.saleStatus);
					}else{
						$.messager.show("错误", "更新数据错误: "+data.result, "error");
					}
				});
			}
			
		}
		
		/*
		function selectedProd(selectRow){
			$datagrid.hdatagrid('getCurrentRow').o2oProdCategory = selectRow.id;
		}
		
		function prodPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').o2oProdId = selectRow.id;
			return selectRow.part;
		} */
		
		function goodsNameFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openGoodsDetailWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
		
		function openGoodsDetailWin(goodsId){
			if(!goodsId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			$brandGoodsDetailWinFram.attr("src","");
			if( !$brandGoodsDetailWinFram.attr("src") ){
				$brandGoodsDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/AddBrandGoods.jsp?goodsId="+goodsId);
				$brandGoodsDetailWinFram[0].onload = function() {
					$brandGoodsDetailWinFram[0].contentWindow.datailInfoInit(goodsId, "reload");//等待窗口加载完毕
				}
			}else{
				$brandGoodsDetailWinFram[0].contentWindow.datailInfoInit(goodsId, "reload");
			}
			$brandGoodsDetailWin.css("display", "block");
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
		
		function updateInfo(goodsStatusVal){
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);
			$.post("${AppContext.ctxPath}/action/portal/goods/upsert",
					{row_status:'UPDATE',goodsStatus:goodsStatusVal,id:row.id},function(data){
						$.post("${AppContext.ctxPath}/action/portal/goods/queryById", {id: row.id}, function(data){
							if(data.success){
								$datagrid.datagrid('updateRow', {index : index, row:data.result})
								$datagrid.datagrid('acceptChanges');
								// 处理按钮
								var nowRow = $datagrid.datagrid('getSelected');
								buttonHandle(nowRow.goodsStatus, nowRow.saleStatus);
							}else{
								$.messager.show("错误", "更新数据错误: "+data.result, "error");
							}
						});
			});
		}
		
		function updateSaleInfo(saleStatusVal){
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);
			$.post("${AppContext.ctxPath}/action/portal/goods/upsert",
					{row_status:'UPDATE',saleStatus:saleStatusVal,id:row.id},function(data){
						$.post("${AppContext.ctxPath}/action/portal/goods/queryById", {id: row.id}, function(data){
							if(data.success){
								$datagrid.datagrid('updateRow', {index : index, row:data.result})
								$datagrid.datagrid('acceptChanges');
								// 处理按钮
								var nowRow = $datagrid.datagrid('getSelected');
								buttonHandle(nowRow.goodsStatus, nowRow.saleStatus);
							}else{
								$.messager.show("错误", "更新数据错误: "+data.result, "error");
							}
						});
			});
		}
		
		// 当点击选中的时候按钮的处理
		function buttonHandle(status, saleStatus){
			
			$('#btn_ok_id').attr("hidden", true);
			$('#btn_redo_id').attr("hidden", true);
			$('#btn_undo_id').attr("hidden", true);
			$('#btn_clear_id').attr("hidden", true);
			$('#btn_inactive_id').attr("hidden", true); 
			
			// 当编辑状态的时候，只能提交
			if(status == 'EDIT'){
				$('#btn_ok_id').attr("hidden", false);
				$('#btn_redo_id').attr("hidden", true);
				$('#btn_undo_id').attr("hidden", true);
				$('#btn_clear_id').attr("hidden", true);
				$('#btn_inactive_id').attr("hidden", true); 
			}
			
			// 当审核中的时候，可以撤回
			if(status == 'PENDING'){
				$('#btn_ok_id').attr("hidden", true);
				$('#btn_redo_id').attr("hidden", true);
				$('#btn_undo_id').attr("hidden", true);
				$('#btn_clear_id').attr("hidden", false);
				$('#btn_inactive_id').attr("hidden", true);
			}
			
			// 审核通过的可以上架
			if(status == 'APPROVED'){
				$('#btn_ok_id').attr("hidden", true);
				$('#btn_clear_id').attr("hidden", true);
				$('#btn_inactive_id').attr("hidden", true);
				if(saleStatus == 'SELLING'){
					$('#btn_redo_id').attr("hidden", true);
					$('#btn_undo_id').attr("hidden", false);
				}else{
					$('#btn_redo_id').attr("hidden", false);
					$('#btn_undo_id').attr("hidden", true);
				}
			}
			
			// 审核拒绝的只能提交
			if(status == 'REFUSED'){
				$('#btn_ok_id').attr("hidden", false);
				$('#btn_redo_id').attr("hidden", true);
				$('#btn_undo_id').attr("hidden", true);
				$('#btn_clear_id').attr("hidden", true);
				$('#btn_inactive_id').attr("hidden", true);
			}
			
		}
		
		$('#goodsType').combobox({ 
		    method:'get',
		    url:'/action/portal/classify/brandClassifyList',
			valueField:'id',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
		$('#goodsStatus').combobox({ 
		    method:'get',
			data:getLovArray('PRO_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
		$('#saleStatus').combobox({ 
		    method:'get',
			data:getLovArray('SALE_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		});
		
		function goodsSearch(){
		   o2oDisplayName = $('#o2oDisplayName').val();
		   productCode = $('#productCode').val();
		   goodsType = $('#goodsType').combobox('getValue');
		   goodsStatus = $('#goodsStatus').combobox('getValue');
		   saleStatus = $('#saleStatus').combobox('getValue');
		   $datagrid.datagrid('reload');
	    }
	   
	    function goodsClean(){
		   $('#o2oDisplayName').val('');
		   $('#productCode').val('');
		   $('#goodsType').combobox('setValue',''); 
		   $('#goodsStatus').combobox('setValue',''); 
		   $('#saleStatus').combobox('setValue',''); 
		   o2oDisplayName = null;
		   productCode = null;
		   goodsType = null;
		   goodsStatus = null;
		   saleStatus = null;
		   $datagrid.datagrid('reload');
	    }
	</script>
</body>
</html>