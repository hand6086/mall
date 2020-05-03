<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css">
</style>
<body>		
  <div  class="easyui-layout" border="false" fit="true">		
		<div data-options="region:'north',split:true" title="" border="false"  style="width: 100%;" fit="true">
			<table id="address-table" fit="true">
				<thead>
					<tr>
						<th field="custmName" width="80px"  <%-- editor="{type:'picklistbox',options:{title:'消费者名称',
															completeFun:custmNamePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/customerNamePickList.jsp'}}"  --%>
															>消费者名称</th>
						<th field="custmCode" width="80px">消费者编码</th>
						<th field="custmPhone" width="100px">消费者电话</th>
						<th field="isPredefault" width="80px"lov="TB_O2O_JUDGE_TYPE"editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false,
																required:true,}}">是否默认地址</th>
						<th field="province" width="100px" editor="{type:'combobox',options:{
																		valueField:'areaName',
																		textField:'areaName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
																		editable:false,
																		onSelect:selectedProvince,
																		required:true,
																		onLoadSuccess : loadProvinceSuccess}}">省</th>
						<th field="city" width="100px"  editor="{type:'combobox',options:{
																		valueField:'areaName',
																		textField:'areaName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
																		onBeforeLoad:beforeSelectCity,
																		onSelect:selectedCity,
																		required:true,
																		editable:false}}">市</th>
						<th field="district" width="100px" editor="{type:'combobox',options:{
																		required:true,
																		valueField:'areaName',
																		textField:'areaName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
																		onBeforeLoad:beforeSelectDistrict,
																		onSelect:selectedDistrict,
																		editable:false}}">区/县</th>
						<th field="address" width="80px" editor="{type:'textbox', options:{required:true}}">详细地址</th>
						<th field="contact" width="100px" editor="{type:'textbox',options:{required:true}}">收货人</th>
						<th field="contPhone" width="105px" editor="{type:'textbox',options:{required:true}}">联系电话</th>
						<th field="gpsLong" width="80px" editor="{type:'numberbox',options:{min:0,precision:7}}">GPS经度</th>
						<th field="gpsLat" width="80px" editor="{type:'numberbox',options:{min:0,precision:7}}">GPS纬度</th>
						<th field="postCode" width="80px" editor="{type:'numberbox'}">邮政编码</th>
						<th field="labelName" width="80px"  editor="{type:'combobox',options:{
																		valueField:'labelName',
																		textField:'labelName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/labelNamePickList',
																		panelHeight: 'auto',//自动高度适合
																		onSelect:selectedLabel,
																		editable:false}}">地址标签</th>
						<th field="labelId" hidden="true">标签ID</th>
						<th field="status" width="80px"lov="TB_O2O_STATUS"editor="{type:'combobox',options:{valueField:'val',
															textField:'name',
															data:getLovArray('TB_O2O_STATUS'),
															editable:false,
															panelHeight: 'auto',//自动高度适合
															required:true,}}">状态</th>
					</tr>
				</thead>
			</table>
		</div>					
	</div>  

	<script type="text/javascript">
		$('.easyui-layout').layout(); 
		$datagrid = $('#address-table');
		$datagrid
				.hdatagrid({
					updateable:true,
					toolbarShow:true,	//显示工具栏
					buttonSearch:true,	//搜索框功能
					buttonExport:false,
					buttonCopy:false,
					buttonMenu:true,
					nowrap:false,
					oauthFlag:true,
					pagination:true,
					menuButtonCount : true,
					striped:true,
					title:'',
					border:false,
					pageSize: 25,//每页显示的记录条数，默认为10 
					pageList: [5,10,25],//可以设置每页记录条数的列表 
					url : '${AppContext.ctxPath}/action/portal/address/queryByExamplePage',
					
					onInsertOrUpdateAction:function(row,successFun,errFun,that){
						$.post('${AppContext.ctxPath}/action/portal/address/upsert',row, 
						function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					},
					onDeleteAction : function(row, successFun, errFun, that) {
					$.messager.confirm("操作提示",'是否确定删除信息？',
					function(data) {
						if (data) {
							$.post('${AppContext.ctxPath}/action/portal/address/deleteById',
							{id : row.id},
							function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {successFun(that);}
							});
							}
						});
					},
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(95,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="updateLatLng()">更新经纬度</a>',that);
					},
					onInitNewData:function(that){return{
						status:'Active',
						isPredefault:'N'
						
					};},
				});
		//消费者名称picklist
		function custmNamePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').custmName = selectRow.customerName;
			$datagrid.hdatagrid('getCurrentRow').custId = selectRow.id;
			return selectRow.customerName;
		}			
		//初始化选择城市
		
		function beforeSelectCity(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			if(province == null || province == ''){
				param.parentAddrName='noMatchId';
			}else{
				param.parentAreaName=province;
			}
		}

		//初始化选择区/县
		function beforeSelectDistrict(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			var city = $datagrid.hdatagrid('getCurrentRow').city;
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
		//选择省份
		function selectedProvince(selectRow){
			//alert(selectRow.id);
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.areaName;
			$datagrid.hdatagrid('getCurrentRow').city = '';
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').provinceId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').cityId = '';
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('setValue','');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
			
		}
		function loadProvinceSuccess(){
			
		}
		//城市
		function selectedCity(selectRow){
			$datagrid.hdatagrid('getCurrentRow').city = selectRow.areaName;
			$datagrid.hdatagrid('getCurrentRow').district = '';
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').districtId = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
		}
		function selectedDistrict(selectRow){
			$datagrid.hdatagrid('getCurrentRow').districtId = selectRow.id;
		}
		
		function updateLatLng(){
			var row = $datagrid.datagrid('getSelected');
			$.messager.confirm("操作提示", '是否确定更新经纬度信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/address/updateLatLng', row,
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		function selectedLabel(selectRow){
			$datagrid.hdatagrid('getCurrentRow').labelId = selectRow.id;
		}
		
	</script>
</body>
</html>