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
	         		<input class="easyui-validatebox" name="addrType" id="addrType" style="width: 174px;" />
	         		<input type="hidden" name="acctId" id="acctId" />
	         	</td>
	         	
	         	<td class="td-label"><label>收货联系人 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" style="width: 168px;" type="text" id="consignee" name="consignee"  />
	         	</td>
	        </tr>
	        
	        <tr>
				<td class="td-label"><label>省/(直辖)市 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" name="province" id="province" style="width: 174px;" />
	         	</td>
	        
	         	<td class="td-label"><label>移动电话 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" style="width: 174px;" type="text" id="mobilePhone" name="mobilePhone"  />
	         	</td>
	        </tr>
	        
	        <tr>
	         	<td class="td-label"><label>城市 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" name="city" id="city" style="width: 174px;" />
	         	</td>
	         	
	         	<td class="td-label"><label>固定电话 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" style="width: 174px;" type="text" id="fixedPhone" name="fixedPhone"  />
	         	</td>
	        </tr>
	        
	        <tr>
	         	<td class="td-label"><label>县区 :</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" name="district" id="district" style="width: 174px;" />
	         	</td>
	         	
	         	<td class="td-label" rowspan="4"><label>备注 :</label></td>
	         	<td class="td-content" rowspan="4">
	         		<textarea class="easyui-validatebox"  name="comments" id="comments" style="width:174px; height:80px; font-size: 13px;" ></textarea>
	         	</td>
	        </tr>
	        
	        <tr style="display:none;">
	         	<td class="td-label"><label>乡镇:</label></td>
	         	<td class="td-content">
	         		<input class="easyui-validatebox" name="town" id="town" style="width: 174px;" />
	         	</td>
	         	
	         	
	        </tr>
	        
	        <tr>
	         	<td class="td-label" rowspan="2"><label>详细地址 :</label></td>
	         	<td class="td-content" rowspan="2">
	         		<textarea class="easyui-validatebox"  name="addr" id="addr" style="width:174px; height:100%; font-size: 13px;" ></textarea>
	         	</td>
	         	
	         	
	        </tr>
	        <tr>
	        </tr>
	         	
		</table>
	</div>


	<script type="text/javascript">
		$('#acctId').val('${id}');//保存客户的ID，插入地址时要用到
		$provinceCombobox = $('#province');
		$cityCombobox = $('#city');
		$districtCombobox = $('#district');
		$townCombobox = $('#town');
		$addrTypeCombobox = $('#addrType');

		/**
		 * 地址类型下拉
		 */
		$.post('${AppContext.ctxPath}/action/portal/basic/list/ADDR_TYPE', {}, function(data) {
			$addrTypeCombobox.combobox({
				data : data,
				valueField : 'name',
				textField : 'name',
				editable : false, //不可编辑状态
				cache : false
			});
		});

		//下拉框选择控件，下拉框的内容是动态查询数据库信息
		/**
		 * 省市县 下拉框选择控件
		 */
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
							$.ajax({
								type : "POST",
								url : "${AppContext.ctxPath}/action/portal/address/childList?id=" + province,
								cache : false,
								dataType : "json",
								success : function(data) {
									$cityCombobox.combobox("loadData", data);
								}
							});
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
					$.ajax({
						type : "POST",
						url : "${AppContext.ctxPath}/action/portal/address/childList?id=" + city,
						cache : false,
						dataType : "json",
						success : function(data) {
							$districtCombobox.combobox("loadData", data);
						}
					});
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
					$.ajax({
						type : "POST",
						url : "${AppContext.ctxPath}/action/portal/address/childList?id=" + district,
						cache : false,
						dataType : "json",
						success : function(data) {
							$townCombobox.combobox("loadData", data);
						}
					});
				}
			}
		});
		
		$townCombobox.combobox({
			editable : false, //不可编辑状态
			cache : false,
			valueField : 'id',
			textField : 'addrName'
		});
	</script>

</body>
</html>