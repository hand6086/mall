<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>

<style>
.td-label{
text-align:right;
}
.td-input{
padding:5px;
}
.td-input-input{
width:200px;
}
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
	<div data-options="region:'north',split:true" fit="true" border="false">
	<div id="header" class="easyui-panel"
				style="width: '$(window).width() - 18'" title="配置对象"
				data-options="border:false,">
		<form id="objectForm">
		<fieldset style="margin-top:10px;">
				<legend style="font-size: 16px;">配置对象</legend>
				<table style="width:100%; min-width:900px">
					<tr>
						<td class="td-label"><label>对象ID :</label></td>
						<td class="td-input">
							<input id="id" name="id" disabled readonly class="easyui-textbox td-input-input" editable="false"  />
						</td>
						
						<td class="td-label"><label>基表 :</label></td>
						<td class="td-input">
							<input id="basetable" name="basetable" class="easyui-textbox td-input-input " data-options="
											required:true,"  />
						</td>
						
						<td class="td-label"><label>新建 :</label></td>
						<td class="td-input">
							<input id="newflag" name="newflag" type="checkbox" class="easyui-checkbox " data-options="
											on:'Y',
											off:'N' "  />
						</td>
						
						<td class="td-label"><label>有效 :</label></td>
						<td class="td-input">
							<input id="activeflag" name="activeflag" type="checkbox" class="easyui-checkbox " data-options="
											on:'Y',
											off:'N' "  />
						</td>
					</tr>
					<tr>
						<td class="td-label"><label>项目名称 :</label></td>
						<td class="td-input">
							<input id="attr02" name="attr02" class="easyui-combobox td-input-input" data-options="
											editable:false,
											valueField:'val',
											textField: 'name',
											data: getLovArray('LNK_SRPRO_PROJECT'),
											required:true,"  />
						</td>
						
						<td class="td-label"><label>基表别名 :</label></td>
						<td class="td-input">
							<input id="basetablealais" name="basetablealais" disabled readonly value="T1" class="easyui-textbox td-input-input"  />
						</td>
						
						<td class="td-label"><label>更新 :</label></td>
						<td class="td-input">
							<input id="updateflag" name="updateflag" type="checkbox" class="easyui-checkbox " data-options="
											on:'Y',
											off:'N' "  />
						</td>
						
						<td class="td-label"><label>说明 :</label></td>
						<td class="td-input" rowspan="3">
							<input id="coms" name="coms" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											multiline:true," style="height:90%;" />
						</td>
					</tr>
					<tr>
						<td class="td-label"><label>文件夹名称 :</label></td>
						<td class="td-input">
							<input id="attr03" name="attr03" class="easyui-textbox easyui-validatebox  td-input-input" data-options="
											required:true,
											validType: 'english' "  />
						</td>
						
						<td class="td-label"><label>排序字段 :</label></td>
						<td class="td-input">
							<input id="orderbyfield" name="orderbyfield" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:true,"  />
						</td>
						
						<td class="td-label"><label>删除 :</label></td>
						<td class="td-input">
							<input id="deleteflag" name="deleteflag" type="checkbox" class="easyui-checkbox " data-options="
											on:'Y',
											off:'N' "  />
						</td>
					</tr>
					<tr>
						<td class="td-label"><label>显示名称 :</label></td>
						<td class="td-input">
							<input id="attr01" name="attr01" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:true,"  />
						</td>
	
						<td class="td-label"><label>数据源名称 :</label></td>
						<td class="td-input">
							<input id="attr09" name="attr09" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:false,
											"  />
						</td>
						
						<td class="td-label"><label>查询 :</label></td>
						<td class="td-input">
							<input id="queryflag" name="queryflag" type="checkbox" class="easyui-checkbox " data-options="
											on:'Y',
											off:'N' "  />
						</td>
					</tr>
					<tr>
						<td class="td-label"><label>对象名称（英文） :</label></td>
						<td class="td-input">
							<input id="name" name="name" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:true,"  />
						</td>
						
						<td class="td-label"><label>公司账套 :</label></td>
						<td class="td-input">
							<input id="attr10" name="attr10" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:false,
											"  />
						</td>
					</tr>
					<tr>
						<td class="td-label"><label>crm包名 :</label></td>
						<td class="td-input">
							<input id="attr04" name="attr04" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:false,"  />
						</td>
						
						<td colspan="6" rowspan="2">
							<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-redo" 
							plain="false" style="margin-left:100px;width: 100px;height:30px;" onclick="objectReturn()">返回</a>
							
							<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-save" 
				    		plain="false" style="margin-left:70px;width: 100px;height:30px;" onclick="objectSave()">保存</a>
				    		
				    		<a href="javascript:void(0)" id="btn_edit" class="easyui-linkbutton" iconCls="icon-edit" 
				    		plain="false" style="margin-left:70px;width: 100px;height:30px;display:none;" onclick="enableEdit()" hidden="true">编辑</a>
						</td>
					</tr>
					<tr>
						<td class="td-label"><label>mobile包名 :</label></td>
						<td class="td-input">
							<input id="attr18" name="attr18" class="easyui-textbox easyui-validatebox td-input-input" data-options="
											required:false,"  />
						</td>
					</tr>
				</table>
		</fieldset>
		<input name="created" hidden />
		<input name="orgId" hidden />
		<input name="postnId" hidden />
		<!-- <input name="row_status" value="NEW" hidden /> -->
		</form>
	</div>
	<div id="autoconfig-tabs" class="easyui-tabs"
				style="width:100%; height: 500px;"
				data-options="border:false">
		<!-- tab 对象字段 -->
		<div title="对象字段" href="${AppContext.ctxPath}/portal/lnkautoconfig/modules/FieldForMobileList.jsp"></div>
		<!-- tab 关联表 -->
		<div title="关联表" href="${AppContext.ctxPath}/portal/lnkautoconfig/modules/LinkList.jsp"></div>
		<!-- tab 筛选条件 -->
		<div title="筛选条件" href="${AppContext.ctxPath}/portal/lnkautoconfig/modules/WhereList.jsp"></div>
	</div>
	</div>

</body>

<script type="text/javascript">
var objId = "${param.id}";//对象id
var objStatus = "NEW"; //对象状态
var operate = "${param.op}";
var returnCode = "CANCEL";
$(function(){
	
	if(operate == "UPDATE"){ //查看记录详情
		objStatus = "UPDATE";
		$.post("${AppContext.ctxPath}/action/portal/autoconfig/queryById", {id:objId}, function(data){
			if(data.success){
				object = data.result;
				loadObject(object);//数据填充到表单
				disableEdit();
			}else{
				$.messager.alert("警告", "查询对象错误: "+data.result, "error", function(r){
					window.parent.editWinClose("SUCCESS");
				});
			}
		});
	}else{//新建记录
		var object = {
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName,
				newflag : "Y",
				updateflag : "Y",
				deleteflag : "Y",
				queryflag : "Y",
				orderbyfield : "T1.CREATED DESC",
				basetablealais : "T1",
				attr04 : "com.hand.base",
				attr18 : "com.hand.mobile",
				activeflag : "Y"
		}
		$.post("${AppContext.ctxPath}/action/portal/autoconfig/preDefaultValue", {}, function(data){
			if(data.success){
				object = $.extend(object, data.result);
				loadObject(object);//数据填充到表单
				objId = object.id;
			}
		});
	}
	
});

/**
 * 取消新建
 */
function objectReturn(){
	window.parent.editWinClose(returnCode);
}
/**
 * 提交保存
 */
function objectSave(){
	var row = getObject();
	if($("#objectForm").form("validate")){
		row.attr03 = toLower(row.attr03);
		row.attr18 = toLower(row.attr18);
		row.attr04 = toLower(row.attr04);
		row.basetable = toLower(row.basetable);
		row.row_status =objStatus;
		
		$.post('${AppContext.ctxPath}/action/portal/autoconfig/upsert',row, 
				function(data) {
						if (!data.success) {
							$.messager.alert("错误",data.result,"error");
						} else {
							objStatus = "UPDATE";
							returnCode = "SUCCESS";
							disableEdit();
							loadObject(data.newRow);
						}
					});
		
	}
}
/**
 * 使表单能编辑修改
 */
function enableEdit(){
	/* $("#basetable").removeAttr("disabled");
	$("#newflag").removeAttr("disabled");
	$("#activeflag").removeAttr("disabled"); */
	$("#attr02").combobox('enable');
	$(":disabled", $("#objectForm")).removeAttr("disabled");
	$("#id").textbox("disable");
	$("#basetablealais").textbox("disable");
	$("#btn_submit").show();
	$("#btn_edit").hide();
}

/**
 * 禁止表单修改
 */
function disableEdit(){
	$("#attr02").combobox("disable");
	$(":enabled", $("#objectForm")).attr("disabled", "disabled");
	$("#btn_submit").hide();
	$("#btn_edit").show();
}
/**
 * 获取表单数据组织成对象并返回
 */
function getObject(){
	var object = {};
	$("#objectForm [name]").each(function(){
		tagName = $(this)[0].tagName;
		type = $(this).attr('type');
		name = $(this).attr("name");
		if(name){
			if(tagName == "INPUT"){
				if(type == "checkbox"){
					object[name] = $(this).prop("checked") ? "Y" : "N";
				}else{
					object[name] = $(this).val();
				}
			}else if(tagName == "SELECT" || tagName == "TEXTAREA"){
				object[name] = $(this).val();
			}
		}
	});
	return object;
}

/**
 * 把对象数据填充到表单上
 */
function loadObject(object){
	$("#objectForm").form("clear");
	$("#objectForm").form("load", object);
	for (key in object) {
		value = object[key];
		$("[name='" + key + "'][type='checkbox']", $("#objectForm"))
				.each(
						function() {
							$(this).prop("checked", value=="Y" ? true : false);
						});
	} 
}
</script>
</html>