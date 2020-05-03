<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body>
	<div style="margin-left:50px;">
		<a href="javascript:void(0)" onclick="toLogin()" style="margin-top:20px;background-color: #95B8E7; width: 80px;" class="easyui-linkbutton" plain="true">添加银行卡></a>
		<div class="bankdiv"></div>
	</div>
	
	
	<script type="text/javascript">
		var interval;
	
		bankCardInfoInit();//页面加载时调用初始化函数
		
		function bankCardInfoInit(){
			$.post("${AppContext.ctxPath}/action/portal/account/queryAccountPickListPage",{pageFlag:false},
				function(data){
						if(data.success){
							bankCard = data.rows;
							var html = [];
							for(var i=0; bankCard != null && i< bankCard.length;i++){
				    			var item = bankCard[i];
				    			var bank =  getLovShowName('TB_O2O_BANK', item.bank);
								html.push('<table class="bankCard"><tr><td>'+bank+'</td></tr><tr><td>卡号：<label>'+item.cardNum+'</label></td></tr>')
								html.push('<tr><td>预留手机号：<label>'+item.applicantPhone+'</label>')		
								html.push('<a href="javascript:void(0)" id="'+item.id+'" onclick="toLogin2(event)">修改</a></td></tr></table>')		
				    		 }
							$('.bankdiv').html(html.join(''))
					}
				});
			
		}
		
		function toLogin(){
			$('#dlg-login').dialog('open');
			$('#type').val("addCard");
		}
		
		function toLogin2(e){
			$('#dlg-login').dialog('open');
			$('#type').val("updatePhone");
			$('#bankCardId').val($(e.target).attr('id'));
		}
		
		$("#bank1").combobox({ 
			method:'get',
			data:getLovArray('TB_O2O_BANK'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    cache: false
		});
		
		function toAddCard(){
			var result = $("#loginForm").form('validate');
			if(result){
				var type = $('#type').val();
				var password = $('#password').val();
				var bankCardId = $('#bankCardId').val();
				
				$('#dlg-login').dialog('close');
				$('#loginForm').form('clear');
				$.post('${AppContext.ctxPath}/action/portal/user/checkPassword',
						{
							password:password,
						},
						function(data) {
							if (!data.success) {
								window.parent.operationtip(data.result, 'error');
								errFun(data.result,that);
							} else {
								
								if(type == 'updatePhone'){
									$('#dlg-newPhone').dialog('open');
									$('#bankCardId2').val(bankCardId);
								}else{
									$('#dlg-addCard').dialog('open');
								}
								
								successFun("",that);
							}
				});
			}else{
				return result;
			}
		}
		
		function toVeriCode(){
			var result = $("#addCardForm").form('validate');
			if(result){
				var bank = $('#bank1').combobox("getValue");
				var creaitCard = $('#creaitCard1').val();
				var accntHolder = $('#accntHolder1').val();
				var contactPhone = $('#contactPhone1').val();
				$('#dlg-addCard').dialog('close');
				$('#addCardForm').form('clear');
				$('#dlg-veriCode').dialog('open');
				$('#bank').val(bank);
				$('#creaitCard').val(creaitCard);
				$('#accntHolder').val(accntHolder);
				$('#contactPhone').val(contactPhone);
				
				getCode();
				
			}else{
				return result;
			}
			
		}
		
		function toAddFinish(){
			var result = $("#veriCodeForm").form('validate');
			if(result){
				$('#dlg-veriCode').dialog('close');
				var code = $('#code').val();
				var contactPhone = $('#contactPhone').val();
				var bank = $('#bank').val();
				var creaitCard = $('#creaitCard').val();
				var accntHolder = $('#accntHolder').val();
				$.post('${AppContext.ctxPath}/action/portal/sms/verifyCode',
						{
							VerifyCode : code,
							contactPhone:contactPhone
						},
						function(data) {
							if (data.success) {
								clearInterval(interval);
								$('#veriCodeForm').form('clear');
								$.post('${AppContext.ctxPath}/action/portal/account/accountInsert',
										{
											applicantPhone:contactPhone,
											accntHolder:accntHolder,
											bank:bank,
											cardNum:creaitCard,
											type:'Bankcard',
											sequence:'1',
										},
										function(data) {
											if (!data.success) {
												window.parent.operationtip(data.result, 'error');
											} else {
												window.parent.operationtip("添加成功", 'info');
												bankCardInfoInit();
											}
								});
								
							} else {
								$('#veriCodeForm').form('clear');
								window.parent.operationtip(data.result, 'error');
							}
						});
			}else{
				return result;
			}
			
		}
		
		function getCode(){
			$.post('${AppContext.ctxPath}/action/portal/sms/getCode',{
				contactPhone: $('#contactPhone').val(),
			},function(data){
				if(data.success){
					
					$('#sendSMSCode').attr("disabled","disabled");
					var num =60;
					$('#sendSMSCode').attr({'class':'codeWait'});
					$("#username").attr("disabled", true);
					$('#phonenumber').attr("disabled", true);
					interval = setInterval(function() {
					$('#sendSMSCode').linkbutton({text:num+'S 后再次发送'});
					num--;
					if (num < 0) {
						$('#sendSMSCode').removeAttr("disabled");
						$('#sendSMSCode').linkbutton({text:'重新发送'});
						clearInterval(interval);
						}
					}, 1000);
				}else{
					$('#dlg-veriCode').dialog('close');
					window.parent.operationtip("您输入的号码有误，请稍后重试", 'error');
				}
			})
		}
		
	</script>
</body>
</html>