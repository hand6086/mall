<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 1000px;
}
.table-block {
	margin: 5px auto;
	width: 1000px;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 20px;
}
.table-block tr{
	height:40px;
}
.td-label {
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:300px;
	margin-left: 10px;
}

.textbox {
    margin-left: 10px;
}

.bank {
	margin: 10px auto 0px 10px;
	padding: 10px 0 10px 0;
	border:1px solid #ddd;
	text-align: center;
	line-height: 1.5;
	word-spacing: 20px;
	width: 300px;
}

.bank label {
	margin-top: 10px;
}

.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:100%;background-color:black;z-index:1001;-moz-opacity:0.1 ;opacity:0.1;filter:alpha(opacity=10);}
</style>
<body id="back-color" style="background-color:#777;">
<div class="black_overlay" id="fade">
	<div class="easyui-layout"  data-options="fit:true" border="false">
		<div  data-options="region:'center'" style="width: 100%; height: 100%; padding: 0px;">
		<div class="head" style="background: #469ce7; color: #FFFFFF; padding: 20px 0; text-align: center; font-size: 18px; margin: 20px 100px">转账信息确认</div>
				<form id="enterHeaderForm" method="post" novalidate>
				<!-- <table class="form-table" title=""> -->
							<table class="table-block">
								<tr>
									<td class="td-label"><label>您的网店资料已经审核通过，当前主营类目为：</label></td>
									<td class="td-content">
									<input Style="margin-right:15px" name="mainProductCategory" type="text" id="mainProductCategory" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>根据线下协商确认，需要缴纳的平台押金为：</label></td>
									<td class="td-content">
									<input Style="margin-right:3px" name="depositAmount" type="text" id="depositAmount" value="1000" disabled="disabled"/>元
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>需要缴纳的信息服务支持费为：</label></td>
									<td class="td-content">
										<input Style="margin-right:3px" name="serviceCharge" type="text" id="serviceCharge" value="0" disabled="disabled"/>元
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>请选择支付方式：</label></td>
									<td>
										<label style="margin:0px 10px"><input id="alipay"  type="checkbox" />支付宝转账 </label> 
										<label style="margin:0px 10px"><input id="card"  type="checkbox" checked="checked"/>银行转账 </label>
									</td>
								</tr>
								<tr>
									<td></td>
									<td>
										<p class="bank alipay" hidden>
										
										</p>
										
										<p class="bank card">
										
										</p>
									</td>
								</tr>
								<tr>
									<td></td>
									<td colspan="2">
										<p style="color: red;">
											注：请您转账时请在转账附言中填写短信收到的转账识别码， 
										<br>
										<p style="color: red;margin-left: 15px;">
											用于识别您的身份，若未填写识别码金额可能将被退回
										</p>
									</td>
								</tr>
								<tr>
									<td class="td-label">请输入您的开户行： </td>
									<td class="td-content">
										<input class="easyui-combobox" name="bank" type="text" id="bank" required="true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">请输入您的银行卡号： </td>
									<td class="td-content" >
										<input class="easyui-textbox" name="creaitCard" type="text" id="creaitCard" data-options="required:true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">请输入开户人： </td>
									<td class="td-content" >
										<input class="easyui-textbox" name="accntHolder" type="text" id="accntHolder" required="true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label">请输入预留手机号： </td>
									<td class="td-content">
										<input class="easyui-textbox" name="applicantPhone" type="text" id="contactPhone" data-options="required:true,validType:'phoneNum'"/>
									</td>
								</tr>
								<tr>
									<td  colspan="2" style="text-align: center;">
										<a href="javascript:void(0)" style="background-color: #469ce7; width: 100px;margin: 15px 0px 0px 0px;" class="easyui-linkbutton" id="transferButtn" plain="true" onclick="transferred()">我已转账</a>
									</td>
								</tr>
					</table>
			</form>
		</div>
	</div>
	</div>
	<!-- 我已转账弹窗 -->
	<div id="transferred" class="easyui-window" title="我已转账" closed="true" style="width:300px;height:100px;padding:5px;">
		您的转账申请已提交，请等待平台确认
		<div style="padding:5px;text-align:center;">
		<!-- <a href="/portal/enterprise/AgreementPage.jsp" class="easyui-linkbutton" icon="icon-ok">下一步</a> -->
		<div class="easyui-linkbutton" id="next" icon="icon-ok" align="center"><b>下&nbsp;一&nbsp;步</b></div>
		</div>
	</div>

<script type="text/javascript">
$(function(){ //初始化转账信息
	$.post("${AppContext.ctxPath}/action/portal/account/queryAccountPickListPage",{usercorpid:'101',pageFlag:false},
			function(data){
				if(data.success){
					var account = {};
					account = data.rows;
					for(var i = 0 ;account.length != 0 && i < account.length; i++){
						//p标签内设置单词间距，有空格的讲有25px的间距，所以不要删除p标签内的空格，也不要随便加空格 
						if(account[i].type == 'Bankcard' && account[i].sequence == '1' ){
							$(".card").html("快购平台线下银行账号:<br>"+account[i].cardNum+" "+account[i].accntHolder+"<br><br>请完成线下转账后点击左侧“我已转账”按钮 ");
						}
				
						if(account[i].type == 'Alipay' && account[i].sequence == '1'){
							$(".alipay").html("快购平台支付宝账号：<br>"+account[i].cardNum+" "+account[i].accntHolder+"<br><br>请完成线下转账后点击左侧“我已转账”按钮 ");
						}
					}
				}
		});
}); 

$("#alipay").click(function(){
	if($("#alipay").is(":checked")==true){
		$("#card").attr('checked', false);
		$(".alipay").attr('hidden', false);
		$(".card").attr('hidden', true);
	}else{
		$(".alipay").attr('hidden', true);
	}
}); 

$("#card").click(function(){
	if($("#card").is(":checked")==true){
		$("#alipay").attr('checked', false);
		$(".card").attr('hidden', false);
		$(".alipay").attr('hidden', true);
	}else{
		$(".card").attr('hidden', true);
	}
}); 

	$.post("${AppContext.ctxPath}/action/portal/enterprise/queryByUserId",{},
		function(data){
			if(data.success){
				var enter = {};
				enter = data.result;
				if(enter!=null){
					if(enter.storeStatus == "AUDIT_REJECT" || enter.storeStatus == "CHECK_PENDING" ){
						window.location.href = '${AppContext.ctxPath}/store_info.jsp';
					} else if( enter.storeStatus == 'AUDIT_PASSED' ){
						var data2 = getLovArray('MAIN_PRODUCTS');
						for (var i = data2.length - 1; i >= 0; i--) {
							if (data2[i].val == enter.mainProductCategory ) {
								$("#mainProductCategory").val(data2[i].name);
							}
						}
						$('#fade').css('display','block');
						$.messager.alert('操作提示','恭喜！您的资料已审批通过！', 'info',function(){
							$('#back-color').css('background-color','white');
							$('.black_overlay').css('opacity','1');
						});
					}else if( enter.storeStatus == 'PASSED_NOPAID' ){
						$('#transferButtn').linkbutton('disable');//防止转账申请已提交后多次点击产生多条记录
						var data2 = getLovArray('MAIN_PRODUCTS');
						for (var i = data2.length - 1; i >= 0; i--) {
							if (data2[i].val == enter.mainProductCategory ) {
								$("#mainProductCategory").val(data2[i].name);
							}
						}
						$('#fade').css('display','block');
						$.messager.alert('操作提示','您的转账申请已提交！请等待平台确认！', 'info',function(){
							$('#back-color').css('background-color','white');
							$('.black_overlay').css('opacity','1');
						});
					}
				}
			}
	});
	
	//我已转账的弹窗
	function transferred() {  
		//$('#transferred').window('open');  
		if($("#enterHeaderForm").form('validate')){
			$.post('${AppContext.ctxPath}/action/portal/storeregister/getUserByName',
					{},
					function(data) {
						if (data.success) {
							var storeStatus = data.result.storeStatus;
							if(storeStatus=="ALREADY_PAID"){
								window.location.href = "/portal/enterprise/AgreementPage.jsp";
							}else if(storeStatus=="AUDIT_PASSED"){
								$.post("${AppContext.ctxPath}/action/portal/enterprise/storeStatuspassedNopaidUpdate",{userId:appCtx.userId},
										function(data){
											if(data.success){
												$.messager.alert("提示","您的转账申请已提交，请等待平台确认！");
												$('#transferButtn').linkbutton('disable');//防止转账申请已提交后多次点击产生多条记录
											}
									});
							}else{
								window.parent.operationtip("您的转账申请已提交！请等待平台确认！", 'info');
							}
						} else {									
							window.parent.operationtip("无法获取当前用户信息！", 'info');
						}
					});
				isPaid();
		}else{
			$.messager.alert('Warning','请输入所有字段');
		}
	}
	
	function isPaid() {
		var bank = $("#bank").combobox('getValue');
		var cardNum = $("#creaitCard").textbox('getValue');
		var accntHolder = $("#accntHolder").textbox('getValue');
		var applicantPhone = $("#contactPhone").textbox('getValue');
		$.post('${AppContext.ctxPath}/action/portal/account/removalDuplicateBankCard',{cardNum:cardNum},
			function(data){
				if(data.success){
					if(!data.duplicated){
						//不存在重复银行卡
						$.ajax({
							url:"${AppContext.ctxPath}/action/portal/account/accountUpsert",
							data: {
								bank:bank,
								cardNum:cardNum,
								accntHolder:accntHolder,
								applicantPhone:applicantPhone,
								type:'Bankcard',
								sequence:'1',
								row_status:'NEW'
							}
						}); 
					}
				}
			});
	}
	
	function offlineTransfer(){
		window.parent.operationtip("快购平台线下银行卡号：6226481473241934 请完成线下转账后点击我已转账按钮", 'info');
	}
	
	$("#bank").combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_BANK'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    cache: false
	});
	
	//手机号和身份证验证
	 $(function(){ 
		$.extend($.fn.validatebox.defaults.rules, {
			phoneNum: { //验证手机号   
				validator: function(value, param){
					return /^1[3-8]+\d{9}$/.test(value);
				},
				message: '请输入正确的手机号码！'
			},
			cardNum:{//验证银行卡号
				validator:function(value,param){
					return /^([1-9]{1})(\d{11}|\d{14}|\d{18})$/.test(value);
		       },
		       message: '请输入正确的银行卡号'
		   },
			});
	}); 
	
	<%--  $(function(){
	    $('#next').bind('click', function(){
	    	$.post('<%=ctxPath%>/action/portal/storeregister/getUserByName',
					{},
					function(data) {
						if (data.success) {
							var storeStatus = data.result.storeStatus;
							alert(storeStatus);
							if(storeStatus=="ALREADY_PAID"){
								window.location.href = "/portal/enterprise/AgreementPage.jsp";
							}else{
								window.parent.operationtip("您的转账平台还未审批，请耐心等待！", 'info');
							}
							
						} else {									
							window.parent.operationtip("无法获取当前用户信息！", 'info');
							
						}
					});
	    });
	});  --%>
</script>
</body>
</html>
	