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
.selectedreg{
	color: #f40;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" title="运费模板基本信息" border="false" style="width:100%;height:100%;">
			<form id="freightForm" method="post"> 
				<table class="form-table">
					<tr>
						<td>
							<fieldset>
								<legend>不包邮区域</legend>
								<table class="table-block" >							
									<tr>
										<td class="td-label"><label>选择区域：</label></td>
										<td>
											<div class="region"></div>
							    			<div>已选择区域：<span class="selectedreg"></span></div>
							    			<div style="margin-top: 10px;">
							    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton selectAll" plain="true">全选</a>
							    				&nbsp;&nbsp;&nbsp;
						    					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton inverse" plain="true">反选</a>	
							    				&nbsp;&nbsp;&nbsp;
							    				<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton reset" plain="true">重置</a>
							    			</div>
										</td>
									</tr>
								</table>
							</fieldset>
						</td>
					</tr>
					<tr>	
						<td>
							<fieldset>
								<legend>不包邮邮费计算规则</legend>
								<form id="freightForm" method="post"> 
								<table class="table-block" >							
									<tr>
										<td>
											<table>
												<tr class="piece">
													<td class="td-label piece"><label>首件 &nbsp</label></td>
													<td class="td-label weight"><label>&nbsp 首重 &nbsp</label></td>
													<td>
														<input name="firstNumber" id="firstNumber" class="easyui-numberbox" data-options="min:0,
																					precision:0,required:true"/>
													</td>
													<td class="piece"><label>&nbsp 件,配送费 &nbsp</label></td>
													<td class="weight"><label>&nbsp kg,配送费  &nbsp</label></td>
													<td>
														<input name="firstFee" id="firstFee" class="easyui-numberbox" data-options="min:0,
																					precision:2,required:true"/>
													</td>
													<td><label>&nbsp 元 ，每增加 &nbsp</label></td>
													<td>
														<input name="addNumber" id="addNumber" class="easyui-numberbox" data-options="min:0,
																					precision:0,required:true"/>
													</td>
													<td class="piece"><label>&nbsp 件，加收  &nbsp</label></td>
													<td class="weight"><label>&nbsp Kg，加收  &nbsp</label></td>
													<td>
														<input name="addFee" id="addFee" class="easyui-numberbox" data-options="min:0,
																					precision:2,required:true"/>
													</td>
													<td><label> &nbsp元，不足部分按整数收取 </label></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								</form>
							</fieldset>
						</td>
					</tr>
				</table>
			</form>
			
			<div>
				<center>
					<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton save" iconCls="icon-save" onclick="save()" plain="true">保存</a>
		    		&nbsp;&nbsp;&nbsp;
		    		<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton cancel" iconCls="icon-redo" plain="true">取消</a> 
				</center>
			</div>
		</div>
	</div>
	

	<script type="text/javascript">
	$freightForm = $("#freightForm");	
	var freightId = "${param.freightId}";
	var type  = "${param.type}";
	var rowId = "${param.rowId}";
	var row_status = null;
	if(type == "piece"){
		$('.weight').attr("hidden",true);
		$('.piece').attr("hidden",false);
	}
	else if(type == "weight"){
		$('.weight').attr("hidden",false);
		$('.piece').attr("hidden",true);
	}
	
	$(".selectAll").click(function(){
		$(".region div").addClass("selected");
	}); 
	$(".reset").click(function(){
		$(".region div").removeClass("selected");
	}); 
	$(".inverse").click(function(){
		$(".region div").toggleClass("selected");
	});
	
	function save(){
		$(".save").linkbutton('disable');
		var city=$(".region div.selected");
		var mailAreaAll=new Array();
		for(i=0,len=city.length;i<len;i++){
            if($(city[i]).attr("value")!=""){
            	mailAreaAll.push($(city[i]).attr("value"));
            }
        }
		var areaId = mailAreaAll.join(",");
		if(!areaId){
			$.messager.alert("错误","请选择不包邮区域", "error");
			$(".save").linkbutton('enable');
			return;
		}
		var options = {
				url : '${AppContext.ctxPath}/action/portal/freight/nomailAreaUpsert',
				type : 'post',
				dataType :'json',
				data: {
					id:rowId,
					areaId:areaId,
					freightId:freightId,
					row_status:row_status
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
						window.parent.closeAddNextWin(freightId);
					} else {
						$(".save").linkbutton('enable');
						window.parent.operationtip(data.result, 'error');
					}
				}
			};
		$freightForm.ajaxSubmit(options);
	}
	
	$(".cancel").click(function(){
		window.parent.closeAddNextWin(freightId);
	}); 
	
	function addInfoInit(refreshDatagrid){
		$.post("${AppContext.ctxPath}/action/portal/freight/queryOtherArea",{freightId : freightId},
			function(data){
				if(data){
					var city = data.city;
					row_status = 'NEW';
					
					for(var i=0;i<city.length;i++){
						$('.region').append('<div value='+city[i].id+' id='+city[i].id+'>'+city[i].areaName+'</div>');
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
	
	function updateInfoInit(refreshDatagrid){
		if(!type || !freightId || !rowId){
			$.messager.alert("错误","参数错误, 无法获取id或类型", "error");
			return;
		}
		$.post("${AppContext.ctxPath}/action/portal/freight/queryOtherArea",{freightId : freightId , id: rowId ,attr1 : "updateNma"},
			function(data){
				if(data){
					var city = data.city;
					row_status = 'UPDATE';
					
					freight = data.result;
					$freightForm.form("load", freight);
					
					var areas = data.areas;
					
					for(var i=0;i<city.length;i++){
						$('.region').append('<div value='+city[i].id+' id='+city[i].id+'>'+city[i].areaName+'</div>');
					}
					$('.region').append('<span></span>');
					$(".region div").click(function(){
			    		$(this).toggleClass("selected");
					});	
					
					for(var i=0;i<areas.length;i++){
						document.getElementById(areas[i]).setAttribute("class","selected");
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
			});
		if(refreshDatagrid){
			
		}
	}
	</script>

</body>
</html>