<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<head>
</head>

<body>
<style type="text/css">
.center{
	width:100%;
	height:100%;
}
.center table{
	margin: 50px auto;
}
.td-label{
	font-size:12px;
	text-align:right;
	height:40px;
}
.td-content{
	height:40px;
	width:300px;
}
</style>

	<div class="center">
		<table>
			<tr>
				<td class="td-label"><label>地址类型 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-combobox" name="addrType" id="addrType" style="width: 174px;" />
	         		<input type="hidden" name="addressId" id="addressId" />
	         	</td>
	        </tr>
	        
	        <tr>
				<td class="td-label"><label>省/(直辖)市 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-combobox" name="province" id="province" style="width: 174px;" />
	         	</td>
	        </tr>
	        
	        <tr>
	         	<td class="td-label"><label>城市 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-combobox" name="city" id="city" style="width: 174px;" />
	         	</td>
	        </tr>
	        
	        <tr>
	         	<td class="td-label"><label>县区 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-combobox" name="district" id="district" style="width: 174px;" />
	         	</td>
	        </tr>
	        
	        <tr>
	         	<td class="td-label"><label>乡镇 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-combobox" name="town" id="town" style="width: 174px;" />
	         	</td>
	        </tr>
	        
	        <tr>
	         	<td class="td-label" rowspan="2"><label>详细地址 :</label></td>
	         	<td class="td-content" rowspan="2">
	         		<textarea class="easyui-validatebox"  name="addr" id="addr" style="width:174px; height:100%; font-size: 13px;" >${address.addr}</textarea>
	         	</td>
	         	
	        </tr>
	        <tr>
	        </tr>
	         	
		</table>
	</div>


	<script type="text/javascript">
		$('#addressId').val('${address.id}');//保存地址的ID，更新地址时要用到
		$provinceCombobox = $('#province');
		$cityCombobox = $('#city');
		$districtCombobox = $('#district');
		$townCombobox = $('#town');
		$addrTypeCombobox = $('#addrType');

		/**
		 * 地址类型下拉
		 */
		 $addrTypeCombobox.combobox({
			data:getLovArray('ADDR_TYPE'),
			valueField : 'name',
			textField : 'name',
			editable : false, //不可编辑状态
			cache : false,
			onLoadSuccess: function () { 
				//如果首次加载，则默认选择原来的地址类型
				var data = $addrTypeCombobox.combobox('getData');
				if (data.length > 0) {
					$addrTypeCombobox.combobox('select', '${address.addrType}');
	             }
			}
		});

		//下拉框选择控件，下拉框的内容是动态查询数据库信息
		/**
		 * 省市县 下拉框选择控件
		 */
		var provinceFirstLoadFlag = true;//省是否首次加载
		var cityFirstLoadFlag = true;//市是否首次加载
		var districtFirstLoadFlag = true;//县是否首次加载
		var townFirstLoadFlag = true;//乡是否首次加载
		 $provinceCombobox.combobox(
				{
					url : '${AppContext.ctxPath}/action/portal/address/provinceList',
					valueField : 'id',
					textField : 'addrName',
					editable : false, //不可编辑状态
					cache : false,
					onSelect : function() {
						$cityCombobox.combobox("setValue", '');
						$districtCombobox.combobox("setValue", '');
						var province = $provinceCombobox.combobox('getValue');
						if (province != '') {
							loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/childList?id=" + province, $cityCombobox);
						}
					},
					onLoadSuccess: function () { 
						//如果首次加载，则默认选择原地址的省份
						if(provinceFirstLoadFlag){
							provinceFirstLoadFlag = false;
							var data = $provinceCombobox.combobox('getData');
							if (data.length > 0) {
								$provinceCombobox.combobox('select', '${address.provinceId}');
				             }
						}
					}
				});
	
		$cityCombobox.combobox({
			editable : false, //不可编辑状态
			cache : false,
			valueField : 'id',
			textField : 'addrName',
			onSelect : function() {
				$districtCombobox.combobox("setValue", '');
				var city = $cityCombobox.combobox('getValue');
				if (city != '') {
					loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/childList?id=" + city, $districtCombobox);
				}
			},
			onLoadSuccess: function () { 
				//如果首次加载，则默认选择原地址的城市
				if(cityFirstLoadFlag){
					cityFirstLoadFlag = false;
					var data = $cityCombobox.combobox('getData');
					if (data.length > 0) {
						$cityCombobox.combobox('select', '${address.cityId}');
		             }
				}
			}
		});
		$districtCombobox.combobox({
			editable : false, //不可编辑状态
			cache : false,
			valueField : 'id',
			textField : 'addrName',
			onSelect : function() {
				$townCombobox.combobox("setValue", '');
				var district = $districtCombobox.combobox('getValue');
				if (district != '') {
					loadAddrPstAjax("${AppContext.ctxPath}/action/portal/address/childList?id=" + district, $townCombobox);
				}
			},
			onLoadSuccess: function () { 
				//如果首次加载，则默认选择原地址的城市
				if(districtFirstLoadFlag){
					districtFirstLoadFlag = false;
					var data = $districtCombobox.combobox('getData');
					if (data.length > 0) {
						$districtCombobox.combobox('select', '${address.districtId}');
		             }
				}
			}
		});
		$townCombobox.combobox({
			editable : false, //不可编辑状态
			cache : false,
			valueField : 'id',
			textField : 'addrName',
			onSelect : function() {},
			onLoadSuccess: function () { 
				//如果首次加载，则默认选择原地址的县/区
				if(townFirstLoadFlag){
					townFirstLoadFlag = false;
					var data = $townCombobox.combobox('getData');
					if (data.length > 0) {
						$townCombobox.combobox('select', '${address.townId}');
		             }
				}
			}
		});
		
		function loadAddrPstAjax(url, objCombobox){
			$.ajax({
				type : "POST",
				url : url,
				cache : false,
				dataType : "json",
				success : function(data) {
					if(objCombobox != null){
						objCombobox.combobox("loadData", data);
					}
				}
			});
		}
	</script>

</body>
</html>