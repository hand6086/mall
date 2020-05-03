<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>
<style type="text/css">
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
<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:347px;width:100%">
	<table id="WithRefundOrder-table" fit="true" >
		<thead>
			<tr>
				<th field="check" checkbox="true"></th>
				<th field="orderNumber" width="130px" defaultSearch="true" >订单编号</th>							
				<!-- <th field="o2oExloderNumber" width="150px" >外部订单编号</th> -->
				<th field="o2oPayInfoType" width="150px" lov="TB_O2O_PAYMENT_TYPE">在线支付方式</th>
				<th field="o2oorderStatus" width="150px" lov="BRAND_ORDER_STATUS">订单状态</th>
				<th field="o2oLogisticsStatus" width="150px" lov="TB_O2O_LOGISTICS_STATUS">物流状态</th>
				<th field="account" width="150px" >消费者名称</th>
				<th field="accountCode" width="150px" >消费者编码</th>
				<th field="mainPhoneNumber" width="150px" >消费者电话</th>
				<th field="o2oStoreName" width="150px" lov="TB_O2O_STORE_NAME">店铺名称</th>
				<th field="o2oReceiverName" width="150px" >收件人</th>
				<th field="o2oReceiverPhone" width="150px" >收货人电话</th>
				<th field="o2oReceiverProvince" width="150px" >省/直辖市</th>
				<th field="o2oReceiverCity" width="150px" >城市</th>
				<th field="o2oReceiverDistrict" width="150px" >区/县</th>
				<th field="o2oReceiverAddress" width="150px" >详细地址</th>
				<th field="o2oGPSLongitude" width="150px" >GPS经度</th>
				<th field="o2oGPSLatitude" width="150px" >GPS纬度</th>
				<th field="o2omerchandiseprice" width="150px" >商品总价</th>
				<th field="o2oDeducedPrice" width="150px" >特价优惠金额</th>
				<th field="o2oFreeGetPrice" width="150px" >买赠优惠金额</th>
				<th field="o2oFullCutAmount" width="150px" >满减优惠金额</th>
				<th field="o2oCouponValue" width="150px" >优惠券金额</th>
				<th field="o2oTip" width="150px" >小费</th>
				<th field="o2oorderTotalPrice" width="150px" >订单总金额</th>
				<th field="o2oPayType" width="150px" lov="TB_O2O_PAY_TYPE">支付方式</th>
				<th field="o2oCustomerMsg" width="150px" >买家留言</th>
				<th field="o2oDeliveryType" width="150px" lov="TB_O2O_ORDER_DILIVER_TYPE">配送方式</th>
				<th field="o2oDSRName" width="150px">商户名称</th>
				<th field="o2oDSRCode" width="150px" >商户编码</th>
				<th field="o2oStoreCellphone" width="150px" >商户电话</th>
				<th field="o2oDSRStoreType" width="150px" lov="TB_O2O_STORE_TYPE">商户类型</th>
				<th field="o2oDeliveryMan" width="150px" >配送员</th>
				<th field="o2oDeliveryManphone" width="150px" >配送员电话</th>
				<th field="o2oorderType" width="150px" lov="TB_O2O_ORDER_TYPE">o2o订单分类</th>
				<th field="o2oIsForcedPickup" width="150px" lov='S_IF'  editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否兜底订单</th>
				<th field="o2oIsGroPurorder" width="150px" lov='S_IF'  editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否团购订单</th>
				<th field="o2oCheckCode" width="150px" >校验码</th>
				<th field="o2oCheckStatus" width="150px" lov="TB_CHECK_STATUS">校验状态</th>
				<th field="orderCreated" width="150px" >下单时间</th>
				<th field="o2oPayBillTime" width="150px" >付款时间</th>
				<th field="o2oorderPickedT" width="150px" >接单时间</th>
				<th field="o2oStartDeliveryT" width="150px" >配送时间</th>
				<th field="o2oReceivedTime" width="150px" >收货时间</th>
				<th field="o2oorderSourceSystem" width="150px" lov="TB_O2O_ORDER_SOURCE_SYSTEM">来源系统</th>
				<th field="orderType" width="150px" lov="FS_ORDER_TYPE">类型</th>
				<th field="o2oiso2oorder" width="150px" lov='S_IF'  editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否o2o订单</th>
				<th field="o2o1stPushTime" width="150px" >第一轮推送时间</th>
				<th field="o2o2ndPushTime" width="150px" >第二轮推送时间</th>
				<th field="o2o3rdPushTime" width="150px" >第三轮推送时间</th>
				
			</tr>
		</thead>
	</table>
 </div>
	<div  border="false" style="width:100%;height:347px;">
		<table id="WithRefundOrder-table-goods" fit="true" >
			<thead>
				<tr>
				    <th field="merchandiseName" width="100px">商品名称</th>
				    <th field="merchandiseCode" width="100px">商品编码</th>
				    <th field="basePrice" width="100px">报价</th>
				    <th field="quantityRequested" width="100px">数量</th>
				    <th field="o2oOriMePrice" width="100px">报价总金额</th>
				    <th field="netPrice" width="100px">成交价</th>
				    <th field="o2oLineTotalPrice" width="100px">成交金额</th>
				    <th field="o2ooGPProd" width="100px"lov='S_IF'  editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否团购商品</th>
				    <th field="o2oIsFreeMerchandise" width="100px"lov='S_IF'  editor="{type:'combobox',	
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('S_IF'),
											editable:false,
											required:true}}">是否赠品</th>
				</tr>
			</thead>
		</table>
		</div>
	</div>
   	<div id="getOrderNumDetailWin" class="crmWin" style="width:100%;height:100%">
	    <iframe src=""  id="getOrderNumDetailWinFram" name="getOrderNumDetailWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>

	 <div id="closeDlg" class="easyui-dialog" title="此功能用于确认客户申请取消，实际已经发运收货的订单" data-options="closed:true,buttons:'#closeDlg-buttons'"
		  style="width:350px;height:250px;padding-top: 25px;padding-left: 10px;">
		 <form id="orderDelForm" method="post">
			 <table>
				 <tr>
					 <td class="td-label"><label>请输入物流公司名称：</label></td>
					 <td class="td-content">
						 <input  class="easyui-combobox" name="logisticsCompany" type="text" id="logisticsCompany" required="true"/>
					 </td>
				 </tr>
				 <tr>
					 <td class="td-label"><label>请输入物流单号：</label></td>
					 <td class="td-content">
						 <input  class="easyui-textbox" name="logisticsOddNumber" type="text" id="logisticsOddNumber"
								 data-options="required:true,validType:'logisticsNum'"/>
					 </td>
				 </tr>
				 <tr>
					 <td class="td-label"><label>请输入发运时间：</label></td>
					 <td class="td-content">
						 <input class="easyui-datetimebox" name="shippingTime" id="shippingTime"  required="true">
					 </td>
				 </tr>
				 <tr>
					 <td class="td-label"><label>请输入签收时间：</label></td>
					 <td class="td-content">
						 <input class="easyui-datetimebox" name="receiveTime" id="receiveTime"  required="true">
					 </td>
				 </tr>
			 </table>
		 </form>
	 </div>
	 <div id="closeDlg-buttons">
		 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="closeOrder()">确定</a>
		 <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#closeDlg').dialog('close')">取消</a>
	 </div>

	<script type="text/javascript">
	   $getOrderNumDetailWinFram = $("#getOrderNumDetailWinFram");
	   $getOrderNumDetailWin = $("#getOrderNumDetailWin");
	   $datagrid = $('#WithRefundOrder-table');
	   $dataItemgrid=$('#WithRefundOrder-table-goods');
       $orderDelForm = $('#orderDelForm');
       $logisticsCompanyCombobox = $('#logisticsCompany');
       $closeDlg = $('#closeDlg');

	   var initId = getUrlParams("id");
	   $datagrid.hdatagrid({
			updateable:false,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonMenu:true,
			oauthFlag:true,
			menuButtonCount : true,
			singleSelect:false,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    subGridIds: ['WithRefundOrder-table-goods'],
			url:'${AppContext.ctxPath}/action/portal/withrefundorder/queryByExamplePage',
			onBeforeLoad:function(param){
				param.brandQuery = '1';
				
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					param.id = initId;
				}
			},
			onLoadSuccess: function (data) {
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					initId = '';
				}
	        },
			onSelect:function(index, row){
				var selectRows = $datagrid.datagrid('getSelections');
				var count = 0;
				if(selectRows.length == 0 ){
					$('#btn_cancel').attr("hidden", true);
					$('#btn_refund').attr("hidden", true);
                    $('#btn_close').attr("hidden", true);
				}else{
					for(var i=0; i<selectRows.length; i++){
						if(selectRows[0].o2oorderStatus == selectRows[i].o2oorderStatus){
							count = count +1;
						}
					}
					
					if(count == selectRows.length){
						if(selectRows[0].o2oorderStatus == 'Cancelling'){
							$('#btn_cancel').attr("hidden", false);
							$('#btn_refund').attr("hidden", true);
						}else if(selectRows[0].o2oorderStatus == 'Refunding'){
							$('#btn_cancel').attr("hidden", true);
							$('#btn_refund').attr("hidden", false);
						}
					}else{
						$('#btn_cancel').attr("hidden", true);
						$('#btn_refund').attr("hidden", true);
					}

                    if (selectRows.length == 1 && selectRows[0].o2oorderStatus == 'Cancelling') {
                        $('#btn_close').attr("hidden", false);
                    } else {
                        $('#btn_close').attr("hidden", true);
                    }
				}
			},
			onUnselect: function(index, row){
				var selectRows = $datagrid.datagrid('getSelections');
				var count = 0;
				if(selectRows.length == 0 ){
					$('#btn_cancel').attr("hidden", true);
					$('#btn_refund').attr("hidden", true);
					$('#btn_close').attr("hidden", true);
				}else{
					for(var i=0; i<selectRows.length; i++){
						if(selectRows[0].o2oorderStatus == selectRows[i].o2oorderStatus){
							count = count +1;
						}
					}
					
					if(count == selectRows.length){
						if(selectRows[0].o2oorderStatus == 'Cancelling'){
							$('#btn_cancel').attr("hidden", false);
							$('#btn_refund').attr("hidden", true);
						}else if(selectRows[0].o2oorderStatus == 'Refunding'){
							$('#btn_cancel').attr("hidden", true);
							$('#btn_refund').attr("hidden", false);
						}
					}else{
						$('#btn_cancel').attr("hidden", true);
						$('#btn_refund').attr("hidden", true);
					}

                    if (selectRows.length == 1 && selectRows[0].o2oorderStatus == 'Cancelling') {
                        $('#btn_close').attr("hidden", false);
                    } else {
                        $('#btn_close').attr("hidden", true);
                    }
				}
			},
		    onAddMoreButton : function(that, addButtonFun) {
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" id ="btn_cancel" onClick="setCancel()" iconCls="icon-ok" plain="true">确认取消</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" id ="btn_refund" onClick="setRefund()" iconCls="icon-ok" plain="true">去退款</a>',that);
                addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" id ="btn_close" onClick="setClose()" iconCls="icon-ok" plain="true">强制完成</a>',that);
		    }
		});
		
		/* function orderFormatter(val,row){
		     if(val != null){
			     return "<a class='easyui-tooltip' href='javascript:void(0)' onclick='getOrderDetail(\""+row.orderNumber+"\")'>" + val + "</a>";
			 }
		}
		
		function getOrderDetail(orderNum){
 			if(orderNum){
				$.post("${AppContext.ctxPath}/action/portal/order/platformOrder/queryOrderDetail" , {
					orderNum:orderNum
					}, function(data){
					if(data.success){
						$getOrderNumDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/o2o/order/platformOrderEdit.jsp");
						$getOrderNumDetailWin.css("display", "block");
					}
				});
				
			}else{
				$.messager.alert("错误", "请传入正确参数", "error");
			} 
		}
		
		function closeOrderNumDetailWin(){
			$getOrderNumDetailWin.css("display", "none");
		} */
		$dataItemgrid.hdatagrid({
			
			pagination:false,
			toolbarShow:true,
			buttonSearch:true,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表
		    parentGridId : 'WithRefundOrder-table',
		    parentGridField : 'id',
		    linkGridField : 'orderHeaderId',
			 url:'${AppContext.ctxPath}/action/portal/withrefundorder/brandQueryoOderGoodsPage',
			 
		 
		});
	
		/* function selectedType(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').o2oSeriesId = selectRow.id;
		} */
		
		function setCancel(){
			var rows = $datagrid.datagrid('getSelections');
			for(var i=0; i<rows.length; i++){
				$.post('${AppContext.ctxPath}/action/portal/order/update', {brandUpdate:'1',id:rows[i].id,orderStatus:'Refunding'}, function(data) {
					if (!data.success) {
					}else{
					}
				});
			}
			$datagrid.datagrid("reload");
		}
		
		function setRefund(){
			var userRefundUrl = $datagrid.datagrid('getSelected').userRefundUrl;
			var orderId = "";
			var count = 0;
			var rows = $datagrid.datagrid('getSelections');
			if(rows.length == 0){
				$.messager.alert("操作提示", "请至少选中一行!","error");
				return;
			}
			for(var i=0; i<rows.length; i++){
				if(rows[0].o2oPayInfoType == rows[i].o2oPayInfoType){
					count = count +1;
				}
			}
			if(count == rows.length){
				for(var i=0; i<rows.length; i++){
					orderId += rows[i].id + ",";
				}
				orderId = orderId.substr(0, orderId.length - 1);
				window.open(userRefundUrl+"?reason="+encodeURI('无')+"&id="+orderId);
			}else{
				$.messager.alert("操作提示", "在线支付方式必须一致!","error");
			}
		}

       //初始化 客户状态 下拉列表
       $logisticsCompanyCombobox.combobox({
           data : getLovArray('LOGISTICS_COMPANY'),
           valueField : 'val',
           textField : 'name',
           editable : false, //不可编辑状态
           cache : false
       });

       function setClose() {
           var rows = $datagrid.datagrid('getSelections');
           if (rows.length == 1) {
               var row = rows[0];
               if (row.o2oorderStatus == "Cancelling") {
                   $orderDelForm.form("clear");
                   $closeDlg.dialog('open');
               }else {
                   window.parent.operationtip('订单状态必须为取消中状态！', 'error');
               }
           } else {
               window.parent.operationtip('请选中单条订单！', 'error');
           }
       }

       function closeOrder() {
           var rows = $datagrid.datagrid('getSelections')[0];
           if (!rows.id) {
               window.parent.operationtip('请选择需要更新的数据!', 'error');
               return;
           }
           if($('#shippingTime').datetimebox('getValue') == null || $('#shippingTime').datetimebox('getValue') == ''){
               var curr_time=new Date();
               var strDate=curr_time.getFullYear()+"-";
               strDate +=curr_time.getMonth()+1+"-";
               strDate +=curr_time.getDate()+"-";
               strDate +=" "+curr_time.getHours()+":";
               strDate +=curr_time.getMinutes()+":";
               strDate +=curr_time.getSeconds();
               $('#shippingTime').datetimebox('setValue',strDate);
           }
           if($('#receiveTime').datetimebox('getValue') == null || $('#receiveTime').datetimebox('getValue') == ''){
               var curr_time=new Date();
               var strDate=curr_time.getFullYear()+"-";
               strDate +=curr_time.getMonth()+1+"-";
               strDate +=curr_time.getDate()+"-";
               strDate +=" "+curr_time.getHours()+":";
               strDate +=curr_time.getMinutes()+":";
               strDate +=curr_time.getSeconds();
               $('#receiveTime').datetimebox('setValue',strDate);
           }
           var options = {
               url : '${AppContext.ctxPath}/action/portal/order/update',
               type : 'post',
               dataType :'json',
               data: {
                   'id': rows.id,
                   'brandUpdate' : '1',
                   'orderStatus':'To Appraise',
                   'logisticsStatus':'Received',
                   'cancelReason':'该订单为消费者取消，但是实际已经完成发货并签收的订单，由后台管理员关闭',
                   'attr1':'closeOrder',
               },
               beforeSubmit: function() {
                   var result = $orderDelForm.form('validate');
                   return result;
               },
               success : function(data) {
                   if (data.success) {
                       $closeDlg.dialog('close');
                       window.parent.operationtip('订单信息更新成功！', 'info');
                       $datagrid.datagrid('reload');
                   } else {
                       window.parent.operationtip(data.result, 'error');
                   }
               }
           };
           $orderDelForm.ajaxSubmit(options);
       }
	</script>
</body>
</html>