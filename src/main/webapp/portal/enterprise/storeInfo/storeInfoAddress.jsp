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
}
.td-content textarea{
	width:180px;
}
</style>
<body>
		<table class="form-table">
		    <tr>
				<td>
					<fieldset>
						<legend>企业地址</legend>
						<table class="form-table" style="height: 50px;">							
							<tr>
								<td class="td-label" style="text-align: left;"><label>公司注册地址 ：</label></td>
								<td class="td-content">
									<input style="margin-left:35px;width:585px;border:none;" name="applicantAddress1" type="text" id="applicantAddress1" disabled/>
								</td>
						</table>
					</fieldset>
				</td>
			</tr>
		    <tr>
				<td>
					<fieldset>
						<legend>收货地址</legend>
						<form id="addressForm1" method="post">
							<table class="form-table">							
								<tr>
									<td class="td-label" style="text-align: left;"><label>收货地址1 ： </label></td>
									<td class="td-address addr1">
										<label style="margin-right:75px;">收货人：<input style="width:200px;" class="easyui-textbox" name="contact1" id="contact1" disabled required/></label>
										<label>收货电话：<input style="width:200px;" class="easyui-textbox" name="contPhone1" id="contPhone1" disabled required data-options="validType:'phoneNum'"/></label>
										<input name="addressId1" id="addressId1" hidden="true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label" style="text-align: left;"><label> </label></td>
									<td class="td-address addr1">
										<label style="margin:0px 28px 0px 12px;">省份：<input name="province1" id="province1" class="easyui-combobox" disabled required/></label>
										<label style="margin-right:28px;">城市：<input name="city1" id="city1" class="easyui-combobox" disabled required/></label>
										<label>区/县：<input name="district1" id="district1" class="easyui-combobox" disabled required/></label>
									</td>
								</tr>
								<tr>
									<td class="td-label" style="text-align: left;"><label>默认 <input id="isPredefault1"  type="checkbox" disabled/> </label></td>
									<td class="td-address addr1">
										<label style="margin:0px 32px 0px 12px;">街道：<input style="width:540px;" class="easyui-textbox" id='address1' name="address1" disabled required/></label>
										<a href="javascript:void(0)" onclick="updateAddress1()" id="updateAddress1" style="margin-left:100px;background-color: #e0ecff; width: 80px;" class="easyui-linkbutton" plain="true">更改</a>
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
						<form id="addressForm2" method="post">
							<table class="form-table">	
								<tr>
									<td class="td-label" style="text-align: left;"><label>收货地址2： </label></td>
									<td class="td-address addr2">
										<label style="margin-right:75px;">收货人：<input style="width:200px;" class="easyui-textbox" name="contact2" id="contact2" disabled required/></label>
										<label>收货电话：<input style="width:200px;" class="easyui-textbox" name="contPhone2" id="contPhone2" disabled required data-options="validType:'phoneNum'"/></label>
										<input name="addressId2" id="addressId2" hidden="true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label" style="text-align: left;"><label> </label></td>
									<td class="td-address addr2">
										<label style="margin:0px 28px 0px 12px;">省份：<input name="province2" id="province2" class="easyui-combobox" disabled required/></label>
										<label style="margin-right:28px;">城市：<input name="city2" id="city2" class="easyui-combobox" disabled required/></label>
										<label>区/县：<input name="district2" id="district2" class="easyui-combobox" disabled required/></label>
									</td>
								</tr>
								<tr>
									<td class="td-label" style="text-align: left;"><label>默认 <input id="isPredefault2"  type="checkbox" disabled/> </label></td>
									<td class="td-address addr2">
										<label style="margin:0px 32px 0px 12px;">街道：<input style="width:540px;" class="easyui-textbox" id='address2' name="address2" disabled required/></label>
										<a href="javascript:void(0)" onclick="updateAddress2()" id="updateAddress2" style="margin-left:100px;background-color: #e0ecff; width: 80px;" class="easyui-linkbutton" plain="true">更改</a>
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
						<form id="addressForm3" method="post">
							<table class="form-table">	
								<tr>
									<td class="td-label" style="text-align: left;"><label>收货地址3 ： </label></td>
									<td class="td-address addr3">
										<label style="margin-right:75px;">收货人：<input style="width:200px;" class="easyui-textbox" name="contact3" id="contact3" disabled required/></label>
										<label>收货电话：<input style="width:200px;" class="easyui-textbox" name="contPhone3" id="contPhone3" disabled required data-options="validType:'phoneNum'"/></label>
										<input name="addressId3" id="addressId3" hidden="true"/>
									</td>
								</tr>
								<tr>
									<td class="td-label" style="text-align: left;"><label> </label></td>
									<td class="td-address addr3">
										<label style="margin:0px 28px 0px 12px;">省份：<input name="province3" id="province3" class="easyui-combobox" disabled required/></label>
										<label style="margin-right:28px;">城市：<input name="city3" id="city3" class="easyui-combobox" disabled required/></label>
										<label>区/县：<input name="district3" id="district3" class="easyui-combobox" disabled required/></label>
									</td>
								</tr>
								<tr>
									<td class="td-label" style="text-align: left;"><label>默认 <input id="isPredefault3"  type="checkbox" disabled/> </label></td>
									<td class="td-address addr3">
										<label style="margin:0px 32px 0px 12px;">街道：<input style="width:540px;" class="easyui-textbox" id='address3' name="address3" disabled required/></label>
										<a href="javascript:void(0)" onclick="updateAddress3()" id="updateAddress3" style="margin-left:100px;background-color: #e0ecff; width: 80px;" class="easyui-linkbutton" plain="true">更改</a>
									</td>
								</tr>
							</table>
						</form>
					</fieldset>
				</td>
			</tr>
		</table>
<script type="text/javascript">
$("#applicantAddress1").val(applicantAddress);

addressInfoInit();//页面加载时调用初始化函数

function addressInfoInit(){
	$.post("${AppContext.ctxPath}/action/portal/address/queryByExamplePage",{pageFlag:false,attr1:'afterSale',corpid:appCtx.corpId,brandQuery:'1'},
		function(data){
				if(data.success){
					address = data.rows;
					if(address.length > 0){
						var item = address[0];
						if(item.isPredefault == 'Y'){
							$("#isPredefault1").attr('checked', true);
						}
						$("#addressId1").val(item.id);
						$("#isPredefault1").val(item.isPredefault);
						$("#contact1").textbox("setValue",item.contact);
						$("#contPhone1").textbox("setValue",item.contPhone);
						$("#province1").combobox("setValue",item.province);
						$("#city1").combobox("setValue",item.city);
						$("#district1").combobox("setValue",item.district);
						$("#address1").textbox("setValue",item.address);
						$("#contact1").textbox("setValue",item.contact);
					}
					if(address.length > 1){
						var item = address[1];
						if(item.isPredefault == 'Y'){
							$("#isPredefault2").attr('checked', true);
						}
						$("#addressId2").val(item.id);
						$("#isPredefault2").val(item.isPredefault);
						$("#contact2").textbox("setValue",item.contact);
						$("#contPhone2").textbox("setValue",item.contPhone);
						$("#province2").combobox("setValue",item.province);
						$("#city2").combobox("setValue",item.city);
						$("#district2").combobox("setValue",item.district);
						$("#address2").textbox("setValue",item.address);
						$("#contact2").textbox("setValue",item.contact);
					}
					if(address.length > 2){
						var item = address[2];
						if(item.isPredefault == 'Y'){
							$("#isPredefault3").attr('checked', true);
						}
						$("#addressId3").val(item.id);
						$("#isPredefault3").val(item.isPredefault);
						$("#contact3").textbox("setValue",item.contact);
						$("#contPhone3").textbox("setValue",item.contPhone);
						$("#province3").combobox("setValue",item.province);
						$("#city3").combobox("setValue",item.city);
						$("#district3").combobox("setValue",item.district);
						$("#address3").textbox("setValue",item.address);
						$("#contact3").textbox("setValue",item.contact);
					}
			}
		});
}

$("#isPredefault1").click(function(){
	if($("#isPredefault1").is(":checked")==true){
		if($("#isPredefault2").is(":checked")==true){
			changeisPredefault($("#addressId2").val());
		}
		$("#isPredefault2").attr('checked', false);
		
		if($("#isPredefault3").is(":checked")==true){
			changeisPredefault($("#addressId3").val());
		}
		$("#isPredefault3").attr('checked', false);
	}else{
		changeisPredefault($("#addressId1").val());
	}
}); 

$("#isPredefault2").click(function(){
	if($("#isPredefault2").is(":checked")==true){
		if($("#isPredefault1").is(":checked")==true){
			changeisPredefault($("#addressId1").val());
		}
		$("#isPredefault1").attr('checked', false);

		if($("#isPredefault3").is(":checked")==true){
			changeisPredefault($("#addressId3").val());
		}
		$("#isPredefault3").attr('checked', false);
	}else{
		changeisPredefault($("#addressId2").val());
	}
});

$("#isPredefault3").click(function(){
	if($("#isPredefault3").is(":checked")==true){
		if($("#isPredefault1").is(":checked")==true){
			changeisPredefault($("#addressId1").val());
		}
		$("#isPredefault1").attr('checked', false);

		if($("#isPredefault2").is(":checked")==true){
			changeisPredefault($("#addressId2").val());
		}
		$("#isPredefault2").attr('checked', false);
	}else{
		changeisPredefault($("#addressId3").val());
	}
});
//第一个省市县
$("#province1").combobox({ 
	method:'get',
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
	onSelect:selectedProvince1,
    editable:false, //不可编辑状态
    cache: false
});

function selectedProvince1(selectRow){
	$("#province1").val(selectRow.areaName);
	$("#city1").val('');
	$("#district1").val('');
	$("#city1").combobox('reload');
	$("#city1").combobox('setValue','');
	$("#district1").combobox('reload');
	$("#district1").combobox('setValue','');
	
}

$("#city1").combobox({ 
	method:'get',
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
	onBeforeLoad:beforeSelectCity1,
	onSelect:selectedCity1,
    editable:false, //不可编辑状态
    cache: false
});

//初始化选择城市
function beforeSelectCity1(param){
	var province = $("#province1").val();
	if(province == null || province == ''){
		param.parentAddrName='noMatchId';
	}else{
		param.parentAreaName=province;
	}
}

//城市
function selectedCity1(selectRow){
$("#city1").val(selectRow.areaName);
$("#district1").val('');
$("#district1").combobox('reload');
$("#district1").combobox('setValue','');
}

$("#district1").combobox({ 
	method:'get',
	data:getLovArray('MAIN_PRODUCTS'),
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
	onBeforeLoad:beforeSelectDistrict1,
	onSelect:selectedDistrict1,
    editable:false, //不可编辑状态
    cache: false
});

//初始化选择区/县
function beforeSelectDistrict1(param){
	var province = $("#province1").val();
	var city =  $("#city1").val();
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

function selectedDistrict1(selectRow){
	$("#district1").val(selectRow.id);
}
//第二个省市县
$("#province2").combobox({ 
	method:'get',
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
	onSelect:selectedProvince2,
    editable:false, //不可编辑状态
    cache: false
});

function selectedProvince2(selectRow){
	$("#province2").val(selectRow.areaName);
	$("#city2").val('');
	$("#district2").val('');
	$("#city2").combobox('reload');
	$("#city2").combobox('setValue','');
	$("#district2").combobox('reload');
	$("#district2").combobox('setValue','');
	
}

$("#city2").combobox({ 
	method:'get',
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
	onBeforeLoad:beforeSelectCity2,
	onSelect:selectedCity2,
    editable:false, //不可编辑状态
    cache: false
});

//初始化选择城市
function beforeSelectCity2(param){
	var province = $("#province2").val();
	if(province == null || province == ''){
		param.parentAddrName='noMatchId';
	}else{
		param.parentAreaName=province;
	}
}

//城市
function selectedCity2(selectRow){
$("#city2").val(selectRow.areaName);
$("#district2").val('');
$("#district2").combobox('reload');
$("#district2").combobox('setValue','');
}

$("#district2").combobox({ 
	method:'get',
	data:getLovArray('MAIN_PRODUCTS'),
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
	onBeforeLoad:beforeSelectDistrict2,
	onSelect:selectedDistrict2,
    editable:false, //不可编辑状态
    cache: false
});

//初始化选择区/县
function beforeSelectDistrict2(param){
	var province = $("#province2").val();
	var city =  $("#city2").val();
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

function selectedDistrict2(selectRow){
	$("#district2").val(selectRow.id);
}
//第三个省市县
$("#province3").combobox({ 
	method:'get',
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
	onSelect:selectedProvince3,
    editable:false, //不可编辑状态
    cache: false
});

function selectedProvince3(selectRow){
	$("#province3").val(selectRow.areaName);
	$("#city3").val('');
	$("#district3").val('');
	$("#city3").combobox('reload');
	$("#city3").combobox('setValue','');
	$("#district3").combobox('reload');
	$("#district3").combobox('setValue','');
	
}

$("#city3").combobox({ 
	method:'get',
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
	onBeforeLoad:beforeSelectCity3,
	onSelect:selectedCity3,
    editable:false, //不可编辑状态
    cache: false
});

//初始化选择城市
function beforeSelectCity3(param){
	var province = $("#province3").val();
	if(province == null || province == ''){
		param.parentAddrName='noMatchId';
	}else{
		param.parentAreaName=province;
	}
}

//城市
function selectedCity3(selectRow){
$("#city3").val(selectRow.areaName);
$("#district3").val('');
$("#district3").combobox('reload');
$("#district3").combobox('setValue','');
}

$("#district3").combobox({ 
	method:'get',
	data:getLovArray('MAIN_PRODUCTS'),
	valueField:'areaName',
	textField:'areaName',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
	onBeforeLoad:beforeSelectDistrict3,
	onSelect:selectedDistrict3,
    editable:false, //不可编辑状态
    cache: false
});

//初始化选择区/县
function beforeSelectDistrict3(param){
	var province = $("#province3").val();
	var city =  $("#city3").val();
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

function selectedDistrict3(selectRow){
	$("#district3").val(selectRow.id);
}

function updateAddress1(){
	if($("#updateAddress1").text()=='更改'){
		$("#updateAddress1").linkbutton({text:'保存'});
		$(".addr1").removeClass("td-address");
		$("#isPredefault1").attr("disabled",false);
		$("#contact1").textbox('enable'); 
		$("#contPhone1").textbox('enable'); 
		$("#province1").combobox('enable'); 
		$("#city1").combobox('enable'); 
		$("#district1").combobox('enable'); 
		$("#address1").textbox('enable'); 
	}else{
		var result = $("#addressForm1").form('validate');
		if(result){
			var row_status = null;
			if($("#addressId1").val() != null && $("#addressId1").val() != ''){
				row_status = "UPDATE";
			}else{
				row_status = "NEW";
			}
			
			if($('#isPredefault1').is(":checked")==true){
				$('#isPredefault1').val('Y');
			} else {
				$('#isPredefault1').val('N');
			}
			
			$.post('${AppContext.ctxPath}/action/portal/address/upsert',
					{
						row_status : row_status,
						id : $("#addressId1").val(),
						isPredefault : $("#isPredefault1").val(),
						contact : $("#contact1").val(),
						contPhone : $("#contPhone1").val(),
						province : $("#province1").combobox("getValue"),
						city : $("#city1").combobox("getValue"),
						district : $("#district1").combobox("getValue"),
						address : $("#address1").val(),
						contact : $("#contact1").val(),
						status : 'Active',
						addressType : 'AFTER_SERVICE'
					},
					function(data) {
						if (!data.success) {
							window.parent.operationtip(data.result, 'error');
							errFun(data.result,that);
						} else {
							if(row_status == "NEW"){
								addressInfoInit();
							}
							$("#updateAddress1").linkbutton({text:'更改'});
							$(".addr1").addClass("td-address");
							$("#isPredefault1").attr("disabled",true);
							$("#contact1").textbox('disable'); 
							$("#contPhone1").textbox('disable'); 
							$("#province1").combobox('disable'); 
							$("#city1").combobox('disable'); 
							$("#district1").combobox('disable'); 
							$("#address1").textbox('disable'); 
						}
			});
		}else{
			return result;
		}
		
	}
}

function updateAddress2(){
	$('#pauseCtrl').linkbutton({text:'暂停'});
	if($("#updateAddress2").text()=='更改'){
		$("#updateAddress2").linkbutton({text:'保存'});
		$(".addr2").removeClass("td-address");
		$("#isPredefault2").attr("disabled",false);
		$("#contact2").textbox('enable'); 
		$("#contPhone2").textbox('enable'); 
		$("#province2").combobox('enable'); 
		$("#city2").combobox('enable'); 
		$("#district2").combobox('enable'); 
		$("#address2").textbox('enable'); 
	}else{
		var result = $("#addressForm2").form('validate');
		if(result){
			var row_status = null;
			if($("#addressId2").val() != null && $("#addressId2").val() != ''){
				row_status = "UPDATE";
			}else{
				row_status = "NEW";
			}
			
			if($('#isPredefault2').is(":checked")==true){
				$('#isPredefault2').val('Y');
			} else {
				$('#isPredefault2').val('N');
			}
			
			$.post('${AppContext.ctxPath}/action/portal/address/upsert',
					{
						row_status : row_status,
						id : $("#addressId2").val(),
						isPredefault : $("#isPredefault2").val(),
						contact : $("#contact2").val(),
						contPhone : $("#contPhone2").val(),
						province : $("#province2").combobox("getValue"),
						city : $("#city2").combobox("getValue"),
						district : $("#district2").combobox("getValue"),
						address : $("#address2").val(),
						contact : $("#contact2").val(),
						status : 'Active',
						addressType : 'AFTER_SERVICE'
					},
					function(data) {
						if (!data.success) {
							window.parent.operationtip(data.result, 'error');
							errFun(data.result,that);
						} else {
							if(row_status == "NEW"){
								addressInfoInit();
							}
							$("#updateAddress2").linkbutton({text:'更改'});
							$(".addr2").addClass("td-address");
							$("#isPredefault2").attr("disabled",true);
							$("#contact2").textbox('disable'); 
							$("#contPhone2").textbox('disable'); 
							$("#province2").combobox('disable'); 
							$("#city2").combobox('disable'); 
							$("#district2").combobox('disable'); 
							$("#address2").textbox('disable'); 
						}
			});
		}else{
			return result;
		}
		
	}
}

function updateAddress3(){
	if($("#updateAddress3").text()=='更改'){
		$("#updateAddress3").linkbutton({text:'保存'});
		$(".addr3").removeClass("td-address");
		$("#isPredefault3").attr("disabled",false);
		$("#contact3").textbox('enable'); 
		$("#contPhone3").textbox('enable'); 
		$("#province3").combobox('enable'); 
		$("#city3").combobox('enable'); 
		$("#district3").combobox('enable'); 
		$("#address3").textbox('enable'); 
	}else{
		var result = $("#addressForm3").form('validate');
		if(result){
			var row_status = null;
			if($("#addressId3").val() != null && $("#addressId3").val() != ''){
				row_status = "UPDATE";
			}else{
				row_status = "NEW";
			}
			
			if($('#isPredefault3').is(":checked")==true){
				$('#isPredefault3').val('Y');
			} else {
				$('#isPredefault3').val('N');
			}
			
			$.post('${AppContext.ctxPath}/action/portal/address/upsert',
					{
						row_status : row_status,
						brandUpsert:'1',
						id : $("#addressId3").val(),
						isPredefault : $("#isPredefault3").val(),
						contact : $("#contact3").val(),
						contPhone : $("#contPhone3").val(),
						province : $("#province3").combobox("getValue"),
						city : $("#city3").combobox("getValue"),
						district : $("#district3").combobox("getValue"),
						address : $("#address3").val(),
						contact : $("#contact3").val(),
						status : 'Active',
						addressType : 'AFTER_SERVICE'
					},
					function(data) {
						if (!data.success) {
							window.parent.operationtip(data.result, 'error');
							errFun(data.result,that);
						} else {
							if(row_status == "NEW"){
								addressInfoInit();
							}
							$("#updateAddress3").linkbutton({text:'更改'});
							$(".addr3").addClass("td-address");
							$("#isPredefault3").attr("disabled",true);
							$("#contact3").textbox('disable'); 
							$("#contPhone3").textbox('disable'); 
							$("#province3").combobox('disable'); 
							$("#city3").combobox('disable'); 
							$("#district3").combobox('disable'); 
							$("#address3").textbox('disable'); 
						}
			});
		}else{
			return result;
		}
		
	}
}
function changeisPredefault(id){
	if(id == null || id == ''){
		return;
	}
	$.post('${AppContext.ctxPath}/action/portal/address/upsert',
			{
				row_status : "UPDATE",
				brandUpsert:'1',
				id : id,
				isPredefault : 'N',
			},
			function(data) {
				if (!data.success) {
					
				} else {
					
				}
	});
}
</script>
</body>
</html>