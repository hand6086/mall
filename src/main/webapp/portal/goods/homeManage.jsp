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
	   <table id="goods-table"
				singleSelect="true" rownumbers="true"  pagination="true" fit="true" style="width:100%;height:100%;" >
			<thead>
				<tr>
					<th field="o2oDisplayName" width="280px" formatter="goodsNameFormatter" editor="{type:'textbox'}">商品名称</th>
					<th field="linePath" width="150px" formatter="linePathFormatter">商品图片</th>
					<th field="goodsStatus" width="100px" lov="TB_O2O_STATUS" editor="{type:'combobox',options:{valueField:'val',
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
	   	<!-- 弹出窗1 -->
	    <div id="goodsDetailWin" class="crmWin" style="width:100%;height:100%">
	    <iframe src=""  id="goodsDetailWinFram" name="goodsDetailWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
	    </div>
	</div> 
	<script type="text/javascript">
		var o2oDisplayName = null;
		var o2oIntCode = null;
		var o2oProdSeries = null;
		$goodsDetailWin = $("#goodsDetailWin");
		$goodsDetailWinFram = $("#goodsDetailWinFram");
	    $datagrid = $('#goods-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonExport:false,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			nowrap:false,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/goods/queryByExamplePage',
			
			onBeforeLoad:function(param){
				if(o2oDisplayName != null && o2oDisplayName != ''){
		    		param.o2oDisplayName = o2oDisplayName;
				}
				if(o2oIntCode != null && o2oIntCode != ''){
		    		param.o2oIntCode = o2oIntCode;
				}
				if(o2oProdSeries != null && o2oProdSeries != ''){
		    		param.o2oProdSeries = o2oProdSeries;
				}
			},
			
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
	        
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goods/upsert",row, 
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

			onInitNewData:function(that){
				return {
					vodLockedFlag: 'Y',
					vodLockedBy : appCtx.username,
					vodLockedDate : appCtx.sysdate(),
					type : 'Finished Bear',
					o2oShareType : 'Screenshot',
					prodDefTypeCode : 'Simple'
				};
			},
			
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="goodsSeriesId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
 			},
 			
 			/**
			 * 切换行，或加载数据成功后，触发选中行信息
			 */
			onChangeSelectedItem:function(row,that){
				if(row.goodsStatus == 'Active'){
					$("#btn_add").linkbutton({text:'无效'});
				} else{
					$("#btn_add").linkbutton({text:'有效'});
				}
			},

		});
		
		$('#o2oProdSeries').combobox({ 
			url:'/action/portal/goodsSeries/queryByPkAll',
			method:'get',
			cache : false,
			valueField:'name',
			textField:'name',
		});
		
		function linePathFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.linePath +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		//失效
		function Invalid(){
			var row = $datagrid.datagrid('getSelected');
			if(row.goodsStatus=="Inactive"){
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,goodsStatus:"Active"});
			}else{
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,goodsStatus:"Inactive"});
			}
			var index = $datagrid.hdatagrid('getRowIndex', row);
            $datagrid.datagrid('selectRow',index);
		}
		
		//更改产品系列字段为“产品组合”，更改套装商品Flag=Y即ATTRIB_09='Y'
		function saveAsSuitGoods(){
			var row = $datagrid.datagrid('getSelected');
			$.post("${AppContext.ctxPath}/action/portal/goods/saveAsSuitGoods", {id: row.id,o2oProdSeries : '产品组合'}, function(data){
				if(data.success){
					$.messager.alert("成功", "修改成功", "info");
					$datagrid.hdatagrid("reload");
				}else{
					$.messager.show("错误", "更新数据错误: "+data.result, "error");
				}
			});
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
			$('#goodsSeriesId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/goods/uploadImg',
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
		
		function selectedProd(selectRow){
			$datagrid.hdatagrid('getCurrentRow').o2oProdCategory = selectRow.id;
		}
		
		function onLoadProdSeriesSuccess(){
			var data = $(this).combobox('getData');
			$(this).combobox('select', data[0].name);
			$datagrid.hdatagrid('getCurrentRow').o2oProdCategory = data[0].id;
		}
		
		function prodPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').o2oProdId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').name = selectRow.name;
			$datagrid.hdatagrid('getCurrentRow').type = selectRow.type;
			$datagrid.hdatagrid('getCurrentRow').o2oProductCode = selectRow.part;
			return selectRow.part;
		}
		
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
			$goodsDetailWinFram.attr("src","");
			if( !$goodsDetailWinFram.attr("src") ){
				$goodsDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/goodsNewDetail.jsp?goodsId="+goodsId);
				$goodsDetailWinFram[0].onload = function() {
					$goodsDetailWinFram[0].contentWindow.goodsInfoInit(goodsId, "reload");//等待窗口加载完毕
				}
			}else{
				$goodsDetailWinFram[0].contentWindow.goodsInfoInit(goodsId, "reload");
			}
			//$accntDetailWin.window("open");
			$goodsDetailWin.css("display", "block");
		}
	   function closeGoodsDetailWin(){
			//$accntDetailWin.window("close");
			$goodsDetailWin.css("display", "none");
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);

			$.post("${AppContext.ctxPath}/action/portal/goods/queryById", {id: row.id}, function(data){
				if(data.success){
					$datagrid.datagrid('updateRow', {index : index, row:data.result})
					$datagrid.datagrid('acceptChanges');
				}else{
					$.messager.show("错误", "更新数据错误: "+data.result, "error");
				}
			});
		}
	   
	   function goodsSearch(){
		   o2oDisplayName = $('#o2oDisplayName').val();
		   o2oIntCode = $('#o2oIntCode').val();
		   o2oProdSeries = $('#o2oProdSeries').combobox('getValue');
		   $datagrid.datagrid('reload');
	   }
	   
	   function goodsClean(){
		   $('#o2oDisplayName').val('');
		   $('#o2oIntCode').val('');
		   $('#o2oProdSeries').combobox('setValue',''); 
		   o2oDisplayName = null;
		   o2oIntCode = null;
		   o2oProdSeries = null;
		   $datagrid.datagrid('reload');
	   }
	</script>
</body>
</html>