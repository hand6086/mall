<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>

<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
			<table id="goodsCity-table" width="100%" height="40%">
				<thead>
					<tr>
						<th field="cityName" width="20%">城市</th>
						<th field="cityNotes" width="76%">说明</th>
					</tr>
				</thead>
			</table>
	
			<table id="goodsPrice-table" width="98%" height="60%"
				singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="prodDisplayName" width="180px" formatter="nameFormatter">商品名称</th>
						<th field="prodIntCode" width="160px">商品编码</th>
						<th field="appPicUrl" width="160px" formatter="appFormatter">APP首页展示图</th>
						<th field="onePicUrl" width="160px" formatter="oneFormatter">一级页面轮播图</th>
						<th field="prodPricUrl" width="160px" formatter="prodFormatter">二级页面海报图</th>
						<th field="prodUrl" width="160px" hidden = "true">商品海报图URL</th>
						<th field="startTime" width="160px">有效开始时间</th>
						<th field="endTime" width="160px">有效结束时间</th>
						<th field="isDisplay" width="160px">是否展示</th>
						<th field="npDisplaySequence" width="160px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:0}}">爱新品频道显示顺序</th>
					</tr>
				</thead>
			</table>
			<div id="bigImg" style="display: none;">
				<img id="popUpImg"/>
			</div>
		</div>
	</div>
	<!-- 弹出窗 -->
    <div id="addWin" class="crmWin" style="width:100%;height:100%">
    	<iframe src=""  id="addWinFram" name="addWinFram" width="100%" height="100%" frameborder="0">
    </iframe>	
    </div>
	<!-- 弹出窗 -->
    <div id="detailWin" class="crmWin" style="width:100%;height:100%">
    	<iframe src=""  id="detailWinFram" name="detailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>	
   	</div>
   	
	<script type="text/javascript">
		$addWin = $("#addWin");
		$addWinFram = $("#addWinFram");
		$detailWin = $("#detailWin");
		$detailWinFram = $("#detailWinFram");
	    $datagrid = $('#goodsCity-table');
	    $priceDatagrid = $('#goodsPrice-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			buttonExport:false,
			buttonMenu:true,
			menuButtonCount :true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,10,15],//可以设置每页记录条数的列表 
			subGridIds: ['goodsPrice-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
		});
		
		$priceDatagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			/* buttonCopy:true, */
			buttonExport:true,
			/* buttonImport:true, */
			buttonMenu:true,
			menuButtonCount:false,
			newDefaultValue:true,
			oauthFlag:true,
			nowrap:false,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			subGridIds: ['goodsAdd-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsPrice/queryByExamplePage',
		    parentGridId : 'goodsCity-table',
		    parentGridField : 'cityId',
		    linkGridField : 'districtId',
		    onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
		    onBeforeLoad:function(param){
		    	param.isNewProduct = "Y";
			},
			onAddMoreButton:function(that,addButtonFun){
				/* addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddWin()">新建</a>',that); */
			}
			
		});
		
		function appFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.appPicUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		function oneFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.onePicUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		function prodFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.prodPricUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		function openAddWin(){
			var row = $datagrid.datagrid('getSelected');
			$addWin.css("display", "block");
			$addWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/addNewProductPriceList.jsp?districtId="+row.cityId);
			$addWinFram[0].onload = function() {
				// $addWinFram[0].contentWindow.init("reload");
			}
		}
		
		function closeAddWin(operate, newId){
			$addWin.css("display", "none");
			$addWinFram.attr("src","");
			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/goodsPrice/queryById", {id: newId}, function(data){
					if(data.success){
						var row = $priceDatagrid.datagrid('getSelected');
						var index = $priceDatagrid.datagrid('getRowIndex', row);
						if(row == null){
							index = 0;
						}
						$priceDatagrid.datagrid('insertRow',{index: index, row: data.result});	
						$priceDatagrid.datagrid('acceptChanges');
						$priceDatagrid.datagrid("selectRow", index);
					}else{
						$.messager.show("错误", "更新数据错误: "+data.result, "error");
					}
				});
			}
		}
		
		function nameFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openDetailWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
		
		 function openDetailWin(prodId){
				if(!prodId){
					$.messager.show("错误", "参数错误，无法获取id", "error");
					return;
				}
				if( !$detailWinFram.attr("src") ){
					$detailWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/newProductPriceDatail.jsp?prodId="+prodId);
					$detailWinFram[0].onload = function() {
						$detailWinFram[0].contentWindow.infoInit(prodId, "reload");//等待窗口加载完毕
					}
				}else{
					$detailWinFram[0].contentWindow.infoInit(prodId, "reload");
				}
				$detailWin.css("display", "block");
			}
	   function closeDetailWin(operate){
		   $detailWin.css("display", "none");
		   $detailWinFram.attr("src","");
			var row = $priceDatagrid.datagrid('getSelected');
			var index = $priceDatagrid.datagrid('getRowIndex', row);

			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/goodsPrice/queryById", {id: row.id}, function(data){
					if(data.success){
						$priceDatagrid.datagrid('updateRow', {index : index, row:data.result})
						$priceDatagrid.datagrid('acceptChanges');
					}else{
						$.messager.show("错误", "更新数据错误: "+data.result, "error");
					}
				});
			}
		}
		
	</script>
</body>
</html>