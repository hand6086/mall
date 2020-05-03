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
			<form id="accountForm" method="post" enctype ="multipart/form-data" style="margin-bottom: 50px;" > 
				<div>
					<table class="table-block">
						<tr>
							<td class="td-label"><label>银行卡号 : &nbsp;</label></td>
							<td class="td-content"><input id="cardNum" name="cardNum" class="easyui-validatebox" data-options="required:true" /></td>
						</tr>
						<tr>
							<td class="td-label"><label>开户行 : &nbsp;</label></td>
							<td class="td-content"><input id="bank" name="bank" class="easyui-combobox" data-options="required:true" 	/></td>
						</tr>
						
						<tr>
							<td class="td-label"><label>开户人: &nbsp;</label></td>
							<td class="td-content"><input id="accntHolder" name="accntHolder" class="easyui-validatebox" data-options="required:true" /></td>
						</tr>
						
						<tr>
							<td class="td-label"><label>预留手机号: &nbsp;</label></td>
							<td class="td-content"><input id="applicantPhone" name="applicantPhone" class="easyui-validatebox" type="text" data-options="required:true,validType:'mobile'"/></td>
						</tr>
						<tr>
							<td class="td-label">
								<a href="###"class="easyui-linkbutton"  onclick="confirmSubmit()">确认提交&nbsp;&nbsp;&nbsp;</a>
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
	$form = $("#accountForm");
	
	$bankCombobox = $("#bank");//开户行
	
	$(function(){ 
		$.extend($.fn.validatebox.defaults.rules, {
			cardNum:{//验证银行卡号
				validator:function(value,param){
					return /^([1-9]{1})(\d{11}|\d{14}|\d{18})$/.test(value);
		       },
		       message: '请输入正确的银行卡号'
		   },
			});
	}); 
	
	function entpInfoInit(entpId){
		$.post("${AppContext.ctxPath}/action/portal/account/queryById",{id:entpId},
			function(data){
				if(data.success){
					var account = data.result;
					$("#entpId").text(account.id);
					$("#corpid").text(account.corpid);
					$("#enterpriseName").text(account.enterpriseName);
					$("#applicantPhone").val(account.applicantPhone);
					$("#merchantAccount").val(account.merchantAccount);
				}else{
					window.parent.operationtip("初始化错误！", 'info');
					}
			});
	 } 
		
	$bankCombobox.combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_BANK'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	//确认提交
	function confirmSubmit(){
		var isPass = $form.form('validate');
		if(isPass){
			$.post('${AppContext.ctxPath}/action/portal/account/accountInsert', {
				enterpId : "${param.entpId}",
				bank :$("#bank").combobox('getValue'),
				cardNum :$("#cardNum").val(),
				accntHolder : $('#accntHolder').val(),
				applicantPhone : $('#applicantPhone').val()
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip("新建账户失败！", 'info');
				}else{
					goBack();
					window.parent.operationtip("新建成功！", 'info');
				}
			});
		}else{
			return isPass;
		}
		
	}
	
	//返回
	function goBack(){
		window.parent.addAccountWinClose();
	}
	</script>
</body>
</html>