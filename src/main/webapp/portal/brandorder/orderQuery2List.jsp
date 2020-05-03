<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
ul,p{
	list-style: none;
	padding: 0;
	margin: 0;
}
.fontSize0{
	font-size: 0;
}
.wrap{
	padding: 10px 30px 0 30px;
	overflow: auto;
}
/*导航栏*/
.nav{
	height: 40px;
	line-height: 30px;
}
.nav li{
	float: left;
	width: 13%;
	height: 30px;
	text-align: center;
}
.nav .navLi1{
	width: 30%;
	height: 30px;
	padding-left:30px;
}
.nav .navLi1 div{
	float: left;
	width: 23%;
	text-align: left;
}
.subNav{
	height: 30px;
	line-height: 30px;
	background: #e0ecff;
}
.subNav li{
	float: left;
}
.subNav .subNavLi2{
	width: 48%;
	text-align: center;
}
.subNav .subNavLi3,
.subNav .subNavLi4,
.subNav .subNavLi5,
.subNav .subNavLi6{
	width: 13%;
	text-align: center;
}

.list .order{
	position: relative;
	border: 1px solid #ddd;
	margin-top: 20px;
	padding-bottom: 0;
}
.list .order .listNav{
	width: 100%;
	height: 30px;
	line-height: 30px;
	background: #e0ecff;
}
.list .order .listNav div{
	float: left;
	padding: 0 30px 0 30px;
	text-align: center;
}
.list .content{
	box-sizing: border-box;
	display: inline-block;
	width: 50%;
}
.list .content li{
	height: 80px;
}
.list .content div{
	float: left;
}
.list .goods{
	height: 80px;
	width: 98%;
	border-width: 1px 0 0 0;
	border-style: solid;
	border-color: #ddd;
	padding: 10px 0 5px 10px;
}
.list li:last-child .goods{
	border-width:  1px 0 0 0;
}
.list .goods img{
	float: left;
	width: 80px;
	height: 80px;
}
.list .goods .detail{
	width: 60%;
	padding-left: 30px;
}
.list .goods .detail p{
	margin: 0 0 5px 0;
	line-height: 24px;
}
.list .num{
	width: 15%;
	height: 80px;
}
.list .num div,
.list .afterSale div{
	float: right;
	margin: 2px 2px 0 0;
}
.list .detailWrap{
	position: absolute;
	box-sizing: border-box;
	top: 30px;
	left: 50%;
	width: 50%;
	height: 90%;
	border-width: 1px 0 0 0;
	border-style: solid;
	border-color: #ddd;

}
.list .payer,
.list .pay,
.list .state{
	float: left;
	width: 25%;
	height: 90%;
	line-height: 100px;
	text-align: center;
	border-left: 1px dashed #ddd;
}
.list .payer{
	line-height: 40px;
}
.list .payer p{
	margin: 0 10px;
}
.list .payer p:first-child{
	border-bottom: 1px dashed #ddd;
}
.list .logistics{
	float: left;
	width: 24%;
	height: 88%;
	line-height: 100px;
	text-align: center;
	border-left: 1px dashed #ddd;
}
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.td-label {
	width:100px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:250px;
}
.mask {     
	width: 100%;
	height: 100%;  
    position: absolute;
    top: 0px; 
    filter: alpha(opacity=60); 
    background-color: #777;     
    z-index: 1002; 
    left: 0px;     
    opacity:0.5; 
    -moz-opacity:0.5;     
}
.status-keyfilter > a{     
	display:inline-block;
	text-align: left;
    margin: 0px 20px 4px 0px;
    padding-bottom: 4px;
}
.selected {     
	background-color: #469ce7; 
	padding: 4px;
	color:#fff !important;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" border="false" style="width:100%;height:100%;">
			<div id="mask" class="mask"></div> 
			<div class="wrap">
				 <fieldset class="x-fieldset" id="clientUpdateKeyFilter">
					<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
						<span class="x-fieldset-title">快速查询</span>
					</legend>
			
					<div class="row keyfilter-border">
						<ul class="status-keyfilter">
							<h4 style="display:inline-block;padding-left: 38px;">订单状态：</h4>
							<a class="selected" value="_ALL">全部</a>
						</ul>
					
						<table class="form-table">
							<tr>	
								<td class="td-label"><label>订单编号：</label></td>
								<td class="td-input">
									<input  class="easyui-validatebox" name="orderNum" type="text" id="orderNum" size="25" />
								</td>
								
								<td class="td-label"><label>消费者名称：</label></td>
								<td class="td-input">
									<input  class="easyui-validatebox" name="customerName" type="text" id="customerName" size="25" />
								</td>
								
								<td class="td-label"><label>手机号码：</label></td>
								<td class="td-input">
									<input  class="easyui-validatebox" name="mainPhNum" type="text" id="mainPhNum" size="25" />
								</td>
								
								<td class="td-label"><label>收货地址：</label></td>
								<td class="td-input">
									<input  class="easyui-validatebox" name="addressAll" type="text" id="addressAll" size="25" />
								</td>
							</tr>
						    <tr>
								<td class="td-label"><label>物流状态：</label></td>
								<td class="td-input">
									<input  class="easyui-combobox" name="logisticsStatus" type="text" id="logisticsStatus" size="25" />
								</td>
								
								<td class="td-label"><label>下单时间从：</label></td>
								<td class="td-input">
									<input  class="easyui-datetimebox" name="attr3" type="text" id="attr3" size="25" />
								</td>
								
								<td class="td-label"><label>下单时间到：</label></td>
								<td class="td-input">
									<input  class="easyui-datetimebox" name="attr4" type="text" id="attr4" size="25" />
								</td>
								<td class="td-label"><label>收货人：</label></td>
								<td class="td-input">
									<input  class="easyui-validatebox" name="recieverName" type="text" id="recieverName" size="25" />
								</td>
							</tr>
				   		</table>
			   		</div>
				</fieldset>
				
				<ul class="nav">
					<li class="navLi1">
						<div><a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderSearch()" iconCls="icon-search" plain="true">查询</a></div>
						<div><a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderClean()" iconCls="icon-reload" plain="true">重置</a></div>
						<div><a href="javascript:void(0)" class="easyui-linkbutton" onClick="orderExport()" iconCls="icon-page-excel" plain="true">导出</a></div>
					</li>
				</ul>
				<ul class="subNav">
					<li class="subNavLi2">订单详情</li>
					<li class="subNavLi3">收货人</li>
					<li class="subNavLi4">金额</li>
					<li class="subNavLi5">订单状态</li>
					<li class="subNavLi6">物流状态</li>
				</ul>
				
				<ul class="list">
				</ul>
				
				<div style="float: right; margin: 10px 0 20px 0;">
					<a href="javascript:void(0)" style="background-color: #e0ecff ;width: 100px;" class="easyui-linkbutton back" onclick="back()" plain="true">上一页</a>	    				
					<span style="margin-left:20px">第</span><span class="page" style="color:#F00;margin:0 5px 0 5px;">1</span><span>页,共</span>
					<span class="totalPage" style="color:#F00;margin:0 5px 0 5px;">1</span><span style="margin-right:20px">页</span>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton next" onclick="next()" plain="true">下一页</a>
				</div>
				
				<!-- 弹出窗1 -->
			    <div id="detailWin" class="crmWin" style="width:100%;height:100%">
			    <iframe src=""  id="detailWinFram" name="detailWinFram" width="100%" height="100%" frameborder="0">
			    </iframe>
			    </div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$detailWin = $("#detailWin");
	$detailWinFram = $("#detailWinFram");
	
	var orderNum = null; //订单编号
	var customerName = null; //消费者名称
	var recieverName = null; //收货人
	var mainPhNum = null; //手机号码
	var addressAll = null; //收货地址
	var orderStatus = null; //订单状态
	var logisticsStatus = null; //物流状态
	var attr3 = null; //下单时间从
	var attr4 = null; //下单时间到
	
	var page = $(".page").text();
	var totalPage = 0;
	
	$(function(){
		$(".back").linkbutton('disable');
		$(".next").linkbutton('disable');
        
        $.post("${AppContext.ctxPath}/action/portal/basic/list/BRAND_ORDER_STATUS", null, function(data) //回传函数
        		{	
        			if (data != null) {
        				var a = "";
        				for(var i=0;data != null && i<data.length;i++){
        					a = a + "<a value=\""+data[i].val+"\">"+data[i].name+"</a>";
        				}
        				$(".status-keyfilter").append(a); 
        				$(".status-keyfilter a").click(function(){
        			  	   if(!$(this).hasClass("selected")){
        			  		   $(".status-keyfilter a").removeClass("selected");
        			  		   $(this).addClass("selected");
        			  		   if($(this).attr("value") == "_ALL"){
        			  			   orderStatus = null;
        			  		   }else{
        			  			   orderStatus = $(this).attr("value");
        			  		   }
        			  		   
        			  		   $("#mask").show(); 
        			           $('.list').children('li').remove();
        			  		   infoInit();
        			  		}
        			  	});
        			}
        		}); 
        
        $("#mask").show();

        var initOrderNum = "${param.orderNum}";
        if(initOrderNum != null && initOrderNum != '' && initOrderNum != 'noMatchId' ){
            $('#orderNum').val(initOrderNum);
            orderNum = $('#orderNum').val();
        }
		infoInit();
	})
	function infoInit(){
		$.post("${AppContext.ctxPath}/action/portal/order/batchQueryOrderPage",{
			'rows' : 10 ,
			'page':page,
			'orderNum':orderNum,
			'customerName':customerName,
			'recieverName':recieverName,
			'mainPhNum':mainPhNum,
			'addressAll':addressAll,
			'orderStatus':orderStatus,
			'logisticsStatus':logisticsStatus,
			'attr3':attr3,
			'attr4':attr4,
			},function(data){
			if(data){
				if(data.success){
					var orderList = data.rows;
					if(orderList.length == 0){
						$('.list').append('<li style="text-align: center;font-size: 14px !important;font-weight: 800 !important;font-family: \'微软雅黑\' !important;color: #777;">当前没有记录可显示~</li>');
						$("#mask").hide();
					}else{
						var orderTime = '<li class="order"><div class="listNav"><div class="listDate">';
						var orderNumber = '</div><div class="orderNumber"><a href=\'###\' onClick=\'openDetailWin("';
						var orderNumber2 = '")\'>';
						var storeName = '</a></div><div class="storeName">';
						var addressAll = '</div><div class="addressAll">';
						var heightId = '</div></div><div><ul class="content">';
						var images = '<li><div class="goods"><img src=';
						var detail = '><div class="detail"><p>';
						var num = '</p></div><div class="num"><div>x';
						var numend = '</div></div></div></li>';
						var payer = '</ul><div class="detailWrap"><div class="payer"><p>';
						var mainPhNum = '</p><p>';
						var pay = '</p></div><div class="pay"><p>￥';
						var state = '</p></div><div class="state"><p>';
						var logistics = '</p></div><div class="logistics"><p>';
						var end = '</p></div></div></div></li>';
						
						for(var i = 0 ; i < orderList.length; i++){
							var order = orderList[i];
							var orderItemList = order.orderItem;
							if(orderItemList.length > 0){
								var code = orderTime + order.orderTime + orderNumber + order.id + orderNumber2 + order.orderNum
										+ storeName + order.storeName + addressAll + order.addressAll + heightId;
								for(var j = 0 ; j < orderItemList.length; j++){
									var orderItem = orderItemList[j];
									code = code + images + orderItem.merchPic + detail + orderItem.merchName
											+ num + orderItem.qty + numend;
								}
								var orderStatusName =  getLovShowName('BRAND_ORDER_STATUS', order.orderStatus);
								var logisticsStatusName =  getLovShowName('TB_O2O_LOGISTICS_STATUS', order.logisticsStatus);
								code = code + payer+order.recieverName+mainPhNum+order.recieverPhone+pay+order.orderTotalPrice
										+ state + orderStatusName + logistics + logisticsStatusName + end;
								$('.list').append(code);
								$("#mask").hide();
							}
						} 
						
					}
					var totalPage = data.totalPage;
					$(".page").text(page);
					$(".totalPage").text(totalPage);
					if(page > 1 ){
						$(".back").linkbutton('enable');
					}else{
						$(".back").linkbutton('disable');
					}
					
					if(page < totalPage){
						$(".next").linkbutton('enable');
					}else{
						$(".next").linkbutton('disable');
					}
					
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			}
		});
    }
	
	function back(){
		if(page > 1){
			page--;
			
	        $("#mask").show(); 
	        $('.list').children('li').remove();
			infoInit();
		}
	}
	
	function next(){
		if(page > 0){
			page++;
			
	        $("#mask").show(); 
	        $('.list').children('li').remove();
			infoInit();
		}
	}
	
	function openDetailWin(orderId){
		if(!orderId){
			$.messager.show("错误", "参数错误，无法获取id", "error");
			return;
		}
		$detailWinFram.attr("src","");
		if( !$detailWinFram.attr("src") ){
			$detailWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/orderDetail.jsp?orderId="+orderId);
			$detailWinFram[0].onload = function() {
				$detailWinFram[0].contentWindow.infoInit(orderId, "reload");//等待窗口加载完毕
			}
		}else{
			$detailWinFram[0].contentWindow.infoInit(orderId, "reload");
		}
		$detailWin.css("display", "block");
	}
   function closeDetailWin(){
		$detailWin.css("display", "none");
		$detailWinFram.attr("src","");
	}
	
	$('#logisticsStatus').combobox({
		method:'get',
		data:getLovArray('TB_O2O_LOGISTICS_STATUS'),
		valueField:'val',
		textField:'name',
		panelHeight: 'auto',
	    cache: false
	});
	
	function orderSearch(){
		orderNum = $('#orderNum').val();
		customerName = $('#customerName').val();
        recieverName = $('#recieverName').val();
		mainPhNum = $('#mainPhNum').val();
		addressAll = $('#addressAll').val();
		logisticsStatus = $('#logisticsStatus').combobox('getValue');
		attr3 = $('#attr3').datetimebox('getValue');
		attr4 = $('#attr4').datetimebox('getValue');
		
		page = 1;
		$(".page").text(page);
		$(".back").linkbutton('disable');
		$(".next").linkbutton('disable');
		
        $("#mask").show(); 
        $('.list').children('li').remove();
		infoInit();
   }
   
   function orderClean(){
	    $('#orderNum').val('');
		$('#customerName').val('');
       	$('#recieverName').val('');
		$('#mainPhNum').val('');
		$('#addressAll').val('');
		$('#logisticsStatus').combobox('setValue','');
		$('#attr3').datetimebox('setValue','');
		$('#attr4').datetimebox('setValue','');
		
		orderNum = null;
		customerName = null;
        recieverName = null;
		mainPhNum = null;
		addressAll = null;
		logisticsStatus = null;
		attr3 = null;
		attr4 = null;
		
		page = 1;
		$(".page").text(page);
		$(".back").linkbutton('disable');
		$(".next").linkbutton('disable');
		
        $("#mask").show(); 
        $('.list').children('li').remove();
		infoInit();
   }

    function orderExport() {
        orderNum = $('#orderNum').val();
        customerName = $('#customerName').val();
        recieverName = $('#recieverName').val();
        mainPhNum = $('#mainPhNum').val();
        addressAll = $('#addressAll').val();
        logisticsStatus = $('#logisticsStatus').combobox('getValue');
        attr3 = $('#attr3').datetimebox('getValue');
        attr4 = $('#attr4').datetimebox('getValue');

        //导出字段
        var searchList = [];
        var order = 0;
        searchList.push({ 'field': 'orderNum', 'title': '订单编号', 'order': order++ });
        searchList.push({ 'field': 'customerName', 'title': '消费者名称', 'order': order++ });
        searchList.push({ 'field': 'recieverName', 'title': '收货人', 'order': order++ });
        searchList.push({ 'field': 'addressAll', 'title': '地址', 'order': order++ });
        searchList.push({ 'field': 'recieverPhone', 'title': '收货人电话', 'order': order++ });
        searchList.push({ 'field': 'storeName', 'title': '商户名称', 'order': order++ });
        var orderStatusLovArray = getLovArray('BRAND_ORDER_STATUS');
        var orderStatusLovMap = {};
        for (var i = 0; i < orderStatusLovArray.length; i++) {
            orderStatusLovMap[orderStatusLovArray[i].val] = orderStatusLovArray[i].name;
        }
        searchList.push({ 'field': 'orderStatus', 'title': '订单状态', 'lov': 'BRAND_ORDER_STATUS', 'lovMap': orderStatusLovMap, 'order': order++ });
        searchList.push({ 'field': 'orderTime', 'title': '下单时间', 'order': order++ });
        searchList.push({ 'field': 'orderTotalPrice', 'title': '订单总金额', 'order': order++ });
        var o2oPayTypeLovArray = getLovArray('TB_O2O_PAY_TYPE');
        var o2oPayTypeLovMap = {};
        for (var i = 0; i < o2oPayTypeLovArray.length; i++) {
            o2oPayTypeLovMap[o2oPayTypeLovArray[i].val] = o2oPayTypeLovArray[i].name;
        }
        searchList.push({ 'field': 'o2oPayType', 'title': '支付方式', 'lov': 'TB_O2O_PAY_TYPE', 'lovMap': o2oPayTypeLovMap, 'order': order++ });
        searchList.push({ 'field': 'attrib26', 'title': '付款时间', 'order': order++ });
        var logisticsStatusLovArray = getLovArray('TB_O2O_LOGISTICS_STATUS');
        var logisticsStatusLovMap = {};
        for (var i = 0; i < logisticsStatusLovArray.length; i++) {
            logisticsStatusLovMap[logisticsStatusLovArray[i].val] = logisticsStatusLovArray[i].name;
        }
        searchList.push({ 'field': 'logisticsStatus', 'title': '物流状态', 'lov': 'TB_O2O_LOGISTICS_STATUS', 'lovMap': logisticsStatusLovMap, 'order': order++ });
        var logisticsCompanyLovArray = getLovArray('LOGISTICS_COMPANY');
        var logisticsCompanyLovMap = {};
        for (var i = 0; i < logisticsCompanyLovArray.length; i++) {
            logisticsCompanyLovMap[logisticsCompanyLovArray[i].val] = logisticsCompanyLovArray[i].name;
        }
        searchList.push({ 'field': 'logisticsCompany', 'title': '物流公司', 'lov': 'LOGISTICS_COMPANY', 'lovMap': logisticsCompanyLovMap, 'order': order++ });
        searchList.push({ 'field': 'logisticsOddNumber', 'title': '物流单号', 'order': order++ });
        searchList.push({ 'field': 'shippingTime', 'title': '发运时间', 'order': order++ });
        searchList.push({ 'field': 'tAttr20', 'title': '优惠券金额', 'order': order++ });
        searchList.push({ 'field': 'offerSum', 'title': '优惠总金额', 'order': order++ });
        searchList.push({ 'field': 'customerMsg', 'title': '买家留言', 'order': order++ });
        searchList.push({ 'field': 'refuseRefundDate', 'title': '取消时间', 'order': order++ });
        searchList.push({ 'field': 'cancelReason', 'title': '取消原因', 'order': order++ });
        searchList.push({ 'field': 'fightGroupsId', 'title': '拼团Id', 'order': order++ });
        searchList.push({ 'field': 'couponId', 'title': '优惠券Id', 'order': order++ });
        searchList.push({ 'field': 'freight', 'title': '运费', 'order': order++ });
        searchList.push({ 'field': 'merchName', 'title': '商品名称', 'order': order++ });
        searchList.push({ 'field': 'productCode', 'title': '商品69码', 'order': order++ });
        searchList.push({ 'field': 'price', 'title': '报价', 'order': order++ });
        searchList.push({ 'field': 'qty', 'title': '数量', 'order': order++ });
        searchList.push({ 'field': 'attrib17', 'title': '报价总金额', 'order': order++ });
        searchList.push({ 'field': 'pmoPrice', 'title': '成交价', 'order': order++ });
        searchList.push({ 'field': 'tAttr19', 'title': '成交金额', 'order': order++ });
        var attrib11LovArray = getLovArray('S_IF');
        var attrib11LovMap = {};
        for (var i = 0; i < attrib11LovArray.length; i++) {
            attrib11LovMap[attrib11LovArray[i].val] = attrib11LovArray[i].name;
        }
        searchList.push({ 'field': 'attrib11', 'title': '是否赠品', 'lov': 'S_IF', 'lovMap': attrib11LovMap, 'order': order++ });
        searchList.push({ 'field': 'campId', 'title': '促销活动编码', 'order': order++ });
        searchList.push({ 'field': 'activityName', 'title': '促销活动名称', 'order': order++ });
        searchList.push({ 'field': 'merchantOfferSum', 'title': '商品优惠金额', 'order': order++ });
        //searchList.push({ 'field': 'orderNum', 'title': '订单编号', 'lov': column.lov, 'lovMap': lovMap, 'order': order++ });
        $.post("${AppContext.ctxPath}/action/portal/order/batchQueryOrderPage/exportData", {
            'rows': 10,
            'page': page,
            'orderNum': orderNum,
            'customerName': customerName,
            'recieverName': recieverName,
            'mainPhNum': mainPhNum,
            'addressAll': addressAll,
            'orderStatus': orderStatus,
            'logisticsStatus': logisticsStatus,
            'attr3': attr3,
            'attr4': attr4,
            'exportsRaw': JSON.stringify(searchList),
        }, function (data) {
            if (data.success) {
                window.open(data.url);
            } else {
                detailAlert("错误", "error", data);
            }
        })
    }
	</script>
</body>
</html>