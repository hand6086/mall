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
	   <div data-options="region:'north',split:true" fit="true" border="false">
	   <table id="goods-table"
				singleSelect="true" rownumbers="true"  pagination="true" fit="true">
			<thead>
				<tr>
					<th field="o2oDisplayName" width="280px" formatter="goodsNameFormatter" editor="{type:'textbox'}">商品名称</th>
					<th field="o2oIntCode" width="280px" editor="{type:'textbox'}">商品编码</th>
					<th field="linePath" width="150px" formatter="linePathFormatter">商品图片</th>
					<th field="o2oProdSeries" width="100px" noSearch="true" hidden="true" editor="{type:'combobox',options:{
																			valueField:'name',
																			textField:'name',
																			method:'get',
																			disabled:true,
																			url:'${AppContext.ctxPath}/action/portal/goodsSeries/queryByPkAll',
																			editable:false,
																			onSelect:selectedProd,}}">商品系列</th>
					<th field="o2oFroPageDisp" width="100px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">首页显示</th>
					<th field="o2oStorMeth" width="100px" editor="{type:'textbox'}">包装方式</th>
					<th field="o2oShelfLife" width="100px" editor="{type:'textbox'}">保质期</th>
					<th field="o2oProdIng" width="100px" editor="{type:'textbox'}">原麦汁浓度</th>
					<th field="o2oProdDesp" width="100px" editor="{type:'textbox'}">酒精度</th>	
					<th field="prodDefTypeCode" width="100px" lov="PROD_TYPE_CD" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('PROD_TYPE_CD'),
																			
																			editable:false}}">结构类型</th>
					<th field="o2oShareType" width="100px" lov="TB_O2O_SHARE_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('TB_O2O_SHARE_TYPE'),
																			editable:false}}">分享方式</th>	
					<th field="o2oShareTheme" width="100px" editor="{type:'textbox'}">分享标题</th>
					<th field="o2oShareNotes" width="100px" editor="{type:'textbox'}">分享说明</th>	
					<th field="o2oShareUrl" width="100px" editor="{type:'textbox'}">URL</th>
					<th field="vodLockedFlag" width="100px" noSearch="true" hidden="true" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">锁定标志</th>	
					<th field="vodLockedBy" width="100px" noSearch="true" hidden="true">锁定者</th>
					<th field="vodLockedDate" width="120px" noSearch="true" hidden="true">锁定日期</th>	
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
		$goodsDetailWin = $("#goodsDetailWin");
		$goodsDetailWinFram = $("#goodsDetailWinFram");
    	$datagrid = $('#goods-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			nowrap:false,
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
			url:'${AppContext.ctxPath}/action/portal/goodsSuit/queryByExamplePage',
			
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
	        
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goodsSuit/upsert",row, 
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
						$.post('${AppContext.ctxPath}/action/portal/goodsSuit/deleteById', {
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
					o2oProdSeries:'产品组合',
					o2oProdCategory:'1-7S30A4',
					o2oShareType:'Screenshot',
					prodDefTypeCode:'Simple',
					vodLockedFlag: 'Y',
					vodLockedBy : appCtx.username,
					vodLockedDate : appCtx.sysdate(),
				};
			},

 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(92,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="goodsSeriesId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
 				addButtonFun(93,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="saveAsGoods()" iconCls="icon-cog" plain="true">不为套装</a>',that);
			}, 

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
		
		function goodsNameFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openGoodsDetailWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
	   function openGoodsDetailWin(goodsId){
			if(!goodsId){
				$.messager.show("错误", "参数错误，无法获取商品id", "error");
				return;
			}
			$goodsDetailWinFram.attr("src","");
			if( !$goodsDetailWinFram.attr("src") ){
				$goodsDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/goods/goodsDetail.jsp?goodsId="+goodsId);
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

			$.post("${AppContext.ctxPath}/action/portal/goods/queryDetailById", {id: row.id}, function(data){
				if(data.success){
					$datagrid.datagrid('updateRow', {index : index, row:data.result})
					$datagrid.datagrid('acceptChanges');
				}else{
					$.messager.show("错误", "更新数据错误: "+data.result, "error");
				}
			});
		}
	   
	   //不是套装更改套装商品Flag=N
	   function saveAsGoods() {
			var row = $datagrid.datagrid('getSelected');
			$.post("${AppContext.ctxPath}/action/portal/goodsSuit/saveAsGoods",
					{
						id : row.id,
						attrib09:'N'
					}, function(data) {
						if (data.success) {
							$.messager.alert("成功", "修改成功", "info");
							$datagrid.hdatagrid("reload");
						} else {
							$.messager.show("错误", "更新数据错误: " + data.result, "error");
						}
					});
	    }
	</script>
</body>
</html>