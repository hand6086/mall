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
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;" fit="true">
			<table id="bannerManagement-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="classifyName" width="100px" editor="{type:'mvgPickbox',
							options:{title:'分类名称',completeFun:bannerMvgPickComplete,
									mvgMapperName:'classifyBanner',
									tableId:'bannerManagement-table',
									optionsLeft:{
										tableUrl:'${AppContext.ctxPath}/portal/brandWorkbench/mvgPick/BannerLeftMvgPick.jsp',
										initParam:bannerMvgPickParam
									},
									optionsRight:{
										tableUrl:'${AppContext.ctxPath}/portal/brandWorkbench/mvgPick/BannerRightMvgPick.jsp'
									}
									}}">分类名称</th>
						<th field="name" width="160px" formatter="nameFormatter" editor="{type:'textbox'}">Banner名称</th>
						<th field="imageUrl" width="160px" formatter="imageFormatter">Banner图片</th>
						<th field="targetId" width="140px">Banner编码</th>
						<th field="isDisplay" width="70px" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">是否显示</th>
						<th field="sequence" width="70px"  editor="{type:'numberbox',options:{
																					min:0,
																					precision:0}}">显示顺序</th>
						<th field="startTime" width="140px" mark="date" editor="{type:'datetimebox',options:{showSeconds:true}}">开始时间</th>
						<th field="endTime" width="140px" mark="date" editor="{type:'datetimebox',options:{showSeconds:true}}">结束时间</th>
						<th field="tAttr01" width="100px" lov="BRAND_BANNER_TYPE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			data : getLovArray('BRAND_BANNER_TYPE'),
																			editable:false}}">Banner类型</th>
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
    <!-- 弹出窗2 -->
    <div id="detailWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="detailWinFram" name="detailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
	<script type="text/javascript">
		$addWin = $("#addWin");
		$addWinFram = $("#addWinFram");
		$detailWin = $("#detailWin");
		$detailWinFram = $("#detailWinFram");
		$datagrid = $('#bannerManagement-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:true,
			newDefaultValue:true,
			border:false,
			pageSize: 25, 
		    pageList: [10,25,50],
		    url:'${AppContext.ctxPath}/action/portal/banner/queryByExamplePage',
		    onBeforeLoad:function(param){
		    	param.source = 'brand';
			},
		    onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/banner/brandUpsert",row, 
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

			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddWin()">新建</a>',that);
			}
		});
		
		function merchandisePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').merchandiseId = selectRow.id;
			return selectRow.o2oDisplayName;
		}
		
		function campaignPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').campaignId = selectRow.id;
			return selectRow.name;
		}
		
		/**
		 * 分类mvgPick 按【确定】后执行的方法
		 */
		function bannerMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.classifyId = rightRowsMvg.id;
				currentRow.classifyName = rightRowsMvg.name;
			}
			return currentRow.classifyName;
		}
		/**
		 * 分类mvgPick 列表数据初始化参数
		 */
		function bannerMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
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
		
		function openAddWin(){
			$addWin.css("display", "block");
			$addWinFram.attr("src", "${AppContext.ctxPath}/portal/brandWorkbench/banner/addbanner.jsp")
			$addWinFram[0].onload = function() {
				$addWinFram[0].contentWindow.bannerInfoInit("reload");//等待窗口加载完毕
			};
		}
		
		function closeAddWin(operate, newId){
			$addWin.css("display", "none");
			$addWinFram.attr("src","");
			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/banner/queryById", {id: newId}, function(data){
					if(data.success){
						var row = $datagrid.datagrid('getSelected');
						var index = $datagrid.datagrid('getRowIndex', row);
						if(row == null){
							index = 0;
						}
						$datagrid.datagrid('insertRow',{index: index, row: data.result});	
						$datagrid.datagrid('acceptChanges');
						$datagrid.datagrid("selectRow", index);
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
		
		function openDetailWin(bannerId){
			if(!bannerId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			if( !$detailWinFram.attr("src") ){
				$detailWinFram.attr("src", "${AppContext.ctxPath}/portal/brandWorkbench/banner/bannerDetail.jsp?bannerId="+bannerId);
				$detailWinFram[0].onload = function() {
					$detailWinFram[0].contentWindow.bannerInfoInit(bannerId, "reload");//等待窗口加载完毕
				}
			}else{
				$detailWinFram[0].contentWindow.bannerInfoInit(bannerId, "reload");
			}
			$detailWin.css("display", "block");
		}
		
	   function closeDetailWin(operate){
			$detailWin.css("display", "none");
			$detailWinFram.attr("src","");
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);

			if(operate == "ok"){
				$.post("${AppContext.ctxPath}/action/portal/banner/queryById", {id: row.id}, function(data){
					if(data.success){
						$datagrid.datagrid('updateRow', {index : index, row:data.result})
						$datagrid.datagrid('acceptChanges');
					}else{
						$.messager.show("错误", "更新数据错误: "+data.result, "error");
					}
				});
			}
		}
		
	</script>
</body>
</html>