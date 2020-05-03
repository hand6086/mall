<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>
<style type="text/css">
#typeTable .table-block{
	border-collapse:separate; border-spacing:10px;/*表table的tr间距 */
	width:1000px;
	margin: 20px auto;
}
.td-label{
	font-size:14px;
	font-weight:200;
	text-align:right;
	height:30px;
}
.td-input{
	width:180px;
	height:20px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 16px;
}
#form {
	width: 1000px;
	margin: 30px auto;
}
</style>
<!--给body指定class属性指定easy的easyui-layout样式，这样就可以 使用body创建easyui的layout -->
 <body>
<div class="easyui-layout" data-options="fit:true" >  
   <div data-options="region:'north'" style="height:100%">
      <div  border="false" style="width:100%;height:50%;">
		<table id="activity-table" split="true"fit="true" >
			<thead>
				<tr>
					<th field="activityName" width="200px" >活动名称</th>
					<th field="brandDiscountType" width="120px" lov="PLATFORM_PRO_TYPE" >优惠类型</th>
					<th field="brandStatus" width="120px" lov="TB_BRAND_ACT_STATUS">活动状态</th>
					<th field="startTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>
					<th field="created" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}">创建时间</th>
					<th field="noCouponUse" width="100px" lov='TB_O2O_COUPON_USE'
							editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('TB_O2O_COUPON_USE'),
											editable:false,
											required:true}}">是否可用优惠券</th>
					<th field="activityNotes" width="160px">活动备注</th>
				</tr>
			 </thead>
		 </table>
	   </div>
    <div  border="false" style="width:100%;height:50%;">
		<form id="activityHeaderForm" method="post">
			<table id="typeTable" style="width:100%;height:100%;">
			  <tr>
				<td>
				  <fieldset>
					<legend>促销活动信息</legend>
					  <table class="table-block">
				       	<tr>
				       		<td width="120" class="td-label"><label><span style="color: red;">*</span>订单门槛：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="minOrdAmount" name="minOrdAmount" size="25" class="easyui-numberbox td-input" required="required" data-options="min:0,precision:0"/>
				       		</td>
				       	</tr>
				       	<tr>
				       		<td style="font-size:14px;font-weight:200;height:30px;" colspan="2" align="center">
								<label style="width: 9%;display:inline-block; text-align:right "><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Cash Deduction" onchange="$('#onCouponName').textbox('setValue','');$('#couponId').val('');$('.coupon').hide();$('#freeMerchName').textbox('setValue','');$('#freeMerchId').val('');$('.freeMerch').hide();$('.deduction').show();"/>&nbsp;订单满减&nbsp;&nbsp;&nbsp;</label>
								<label style="width: 12%;display:inline-block;text-align:left "><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Dispatch Coupon" onchange="$('.coupon').show();$('.freeMerch').hide();$('#freeMerchName').textbox('setValue','');$('#freeMerchId').val('');$('#deducedCash').numberbox('setValue','');$('.deduction').hide();$('.searchbox').width(180);"/>&nbsp;订单满赠优惠券&nbsp;&nbsp;&nbsp;</label>
								<label style="width: 15%;display:inline-block; text-align:left "><input class="brandDiscountType" type="radio" name="brandDiscountType" value="Reward for gifts" onchange="$('#onCouponName').textbox('setValue','');$('#couponId').val('');$('.coupon').hide();$('.freeMerch').show();$('#deducedCash').numberbox('setValue','');$('.deduction').hide();"/>&nbsp;订单满赠商品&nbsp;&nbsp;&nbsp;</label>
							</td>
				       	</tr>
				       	<tr class="coupon">
		     				<td class="td-label"><label><span style="color: red;">*</span>优惠券&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input class="easyui-validatebox" name="onCouponName" type="text" id="onCouponName" size="28" width="100px"/>
							</td>
							<td hidden="true">
								<input name="couponId" id="couponId" />
							</td>
							
						</tr>
						<tr class="freeMerch">	
		     				<td class="td-label"><label><span style="color: red;">*</span>赠品&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="freeMerchName" type="text" id="freeMerchName" size="28" />
							</td>
							
							<td hidden="true">
								<input name="freeMerchId" id="freeMerchId" />
							</td>
						</tr>	
						<tr class="freeMerch">	
		     				<td class="td-label"><label><span style="color: red;">*</span>限赠总量&nbsp;&nbsp;:&nbsp;&nbsp;</label></td>
							<td class="td-input">
								<input name="releaseAmt" type="text" id="releaseAmt" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
							</td>
						</tr>	
				
						<tr class="deduction">
							<td width="120" class="td-label"><label><span style="color: red;">*</span>满减金额：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="deducedCash" name="deducedCash" size="25" class="easyui-numberbox td-input" data-options="min:0,precision:0"/>
				       		</td>
				       	</tr>
				       	
				       	<tr>
							<td width="120" class="td-label"><label>活动备注：&nbsp;</label></td>
				       		<td width="100">
				       			<input id="activityNotes" name="activityNotes" size="25" class="easyui-textbox td-input" data-options="multiline:true" style="height:50px;width:180px"/>
				       		</td>
				       	</tr>
		   			 </table>
					<!-- 		   			
					 <div align="center" style="position:relative; left:-20px;">
	   					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveAndPush()">保存</a>
	   					&nbsp;&nbsp;&nbsp;
	   					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="closebrandShopPromotionWin()">取消</a>
	 				 </div>
	 				  -->
		    	  </fieldset>
		       </td>
		    </tr>
		</table>
	  </form>
    </div>
  </div>
</div>
<!-- 弹出窗1 -->
<div id="brandShopPromotionWin" class="crmWin" style="width:100%;height:100%">
	<iframe src="" id="brandShopPromotionWinFram" name="brandShopPromotionWinFram" width="100%" height="100%" frameborder="0"></iframe>
</div>
	<script type="text/javascript">
		$brandShopPromotionWin = $("#brandShopPromotionWin");
		$brandShopPromotionWinFram = $("#brandShopPromotionWinFram");
		
		$freeMerchNamePicklist = $('#freeMerchName');
		$onCouponNamePicklist = $('#onCouponName');
		
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
		    	//店铺优惠 brandDiscountType类型为store
		    	param.brandDiscountType = 'store';
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
				
		 		if( row.brandDiscountType == 'Cash Deduction' ){
					$(".freeMerch").hide();
					$(".deduction").show();
					$(".coupon").hide();
		 		} else if( row.brandDiscountType == 'Dispatch Coupon' ){
					$(".freeMerch").hide();
					$(".deduction").hide();
					$(".coupon").show();
		 		} else if( row.brandDiscountType == 'Reward for gifts'){
					$(".freeMerch").show();
					$(".deduction").hide();
					$(".coupon").hide();
		 		}
				// 为行的form表单赋值
				$("#activityHeaderForm").form("clear");
				$("#activityHeaderForm").form("load", row);
				for (key in row) {
					value = row[key];
					$("[name='" + key + "'][type='checkbox']", $("#activityHeaderForm"))
							.each(
									function() {
										$(this).prop("checked", value=="Y" ? true : false);
									});
				} 
				
				/* 				
				if( row.brandStatus == 'PAUSE' || row.brandStatus == 'NO_START'){
					 $(":disabled", $("#activityHeaderForm")).removeAttr("disabled");
					 $('#freeMerchName').textbox('enable');
					 $('#onCouponName').textbox('enable');
				     $('#btn_submit').attr('onclick', 'saveAndPush()');
				     $('#btn_submit').css('opacity','1');
				     $('#btn_cancel').attr('onclick', 'closebrandShopPromotionWin()');
				     $('#btn_cancel').css('opacity','1');
				     $('.textbox').css('background-color','white');
				} else{ 
				*/
				    $(":enabled",$("#activityHeaderForm")).attr("disabled", true);
				    $('#freeMerchName').textbox('disable');
				    $('#onCouponName').textbox('disable');
				    $('.textbox').css('background-color','#ddd');
				//}
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
						//活动开始时间
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
									//活动开始时间
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
		
	   function campaignAdd(){
			$brandShopPromotionWinFram.attr("src","");
				$brandShopPromotionWinFram.attr("src", "${AppContext.ctxPath}/portal/brandShop/brandShopPromotionNew.jsp");
				$brandShopPromotionWinFram[0].onload = function() {
					$brandShopPromotionWinFram[0].contentWindow.brandShopPromotionInit("reload");//等待窗口加载完毕
				}
			$brandShopPromotionWin.css("display", "block");
		}
	   function closebrandShopPromotionWin(){
			$brandShopPromotionWin.css("display", "none");
			$datagrid.datagrid('reload');
		}
	   
		$onCouponNamePicklist.picklist({
			title : '选择优惠券',
			tableUrl : '/portal/picklist/brandCouponPicklist.jsp',
			completeFun : function(selectRow) {
				$('#couponId').val(selectRow.id);
				return selectRow.onCouponName;
			}
		});
		
 		$freeMerchNamePicklist.picklist({
			title : '选择商品',
			tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
			completeFun : function(selectRow) {
				$('#freeMerchId').val(selectRow.id);
				return selectRow.o2oDisplayName;
			}
		});
 		
 		function saveAndPush(){
 			var brandDiscountType = $('.brandDiscountType:checked').val();
 			var minOrdAmount = $('#minOrdAmount').val();
 			var deducedCash = $('#deducedCash').val();
 			var activityNotes = $('#activityNotes').val();
 			var couponId = $('#couponId').val();
 			var freeMerchId = $('#freeMerchId').val();
 			
 			var row = $datagrid.datagrid('getSelected');
 			var index = $datagrid.datagrid('getRowIndex', row);
 			
 			if( row.brandStatus == 'PAUSE' || row.brandStatus == 'NO_START' ){
				$.post("${AppContext.ctxPath}/action/portal/promotion/update",{
					brandDiscountType :  brandDiscountType,
				 	minOrdAmount      :  minOrdAmount,
				 	activityNotes     :  activityNotes,
				 	deducedCash       :  deducedCash,
				 	freeMerchId       :  freeMerchId,
				 	couponId          :  couponId,
				 	id                :  row.id
				},function(data){
					if(data.success){
						$datagrid.datagrid('updateRow', {index : index, row:data.newRow})
						$.messager.alert("操作提示", "操作成功！","info");
					}else{
						$.messager.alert("错误", data.result, "error");
						return false;
					}
				});
 			} else{
 				$.messager.alert("错误", "该活动状态下不允许修改", "error");
 			}
 		}
	</script>
</body>
</html>