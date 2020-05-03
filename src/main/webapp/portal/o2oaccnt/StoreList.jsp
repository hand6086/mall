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
	width: 100%;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content input{
	width:180px;
}
</style>
<body>		
  <div  class="easyui-layout" border="false" fit="true">		
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			 
			 <fieldset class="x-fieldset" id="storeKeyFilter">
				<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">筛选条件</span>
				</legend>
		
				<div class="row keyfilter-border">
					<table class="form-table">
					    <tr>
			   				<td class="td-label"><label>商户类型：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="storeType" type="text" id="storeType" size="25" />
							</td>
							
							<td class="td-label"><label>商户名称：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="accntName" type="text" id="accntName" size="25" />
							</td>
							
							<td class="td-label"><label>省/直辖市：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="province" type="text" id="province" size="25" />
							</td>
							
							<td class="td-label"><label>城市：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="city" type="text" id="city" size="25" />
							</td>
						</tr>
						<tr>	
							<td class="td-label"><label>区/县：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="district" type="text" id="district" size="25" />
							</td>
							
							<td class="td-label"><label>详细地址：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="address" type="text" id="address" size="25" />
							</td>
							
							<td class="td-label"><label>联系电话：</label></td>
							<td class="td-input">
								<input  class="easyui-validatebox" name="contactPhone" type="text" id="contactPhone" size="25" />
							</td>
							
							<td class="td-label"><label>渠道类型：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="channelType" type="text" id="channelType" size="25" />
							</td>
						</tr>
						<tr>
							<!-- <td class="td-label"><label>状态:</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="status" type="text" id="status" size="25" />
							</td> -->
							
							<td class="td-label"><label>接单状态：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="orderPickStatus" type="text" id="orderPickStatus" size="25" />
							</td>
							
							<td class="td-label"><label>是否O2O商户：</label></td>
							<td class="td-input">
								<input  class="easyui-combobox" name="o2oStoreFlag" type="text" id="o2oStoreFlag" size="25" />
							</td>
			   			</tr>
			   		</table>
				</div>
			</fieldset>
			<table id="store-table" fit="true" style="width:100%;height:100%;" keyFilterDiv="storeKeyFilter">
				<thead>
					<tr>
						<th field="accntCode" width="80px"  editor="{type:'textbox', options:{required:true}}">客户编码</th>
						<th field="accntName" width="80px" editor="{type:'textbox', options:{required:true}}" formatter="accntNameFormatter" >客户名称</th>
						<th field="storeType" width="100px" lov="TB_O2O_STORE_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_STORE_TYPE'),
																editable:false}}">商户类型</th>
						<th field="province" width="80px"editor="{type:'picklistbox',options:{title:'选择省/直辖市',
															completeFun:provincePicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/ProvincePickList.jsp'}}">省/直辖市</th>
						<th field="city" width="80px"editor="{type:'picklistbox',options:{title:'选择城市',
															initParam:cityPickListInit,
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/CityPickList.jsp'}}">城市</th>
						<th field="district" width="100px"editor="{type:'picklistbox',options:{title:'选择区/县',
															initParam:districtPickListInit,
															completeFun:districtPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/DistrictPickList.jsp'}}">区/县</th>
						<th field="address" width="80px"editor="{type:'textbox', options:{required:true}}">详细地址</th>
						<th field="contact" width="100px"editor="{type:'textbox', options:{required:true}}">联系人</th>
						<th field="contactPhone" width="105px"editor="{type:'numberbox', options:{required:true}}">联系电话</th>
						<th field="aliPay" width="80px"editor="{type:'textbox', options:{required:true}}">支付宝账号</th>
						<th field="o2oAccntName" width="80px"editor="{type:'textbox', options:{required:true}}">开户人</th>
						<th field="bank" width="100px" lov="TB_O2O_BANK"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_BANK'),
																editable:false}}">开户银行</th>
						<th field="creaitCard" width="80px"editor="{type:'numberbox', options:{required:true}}">银行卡号</th>
						<th field="gpsLong" width="80px"editor="{type:'numberbox'}">GPS经度</th>
						<th field="gpsLati" width="80px"editor="{type:'numberbox'}">GPS纬度</th>
						<th field="channelType" width="100px" lov="TB_O2O_CHANNEL_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_CHANNEL_TYPE'),
																editable:false}}">渠道类型</th>
						<th field="forcedStore" width="80px" lov="TB_O2O_JUDGE_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false}}">是否兜底商户</th>
						<th field="gpStore" width="80px" lov="TB_O2O_JUDGE_TYPE"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_JUDGE_TYPE'),
																editable:false}}">是否团购商户</th>
						<th field="status" width="80px" lov="TB_O2O_STATUS"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_STATUS'),
																editable:false}}">状态</th>
						<th field="wareHouse" width="100px"editor="{type:'textbox', options:{required:true}}">电商仓库</th>
						<th field="orderPickStatus" width="80px"lov="TB_O2O_ORDER_PICK_STATUS"
							editor="{type:'combobox',options:{	valueField:'val',
																textField:'name',
																data:getLovArray('TB_O2O_ORDER_PICK_STATUS'),
																editable:false}}">接单状态</th>
						<th field="o2oStoreFlag" width="80px" lov="TB_O2O_JUDGE_TYPE">是否O2O商户</th>
						<th field="xxxx" width="80px" hidden="true">二级区域</th>
						<th field="cityId" width="80px" hidden="true">城市id</th>
						<th field="parentOrgName" width="80px" hidden="true">城市大区</th>
						<th field="regionOrgName" width="100px" hidden="true">片区</th>
						<th field="salesOrgName" width="80px" hidden="true">销售单位</th>
					</tr>
				</thead>
			</table>
		</div>					
	</div>  
   
     <div id="accNameWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="accNameWinFram" name="accNameWinFram" width="100%" height="100%" frameborder="0">
    
    </iframe>
    </div>
	<script type="text/javascript">
	var storeType = null;
	var accntName = null;
	var province = null;
	var city = null;
	var district = null;
	var address = null;
	var contactPhone = null;
	var channelType = null;
	var orderPickStatus = null;
	var o2oStoreFlag = null;
	$accNameWinFram = $("#accNameWinFram");
	$accNameWin = $("#accNameWin");
		$('.easyui-layout').layout(); 
		$datagrid = $('#store-table');
		$datagrid
				.hdatagrid({
					updateable : false,    
					toolbarShow:true,	//显示工具栏
					buttonSearch:false,	//搜索框功能
					buttonExport:true,
					buttonDelete:false,
					buttonCopy:false,
					buttonMenu:true,
					oauthFlag:true,
					pagination:true,
					menuButtonCount : true,
					striped:true,
					title:'',
					border:false,
					url : '${AppContext.ctxPath}/action/portal/store/queryByExamplePage',	
					onBeforeLoad:function(param){
						if(storeType != null && storeType != ''){
				    		param.storeType = storeType;
						}
						if(accntName != null && accntName != ''){
				    		param.accntName = accntName;
						}
						if(province != null && province != ''){
				    		param.province = province;
						}
						if(city != null && city != ''){
				    		param.city = city;
						}
						if(district != null && district != ''){
				    		param.district = district;
						}
						if(address != null && address != ''){
				    		param.address = address;
						}
						if(contactPhone != null && contactPhone != ''){
				    		param.contactPhone = contactPhone;
						}
						if(channelType != null && channelType != ''){
				    		param.channelType = channelType;
						}
						/* if(status != null && status != ''){
				    		param.status = status;
						} */
						if(orderPickStatus != null && orderPickStatus != ''){
				    		param.orderPickStatus = orderPickStatus;
						}
						if(o2oStoreFlag != null && o2oStoreFlag != ''){
				    		param.o2oStoreFlag = o2oStoreFlag;
						}
					},
/* 					onInsertAction : function(row,successFun,errFun,that) {
					 delete row.children;
					 $.post('${AppContext.ctxPath}/action/portal/accnt/insert', row, function(data) {
					 if (!data.success) {
					 errFun(data.result,that);
					 }else{
					 successFun(that, data);
					 }
					 });
					 },		 
					 
					 onUpdateAction:function(row,successFun,errFun,that) {
							$.post('${AppContext.ctxPath}/action/portal/store/update', row, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								}else{
									successFun(that, data);
								}
							});
					}, */
						
					onChangeSelectedItem:function(row,that){
						if(row.status == 'Active'){
							$("#btn_add").linkbutton({text:'无效'});
						} else{
							$("#btn_add").linkbutton({text:'有效'});
						}
					},
					
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(1,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="storeSearch()" iconCls="icon-search" plain="true">查询</a>',that);
						addButtonFun(2,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="storeClean()" iconCls="icon-reload" plain="true">重置</a>',that);
						addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" onClick="Invalid()" iconCls="icon-undo" plain="true">失效</a>',that);
		 			}, 

					onInsertOrUpdateAction : function(row, successFun, errFun,
							that) {
						$
								.post(
										'${AppContext.ctxPath}/action/portal/store/upsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					}, 
					/* onDeleteAction : function(row, successFun, errFun, that) {
						$.messager
								.confirm(
										"操作提示",
										'是否确定删除信息？',
										function(data) {
											if (data) {
												$
														.post(
																'${AppContext.ctxPath}/action/portal/accnt/deleteById',
																{
																	id : row.id
																},
																function(data) {
																	if (!data.success) {
																		errFun(
																				data.result,
																				that);
																	} else {
																		successFun(that);
																	}
																});
											}
										});
					} */
				});


		//失效
		function Invalid(){
			var row = $datagrid.datagrid('getSelected');
			if(row.status=="Inactive"){
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Active"});
			}else{
				$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,status:"Inactive"});
			}
			var index = $datagrid.hdatagrid('getRowIndex', row);
            $datagrid.datagrid('selectRow',index);
		}
		//省/直辖市picklist
		function provincePicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.provinceName;
			return selectRow.provinceName;
		}
		
		//城市picklist
		function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').city = selectRow.cityName;
			return selectRow.cityName;
		}
		
		//区县picklist
		function districtPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').district = selectRow.districtName;
			return selectRow.districtName;
		}
		//返回当前行的省/直辖市名称
		function cityPickListInit(){
			var row=$datagrid.hdatagrid('getCurrentRow');
			if(row.province==null || row.province==''){
				return {
				 provinceName:'noMatchID'
				};
			}else
				{
				 return {
					 provinceName:row.province
					};
				}
		 }
		//返回当前行的城市名称
		function districtPickListInit(){
			var row=$datagrid.hdatagrid('getCurrentRow');
			if(row.city==null || row.city==''){
				return {
				 cityName:'noMatchID'
				};
			}else
				{
				 return {
					 cityName:row.city
					};
				}
		 }
	function accntNameFormatter(val,row){
		if(val!=null){
			return "<a class='easyui-tooltip' href='javascript:void(0)' onClick='accName(\""+row.id+"\")'>"+ val +"</a>";
		}
		
	}	 
 	function accName(accntId){
 		if(!accntId){
			$.messager.show("错误", "参数错误，无法获取id", "error");
			return;
		}
		$accNameWinFram.attr("src","");
		if( !$accNameWinFram.attr("src") ){
			$accNameWinFram.attr("src", "${AppContext.ctxPath}/portal/o2oaccnt/AccInfoEdit.jsp?accntId="+accntId);
			$accNameWinFram[0].onload = function() {
				$accNameWinFram[0].contentWindow.AccNameInfoInit(accntId, "reload");//等待窗口加载完毕
			}
		}else{
			alert("else")
			$accNameWinFram[0].contentWindow.AccNameInfoInit(accntId, "reload");
		}
		//$accntDetailWin.window("open");
		$accNameWin.css("display", "block");
			
			
			
		}
		
	
	function closeAccNameWin(operate){
		$accNameWin.css("display", "none");
		$accNameWinFram.attr("src","");
		var row = $datagrid.datagrid('getSelected');
		var index = $datagrid.datagrid('getRowIndex', row);

		if(operate == "ok"){
			$.post("${AppContext.ctxPath}/action/portal/store/queryById", {id: row.id}, function(data){
				if(data.success){
					$datagrid.datagrid('updateRow', {index : index, row:data.result})
					$datagrid.datagrid('acceptChanges');
				}else{
					$.messager.show("错误", "更新数据错误: "+data.result, "error");
				}
			});
		}
	}
	
	$('#storeType').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_STORE_TYPE'),
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
	/* $('#status').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_STATUS'),
		valueField:'val',
		textField:'name',
		panelHeight: 'auto',
	    cache: false
	}); */
	$('#orderPickStatus').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_ORDER_PICK_STATUS'),
		valueField:'val',
		textField:'name',
		panelHeight: 'auto',
	    cache: false
	});
	$('#o2oStoreFlag').combobox({ 
		method:'get',
		data:getLovArray('TB_O2O_JUDGE_TYPE'),
		valueField:'val',
		textField:'name',
		panelHeight: 'auto',
	    cache: false
	});
	
	function storeSearch(){
		storeType = $('#storeType').combobox('getValue');
		accntName = $('#accntName').val();
		province = $('#province').val();
		city = $('#city').val();
		district = $('#district').val();
		address = $('#address').val();
		contactPhone = $('#contactPhone').val();
		channelType = $('#channelType').combobox('getValue');
		/* status = $('#status').combobox('getValue'); */
		orderPickStatus = $('#orderPickStatus').combobox('getValue');
		o2oStoreFlag = $('#o2oStoreFlag').combobox('getValue');
		$datagrid.datagrid('reload');
   }
   
   function storeClean(){
	  	$('#storeType').combobox('setValue','');
		$('#accntName').val('');
		$('#province').val('');
		$('#city').val('');
		$('#district').val('');
		$('#address').val('');
		$('#contactPhone').val('');
		$('#channelType').combobox('setValue','');
		/* $('#status').combobox('setValue',''); */
		$('#orderPickStatus').combobox('setValue','');
		$('#o2oStoreFlag').combobox('setValue','');
		storeType = null;
		accntName = null;
		province = null;
		city = null;
		district = null;
		address = null;
		contactPhone = null;
		channelType = null;
		/* status = null; */
		orderPickStatus = null;
		o2oStoreFlag = null;
		$datagrid.datagrid('reload');
   }
		
	</script>
</body>
</html>