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
					<th field="couponName" width="140px"editor="{type:'textbox',options:{required:true}}">优惠券名称</th>
					<th field="couponCode" width="100px" >优惠券编码</th>
					<th field="created" width="140px" >创建时间</th>
					<th field="startTime" width="140px" editor="{type:'datetimebox',options:{required:true}}" >有效开始日期</th>
					<th field="endTime" width="140px" editor="{type:'datetimebox',options:{required:true}}" >有效结束日期</th>
					<th field="faceValue" width="100px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}" >面额</th>
					<th field="minOrdPrice" width="100px"  editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">门槛（元）</th>
					<th field="amtPerConsumer" width="100px" editor="{type:'numberbox',options:{min:0,precision:0,required:true}}" >每人限领数量</th>
					<th field="releaseAmt" width="100px"  editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">发放数量</th>
					<th field="receivedQuantity" width="100px" editor="{type:'numberbox',options:{min:0,precision:0,required:false}}" >已领取数量</th>
					<th field="usedAmt" width="100px" editor="{type:'numberbox',options:{min:0,precision:0,required:false}}" >使用数量</th>
					<th field="brandCouponStatus" width="120px" lov="PLATFORM_COU_STATUS" >优惠券状态</th>
				</tr>
			 </thead>
		  </table>
	   </div>
   </div>
</div>
<!-- 弹出窗1 -->
<div id="brandShopCouponWin" class="crmWin" style="width:100%;height:100%">
	<iframe src="" id="brandShopCouponWinFram" name="brandShopCouponWinFram" width="100%" height="100%" frameborder="0"></iframe>
</div>
	<script type="text/javascript">
		$brandShopCouponWin = $("#brandShopCouponWin");
		$brandShopCouponWinFram = $("#brandShopCouponWinFram");
	
	    $dataItemgrid=$('#activity-table');
		$dataItemgrid.hdatagrid({
			updateable:false,
			pagination:true,
			buttonNew:false,
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    url:'${AppContext.ctxPath}/action/portal/coupon/queryByExamplePage',
		    onBeforeLoad:function(param){
		    	param.couponType = 'shop';
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="couponAdd()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="couponDel()">删除</a>',that);
			},
		});
		
		//新建优惠券的跳转
	   function couponAdd(){
			$brandShopCouponWinFram.attr("src","");
				$brandShopCouponWinFram.attr("src", "${AppContext.ctxPath}/action/portal/coupon/newInit/" + 'shop');
				$brandShopCouponWinFram[0].onload = function() {
					$brandShopCouponWinFram[0].contentWindow.brandShopCouponInit("reload");//等待窗口加载完毕
				}
			$brandShopCouponWin.css("display", "block");
		}
	   function closeBrandShopCouponWin(){
			$brandShopCouponWin.css("display", "none");
			$dataItemgrid.datagrid('reload');
		}
		//删除记录
		function couponDel(){
			var row = $dataItemgrid.datagrid('getSelected');
			if(row != null && row != ''){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						row.deleteFlg = 'Y';
						row.couponStatus = 'Inactive';
						$.post('${AppContext.ctxPath}/action/portal/coupon/update', row, function(data) {
							if (!data.success) {
								$.messager.alert("错误", data.result, "error");
								 return false;
							} else {
								$.messager.alert("成功", "删除成功", "info");
								$dataItemgrid.hdatagrid("reload");
							}
						})
					}
				});
			}
		}
		
	</script>
</body>
</html>