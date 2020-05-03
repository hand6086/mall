<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
</head>
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
</style>
<body> 
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north'" collapsible="false" border="false" style="width:100%;height:100%;padding:0px;" title="">
		<div id="header" class="easyui-panel" style="height:155px">
			<form id="AccntHeaderForm" method="post">
			<table id="typeTable">
		       	<tr>
		       		<td width="120" class="td-label"><label>客户编码</label></td>
		       		<td width="100">
		       			<input id="accntCode" name="accntCode" disabled size="25" class="easyui-validatebox td-input" />
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>客户名称：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="accntName" name="accntName" size="25" class="easyui-validatebox td-input" />
		       		</td>
		       		<td width="120" class="td-label"><label>配送网点类型：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="channelType" name="channelType" size="25" class="easyui-combobox td-input" />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>联系人：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="contact" name="contact" size="25" class="easyui-validatebox td-input" />
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>联系电话：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="contactPhone" name="contactPhone" size="25" class="easyui-validatebox td-input" />
		       		</td>
		       		<td width="120" class="td-label"><label>状态：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="status" name="status" size="25" class="easyui-combobox td-input" />
		       		</td>
		       	</tr>
		       	 	<tr>
		       		<td width="120" class="td-label"><label>省/直辖市&nbsp;</label></td>
		       		<td width="100">
		       			<input id="province" name="province" size="25" class="easyui-combobox td-input" />
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>城市：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="city" name="city" size="25" class="easyui-combobox td-input" />
		       			<input id="cityId" name="cityId" size="25" class="easyui-validatebox td-input" hidden="true"/>
		       		</td>
		       		<td width="120" class="td-label"><label>区县：&nbsp;</label></td>
		       		<td width="100">
		       			<input id="district" name="district" size="25" class="easyui-combobox td-input" />
		       		</td>
		       	</tr>
		       	<tr>
		       		<td width="120" class="td-label"><label>详细地址&nbsp;</label></td>
		       		<td width="100">
		       			<input id="address" name="address" size="25" class="easyui-validatebox td-input" />
		       		</td>
		       		
		       		<td width="120" class="td-label"><label>GPS精度&nbsp;</label></td>
		       		<td width="100">
		       			<input id="gpsLong" name="gpsLong" size="25" class="easyui-numberbox" data-options="min:0,
																					precision:7"/>
		       		</td>
		       		<td width="120" class="td-label"><label>GPS纬度&nbsp;</label></td>
		       		<td width="100">
		       			<input id="gpsLati" name="gpsLati" size="25" class="easyui-numberbox" data-options="min:0,
																					precision:7"/>
		       		</td>
		       	</tr>
		    </table>
		    </form>
		   
			<div>
				<center>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" onclick="cancel()" plain="true">返回</a>
		    		&nbsp;&nbsp;&nbsp;
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" onclick="save()" plain="true">保存</a>
				</center>
			</div>
		</div>
	 <div id="user-tabs" class="easyui-tabs" style="width: 100%; height: 430px;" data-options="border:false">
				<div title="用户" href="${AppContext.ctxPath}/portal/o2oaccnt/StoreInfoTab.jsp"></div>
				
		</div> 
	</div>
</div>   

<script type="text/javascript">
var accntId = "${param.accntId}";
$AccntHeaderForm=$('#AccntHeaderForm');

$statusCombobox	     = $('#status');

function AccNameInfoInit(accntId,refreshDatagrid){
	if(!accntId){
		$.messager.alert("错误","参数错误, 无法获取Id", "error");
		return;
	}
	var accntResult = {};

	$.post("${AppContext.ctxPath}/action/portal/store/queryById",{id:accntId},
		function(data){
			if(data){
				if(data.success){
					accntResult = data.result;
					loadObject(accntResult);
					$AccntHeaderForm.form('load',accntResult);
					
					$('#city').combobox('reload');
					$('#district').combobox('reload');
				}else{
				
				}
			}
		});
	
}
function loadObject(object){
	$("#AccntHeaderForm").form("clear");
	$("#AccntHeaderForm").form("load", object);
	for (key in object) {
		value = object[key];
		
	} 
}
//初始化 类型下拉列表
$statusCombobox.combobox({ 
    method:'get',
	data:getLovArray('TB_O2O_STATUS'),
	valueField:'val',
	textField:'name',
    editable:false, //不可编辑状态
    panelHeight: 'auto',//自动高度适合
    cache: false
});

$('#channelType').combobox({ 
	method:'get',
	data:getLovArray('TB_O2O_CHANNEL_TYPE'),
	valueField:'val',
	textField:'name',
	panelHeight: 'auto',
    cache: false
});

$('#channelType').combobox({ 
	method:'get',
	data:getLovArray('TB_O2O_CHANNEL_TYPE'),
	valueField:'val',
	textField:'name',
	panelHeight: 'auto',
    cache: false
});

$('#province').combobox({ 
	valueField:'areaName',
	textField:'areaName',
	method:'get',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
	editable:false,
	onSelect:selectedProvince,
	required:true
});

function selectedProvince(selectRow){
	$('#city').combobox('reload');
	$('#city').combobox('setValue','');
	$('#district').combobox('reload');
	$('#district').combobox('setValue','');
}

$('#city').combobox({ 
	valueField:'areaName',
	textField:'areaName',
	method:'get',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
	onBeforeLoad:beforeSelectCity,
	onSelect:selectedCity,
	editable:false,
	required:true
});

function beforeSelectCity(param){
	var province = $('#province').combobox('getValue');
	if(province == null || province == ''){
		param.parentAddrName='noMatchId';
	}else{
		param.parentAreaName=province;
	}
}

function selectedCity(selectRow){
	$('#cityId').val(selectRow.id);
	$('#district').combobox('reload');
	$('#district').combobox('setValue','');
}

$('#district').combobox({ 
	valueField:'areaName',
	textField:'areaName',
	method:'get',
	url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
	onBeforeLoad:beforeSelectDistrict,
	editable:false,
	required:true
});

//初始化选择区/县
function beforeSelectDistrict(param){
	var province = $('#province').combobox('getValue');
	var city = $('#city').combobox('getValue');
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

function cancel(){
	window.parent.closeAccNameWin();
}

function save(){
	var options = {
		url : '${AppContext.ctxPath}/action/portal/store/update',
		type : 'post',
		dataType :'json',
		data: {id:accntId},
		beforeSubmit: function() {
			var result = $AccntHeaderForm.form('validate');
			return result;
		},  
		success : function(data) {
			if (data.success) {
				store = data.newRow;
				window.parent.operationtip('保存成功！', 'info');
				window.parent.closeAccNameWin("ok");
			} else {
				window.parent.operationtip(data.result, 'error');
			}
		}
	};
	$AccntHeaderForm.ajaxSubmit(options);
};
</script>
</body>
</html>