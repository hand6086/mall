<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<!--给body指定class属性指定easy的easyui-layout样式，这样就可以 使用body创建easyui的layout -->
 <body>
<div class="easyui-layout" data-options="fit:true" >  
   <div data-options="region:'north'" style="height:100%">
         <div  border="false" style="width:100%;height:100%;">
			<table id="activity-table" split="true"fit="true" >
			  <thead>
				<tr>
					<th field="activityName" width="200px" formatter="activityNameFormatter">活动名称</th>
					<th field="brandStatus" width="120px" lov="TB_BRAND_ACT_STATUS">活动状态</th>
					<th field="brandDiscountType" width="120px" lov="PLATFORM_PRO_TYPE" >优惠类型</th>
					<%--能否同享满减--%>
					<th field="ifCashDeduction" width="120px" lov="S_IF">是否同享满减</th>
					<th field="startTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>
					<th field="created" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}">创建时间</th>
					<th field="activityNotes" width="160px">活动备注</th>
				</tr>
			 </thead>
		  </table>
	   </div>
   </div>
</div>
	<script type="text/javascript">
	    $datagrid=$('#activity-table');
		$datagrid.hdatagrid({
			updateable:false,
			pagination:true,
			buttonNew:false,
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
		    onBeforeLoad:function(param){
		    	//单品优惠 brandDiscountType类型为product
		    	param.brandDiscountType = 'product';
			},
			onChangeSelectedItem:function(row,that){
				if( row.brandStatus == 'PAUSE' ){
					$("#btn_pause").linkbutton({text:'启动'});
					$("#btn_pause").linkbutton({iconCls:'icon_control_play'});
					$('#btn_remove').linkbutton('enable');
				} else{
					$("#btn_pause").linkbutton({text:'暂停'});
					$("#btn_pause").linkbutton({iconCls:'icon_control_pause'});
					$('#btn_remove').linkbutton('disable');
				}
			},
			readOnlyCondition: function(row, that){
				if( row.brandStatus != 'PAUSE' ){
					return true;
				}
				return false;
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="campaignAdd()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="campaignDel()">删除</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_pause" class="easyui-linkbutton" iconCls="icon_control_pause" plain="true" onclick="pause()">暂停</a>',that);
			},
		});
		function activityNameFormatter(val,row){   
			if(val != null){
				switch(row.brandDiscountType){
					case 'Bargain_Price':return "<a href='${AppContext.ctxPath}/portal/brandShop/brandBargainPriceProductList.jsp?headId=" + row.id + "&startTime=" + row.startTime + "&endTime=" + row.endTime + "'>" + val + "</a>";break;
					case 'Discount':return "<a href='${AppContext.ctxPath}/portal/brandShop/brandDiscountProductList.jsp?headId=" + row.id + "&startTime=" + row.startTime + "&endTime=" + row.endTime + "'>" + val + "</a>";break;
					case 'BOFO':return "<a href='${AppContext.ctxPath}/portal/brandShop/brandBuyFreeProductList.jsp?headId=" + row.id + "&startTime=" + row.startTime + "&endTime=" + row.endTime + "'>" + val + "</a>";break;
					default:$.messager.alert('Warning','优惠类型未知！');
				}
			} 
		}
		//新建活动的跳转
		function campaignAdd(){
			window.location.href="${AppContext.ctxPath}/action/portal/promotion/newInit";
		}
		
		//删除记录
		function campaignDel(){
			var row = $datagrid.datagrid('getSelected');
			if(row != null && row != ''){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						row.brandStatus = 'PAUSE';
						row.deleteFlg = 'Y';
						row.status = 'Inactive';
						row.attr1 = 'delete';
						$.post('${AppContext.ctxPath}/action/portal/promotion/update', row, function(data) {
							if (!data.success) {
								$.messager.alert("错误", data.result, "error");
								 return false;
							} else {
								$.messager.alert("成功", "删除成功", "info");
								$datagrid.hdatagrid("reload");
							}
						})
					}
				});
			}
		}
		//方案暂停、启用
		function pause() {
			var row = $datagrid.datagrid('getSelected');
			$.messager.confirm('操作提示', '本次操作将使得活动状态改变,确定要这样操作吗?', function(data) {
				if(data){
					if ( row.brandStatus != 'PAUSE') {
						row.brandStatus = 'PAUSE';
					} else{
						/*
						//活动开始时间 /-/g 表示将所有短横线-替换为斜杠/,其中g表示全局替换(不这样转换ie会出问题，时间无效)
						var startTime = new Date( row.startTime.replace(/-/g,"/") );
						//活动结束时间
						var endTime = new Date( row.endTime.replace(/-/g,"/") );
						
						var currentDate = new Date();
						if(currentDate < startTime){
							row.brandStatus = 'NO_START';
						}
						if( startTime<= currentDate && currentDate <= endTime){
							row.brandStatus = 'GOING';
						}
						if( endTime < currentDate){
							row.brandStatus = 'END';
						}
						*/
						row.brandStatus = 'GOING';
					}
					$.post('${AppContext.ctxPath}/action/portal/promotion/update', row, function(data) {
						   if (!data.success) {
							   $.messager.alert("错误", "修改活动状态时出错", "error");
							}else{
								var index = $datagrid.hdatagrid('getRowIndex', row);
								if( row.brandStatus != 'PAUSE' ){
									//活动开始时间 /-/g 表示将所有短横线-替换为斜杠/,其中g表示全局替换(不这样转换ie会出问题，时间无效)
									var startTime = new Date( row.startTime.replace(/-/g,"/") );
									//活动结束时间
									var endTime = new Date( row.endTime.replace(/-/g,"/") );
									
									var currentDate = new Date();
									if(currentDate < startTime){
										row.brandStatus = 'NO_START';
									}
									if( startTime<= currentDate && currentDate <= endTime){
										row.brandStatus = 'GOING';
									}
									if( endTime < currentDate){
										row.brandStatus = 'END';
									}
								}
								$datagrid.hdatagrid("refreshRow", index);
								$datagrid.datagrid('selectRow', index);
								$.messager.alert("操作提示", "操作成功！","info");
							}
						});
					}
				});
		}
	</script>
</body>
</html>