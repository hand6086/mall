<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
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
}
.td-content input{
	width:600px;
}
</style>
<body>
	<div style="width: 80%;background: #fff;margin: 20px 10% 0 10%;overflow: hidden;">
		<div class="head" style="background: #469ce7; color: #FFFFFF; padding: 20px 0; text-align: center; font-size: 18px; margin: 20px 0">平台信息完善 </div>
		<form id="acctHeaderForm" method="post">
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend> 注册人信息</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>申请人姓名 ：</label></td>
									<td class="td-content">
										<input id='id' name="id"  class="easyui-validatebox" hidden="true"/>
										<input id='code' name="code"  class="easyui-validatebox" hidden="true"/>
										<input id='applicantName' name="applicantName"  class="easyui-textbox" required="true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>申请人邮箱： </label></td>
									<td class="td-content">
										<input id='applicantMailbox' name="applicantMailbox" class="easyui-textbox" data-options="required:true,validType:'email'"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>申请人常用手机号： </label></td>
									<td class="td-content">
										<input id='applicantPhone' name="applicantPhone" class="easyui-textbox" data-options="required:true,validType:'phoneNum'"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>是否存在第三方店铺： </label></td>
									<td>
										<label style="margin-left: 20px"><input name="ifThirdStore"  type="radio" value="Y"/>是 </label> 
										<label style="margin-left: 153px"><input name="ifThirdStore"  type="radio" value="N"/>否 </label>
										<label><input name="" id="ifThirdStore"  hidden="true"/> </label>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>	
					<td>
						<fieldset>
							<legend>店铺所有人信息</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>公司名称 ：</label></td>
									<td class="td-content">
										<input id='name' name="name" class="easyui-textbox" data-options="required:true" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>主营产品类目 ： </label></td>
									<td class="td-content">
										<input id='mainProductCategory' name="mainProductCategory" class="easyui-textbox" data-options="required:true" />
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>公司经营地址 ： </label></td>
									<td>
										<label style="margin-right:50px;"><input name="province" id="province" class="easyui-combobox" data-options="required:true"/>省</label>
										<label style="margin-right:50px;"><input name="city" id="city" class="easyui-combobox" data-options="required:true"/>市</label>
										<label><input name="county" id="county" class="easyui-combobox"data-options="required:true"/>区/县</label>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>详细地址 ： </label></td>
									<td class="td-content">
										<input placeholder="公司详细地址" id='companyAddress' name="companyAddress" class="easyui-textbox" data-options="required:true"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>企业法人邮箱 ：</label></td>
									<td class="td-content">
										<input name="cLegalPersonMail" id="cLegalPersonMail"   class="easyui-textbox" data-options="required:true,validType:'email'"/>
									</td>
								</tr>
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>企业法人手机号  ： </label></td>
									<td class="td-content">
										<input id='cLegalPersonPhone' name="cLegalPersonPhone"  class="easyui-textbox" data-options="required:true,validType:'phoneNum'"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>企业法人身份证号 ： </label></td>
									<td class="td-content"> 
										<input id='cLegalPersonIDNum' name="cLegalPersonIDNum" class="easyui-textbox" data-options="required:true,validType:'idCode'"/><br>
									</td>
								</tr>
								
								<tr>
									<td colspan="2"><span style="color: #FF0000; padding-top: 20px; margin-left: 90px;">注：请确认输入的证件号码无误，该身份证必须和您上传的的身份证照片一致</span></td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>是否国内企业证明： </label></td>
									<td>
										<label style="margin-left: 20px"><input name="ifDomEnterProve"  type="radio" value="Y"/>是 </label> 
										<label style="margin-left: 153px"><input name="ifDomEnterProve"type="radio" value="N"/>否 </label>
										<label><input name="" id="ifDomEnterProve"  hidden="true"/> </label>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>是否三证合一： </label></td>
									<td>
										<label style="margin-left: 20px"><input name="ifThreeInOne"  type="radio" value="Y" onclick="isThreeInOne()"/>是 </label> 
										<label style="margin-left: 153px"><input name="ifThreeInOne" type="radio" value="N" onclick="unThreeInOne()"/>否 </label>
										<label><input name="" id="ifThreeInOne" hidden="true" /> </label>
									</td>
								</tr>
								
								<tr id ="businessLicenseNumDiv" hidden="true">
									<td class="td-label"><span style="color: red;">*</span><label>营业执照注册号 ：</label></td>
									<td class="td-content">
										<input id='businessLicenseNum' name="businessLicenseNum" class="easyui-textbox" data-options="validType:'mylength[15]'"/>
									</td>
								</tr>
								
								<tr id ="organizatioCodeDiv" hidden="true">
									<td class="td-label"><span style="color: red;">*</span><label>组织机构代码  ： </label></td>
									<td class="td-content">
										<input id='organizatioCode' name="organizatioCode"  class="easyui-textbox"/>
									</td>
								</tr>
								
								<tr id ="taxIdentifiCodeDiv" hidden="true">
									<td class="td-label"><span style="color: red;">*</span><label>纳税人识别码 ：</label></td>
									<td class="td-content">
										<input id='taxIdentifiCode' name="taxIdentifiCode"  class="easyui-textbox"/>
									</td>
								</tr>
								
								<tr id ="socialCreditCodeDiv" hidden="true">
									<td class="td-label"><span style="color: red;">*</span><label>统一社会信用代码 ： </label></td>
									<td class="td-content"> 
										<input id='socialCreditCode' name="socialCreditCode"  class="easyui-textbox" data-options="validType:'mylength[18]'"/>
									</td>
								</tr>
								
								<tr>
									<td colspan="2"><span style="color: #FF0000; padding-top: 20px; margin-left: 90px;">注：三证合一的营业执照，请全部填写统一社会信用代码，非三证合一的营业执照请在统一社会信用社填写营业执照注册号，请根据您的营业执照类型依次填写。</span></td>
									<td>
										<input hidden="true" id="iDStarttime" name="iDStarttime"/>
										<input hidden="true" id="iDFinishtime" name="iDFinishtime"/>
										<input hidden="true" id="markRegistrationNum" name="markRegistrationNum"/>
										<input hidden="true" id="brandAuthorizaStart" name="brandAuthorizaStart"/>
										<input hidden="true" id="brandAuthorizaEnd" name="brandAuthorizaEnd"/>
										<input hidden="true" id="storeName" name="storeName"/>
										<input hidden="true" id="storeType" name="storeType"/>
										<input hidden="true" id="storeDetails" name="storeDetails"/>
										<input hidden="true" id="pIdentifiCard" name="pIdentifiCard"/>
										<input hidden="true" id="NIdtifiCard" name="NIdtifiCard"/>
										<input hidden="true" id="businessLicense" name="businessLicense"/>
										<input hidden="true" id="openAccountLicense" name="openAccountLicense"/>
										<input hidden="true" id="qualityReport" name="qualityReport"/>
										<input hidden="true" id="certificateRegistration" name="certificateRegistration"/>
										<input hidden="true" id="authorizationCertificate" name="authorizationCertificate"/>
										<input hidden="true" id="storeLogo" name="storeLogo"/>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
		</form>
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>资质信息上传</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>法定代表人正面照片：</label></td>
									<td style="width: 180px">
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="pIdentifiCard1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
									
									<td class="td-label"><label>示例：</label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="pIdentifiCard2" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>法定代表人反面照片： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="NIdtifiCard1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
									
									<td class="td-label"><label>示例： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="NIdtifiCard2" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>法定代表身份有效期： </label></td>
									<td style="padding-left:20px;">
										<input style="width: 150px;" id='iDStarttime1' name="iDStarttime1" class="easyui-datebox" data-options="required:true"/>
									</td>
									<td>
										<label>至： </label><input style="width: 150px;" id='iDFinishtime1' name="iDFinishtime1" class="easyui-datebox" data-options="required:true" validType="endDate['#iDStarttime1']"/>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>营业执照： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="businessLicense1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
									
									<td class="td-label"><label>开户许可证： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="openAccountLicense1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>其他材料（最多不超过13张）： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="qualityReport1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
								</tr>
								
								<tr>
									<td colspan="3" style="padding-left: 220px">注：经营<span style="color: red;">食品及酒类者</span> 需在其他材料处上传<span style="color: red;">食品许可证</span></td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>
					<td>
						<fieldset>
							<legend> 商标信息上传</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>商标注册号 ：</label></td>
									<td colspan="3" style="padding-left:20px;">
										<input style="width:580px;" class="easyui-textbox" id='markRegistrationNum1' name="markRegistrationNum1" />
									</td>
								</tr>
								<tr>
									<td class="td-label"><label>商标注册证明： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="certificateRegistration1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
									
									<td class="td-label"><label>品牌授权证明： </label></td>
									<td>
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="authorizationCertificate1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><label>品牌授权有效期： </label></td>
									<td style="padding-left:20px;width: 160px;">
										<input style="width: 150px;" id='brandAuthorizaStart1' name="brandAuthorizaStart1" class="easyui-datebox"/>
									</td>
									<td>
										<label>至： </label><input style="width: 150px;" id='brandAuthorizaEnd1' name="brandAuthorizaEnd1" class="easyui-datebox" validType="endDate['#brandAuthorizaStart1']"/>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>
					<td>
						<fieldset>
							<legend>店铺管理人基本信息</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>店铺名称： </label></td>
									<td class="td-content" style="padding-left:20px;">
										<input id='storeName1' name="storeName1" class="easyui-textbox"data-options="required:true"/>
									</td>
								</tr>
								<tr style="height: 25px">
									<td class="td-label"><span style="color: red;">*</span><label>店铺类型：</label></td>
									<td class="td-content" style="padding-left:20px;">
										<input class="easyui-textbox" id='storeType1' name="storeType1" data-options="required:true"/>
									</td>
								</tr>
								<tr id='comments' hidden="true" style="height: 1px">
									<td ></td>
									<td style="padding-left:20px;">
										<span style="color: red;" class='comments'></span>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>店铺logo： </label></td>
									<td class="td-content">
										<div>
											<section class="img-section" >
												<div class="z_photo upimg-div clear" >
													 <section class="z_file fl">
													 	<form>
															<img src="${AppContext.ctxPath}/static/images/a11.png" class="add-img">
															<input type="file" name="file" id="storeLogo1" class="file" multiple />
													  	</form>
													 </section>
												 </div>
											 </section>
										</div>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"></td>
									<td style="padding-left:20px;">注：正方形的尺寸为（100*100）请务必使用自己店铺的logo</td>
								</tr>
								
								<tr>
									<td class="td-label"></td>
									<td style="padding-left:20px;">出现如下几类logo，审核时将会被驳回：</td>
								</tr>
								
								<tr>
									<td class="td-label"></td>
									<td>
										<span style="color: blue;margin-left:20px;">1.内容直接使用实物照片</span>
										<span style="color: blue;margin-left:80px;">2.网站下载来未经处理的图片</span>
										<span style="color: blue;margin-left:80px;">3.出现广告语 </span>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"></td>
									<td>
										<span style="color: blue;margin-left:20px;">4.未经授权使用他人品牌</span>
										<span style="color: blue;margin-left:80px;">5.出现第三方电商平台信息</span>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"><span style="color: red;">*</span><label>店铺详情：</label></td>
									<td class="td-content" style="padding-left:20px;">
										<input style="height: 100px; width: 600px;" id='storeDetails1' name="storeDetails1" class="easyui-textbox" data-options="multiline:true,required:true"/></input>
									</td>
								</tr>
								
								<tr>
									<td class="td-label"></td>
									<td colspan="2" style="padding:20px 0 0 0;">
										<!-- <span style="color: blue;margin-left:20px;">个人店铺不能出现 <span style="color: red;">厂家直销,直销，批发零售，涉及品牌，个人联系方式或者第三方平台信息</span></span> -->
										<span style="color: blue;margin-left:20px;">企业店铺不能出现 <span style="color: red;">批发零售，个人联系方式或者第三方平台信息</span></span>
										<span style="color: blue;margin-left:20px;">详情不超过200字</span>
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
			<div style="margin:0 0 20px 0;">
				<center>
		    		<a href="javascript:void(0)" style="background-color: #469ce7; width: 100px;margin-left:50px;" class="easyui-linkbutton" plain="true" onclick="check()" id="btn_submit">提交</a> 
		    		<span id="span_cancel" hidden="true">
						<a href="javascript:void(0)" style="background-color: #469ce7; width: 100px;" class="easyui-linkbutton" plain="true" onclick="cancel()" id="btn_cancel">撤回</a>
					</span>
				</center>
			</div>
	</div>
	
	<script type="text/javascript">
	
	$mainProductCategoryCombobox = $("#mainProductCategory");//主营产品类目
	
	$mainProductCategoryCombobox.combobox({ 
		method:'get',
		data:getLovArray('MAIN_PRODUCTS'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	$storeTypeCombobox = $("#storeType1");//店铺类型
	$storeTypeCombobox.combobox({ 
		onChange: function (newVal,oldVal) {
			$('#comments').show();
			if( newVal == "flagship_store" ){
				$('.comments').html('经营1个自有品牌或1级授权品牌旗舰店');
			} else if( newVal == "direct_store" ){
				$('.comments').html('经营1个或多个自有/他人品牌的直营店');
			} else if( newVal == "monopoly_store" ){
				$('.comments').html('经营1个自有品牌或者授权销售专卖店，授权不超过2级');
			} else if( newVal == "general_store" ){
				$('.comments').html('普通企业店铺');
			}
		},	
		method:'get',
		data:getLovArray('STORE_TYPE'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$provinceCombobox = $("#province");//省
	$provinceCombobox.combobox({ 
		method:'get',
		valueField:'areaName',
		textField:'areaName',
		url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
		onSelect:selectedProvince,
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$cityCombobox = $("#city");//市
	$cityCombobox.combobox({ 
		method:'get',
		valueField:'areaName',
		textField:'areaName',
		url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
		onBeforeLoad:beforeSelectCity,
		onSelect:selectedCity,
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$countyCombobox = $("#county");//区/县
	$countyCombobox.combobox({ 
		method:'get',
		data:getLovArray('MAIN_PRODUCTS'),
		valueField:'areaName',
		textField:'areaName',
		url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
		onBeforeLoad:beforeSelectDistrict,
		onSelect:selectedDistrict,
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	window.onload=enterpriseInfoInit;//页面加载时调用初始化函数
	$acctHeaderForm = $("#acctHeaderForm");
	
	$('#pIdentifiCard2').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : "${AppContext.ctxPath}/static/css/img/identification_card.png",
	    readOnly : true,
	    width : '100px',
	    height : '100px',
		myComplete : function (success, result, message){
			// 自定义操作
		},
		myRemove : function(){
		}
	});
	
	$('#NIdtifiCard2').BobImage({
		upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
	    initImgUrl : "${AppContext.ctxPath}/static/css/img/identification_card2.png",
	    readOnly : true,
	    width : '100px',
	    height : '100px',
		myComplete : function (success, result, message){
			// 自定义操作
		},
		myRemove : function(){
		}
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
	
	//手机号和身份证验证
 	 $(function(){ 
	 	$.extend($.fn.validatebox.defaults.rules, {
	 		phoneNum: { //验证手机号   
	 			validator: function(value, param){
	 				return /^1[3-8]+\d{9}$/.test(value);
	 			},
	 			message: '请输入正确的手机号码！'
	 		},
	 		idCode:{//验证身份证号
	 			validator:function(value,param){
	 				return /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);
		       },
		       message: '请输入正确的身份证号'
		   },
		   mylength:{//验证长度
			   validator: function(value, param){
	 				return value.length ==param[0];
	 			},
	 			message: '长度必须为{0}位！'
		   },
		   endDate:{//验证结束时间必须大于开始时间
			   validator: function(value, param){
	 				var startDate= $(param[0]).datebox('getValue');
	 				var date=new Date();
	 				now =date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	 				var endDate=value;
				   return endDate>startDate;//不校验大于当前时间
	 			},
	 			message: '结束时间必须大于开始时间和当前时间！'
		  	 },
		   idDate:{//验证身份证的有效日期必须大于当前日期的三个月
			   validator: function(value, param){
	 				var date=new Date();
	 				now =date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	 				var endDate=value;
				   return day>90;
	 			},
	 			message: '身份证有效日期必须大于当前日期3个月！'
		  	 }
			});
	}); 
	//不是三证合一时显示div
	function unThreeInOne(){
		$("#organizatioCodeDiv").show();
		$('#organizatioCode').textbox({required:true});
		$("#businessLicenseNumDiv").show();
		$('#businessLicenseNum').textbox({required:true});
		$("#taxIdentifiCodeDiv").show();
		$('#taxIdentifiCode').textbox({required:true});
		$("#socialCreditCodeDiv").hide();
		$('#socialCreditCode').textbox({required:false});
	}
	//是三证合一时隐藏div
	function isThreeInOne(){
		$("#organizatioCodeDiv").hide();
		$('#organizatioCode').textbox({required:false});
		$("#businessLicenseNumDiv").hide();
		$('#businessLicenseNum').textbox({required:false});
		$("#taxIdentifiCodeDiv").hide();
		$('#taxIdentifiCode').textbox({required:false});
		$("#socialCreditCodeDiv").show();
		$('#socialCreditCode').textbox({required:true});
	}
 	function selectedProvince(selectRow){
			$("#province").val(selectRow.areaName);
			$("#city").val('');
			$("#county").val('');
			$cityCombobox.combobox('reload');
			$cityCombobox.combobox('setValue','');
			$countyCombobox.combobox('reload');
			$countyCombobox.combobox('setValue','');
			
	}
	//初始化选择城市
	function beforeSelectCity(param){
		var province = $("#province").val();
		if(province == null || province == ''){
			param.parentAddrName='noMatchId';
		}else{
			param.parentAreaName=province;
		}
	}
	//初始化选择区/县
	function beforeSelectDistrict(param){
		var province = $("#province").val();
		var city =  $("#city").val();
		if(province == null || province == ''){
			param.parentAreaName2='noMatchId';
		}else{
			param.parentAreaName2=province;
		}
		if(city == null || city == ''){
			param.parentAreaName='noMatchId';
		}else{
			param.parentAreaName=city;
		}
	}
	//城市
	function selectedCity(selectRow){
		$("#city").val(selectRow.areaName);
		$("#county").val('');
		$countyCombobox.combobox('reload');
		$countyCombobox.combobox('setValue','');
	}
	function selectedDistrict(selectRow){
		$("#county").val(selectRow.id);
	}
		
	function check(){
		//取消其他材料必输
		/* if($("#qualityReport").val() == null || $("#qualityReport").val() == ''){
			window.parent.operationtip('质检报告图片未上传', 'info');
			return;
		} */
		
		if($("#storeLogo").val() == null || $("#storeLogo").val() == ''){
			window.parent.operationtip('店铺logo未上传', 'info');
			return;
		}
		
		if(!($acctHeaderForm.form('validate') && $("#iDFinishtime1").datebox('isValid')
				&& $("#iDFinishtime1").datebox('isValid') && $("#markRegistrationNum1").textbox('isValid')
				&& $("#brandAuthorizaStart1").datebox('isValid') && $("#brandAuthorizaEnd1").datebox('isValid')
				&& $("#storeName1").textbox('isValid') && $("#storeDetails1").textbox('isValid')
				&& $("#storeType1").combobox('isValid'))){
			window.parent.operationtip('请完善必输项', 'info');
			return;
		}
		
		$.messager.confirm("操作提示", '是否确认提交审批？', function(data) {
			if(data){
				
				$("#iDStarttime").val($("#iDStarttime1").datebox("getValue"));
				$("#iDFinishtime").val($("#iDFinishtime1").datebox("getValue"));
				$("#markRegistrationNum").val($("#markRegistrationNum1").val());
				$("#brandAuthorizaStart").val($("#brandAuthorizaStart1").datebox("getValue"));
				$("#brandAuthorizaEnd").val($("#brandAuthorizaEnd1").datebox("getValue"));
				$("#storeName").val($("#storeName1").val());
				$("#storeDetails").val($("#storeDetails1").val());
				$("#storeType").val($("#storeType1").combobox("getValue"));
				
				
				var options = {
						url : '${AppContext.ctxPath}/action/portal/enterprise/upsert',
						type : 'post',
						dataType :'json',
						data: {},
						success : function(data) {
							if (data.success) {
								$.post('${AppContext.ctxPath}/action/portal/storeregister/storeStatusUpdate',
										{},
										function(data) {
											if (!data.success) {
												errFun(data.result,that);
											} else {
												window.parent.operationtip("你的资料提交成功！请等待审核通过！", 'info');
												$('#btn_submit').linkbutton('disable');
												$('#span_cancel').show();
												successFun("",that);
											}
								});
							} else {
								window.parent.operationtip(data.result, 'error');
							}
						}
					};
				$acctHeaderForm.ajaxSubmit(options);
			}
		});
			
	}
	
	// 撤回
	function cancel(){
		$.post('${AppContext.ctxPath}/action/portal/storeregister/storeStatusUpdate',
				{storeStatus : 'cancel'},
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					} else {
						window.parent.operationtip("你的资料已撤回！", 'info');
						$('#span_cancel').hide();
						$('#btn_submit').linkbutton('enable');
						successFun("",that);
					}
		});
	}
	//根据userid初始化信息填写界面，审批拒绝之后会跳到该页面进行修改
	function enterpriseInfoInit(){
		var enter = {};
		$.post("${AppContext.ctxPath}/action/portal/enterprise/queryByUserId",{},
			function(data){
					if(data.success){
						enter = data.result;
						if(enter!=null){
							if(enter.storeStatus == "AUDIT_REJECT"){
								window.parent.operationtip("您的申请被拒绝，拒绝理由："+ enter.approvalOpinion + ",请修改后再提交", 'info');
							} else if( enter.storeStatus == "CHECK_PENDING" ){
								window.parent.operationtip("你的资料已提交！请等待审核通过！", 'info');
								$('#span_cancel').show();
								$('#btn_submit').linkbutton('disable');
							} else if( enter.storeStatus == "AUDIT_PASSED" ){
								window.location.href = '${AppContext.ctxPath}/portal/enterprise/depositPayment.jsp';
							}
							
							$acctHeaderForm.form("load", enter);
							
							$("#iDStarttime1").datebox("setValue",enter.iDStarttime);
							$("#iDFinishtime1").datebox("setValue",enter.iDFinishtime);
							$("#brandAuthorizaStart1").datebox("setValue",enter.brandAuthorizaStart);
							$("#brandAuthorizaEnd1").datebox("setValue",enter.brandAuthorizaEnd);
							$("#storeType1").combobox('setValue',enter.storeType);
							$("#storeName1").textbox('setValue',enter.storeName);
							$("#markRegistrationNum1").textbox('setValue',enter.markRegistrationNum);
							$("#storeDetails1").textbox('setValue',enter.storeDetails);

							initRadioButton();
							//三证合一
							if(enter.ifThreeInOne=='Y'){
								isThreeInOne();
							}else if(enter.ifThreeInOne=='N'){
								unThreeInOne();
							}
							//图片
							var pIdentifiCardPath = enter.pIdentifiCardPath;
							var NIdtifiCardPath = enter.nIdtifiCardPath;
							var businessLicensePath = enter.businessLicensePath;
							var openAccountLicensePath = enter.openAccountLicensePath;
							var qualityReportPath = enter.qualityReportPath;
							var certificateRegistrationPath = enter.certificateRegistrationPath;
							var authorizationCertificatePath = enter.authorizationCertificatePath;
							var storeLogoPath = enter.storeLogoPath;
						}
						$('#pIdentifiCard1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :pIdentifiCardPath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#pIdentifiCard").val(result.id); 
							},
							myRemove : function(){
								$('#pIdentifiCard').val('');
							}
						});
						$('#NIdtifiCard1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :NIdtifiCardPath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#NIdtifiCard").val(result.id); 
							},
							myRemove : function(){
								$('#NIdtifiCard').val('');
							}
						});
						$('#businessLicense1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :businessLicensePath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#businessLicense").val(result.id); 
							},
							myRemove : function(){
								$('#businessLicense').val('');
							}
						});
						$('#openAccountLicense1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :openAccountLicensePath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#openAccountLicense").val(result.id); 
							},
							myRemove : function(){
								$('#openAccountLicense').val('');
							}
						});
						$('#qualityReport1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :qualityReportPath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#qualityReport").val(result.id); 
							},
							myRemove : function(){
								$('#qualityReport').val('');
							}
						});
						$('#certificateRegistration1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :certificateRegistrationPath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#certificateRegistration").val(result.id); 
							},
							myRemove : function(){
								$('#certificateRegistration').val('');
							}
						});
						$('#authorizationCertificate1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :authorizationCertificatePath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#authorizationCertificate").val(result.id); 
							},
							myRemove : function(){
								$('#authorizationCertificate').val('');
							}
						});
						$('#storeLogo1').BobImage({
							upLoadUrl : '${AppContext.ctxPath}/action/portal/myFile/uploadImg',
						    initImgUrl :storeLogoPath,
						    readOnly : false,
						    width : '100px',
						    height : '100px',
							myComplete : function (success, result, message){
								// 自定义操作
								// $('#fileId').val(result.id);
								
								$("#storeLogo").val(result.id); 
							},
							myRemove : function(){
								$('#storeLogo').val('');
							}
						});
						
				}
			});
		
	}
	</script> 
</body>
</html>