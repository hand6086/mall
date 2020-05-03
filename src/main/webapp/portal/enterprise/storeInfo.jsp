<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 5px auto auto 20px; 
	width: 1000px;
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
	width:125px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
	border:none;
}
.table1 tr{
	height:52px;
}
.td-content textarea{
	height: 54px;
	width: 220px;
	border:none;
}
input:disabled,textarea:disabled
{
background:#ffffff;
color: #29303F;
}
.textbox .textbox-prompt {color: #29303F;}
.td-content .textbox {border:none;}
.td-address .textbox {border:none}
.td-address .combo {border:none}
.td-address .combo-arrow {display:none}

.bankCard {
	width:280px;
	height: 100px;
	margin-top:20px;
	cellpadding:'4';
	border:1px solid #ddd;
}
.bankCard td {
	padding-left:10px;
	font-weight:bold !important;
	font-size: 14px !important;
}
.bankCard label {
	padding-left:5px;
	font-weight:normal;
	color:#505050;
}
.bankCard a {
	font-weight:normal;
	margin-right:20px;
	float:right;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:270px">
				<legend style="margin: 5px auto auto 20px;font-size: 16px;">网店信息</legend>
				<table class="form-table" style="border-top:0.5px solid #ddd;width: 90%;">
					<tr>
						<td style="width:438px;">
							<fieldset>
								<table class="table-block table1" >
									<tr>
								    	<td class="td-label"><label>网店名称： </label></td>
										<td class="td-content">
											<input id='id' name="id" hidden="true"/>
											<input id='name' name="name" type="text" disabled/>
										</td>
								    </tr>
								    <tr>
								    	<td class="td-label"><label>网店编号： </label></td>
										<td class="td-content">
											<input id='storeNumber' name="storeNumber" type="text" disabled/>
										</td>
								    </tr>
								    <tr>
								    	<td class="td-label"><label>主营类目： </label></td>
										<td class="td-content">
											<input id='mainProductCategory' name="mainProductCategory" type="text" disabled/>
										</td>
								    </tr>
								    <tr>
								    	<td class="td-label"><label>管理人姓名： </label></td>
										<td class="td-content">
											<input id='applicantName' name="applicantName" type="text" disabled/>
										</td>
								    </tr>
								</table>
							</fieldset>
						</td>
						<td>
							<fieldset>
								<table class="table-block" >
									<tr>
								    	<td class="td-label"><label>店铺logo： </label></td>
										<td>
											<div>
												<section class="img-section" >
													<div class="z_photo upimg-div clear" >
														 <section class="z_file fl">
														 	<form>
																<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
																<input type="file" name="file" id="storeLogo" class="file" multiple />
														  	</form>
														 </section>
													 </div>
												 </section>
											</div>
										</td>
								    </tr>
									<tr style="margin-top:100px;">
								    	<td class="td-label"><label>店铺介绍：</label></td>
										<td class="td-content">
											<textarea style="" id='storeDetails' name="storeDetails" disabled/></textarea>
										</td>
								    </tr>
								</table>
							</fieldset>
						</td>
					</tr>
				</table>
			</div>
			<div id="goods-tabs" class="easyui-tabs" style="width: 98%;height: 570px;" data-options="border:false">
				<div title="押金信息">
					<table id="depositDetails-table" fit="true" rownumbers="true" pagination="true">
						<thead>
							<tr>
								<th field="id" width="100px">单据编号</th>
								<th field="receiptType" width="100px" value="押金">单据类型</th>
								<th field="fundingDirection" width="80px" editor="{type:'validatebox',options:{required:true}}">资金往来方向</th>
								<th field="arrivedAmount" width="80px" editor="{type:'checkbox',options:{on:'Y', off:'N'}}" align="center">到账金额</th>
								<th field="d_serviceCharge" width="80px" align="center">手续费</th>
								<th field="created" width="200px" editor="{type:'textarea'}">创建时间</th>
								<th field="createdBy" width="100px" editor="{type:'textarea'}" >创建人</th>
								<th field="d_merchantAccount" width="120px" editor="{type:'textarea'}" >商户账户</th>
								<th field="d_bank" width="120px" editor="{type:'textarea'}" >开户行</th>
								<th field="status" width="80px" lov="FUNDS_STATUS" editor="{type:'textbox',options:{valueField:'val',
																										textField:'name',
																										data : getLovArray('FUNDS_STATUS'),
																										editable:true,
																										required:true}}">状态</th>
								<th field="remarks" width="100px" editor="{type:'textarea'}" >备注</th>
								<th field="id" width="100px" editor="{type:'textarea'}" >提现对账单号</th>
							</tr>
						</thead>
					</table>
				</div>
				<div title="网店人员"  href="${AppContext.ctxPath}/portal/enterprise/storeInfo/storeInfoUser.jsp"></div>
				<div title="地址信息" href="${AppContext.ctxPath}/portal/enterprise/storeInfo/storeInfoAddress.jsp"></div>
				<div title="银行卡号" href="${AppContext.ctxPath}/portal/enterprise/storeInfo/storeBankCard.jsp"></div>
			</div>
		</div>
	</div>
	
	<div id="dlg-login" class="easyui-dialog" title="身份校验" data-options="closed:true,buttons:'#dlg-buttons'" style="width:350px;height:300px">
		<form id="loginForm" method="post">
			<table style="width:100%;height:80px;margin-top: 50px;">
				<tr>
					<td align="center">请输入登录密码，完成身份校验： </td>
				</tr>
				<tr>
					<td align="center">
						<input  style="width:200px;" class="easyui-textbox" type="text" name="password" id="password"  onfocus="this.type='password'" autocomplete="off" required="true"/>
						<input name="type" id="type" hidden="true"/>
						<input name="bankCardId" id="bankCardId" hidden="true"/>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-buttons" style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="toAddCard()">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="javascript:$('#dlg-login').dialog('close');$('#loginForm').form('clear');">返回</a>
	</div>
	
	<div id="dlg-addCard" class="easyui-dialog" title="添加银行卡信息" data-options="closed:true,buttons:'#dlg-addCardButtons'" style="width:350px;height:300px">
		<form id="addCardForm" method="post">
			<table style="width:100%;height:125px;margin-top: 25px;">
				<tr>
					<td align="center">请输入您的开户行： </td>
				</tr>
				<tr>
					<td align="center">
						<input  style="width:200px;" class="easyui-combobox" name="bank1" type="text" id="bank1" required="true"/>
					</td>
				</tr>
				<tr>
					<td align="center">请输入您的银行卡号： </td>
				</tr>
				<tr>
					<td align="center">
						<input  style="width:200px;" class="easyui-textbox" name="creaitCard1" type="text" id="creaitCard1" data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td align="center">请输入开户人： </td>
				</tr>
				<tr>
					<td align="center">
						<input  style="width:200px;" class="easyui-textbox" name="accntHolder1" type="text" id="accntHolder1" required="true"/>
					</td>
				</tr>
				<tr>
					<td align="center">请输入预留手机号： </td>
				</tr>
				<tr>
					<td align="center">
						<input  style="width:200px;" class="easyui-textbox" name="contactPhone1" type="text" id="contactPhone1" data-options="required:true,validType:'phoneNum'"/>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-addCardButtons" style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="toVeriCode()">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="javascript:$('#dlg-addCard').dialog('close');$('#addCardForm').form('clear');">返回</a>
	</div>
	
	<div id="dlg-veriCode" class="easyui-dialog" title="添加银行卡信息" data-options="closed:true,buttons:'#dlg-veriCodeButtons'" style="width:350px;height:300px">
		<form id="veriCodeForm" method="post">
			<table style="width:100%;height:125px;margin-top: 50px;">
				<tr>
					<td align="center"><p style="width:200px;">我们向您的预留手机号发送了一条验证短信，请输入短信验证码： </p></td>
				</tr>
				<tr>
					<td align="center">
						<input  style="width:200px;" class="easyui-textbox" name="code" type="text" id="code" required="true"/>
						<input  name="bank" id="bank" hidden="true"/>
						<input  name="creaitCard" id="creaitCard" hidden="true"/>
						<input  name="accntHolder" id="accntHolder" hidden="true"/>
						<input  name="contactPhone" id="contactPhone" hidden="true"/>
					</td>
				</tr>
				<tr>
					<td align="center"><a href="javascript:void(0)" id="sendSMSCode" onclick="getCode()" class="easyui-linkbutton" style="background-color: #e0ecff;" plain="true">重新发送</a></td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-veriCodeButtons" style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="toAddFinish()">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="javascript:$('#dlg-veriCode').dialog('close');$('#veriCodeForm').form('clear');">返回</a>
	</div>
	
	<div id="dlg-newPhone" class="easyui-dialog" title="修改手机号" data-options="closed:true,buttons:'#dlg-newPhoneButtons'" style="width:350px;height:300px">
		<form id="newPhoneForm" method="post">
			<table style="width:100%;height:80px;margin-top: 50px;">
				<tr>
					<td align="center">请输入新的绑定手机号： </td>
				</tr>
				<tr>
					<td align="center">
						<input style="width:200px;" class="easyui-textbox" name="contactPhone2" type="text" id="contactPhone2" data-options="required:true,validType:'phoneNum'"/>
						<input name="bankCardId2" id="bankCardId2" hidden="true"/>
						<input name="type2" id="type2" hidden="true"/>
					</td>
				</tr>
			</table>
		</form>
    </div>
    <div id="dlg-newPhoneButtons" style="text-align: center;">
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="newPhone()">确认</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" style="background-color: #e0ecff;width: 80px;" plain="true" onclick="javascript:$('#dlg-newPhone').dialog('close');$('#newPhoneForm').form('clear');">返回</a>
	</div>
<script type="text/javascript">
window.onload=enterpriseInfoInit;//页面加载时调用初始化函数

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

var applicantName = '';
var applicantMailbox = '';
var applicantPhone = '';
var applicantAddress = '';

function enterpriseInfoInit(){
	var enter = {};
	$.post("${AppContext.ctxPath}/action/portal/enterprise/queryByUserId",{},
		function(data){
				if(data.success){
					enter = data.result;
					$("#id").val(enter.id);
					$("#name").val(enter.name);
					$("#storeNumber").val(enter.storeNumber);
					$("#mainProductCategory").val(getLovShowName('MAIN_PRODUCTS', enter.mainProductCategory));
					$("#applicantName").val(enter.applicantName);
					$("#storeDetails").val(enter.storeDetails);
					applicantName = enter.applicantName;
					applicantMailbox = enter.applicantMailbox;
					applicantPhone = enter.applicantPhone;
					applicantAddress = enter.province+enter.city+enter.county+enter.companyAddress;
					$('#storeLogo').BobImage({
						upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
					    initImgUrl : enter.storeLogoPath,
					    readOnly : true,
					    width : '100px',
					    height : '100px',
						myComplete : function (success, result, message){
							// 自定义操作
						},
						myRemove : function(){
						}
					});
			}
		});
	
}

var $datagrid = $("#depositDetails-table");

$datagrid.hdatagrid({
	updateable:false,
	toolbarShow:true,
	buttonSearch:true,
	selectFirstRow:false,
	striped : true,
	border : false,
	pagination : true,
	pageSize : 10,//每页显示的记录条数，默认为20 
	pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表
	url :'${AppContext.ctxPath}/action/portal/deposit/queryByExamplePage',
	onBeforeLoad:function(param){
		var corpid = appCtx.corpId;
		if(!corpid){
    		param.usercorpid = "noMatchId";
    	}else{
    		param.usercorpid=corpid;
    	}
	}
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
							$('#type2').val("bankCard");
						}else if(type == 'user'){
							$('#dlg-newPhone').dialog('open');
							$('#bankCardId2').val(bankCardId);
							$('#type2').val("user");
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

function newPhone(){
	var result = $("#newPhoneForm").form('validate');
	if(result){
		var id = $("#bankCardId2").val();
		var contactPhone = $("#contactPhone2").val();
		var type = $("#type2").val();
		$('#dlg-newPhone').dialog('close');
		$('#newPhoneForm').form('clear');
		if(type == 'user'){
			$.post('${AppContext.ctxPath}/action/portal/enterprise/upsert',
					{
						id:id,
						applicantPhone:contactPhone,
					},
					function(data) {
						if (!data.success) {
							window.parent.operationtip(data.result, 'error');
						} else {
							$("#applicantPhone").val(contactPhone);
						}
			});
		}else{
			$.post('${AppContext.ctxPath}/action/portal/account/accountUpsert',
					{
						id:id,
						row_status : 'UPDATE',
						applicantPhone:contactPhone,
					},
					function(data) {
						if (!data.success) {
							window.parent.operationtip(data.result, 'error');
						} else {
							bankCardInfoInit();
						}
			});
		}
	}else{
		return result;
	}
	
}
</script>
</body>
</html>