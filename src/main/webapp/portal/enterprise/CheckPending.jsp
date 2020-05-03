<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 100%;
}
.table-block {
	margin: 5px auto;
	width:100%;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 16px;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
.td-content textarea{
	width:500px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
				<form id="enterHeaderForm" method="post">
		        <legend>企业信息审核</legend>
				<table class="form-table">
				    <tr>
					   <td>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>企业名称</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="name" type="text" id="name" disabled="disabled" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>注册人</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="applicantName" type="text" id="applicantName" disabled="disabled" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>省份</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="province" type="text" id="province" disabled="disabled"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table-block">
								 <tr>
									<td class="td-label"><label>主营产品类目</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="mainProductCategory" type="text" id="mainProductCategory" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>注册人电话</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="applicantPhone" type="text" id="applicantPhone" disabled="disabled" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>市</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="city" type="text" id="city" disabled="disabled" />
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>注册人邮箱</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="applicantMailbox" type="text" id="applicantMailbox" disabled="disabled" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>区/县</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="county" type="text" id="county" disabled="disabled" />
								</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>地址</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="companyAddress" type="text" id="companyAddress" disabled="disabled"/>
									</td>
								</tr>
							</table>
				 		</td>
				 	</tr>
				 	<tr>
					   <td>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>是否存在第三方店铺</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="ifThirdStore" type="text" id="ifThirdStore" disabled="disabled" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>企业法人电话</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="cLegalPersonPhone" type="text" id="cLegalPersonPhone" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>统一社会信用代码</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="socialCreditCode" type="text" id="socialCreditCode" disabled="disabled"/>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table-block">
								 <tr>
									<td class="td-label"><label>是否国内企业证明</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="ifDomEnterProve" type="text" id="ifDomEnterProve" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>企业法人身份证号</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="cLegalPersonIDNum" type="text" id="cLegalPersonIDNum" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>商标注册号</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="markRegistrationNum" type="text" id="markRegistrationNum" disabled="disabled" />
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>是否三证合一</label></td>
									<td class="td-content">
											<input  class="easyui-validatebox" name="ifThreeInOne" type="text" id="ifThreeInOne" disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>企业法人邮箱</label></td>
									<td class="td-content">
										<input  class="easyui-validatebox" name="cLegalPersonMail" type="text" id="cLegalPersonMail" disabled="disabled"/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					   <td>
							<table class="table-block">
								<tr>
									<td class="td-label"><label>法人身份证照片（正面）</label></td>
									<td class="td-content">
										<input type="image" id="pIdentifiCard" src=""/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>营业执照</label></td>
									<td class="td-content">
										<input  type="image" id="businessLicense" src=""/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>质检报告</label></td>
									<td class="td-content">
										<input type="image" id="qualityReport" src=""/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>品牌授权证明</label></td>
									<td class="td-content">
										<input  type="image" id="authorizationCertificate" src="" />
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table class="table-block">
								 <tr>
									<td class="td-label"><label>法人身份证照片（反面）</label></td>
									<td class="td-content">
										<input  type="image" id="nIdtifiCard" src=""/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>开户许可证</label></td>
									<td class="td-content">
										<input  type="image" id="openAccountLicense" src=""/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>商标注册证明</label></td>
									<td class="td-content">
										<input  type="image" id="certificateRegistration" src=""/>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					    <td>
						    <table class="table-block">
									 <tr>
										<td class="td-label"><label>授权有效开始时间</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="brandAuthorizaStart" type="text" id="brandAuthorizaStart" disabled="disabled" />
										</td>
									</tr>
							  </table>
					    </td>
					    <td>
						    <table class="table-block">
									 <tr>
										<td class="td-label"><label>授权有效结束时间</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="brandAuthorizaEnd" type="text" id="brandAuthorizaEnd" disabled="disabled" />
										</td>
									</tr>
							  </table>
					    </td>
					</tr>
				</table>
				<table class="form-table">
					 <tr>
						<td class="td-label"><label>审批意见</label></td>
						<td class="td-content">
							<textarea  class="easyui-validatebox" name="approvalOpinion" type="text" id="approvalOpinion"/></textarea>
						</td>
					</tr>
				</table>
				</form>
				
				<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
					<a href="###" class="easyui-linkbutton" iconCls="icon-redo" onclick="auditPasse()">下一步&nbsp;&nbsp;&nbsp;</a> 
				</div>
		</div>
	</div>
	
<script type="text/javascript">

window.onload=enterpriseInfoInit;//页面加载时调用初始化函数


/* *********** 定义变量并且绑定输入框   start **************** */
$approvalOpinionInput		 	 = $('#approvalOpinion');


/* *********** 定义变量并且绑定输入框   end **************** */


	/**
	 * 更新客户的头信息
	 */
	function enterHeadUpdate(){
		if(enterHeadIsEditing){
			//acctHeadDisable();
			$enterHeaderForm.form({
				success : function(data){
					var data = eval('(' + data + ')'); // change the JSON string to javascript object
					if (data.success) {
						enterHeadDisable();
						window.parent.operationtip('保存成功！','info');
					} else {
						enterHeadEnable();
						window.parent.operationtip(data.result,'error');
					}
				}
			});
			$enterHeaderForm.submit();
		} 
	}
	
	$enterHeaderForm = $("#enterHeaderForm");
	$enterHeaderForm.form({
		url : "${AppContext.ctxPath}/action/portal/enterprise/update",
		onSubmit : function(){
			return $enterHeaderForm.form('validate');
		}
	});
	
	//
	function enterpriseInfoInit(){
		var enter = {};
		$.post("${AppContext.ctxPath}/action/portal/enterprise/queryByUserId",{},
			function(data){
				if(data){
					if(data.success){
						enter = data.result;
						$("#applicantName").val(enter.applicantName);
						$("#applicantMailbox").val(enter.applicantMailbox);
						$("#applicantPhone").val(enter.applicantPhone);
						$("#ifThirdStore").val(enter.ifThirdStore);
						$("#name").val(enter.name);
						$("#mainProductCategory").val(enter.mainProductCategory);
						$("#province").val(enter.province);
						$("#city").val(enter.city);
						$("#county").val(enter.county);
						$("#companyAddress").val(enter.companyAddress);
						$("#cLegalPersonMail").val(enter.cLegalPersonMail);
						$("#cLegalPersonPhone").val(enter.cLegalPersonPhone);
						$("#cLegalPersonIDNum").val(enter.cLegalPersonIDNum);
						$("#markRegistrationNum").val(enter.markRegistrationNum);
						$("#ifDomEnterProve").val(enter.ifDomEnterProve);
						$("#ifThreeInOne").val(enter.ifThreeInOne);
						$("#businessLicenseNum").val(enter.businessLicenseNum);
						$("#organizatioCode").val(enter.organizatioCode);
						$("#taxIdentifiCode").val(enter.taxIdentifiCode);
						$("#socialCreditCode").val(enter.socialCreditCode);
						$("#iDStarttime1").val(enter.iDStarttime1);
						$("#brandAuthorizaStart1").val(enter.brandAuthorizaStart1);
						$("#brandAuthorizaEnd1").val(enter.brandAuthorizaEnd1);
						$("#storeName1").val(enter.storeName1);
						
					}
				}
			});
	}
	
	//打开弹窗
	function auditPasse(){
		$(function(){
		    	$.post('${AppContext.ctxPath}/action/portal/storeregister/getUserByName',
						{},
						function(data) {
							if (data.success) {
								var storeStatus = data.result.storeStatus;
								if(storeStatus=="AUDIT_PASSED"){
									window.location.href = "/portal/enterprise/depositPayment.jsp";
								}else{
									window.parent.operationtip("您的申请平台还未审批，请耐心等待！", 'info');
								}
								
							} else {									
								window.parent.operationtip("无法获取当前用户信息！", 'info');
							}
						});
		}); 
	}
	
</script>
</body>
</html>