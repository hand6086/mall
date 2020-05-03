<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>
<body>
<div class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
	   <table id="city-table" width="98%" height="347px">
			<thead>
				<tr>
					<th field="cityName" width=20% editor="{type:'picklistbox',options:{title:'选择城市',
																completeFun:cityPicklistComplete,
																tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp'}}">城市</th>
					<th field="cityNotes" width=76% editor="{type:'textbox'}">说明</th>
				</tr>
			</thead>
		</table>
		
		<table id="restaurant-table" width="98%" height="65%" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="name" width="100px" defaultSearch="true" editor="{type:'validatebox', options:{required:true}}">餐厅名称</th>
						<th field="logoUrl" width="80px" formatter="logoFormatter">Logo图片</th>
						<th field="province" width="100px" editor="{type:'combobox',options:{
																				valueField:'areaName',
																				textField:'areaName',
																				method:'get',
																				url:'${AppContext.ctxPath}/action/portal/o2oaddress/provinceList',
																				editable:false,
																				onSelect:selectedProvince,
																				onLoadSuccess : loadProvinceSuccess}}">省/直辖市</th>
						<th field="city" width="100px"  editor="{type:'combobox',options:{
																				valueField:'areaName',
																				textField:'areaName',
																				method:'get',
																				url:'${AppContext.ctxPath}/action/portal/o2oaddress/cityList',
																				onBeforeLoad:beforeSelectCity,
																				onSelect:selectedCity,
																				editable:false}}">市</th>
						<th field="district" width="100px" editor="{type:'combobox',options:{
																				valueField:'areaName',
																				textField:'areaName',
																				method:'get',
																				url:'${AppContext.ctxPath}/action/portal/o2oaddress/districtList',
																				onBeforeLoad:beforeSelectDistrict,
																				onSelect:selectedDistrict,
																				editable:false}}">区/县</th>
						<th field="street" width="200px" editor="{type:'validatebox'}">街道</th>
						<th field="address" width="80px" editor="{type:'validatebox',options:{required:true}}">详细地址</th>
						<th field="phone" width="100px" editor="{type:'validatebox',options:{required:true}}">餐厅电话</th>
						<th field="merchantsName" width="80px" editor="{type:'validatebox'}">配送商名称</th>
						<th field="merchantsContact" width="80px">配送商联系人</th>
						<th field="merchantsPhone" width="80px">配送商联系方式</th>
						<th field="status" width="80px" lov="TB_O2O_STATUS">状态</th>
				   </tr>
				</thead>
			</table>
			<div id="bigImg" style="display: none;">
				<img id="popUpImg"/>
			</div>
		</div>
	</div>
   	
	<script type="text/javascript">
	    $datagrid = $('#city-table');
		$subdatagrid = $('#restaurant-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:false,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			pageSize: 10,//每页显示的记录条数，默认为20 
		    pageList: [10,30,50],//可以设置每页记录条数的列表 
			subGridIds: ['restaurant-table'],
			url:'${AppContext.ctxPath}/action/portal/goodsCity/queryByExamplePage',
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/goodsCity/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/goodsCity/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			
		});
		
		$subdatagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			newDefaultValue:true,
			title:'餐厅列表',
			border:false,
			pageSize: 10, 
		    pageList: [5,10,15],
		    url:'${AppContext.ctxPath}/action/portal/restaurant/queryByExamplePage',
		    parentGridId : 'city-table',
		    parentGridField : 'cityId',
		    linkGridField : 'cityId',
		    onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
		    onInsertOrUpdateAction:function(row,successFun,errFun,that){
		    	row.cityId = $datagrid.datagrid('getSelected').cityId;
				$.post("${AppContext.ctxPath}/action/portal/restaurant/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/restaurant/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});
			},
			

			/**
			 * 切换行，或加载数据成功后，触发选中行信息
			 */
			onChangeSelectedItem:function(row,that){
				if(row.status == 'Active'){
					$("#btn_add").linkbutton({text:'无效'});
				} else{
					$("#btn_add").linkbutton({text:'有效'});
				}
			},
			
 			onAddMoreButton:function(that,addButtonFun){
 				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
			}, 

		});
		
		function logoFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.logoUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
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
		
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
		
		//失效
		function Invalid(){
			var row = $subdatagrid.datagrid('getSelected');
			if(row.status == 'Inactive'){
				$subdatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
			}else{
				$subdatagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
			}
			var index = $subdatagrid.hdatagrid('getRowIndex', row);
            $subdatagrid.datagrid('selectRow',index);
		}
		
		function selectedProd(selectRow){
			$subdatagrid.hdatagrid('getCurrentRow').o2oSeriesId = selectRow.id;
		}
	</script>
</body>
</html>