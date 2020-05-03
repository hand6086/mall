<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
/* 
//造成弹出table没有列标题
table {
	margin: 0 auto;
	border-collapse:collapse;
} */
.left{
	float: left;
	width: 360px;
}
.center{
	float: left;
	width: 90%;
	margin-left:10px;
	
	/* position:absolute; */
}
.right{
	float: left;
	width: 360px;
	margin-left:10px;
}

.form-table{
	margin: 5px auto; 
	width: 1200px;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
.table-block tr{
	height:40px;
}
.td-label {
	width:90px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
	width:90px;
}
.td-content input{
	width:180px;
}
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
.ui-btn {
    min-width: 85px;
	width: auto;
	margin-bottom: 0;
	font-weight: 400;
	white-space: nowrap;
	background-image: none;
	line-height: 32px;
	height: 32px;
	display: inline-block;
	text-align: center;
	border: 0;
	background-color: #f0f0f0;
	font-size: 14px;
	vertical-align: middle;
	cursor: pointer;
	color: #555;
}
.ui-btn:focus,.ui-btn:hover {
	background-image:none;
	text-decoration:none;
	color:#555;
	background-color:#e8eaeb;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false"  border="false" width="100%" height="100%">
			<form id="billForm" method="post" enctype ="multipart/form-data" style="margin-bottom: 50px;" > 
				<div>
					<table class="table-block">
						<tr>
							<td class="td-label"><label>单据类型 : &nbsp;</label></td>
							<td><label >保证金</label></td>
							<!-- <td class="td-label"><label>单据编号 : &nbsp;</label></td>
							<td><label id="receiptCode"></label></td> -->
							<td><label id="corpid" hidden="true"></label></td>
						</tr>
						<tr>
							<td class="td-label"><label>商家名称 : &nbsp;</label></td>
							<td><label id="enterpriseName"></label></td>
						</tr>
						<tr>
							<td class="td-label"><label>缴纳账号 : &nbsp;</label></td>
							<td><input id="merchantAccount" name="d_merchantAccount" style="width: 300px"/></td>
						</tr>
						<tr>
							<td class="td-label"><label>缴纳总金额 : &nbsp;</label></td>
							<td class="td-content"><input id="arrivedAmount" class="easyui-validatebox" data-options="required:true" name="arrivedAmount" /></td>
						</tr>
						
						<tr>
							<td class="td-label"><label>绑定手机号 : &nbsp;</label></td>
							<td class="td-content"><input id="applicantPhone" name="applicantPhone"readOnly="true" /></td>
							<td><input type="checkbox" id="sendMessage" name="sendMessage" />短信通知</td>
						</tr>
						<tr>
							
							<td class="td-label">
								<a href="###" class="easyui-linkbutton"  id="confirmButtn" onclick="confirmSubmit()">确认提交&nbsp;&nbsp;&nbsp;</a>
								&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<a href="###" class="easyui-linkbutton"  onclick="goBack()">返回&nbsp;&nbsp;&nbsp;</a>
							</td>
						</tr>
				</table>
			</div>
		</form>
	</div>
		
	<script type="text/javascript">
	
	var entpId ="${param.entpId}";
	$form = $("#billForm");
	
	$merchantAccountPickList   = $('#merchantAccount');//提现账户picklist
	
		function entpInfoInit(entpId){
			$.post("${AppContext.ctxPath}/action/portal/account/queryById",{id:entpId},
				function(data){
					if(data.success){
						var account = data.result;
						$("#entpId").text(account.id);
						$("#corpid").text(account.corpid);
						$("#enterpriseName").text(account.enterpriseName);
						$("#applicantPhone").val(account.applicantPhone);
						$("#merchantAccount").picklist('setValue',account.merchantAccount);
					}else{
						window.parent.operationtip("初始化错误！", 'info');
						}
				});
	 } 
		$merchantAccountPickList.picklist({
			title:'选择提现账户',
			required:true,
			oauthFlag:false,
			initParam:initCorpid,
			completeFun:function(selectRow){
				 $("#merchantAccount").val(selectRow.id);
				 return selectRow.merchantAccount;
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/merchantAccountPickList.jsp'
		});
		
	function initCorpid(){
		var corpid=$("#corpid").text();
		return {usercorpid:corpid};
	}
	//确认提交
	function confirmSubmit(){
		$('#confirmButtn').linkbutton('disable');//防止多次点击生成多条记录
		var isPass = $form.form('validate');
		if(isPass){
			var isChecked=$('#sendMessage').is(':checked');
			$.post('${AppContext.ctxPath}/action/portal/deposit/insertDeposit', {
				arrivedAmount :$("#arrivedAmount").val(),
				corpid :$("#corpid").text(),
				merchantAccount :$("#merchantAccount").picklist('getValue')
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip("保证金缴纳失败！", 'info');
				}else{
					if(isChecked){//勾选短信通知
						sendMessage();
					}
					window.parent.operationtip("保证金缴纳成功！", 'info');
					goBack();
					
				}
			});
			$.post('${AppContext.ctxPath}/action/portal/enterprise/storeStatusPayUpdate',{
				entpId:entpId
			});
		}else{
			return isPass;
		}
		
	}
	
	function sendMessage(){
		var phone =$("#applicantPhone").val();
		$.post('${AppContext.ctxPath}/action/portal/sms/getCode',{
			contactPhone:phone
		},function(data){
			if(data.success){
			}else{
				window.parent.operationtip("验证码发送失败！", 'info');
				}
			});
	}
	
	//返回
	function goBack(){
		window.parent.depositWinClose();
	}
	</script>
</body>
</html>