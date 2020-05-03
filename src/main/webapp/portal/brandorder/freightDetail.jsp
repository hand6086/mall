<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
.left{
	float: left;
	width: 360px;
}
.center{
	float: left;
	width: 90%;
	margin-left:10px;
	
	/* position:absolute; */
}
.right{
	float: left;
	width: 360px;
	margin-left:10px;
}

.form-table{
	margin: 5px auto; 
	width: 1100px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}
.table-block1 {
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
.table-block tr{
	height:40px;
}
.td-label {
	width:90px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input,select{
	width:180px;
}
.td-content textarea{
	width:300px;
}
.region{
	overflow: hidden;
	width: 1000px;
}
.region > div{
	width: 10%;
	float: left;
	margin-right: 2%;
	height: 30px;
	border:1px solid #ccc;
	margin-bottom:10px;
	line-height: 30px;
	border-radius: 2px;
	text-align: center;
	cursor: pointer;
}
.selected{
	background: #fee1c4;
}
.selectedreg,.selectedreg2{
	color: #f40;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" title="运费模板基本信息"
			 border="false" style="width:100%;height:100%;">
			<table class="form-table">
				<tr>
					<td>
						<fieldset>
							<legend>运费模板</legend>
							<form id="freightForm" method="post"> 
								<table class="table-block" >							
									<tr>
										<c:if test="${UserContext.systemRole == 'super_administrator'}">
										    <td class="td-label"><label>商户名称 ：</label></td>
											<td class="td-content">
												<input  class="easyui-validatebox" name="corpName" type="text" id="corpName" disabled="disabled" size="25" />
											</td>
										</c:if>
										<td class="td-label"><label>模板名称 ：</label></td>
										<td class="td-content">
											<input  class="easyui-validatebox" name="name" type="text" id="name"/>
										</td>
										
										<td class="td-label"><label>模板说明： </label></td>
										<td class="td-content">
											<textarea  class="easyui-validatebox" name="notes" type="text" id="notes"></textarea>
										</td>
									</tr>
									<tr>
										<td class="td-label"><label>计费方式： </label></td>
										<td class="td-content">
											<input id="way" name="way" class="easyui-combobox"  data-options="required:true"/>
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
							<legend>包邮区域</legend>
							<table class="table-block" >							
								<tr>
									<td class="td-label"><label>选择区域：</label></td>
									<td>
										<div class="region region"></div>
						    			<div>已选择区域：<span class="selectedreg"></span></div>
						    			<div style="margin-top: 10px;">
						    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton selectAll" plain="true">全选</a>	    				
						    				&nbsp;&nbsp;&nbsp;
						    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton inverse" plain="true">反选</a>
						    				&nbsp;&nbsp;&nbsp;
						    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton reset" plain="true">重置</a>
						    			</div>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				
				<tr>	
					<td>
						<table class="table-block" >
							<tr>
								<td class="td-label"><label></label></td>
								<td>
									<div>
										<center>
											<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton save" iconCls="icon-save" onclick="save()" plain="true">保存</a>
								    		&nbsp;&nbsp;&nbsp;
								    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" iconCls="icon-redo" plain="true">取消</a> 
										</center>
									</div>
								</td>
							</tr>							
						</table>
					</td>
				</tr>
				<tr>	
					<td>
						<fieldset>
							<legend>不包邮邮费计算规则</legend>
							<table class="table-block" >
								<tr>
									<td class="td-label"><label></label></td>
									<td>
										<div>
						    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton add" plain="true">添加</a>	    				
						    				&nbsp;&nbsp;&nbsp;
						    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton update" plain="true">修改</a>
						    			</div>
									</td>
								</tr>							
							</table>
						</fieldset>
					</td>
				</tr>
				<tr>
					<td>
						<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:245px;padding:0px;" fit="true">
						    <table id="freight-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
								<thead>
									<tr>
										<th field="areaName" width="280pxpx">不包邮区域</th>
										<th field="firstNumber" width="180px">基础配送数量</th>
										<th field="firstFee" width="180px">基础配送价格</th>
										<th field="addNumber" width="180px">累加基数</th>
										<th field="addFee" width="180px">累加价格</th>
								   	</tr>
								</thead>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	

	<script type="text/javascript">
	$freightForm = $("#freightForm");	
	var freightId = "${param.freightId}";
	var row_status = null;
	var mailAreaOld=new Array();
	//初始化 计费方式  下拉列表
	$("#way").combobox({ 
		method:'get',
		data:getLovArray('BILLING_METHODS'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	$(".selectAll").click(function(){
		$(".region div").addClass("selected");
	}); 
	$(".inverse").click(function(){
		$(".region div").toggleClass("selected");
	});
	$(".reset").click(function(){
		$(".region div").removeClass("selected");
	});
	
	function addInfoInit(refreshDatagrid){
		$.post("${AppContext.ctxPath}/action/portal/o2oaddress/provinceList",{},
				function(data){
					if(data){
						row_status = 'NEW';
						for(var i=0;i<data.length;i++){
						$('.region').append('<div value='+data[i].id+' name='+data[i].areaName+'>'+data[i].areaName+'</div>');
						}
						$('.region').append('<span></span>');
						
						$(".region div").click(function(){
				    		$(this).toggleClass("selected");
						});
						
						$(".region div,.selectAll,.reset,.inverse").click(function(){
								var i=0;
							$(".region div").each(function(){
								if ($(this).hasClass("selected")){
									i++;
									}
							});
							$(".selectedreg").text(i);
						});
					}
				});
		if(refreshDatagrid){
		}
	}
	
	function detailInfoInit(freightId, refreshDatagrid){
		if(!freightId){
			$.messager.alert("错误","参数错误, 无法获取商品id", "error");
			return;
		}else if(freightId == "current"){
			freightId = initId;
		}
		initId = freightId;
		var freight = {};
		$.post("${AppContext.ctxPath}/action/portal/freight/queryDetailId",{id:initId},
			function(data){
				if(data){
					if(data.success){
						row_status = 'UPDATE';
						var city = data.city;
						var oldma = data.ma;
						for(i=0,len=oldma.length;i<len;i++){
							mailAreaOld.push(oldma[i].areaId);
				        }
						freight = data.result;
						$freightForm.form("load", freight);
						for(var i=0;i<city.length;i++){
							$('.region').append('<div value='+city[i].id+' id='+city[i].id+'>'+city[i].areaName+'</div>');
						}
						$('.region').append('<span></span>');
						$(".region div").click(function(){
				    		$(this).toggleClass("selected");
						});
						for(var i=0;i<oldma.length;i++){
							document.getElementById(oldma[i].areaId).setAttribute("class","selected");
						}
						$(".region div,.selectAll,.reset,.inverse").click(function(){
								var i=0;
							$(".region div").each(function(){
								if ($(this).hasClass("selected")){
									i++;
									}
							});
							$(".selectedreg").text(i);
						});
					}
				}
			});
		if(refreshDatagrid){
		}
	}
	
	function save(){
		$(".save").linkbutton('disable');
		var city=$(".region div.selected");
		var mailAreaNew=new Array();
		for(i=0,len=city.length;i<len;i++){
            if($(city[i]).attr("value")!=""){
            	mailAreaNew.push($(city[i]).attr("value"));
            }
        }
		
		var madel = (mailAreaOld.minus(mailAreaNew)).join(",");  
		var maadd = (mailAreaNew.minus(mailAreaOld)).join(",");  
		
 		var options = {
				url : '${AppContext.ctxPath}/action/portal/freight/upsert',
				type : 'post',
				dataType :'json',
				data: {
					'row_status':row_status,
					'id': freightId,
					'mailArea':maadd,
					'attr5':madel
				},
				beforeSubmit: function() {
					var result = $freightForm.form('validate');
					if(!result){
						$(".save").linkbutton('enable');
					}
					return result;
				},  
				success : function(data) {
					if (data.success) {
						if(row_status == 'NEW'){
							freightId = data.newRow.id;
							window.parent.closeDetailWin(freightId,"NEW");
						}
						window.parent.operationtip('保存成功！', 'info');
						$(".save").linkbutton('enable');
					} else {
						$(".save").linkbutton('enable');
						window.parent.operationtip(data.result, 'error');
					}
				}
			};
		$freightForm.ajaxSubmit(options); 
	}
	
	$(".cancel").click(function(){
		window.parent.closeDetailWin();
	}); 
	
	 Array.prototype.minus = function (arr) {
         var result = new Array();
         var obj = {};
         for (var i = 0; i < arr.length; i++) {
             obj[arr[i]] = 1;
         }
         for (var j = 0; j < this.length; j++) {
             if (!obj[this[j]])
             {
                 obj[this[j]] = 1;
                 result.push(this[j]);
             }
         }
         return result;
     };
	
	$datagrid = $('#freight-table');
	$datagrid.hdatagrid({
		newDefaultValue:true,
		pageSize: 5,//每页显示的记录条数，默认为20 
	    pageList: [5,10,30],//可以设置每页记录条数的列表 
		url:'${AppContext.ctxPath}/action/portal/freight/queryNmaPage',
		onBeforeLoad:function(param){
			if(!freightId){
	    		param.freightId = "noMatchId";
	    	}else{
	    		param.freightId = freightId;
	    	}
		},
		onDeleteAction : function(row,successFun,errFun,that){
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/freight/deleteById', {
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

		onAddMoreButton:function(that,addButtonFun){
		}, 
	});
	
	$(".add").click(function(){
		if(!$freightForm.form('validate')){
			window.parent.operationtip('请先完善信息！', 'info');
			return;
		}
		if(!freightId){
			window.parent.operationtip('请先保存信息！', 'info');
			return;
		}
		window.parent.openAddNextWin(freightId,$("#way").combobox('getValue'));
	});
	
	$(".update").click(function(){
		var row = $datagrid.datagrid('getSelected');
		if(row == null){
			window.parent.operationtip('请选中一行！', 'info');
			return;
		}
		window.parent.openUpdateNextWin(freightId,row.id,$("#way").combobox('getValue'));
	}); 
    </script>

</body>
</html>