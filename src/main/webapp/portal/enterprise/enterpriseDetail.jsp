<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
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
	width:200px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
	padding-left:20px;
}
.td-content input{
	width:600px;
}
.small_pic {
    font-size: 100px;
}
.small_pic img {
    vertical-align: baseline;
    margin-left: 20px;
}
#popUpImg {
	height: 300px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>企业信息审核</legend>
							<form id="enterHeaderForm" method="post">
								<table class="table-block" >							
									<tr>
											<td class="td-label"><label>企业名称：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="name" type="text" id="name" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>主营产品类目：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="mainProductCategory" type="text" id="mainProductCategory" disabled="disabled"/>
											</td>
										</tr>
										<tr hidden="true">
											<td class="td-label"><label>紧急联系人电话：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="emergenContactPhone" type="text" id="emergenContactPhone" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>注册人：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="applicantName" type="text" id="applicantName" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>注册人电话：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="applicantPhone" type="text" id="applicantPhone" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>注册人邮箱：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="applicantMailbox" type="text" id="applicantMailbox" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>公司经营地址 ：： </label></td>
											<td>
												<label style="padding-left:20px;margin-right:12px;"><input style="width: 170px;"  class="easyui-validatebox" name="province" type="text" id="province" disabled="disabled"/>省</label>
												<label style="margin-right:12px;"><input style="width: 170px;"  class="easyui-validatebox" name="city" type="text" id="city" disabled="disabled" />市</label>
												<label><input style="width: 170px;"  class="easyui-validatebox" name="county" type="text" id="county" disabled="disabled" />区/县</label>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>详细地址 ：： </label></td>
											<td class="td-content">
												<input class="easyui-validatebox" name="companyAddress" type="text" id="companyAddress" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>是否存在第三方店铺：</label></td>
											<td>
												<label style="margin-left: 20px"><input name="ifThirdStore"  type="radio" value="Y" disabled/>是 </label> 
												<label style="margin-left: 153px"><input name="ifThirdStore"  type="radio" value="N" disabled/>否 </label>
												<label><input name="" id="ifThirdStore"  hidden="true"/> </label>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>是否国内企业证明：</label></td>
											<td>
												<label style="margin-left: 20px"><input name="ifDomEnterProve"  type="radio" value="Y" disabled/>是 </label> 
												<label style="margin-left: 153px"><input name="ifDomEnterProve"type="radio" value="N" disabled/>否 </label>
												<label><input name="" id="ifDomEnterProve"  hidden="true"/> </label>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>是否三证合一：</label></td>
											<td>
												<label style="margin-left: 20px"><input name="ifThreeInOne"  type="radio" value="Y" disabled onclick="isThreeInOne()"/>是 </label> 
												<label style="margin-left: 153px"><input name="ifThreeInOne" type="radio" value="N" disabled onclick="unThreeInOne()"/>否 </label>
												<label><input name="" id="ifThreeInOne" hidden="true" /> </label>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>企业法人电话：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="cLegalPersonPhone" type="text" id="cLegalPersonPhone" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>企业法人身份证号：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="cLegalPersonIDNum" type="text" id="cLegalPersonIDNum" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>企业法人邮箱：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="cLegalPersonMail" type="text" id="cLegalPersonMail" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>营业执照注册号：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="businessLicenseNum" type="text" id="businessLicenseNum" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>组织结构代码：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="organizatioCode" type="text" id="organizatioCode" disabled="disabled" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>纳税人识别号：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="taxIdentifiCode" type="text" id="taxIdentifiCode" disabled="disabled"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>统一社会信用代码：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="socialCreditCode" type="text" id="socialCreditCode" disabled="disabled"/>
											</td>
										</tr>
								</table>
							</form>
						</fieldset>
					</td>
				</tr>
				<tr>
					<td>
						<fieldset>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>法定代表人正面照片：</label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="pIdentifiCard" height="100px" width="100px" src=""/></a></div>
									</td>
									
									<td class="td-label"><label>法定代表人反面照片： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="NIdtifiCard" height="100px" width="100px" src=""/></a></div>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>法定代表身份有效期： </label></td>
									<td style="padding-left:20px;">
										<input style="width: 150px;" id='iDStarttime' name="iDStarttime" class="easyui-datebox" disabled="disabled"/>
									</td>
									<td>
										<label>至： </label><input style="width: 150px;" id='iDFinishtime' name="iDFinishtime" class="easyui-datebox" disabled="disabled"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>营业执照： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="businessLicense" height="100px" width="100px" src=""/></a></div>
									</td>
									
									<td class="td-label"><label>开户许可证： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="openAccountLicense" height="100px" width="100px" src=""/></a></div>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>质检报告： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="qualityReport" height="100px" width="100px" src=""/></a></div>
									</td>
								</tr>
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>商标注册号 ：</label></td>
									<td colspan="3" style="padding-left:20px;">
										<input style="width:580px;" class="easyui-textbox" id='markRegistrationNum' name="markRegistrationNum"  disabled="disabled"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>商标注册证明： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="certificateRegistration" height="100px" width="100px" src=""/></a></div>
									</td>
									
									<td class="td-label"><label>品牌授权证明： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="authorizationCertificate" height="100px" width="100px" src=""/></a></div>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>品牌授权有效期： </label></td>
									<td style="padding-left:20px;width: 160px;">
										<input style="width: 150px;" id='brandAuthorizaStart' name="brandAuthorizaStart" class="easyui-datebox" disabled="disabled"/>
									</td>
									<td>
										<label>至： </label><input style="width: 150px;" id='brandAuthorizaEnd' name="brandAuthorizaEnd" class="easyui-datebox" disabled="disabled"/>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>
					<td>
						<fieldset>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>店铺名称： </label></td>
									<td class="td-content" style="padding-left:20px;">
										<input id='storeName' name="storeName" class="easyui-textbox" disabled="disabled"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>店铺logo： </label></td>
									<td>
										<div class="small_pic"><a href="#bigImg"><img id="storeLogo" height="100px" width="100px" src=""/></a></div>
									</td>
								</tr>
								<tr style="height: 120px;">
									<td class="td-label"><span style="color: red;">*</span><label>店铺详情：</label></td>
									<td class="td-content" style="padding-left:20px;">
										<input style="height: 100px; width: 600px;" id='storeDetails' name="storeDetails" class="easyui-textbox" data-options="multiline:true" disabled="disabled"/></input>
									</td>
								</tr>
								
								<tr style="height: 120px;">
									<td class="td-label"><label>审批意见：</label></td>
									<td style="padding-left:20px;">
										<input style="height: 100px; width: 600px;" id='approvalOpinion' name="approvalOpinion" class="easyui-textbox" data-options="multiline:true"/></input>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			<div style="margin:0 0 20px 0;">
				<center>
	    			<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;margin-left:50px;" class="easyui-linkbutton" plain="true" onclick="sendTransferCode()" id="btn_passed">审批通过</a> 
	    			<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;margin-left:50px;" class="easyui-linkbutton" plain="true" onclick="auditReject()" id="btn_reject">审批拒绝</a> 
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;margin-left:50px;" class="easyui-linkbutton" plain="true" onclick="cancel()">返回</a> 
				</center>
			</div>
		</div>
	</div>
	<div id="bigImg" style="display: none;">
		<img id="popUpImg"/>
	</div>
<script type="text/javascript">

var initEnterId = "";
var enterId = "${param.enterId}";
var userId="${param.userId}";

$('#mainProductCategory').combobox({ 
	method:'get',
	data:getLovArray('MAIN_PRODUCTS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

//初始化radio按钮
function initRadioButton(){
	var ifThirdStore=$("#ifThirdStore").val();//是否存在第三方店铺
	var ifDomEnterProve =$("#ifDomEnterProve").val();//是否国内企业证明
	var ifThreeInOne=$("#ifThreeInOne").val();//是否三证合一
	if(ifThirdStore!=null && ifThirdStore!=''){ 
        $("input:radio[name='ifThirdStore'][value="+ifThirdStore+"]").attr('checked','true');
    }
	if(ifDomEnterProve!=null && ifDomEnterProve!=''){
        $("input:radio[name='ifDomEnterProve'][value="+ifDomEnterProve+"]").attr('checked','true');
    }
	if(ifThreeInOne!=null && ifThreeInOne!=''){
        $("input:radio[name='ifThreeInOne'][value="+ifThreeInOne+"]").attr('checked','true');
    }
}


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
	function enterInfoInit(enterId, refreshDatagrid){
		if(!enterId){
			$.messager.alert("错误","参数错误, 无法获取企业id", "error");
			return;
		}else if(enterId == "current"){
			enterId = initEnterId;
		}
		initEnterId = enterId;
		var enter = {};
		$.post("${AppContext.ctxPath}/action/portal/enterprise/queryById",{id:initEnterId},
			function(data){
				if(data){
					if(data.success){
						enter = data.result;
						$enterHeaderForm.form("load", enter);
						
						$("#iDStarttime").datebox("setValue",enter.iDStarttime);
						$("#iDFinishtime").datebox("setValue",enter.iDFinishtime);
						$("#brandAuthorizaStart").datebox("setValue",enter.brandAuthorizaStart);
						$("#brandAuthorizaEnd").datebox("setValue",enter.brandAuthorizaEnd);
						$("#storeName").textbox('setValue',enter.storeName);
						$("#markRegistrationNum").textbox('setValue',enter.markRegistrationNum);
						$("#storeDetails").textbox('setValue',enter.storeDetails);
						$("#approvalOpinion").textbox('setValue',enter.approvalOpinion);
						
						if(enter.pIdentifiCardPath != null && enter.pIdentifiCardPath != '' ){
							$('#pIdentifiCard').attr('src',enter.pIdentifiCardPath);
						}else{
							$('#pIdentifiCard').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.nIdtifiCardPath != null && enter.nIdtifiCardPath != '' ){
							$('#NIdtifiCard').attr('src',enter.nIdtifiCardPath);
						}else{
							$('#NIdtifiCard').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.businessLicensePath != null && enter.businessLicensePath != '' ){
							$('#businessLicense').attr('src',enter.businessLicensePath);
						}else{
							$('#businessLicense').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.openAccountLicensePath != null && enter.openAccountLicensePath != '' ){
							$('#openAccountLicense').attr('src',enter.openAccountLicensePath);
						}else{
							$('#openAccountLicense').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.qualityReportPath != null && enter.qualityReportPath != '' ){
							$('#qualityReport').attr('src',enter.qualityReportPath);
						}else{
							$('#qualityReport').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.certificateRegistrationPath != null && enter.certificateRegistrationPath != '' ){
							$('#certificateRegistration').attr('src',enter.certificateRegistrationPath);
						}else{
							$('#certificateRegistration').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.authorizationCertificatePath != null && enter.authorizationCertificatePath != '' ){
							$('#authorizationCertificate').attr('src',enter.authorizationCertificatePath);
						}else{
							$('#authorizationCertificate').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						if(enter.storeLogoPath != null && enter.storeLogoPath != '' ){
							$('#storeLogo').attr('src',enter.storeLogoPath);
						}else{
							$('#storeLogo').attr('src','${AppContext.ctxPath}/static/images/404.jpg');
						}
						
						// 审批通过和审批拒绝状态情况下，审批通过和拒绝按钮禁用
						if( enter.storeStatus != 'CHECK_PENDING' ){
							$('#btn_passed').linkbutton('disable');
							$('#btn_reject').linkbutton('disable');
						}
						
						$('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
					}
				}
			});
		if(refreshDatagrid){

		}
	}
	
	
	/* function enterpriseUpdate(){
		var params = $("#enterHeaderForm").serialize();
		alert ("aaa"+params.value);
		$.ajax({
			type : "POST",
			dataType:'json',
   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
			url : "${AppContext.ctxPath}/action/portal/enterprise/update",
			data : params,
			success : function(data) {
				if (data.success) {
					window.parent.operationtip('修改成功！','info');
				}else{
					window.parent.operationtip(data.result,'info');
				}
			}
		});
	} */
	//返回
	function cancel(){
		window.parent.closeAddEnterpriseWin();
	}
	//审批通过
	function auditPasse(){
		// 点完一次审批通过后不能再次点击了
		$('#btn_passed').linkbutton('disable');
		$('#btn_reject').linkbutton('disable');
		$.post("${AppContext.ctxPath}/action/portal/enterprise/storeStatusPassUpdate",{userId:userId},
				function(data){
					if(data){
						if(data.success){
							window.parent.operationtip('操作成功！','info');
						}
					}
				});
	}
	
	//发送转账验证码
	function sendTransferCode(){
		$.messager.confirm("操作提示", '审批通过后将不能修改，确定要继续？', function(data) {
			if(data){
				$.post("${AppContext.ctxPath}/action/portal/sms/getTransferCode",{id:enterId},
					function(data){
							if(data){
								if(data.success){
									window.parent.operationtip('转账验证码发送成功！','info');
									auditPasse();
								}else{
									if(data.result!=null){//验证码已经存在
										auditPasse();
									}
									window.parent.operationtip('转账验证码发送失败！','info');
								}
							}
					});
			}
		});
	}
	//审批拒绝
	function auditReject(){
		var approvalOpinion= $("#approvalOpinion").val();//审批意见
		if(approvalOpinion!="" && approvalOpinion!=null){
			// 点完一次审批拒绝后不能再次点击了
			$('#btn_passed').linkbutton('disable');
			$('#btn_reject').linkbutton('disable');
			$.post("${AppContext.ctxPath}/action/portal/enterprise/approvalOpinionUpdate",
					{
						id:enterId,
						approvalOpinion:approvalOpinion
					},
					function(data){
						if(data){
							if(data.success){
								$.post("${AppContext.ctxPath}/action/portal/enterprise/storeStatusRejectUpdate",{userId:userId},
										function(data){
												if(data.success){
													window.parent.operationtip('操作成功！','info');
												}
										});
							}
						}
					});
			
		}else{
			window.parent.operationtip("拒绝时审批意见不能为空！", 'info');
		}
	}
</script>
</body>
</html>