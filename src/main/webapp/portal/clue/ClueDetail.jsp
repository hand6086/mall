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
	margin: 0px auto;
	width:300px;
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
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
			<div id="header" class="easyui-panel" style="height:50%"
					title="线索" data-options="border:false,tools:[
							{
								iconCls:'icon-reload',
								text:' 刷新',
								handler:function(){clueInfoInit('current')}
							},
							{
								iconCls:'icon-edit',
								text:'添加',
								handler:function(){clueHeadEnable()}
							},{
								iconCls:'icon-save',
								handler:function(){clueHeadUpdate()}
							}]">
					<form id="clueHeaderForm" method="post">
					<table class="form-table">
						<tr>
							<td>
								<fieldset>
									<legend>线索信息</legend>
									<table class="table-block" >
										<tr>
											<td class="td-label"><label>线索编号 :</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="code" type="text" id="code" size="25" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>线索名称 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="name" name="name" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>线索分类 :</label></td>
							         		<td class="td-content">
							         			<input class="easyui-validatebox" type="text" id="type" name="type"  />
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>跟进状态 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="followStatus" name="followStatus" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>公司名称 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="companyName" name="companyName" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>转介绍 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="turnIntroduce" name="turnIntroduce" />
											</td>
										</tr>
										<tr>
											<td class="td-label"></td>
											<td class="td-content"></td>
										</tr>
									</table>
								</fieldset>
							</td>
							<td>
								<fieldset>
									<legend>所在区域</legend>
									<table class="table-block" >
										<tr>
											<td class="td-label"><label>线索来源 :</label></td>
											<td class="td-content">
												<input class="easyui-combobox" type="text" id="source" name="source"  />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>国家 :</label></td>
											<td class="td-content">
												<input class="easyui-combobox" type="text" id="country" name="country"  />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>省份 :</label></td>
							         		<td class="td-content">
							         			<input class="easyui-combobox" type="text" id="province" name="province"  />
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>城市 :</label></td>
							         		<td class="td-content">
							         			<input class="easyui-combobox" type="text" id="city" name="city"  />
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>区/县 :</label></td>
							         		<td class="td-content">
							         			<input class="easyui-combobox" type="text" id="district" name="district"  />
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>地址 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="address" name="address" />
											</td>
										</tr>
										<tr>
											<td class="td-label"></td>
											<td class="td-content"></td>
										</tr>
									</table>
								</fieldset>
							</td>
							<td>
								<fieldset>
									<legend>联系人信息</legend>
									<table class="table-block" >
										<tr>
											<td class="td-label"><label>联系人 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="contactName" name="contactName" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>性别:</label></td>
											<td class="td-content">
												<input class="easyui-combobox" type="text" id="sex" name="sex" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>职位 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="postnName" name="postnName" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>联系方式 :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="mobilePhone" name="mobilePhone" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>QQ/MSN :</label></td>
											<td class="td-content">
												<input class="easyui-validatebox" type="text" id="qqNum" name="qqNum" />
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>价格 :</label></td>
							         		<td class="td-content">
							         			<input class="easyui-numberbox" id="price" name="price" data-options="min:0,precision:2,prefix:'¥'"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>收入:</label></td>
							         		<td class="td-content">
							         			<input class="easyui-numberbox" id="income" name="income" data-options="min:0,precision:2,prefix:'¥'"/>
							         		</td>
										</tr>
									</table>
								</fieldset>
							</td>
						</tr>
					</table>
					<!-- <input type="hidden" name="id" id="acctId" form="acctDetailForm acctHeaderForm">
					<input type="hidden" name="orgId" id="orgId" from="acctDetailForm acctHeaderForm">
					<input type="hidden" name="postnId" id="postnId" form="acctDetailForm acctHeaderForm"> -->
					<input type="hidden" name="id" id="acctId" >
					<input type="hidden" name="orgId" id="orgId">
					<input type="hidden" name="postnId" id="postnId" >
				</form>
				
				<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
					<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="javascript:window.parent.closeClueDetailWin()">返回&nbsp;&nbsp;&nbsp;</a> 
				</div>

			</div>
			<div id="clue-tabs" class="easyui-tabs" style="width:100% ;height:50%"
				data-options="border:false">
				<!-- tabs0  线索跟进 -->
				<div id="clueFollowUp" title="线索跟进" style="height: 100%; width: 100%">
					<%@ include file="ClueFlowUpList.jsp"%>
				</div>
			</div>
			
		</div>
	</div>
<script type="text/javascript">
getLovOfList("[ADDR_TYPE,IS_EFFECTIVE]");

var clueHeadIsEditing = true; //客户头信息是否为编辑状态 标志
var clueDetailIsEditing = true; //客户信息明细是否为编辑状态 标志
var pickSelectedRow = undefined;
var pickSelectedIndex = undefined;
var dataGridSelectIndex = undefined;
var initClueId = "";
var clueId = "${param.clueId}";

/* *********** 定义变量并且绑定输入框   start **************** */
$clueNameInput		 	= $('#name');
$clueTypeInput	   	    = $('#type');
$followStatusCombobox	= $('#followStatus');
$clueCompanyName 		= $('#companyName');

$countryCombobox	 	= $('#country');
$provinceCombobox	 	= $('#province');
$cityCombobox	 	 	= $('#city');
$districtCombobox	 	= $('#district');
$townCombobox	 		= $('#town');
$clueAddressInput		= $('#address');

$clueContactNameInput	= $('#contactName');
$clueMobilePhoneInput   = $('#mobilePhone');
$cluePriceInput			= $('#price');
$clueIncomeInput		= $('#income');
$sexCombobox			= $('#sex');
$cluePostInput			= $('#postnName');
$clueTurnIntroduceInput = $('#turnIntroduce');
$sourceCombobox		    = $('#source');
$clueCodeInput			= $('#code');
$clueQQNum				= $('#qqNum');

$clueHeaderForm = $("#clueHeaderForm");
$clueFollowUp   = $("#clueFollowUp");

/* *********** 定义变量并且绑定输入框   end **************** */

/**
 * 国省市县 下拉框选择控件
 */
 var countryFirstLoadFlag = true;//国家是否首次加载
 var provinceFirstLoadFlag = true;//省是否首次加载
 var cityFirstLoadFlag = true;//市是否首次加载
 var districtFirstLoadFlag = true;//县是否首次加载
 var townFirstLoadFlag = true;//乡镇是否首次加载
 
 $countryCombobox.combobox({
		url : '${AppContext.ctxPath}/action/portal/address/countryList',
		valueField : 'addrName',
		textField : 'addrName',
		editable : false, //不可编辑状态
		cache : false,
		onSelect : function() {
			$provinceCombobox.combobox("setValue", '');
			$cityCombobox.combobox("setValue", '');
			$districtCombobox.combobox("setValue", '');
			$townCombobox.combobox("setValue", '');
			var country = $countryCombobox.combobox('getValue');
			if (country != '') {
				loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + country+"&addrType=State", $provinceCombobox);
			}
		},
		onLoadSuccess: function () { 
			//如果首次加载，则默认选择原地址的国家
			if(countryFirstLoadFlag){
				countryFirstLoadFlag = false;
				var data = $countryCombobox.combobox('getData');
				if (data.length > 0) {
					//$countryCombobox.combobox('select', '${account.countryId}');
	             }
			}
		}
	});
	$provinceCombobox.combobox({
		editable : false, //不可编辑状态
		cache : false,
		valueField : 'addrName',
		textField : 'addrName',
		onSelect : function() {
			$cityCombobox.combobox("setValue", '');
			$districtCombobox.combobox("setValue", '');
			$townCombobox.combobox("setValue", '');
			var province = $provinceCombobox.combobox('getValue');
			if (province != '') {
				loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + province+"&addrType=City", $cityCombobox);
			}
		},
		onLoadSuccess: function () { 
			//如果首次加载，则默认选择原地址的省份
			if(provinceFirstLoadFlag){
				provinceFirstLoadFlag = false;
				var data = $provinceCombobox.combobox('getData');
				if (data.length > 0) {
					//$provinceCombobox.combobox('select', '${account.provinceId}');
	             }
			}
		}
	});
	$cityCombobox.combobox({
		editable : false, //不可编辑状态
		cache : false,
		valueField : 'addrName',
		textField : 'addrName',
		onSelect : function() {
			$districtCombobox.combobox("setValue", '');
			$townCombobox.combobox("setValue", '');
			var city = $cityCombobox.combobox('getValue');
			if (city != '') {
				loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + city+"&addrType=County", $districtCombobox);
			}
		},
		onLoadSuccess: function () { 
			//如果首次加载，则默认选择原地址的城市
			if(cityFirstLoadFlag){
				cityFirstLoadFlag = false;
				var data = $cityCombobox.combobox('getData');
				if (data.length > 0) {
					//$cityCombobox.combobox('select', '${account.cityId}');
	             }
			}
		}
	});
	$districtCombobox.combobox({
		editable : false, //不可编辑状态
		cache : false,
		valueField : 'addrName',
		textField : 'addrName',
		onSelect : function() {
			$townCombobox.combobox("setValue", '');
			var district = $districtCombobox.combobox('getValue');
			if (district != '') {
				loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/queryAddressListSelect?parentAddrName=" + district+"&addrType=Town", $townCombobox);
			}
		},
		onLoadSuccess: function () { 
			//如果首次加载，则默认选择原地址的县/区
			if(districtFirstLoadFlag){
				districtFirstLoadFlag = false;
				var data = $districtCombobox.combobox('getData');
				if (data.length > 0) {
					//$districtCombobox.combobox('select', '${account.districtId}');
	             }
			}
		}
	});
	$townCombobox.combobox({
		editable : false, //不可编辑状态
		cache : false,
		valueField : 'addrName',
		textField : 'addrName',
		onSelect : function() {},
		onLoadSuccess: function () { 
			//如果首次加载，则默认选择原地址的乡镇
			if(townFirstLoadFlag){
				townFirstLoadFlag = false;
				var data = $townCombobox.combobox('getData');
				if (data.length > 0) {
					//$townCombobox.combobox('select', '${account.townId}');
	             }
			}
		}
	});
	/**
	 * 异步加载级联地址数据
	 */
	function loadAddrPstAjax(url, nextObjCombobox){
		$.ajax({
			type : "POST",
			url : url,
			cache : false,
			dataType : "json",
			success : function(data) {
				if(nextObjCombobox != null){
					nextObjCombobox.combobox("loadData", data);
				}
			}
		});
	}
	
	/* $clueHeaderForm.form({
		url : "${AppContext.ctxPath}/action/portal/clue/updateHeader",
		onSubmit : function(){
			return $clueHeaderForm.form('validate');
		}
	}); */
	
	/* $(document).ready(function() {
		clueInfoInit();
	}); */
	/**
	 * 更新客户的头信息
	 */
	function clueHeadUpdate(){
		if(clueHeadIsEditing){
			//acctHeadDisable();
			$clueHeaderForm.form({
				success : function(data){
					var data = eval('(' + data + ')'); // change the JSON string to javascript object
					if (data.success) {
						clueHeadDisable();
						window.parent.operationtip('保存成功！','info');
					} else {
						clueHeadEnable();
						window.parent.operationtip(data.result,'error');
					}
				}
			});
			$clueHeaderForm.submit();
		} 
	}
	
	$clueHeaderForm = $("#clueHeaderForm");
	$clueHeaderForm.form({
		url : "${AppContext.ctxPath}/action/portal/clue/update",
		onSubmit : function(){
			return $clueHeaderForm.form('validate');
		}
	});
	function clueInfoInit(clueId, refreshDatagrid){
		if(!clueId){
			$.messager.alert("错误","参数错误, 无法获取客户id", "error");
			return;
		}else if(clueId == "current"){
			clueId = initClueId;
		}
		initClueId = clueId;
		var clue = {};
		$.post("${AppContext.ctxPath}/action/portal/clue/queryById",{id:initClueId},
			function(data){
				if(data){
					if(data.success){
						clue = data.result;
						$countryCombobox.combobox('select', clue.country);
						$provinceCombobox.combobox('select', clue.province);
						$cityCombobox.combobox('select', clue.city);
						$clueHeaderForm.form("load", clue);
					}
				}
			});
		//设置输入框默认为不可编辑
		clueHeadDisable();

		if(refreshDatagrid){
			/* $addrdatagrid.hdatagrid("reload");
			$contactsDatagrid.hdatagrid("reload");
			$optyDatagrid.hdatagrid("reload");
			$activityDatagrid.hdatagrid("reload");
			$saleOrderDatagrid.hdatagrid("reload");
			$visitDatagrid.hdatagrid("reload"); */
			
		}
	}

	/**
	 * 设置线索头信息的输入框为 不可编辑 状态
	 */
	function clueHeadDisable(){
		if(clueHeadIsEditing){
			$clueNameInput.attr("disabled","disabled");
			$clueTypeInput.attr("disabled","disabled");
			$followStatusCombobox.combobox("disable");
			$clueCompanyName.attr("disabled","disabled");

			$countryCombobox.combobox("disable");
			$provinceCombobox.combobox("disable");
			$cityCombobox.combobox("disable");
			$districtCombobox.combobox("disable");
			$townCombobox.combobox("disable");
			$clueAddressInput.attr("disabled","disabled");

			$clueContactNameInput.attr("disabled","disabled");
			$clueMobilePhoneInput.attr("disabled","disabled");
			$sexCombobox.combobox("disable");
			$cluePriceInput.numberbox("disable");
			$clueIncomeInput.numberbox("disable");
			$cluePostInput.attr("disabled","disabled");
			$clueTurnIntroduceInput.attr("disabled","disabled");
			$sourceCombobox.combobox("disable");
			$clueCodeInput.attr("disabled","disabled");
			$clueQQNum.attr("disabled","disabled");
			clueHeadIsEditing = false;
		}
	}
	/**
	 * 设置客户头信息的输入框为 编辑 状态
	 */
	function clueHeadEnable(){
		if(!clueHeadIsEditing){
			$clueNameInput.removeAttr('disabled');
			/* $clueTypeInput.removeAttr('disabled'); */
			$followStatusCombobox.combobox('enable');
			$clueCompanyName.removeAttr('disabled');
			$clueAddressInput.removeAttr('disabled');
			$clueContactNameInput.removeAttr('disabled');
			$clueMobilePhoneInput.removeAttr('disabled');
			$cluePriceInput.numberbox("enable");
			$clueIncomeInput.numberbox("enable");
			/* $cluePostInput.removeAttr('disabled'); */
			$countryCombobox.combobox('enable');
			$provinceCombobox.combobox('enable');
			$cityCombobox.combobox('enable');
			$districtCombobox.combobox('enable');
			$townCombobox.combobox('enable');
			$sexCombobox.combobox('enable');
			$clueTurnIntroduceInput.removeAttr('disabled');
			$sourceCombobox.combobox('enable');
			$clueCodeInput.removeAttr('disabled');
			$clueQQNum.removeAttr('disabled');
			clueHeadIsEditing = true;
		}
	}
	
	//初始化 性别 下拉列表
	$sexCombobox.combobox({ 
		method:'get',
		data:getLovArray('GENDER'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	//初始化 线索来源 下拉列表
	$sourceCombobox.combobox({ 
		method:'get',
		data:getLovArray('CLUE_SOURCE'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	//初始化 线索类型 下拉列表
	$followStatusCombobox.combobox({ 
		method:'get',
		data:getLovArray('CLUE_FOLLOW_STATUS'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
/* $("#name").attr("disabled","disabled");
$("#address").attr("disabled","disabled");
$("#followStatus").attr("disabled","disabled");
$("#contactName").attr("disabled","disabled");
$("#mobilePhone").attr("disabled","disabled");
$("#post").attr("disabled","disabled");
$("#sex").attr("disabled","disabled");
$("#contactName").attr("disabled","disabled");
$("#companyName").attr("disabled","disabled");
$("country").combobox("disabled");
$("province").combobox("disabled");
$("city").combobox("disabled");
$("district").combobox("disabled");
$("#type").attr("disabled","disabled");
$("#price").attr("disabled","disabled");
$("#income").attr("disabled","disabled"); */
</script>
</body>
</html>