<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body style="background:#fafafa;margin:0;padding:0">
<style type="text/css">
/* 
//造成弹出table没有列标题
table {
	margin: 0 auto;
	border-collapse:collapse;
} */
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
	width: 1200px;
}
.table-block {
	margin: 5px auto;
	width:100%;
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
.td-content input{
	width:180px;
}
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.ui-btn {
    min-width: 85px;
	width: auto;
	margin-bottom: 0;
	font-weight: 400;
	white-space: nowrap;
	background-image: none;
	line-height: 32px;
	height: 32px;
	display: inline-block;
	text-align: center;
	border: 0;
	background-color: #f0f0f0;
	font-size: 14px;
	vertical-align: middle;
	cursor: pointer;
	color: #555;
}
.ui-btn:focus,.ui-btn:hover {
	background-image:none;
	text-decoration:none;
	color:#555;
	background-color:#e8eaeb;
}
</style>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true,collapsible:false" title="企业管理初始化" border="false" style="width:100%;height:100%;">
			<form id="enterpriseForm" method="post" enctype ="multipart/form-data" style="margin-bottom: 50px;"> 
				<div>
					<table class="form-table">
						<tr>
							<td>
								<table class="table-block" >							
										<tr>
											<td class="td-label"><label>编号 : &nbsp;</label></td>
							         		<td class="td-content">
							         			<input class="easyui-validatebox enterprise" id="code" name="code"  data-options="required:true"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>名称 : &nbsp;</label></td>
							         		<td class="td-content">
							         			<input class="easyui-validatebox enterprise" id="name" name="name" data-options="required:true"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>用户名 : &nbsp;</label></td>
					         				<td class="td-content">
					         					<input id="userName" name="userName" class="easyui-validatebox enterprise"  data-options="required:true"/>
					         				</td>
										</tr>
										<tr>
											<td class="td-label"><label>价格表 : &nbsp;</label></td>
											<td class="td-content">
												 <input class="enterprise"  id="defaultPrice" type="hidden" name="defaultPrice" />
							         			 <input class="enterprise"  id="priceListName" name="priceListName" readOnly="true" disabled class="easyui-validatebox" data-options="editable:false"/>
											</td>
										</tr>								
								</table>
							</td>
							<td>
								<table class="table-block" >
										<tr>
											<td class="td-label"><label>CRM职责 : &nbsp;</label></td>
					         				<td class="td-content">
					         					<input class="enterprise" id="crmDutyId" type="hidden" name="crmDutyId"/>
					         					<input class="enterprise" id="crmDutyName" name="crmDutyName" class="easyui-validatebox" />
					         				</td>
										</tr>	
										<tr>
											<td class="td-label"><label>APP职责 : &nbsp;</label></td>
							         		<td class="td-content">
							         			<input class="enterprise" id="appDutyId" type="hidden" name="appDutyId" />
							         			<input class="enterprise" id="appDutyName" name="appDutyName" class="easyui-validatebox"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>管理人姓名: &nbsp;</label></td>
											<td class="td-content">
												<input class="easyui-validatebox enterprise" id="firstname" name="firstname" data-options="required:true"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>管理人手机号 : &nbsp;</label></td>
							         		<td class="td-content">
							         			<input class="easyui-validatebox enterprise" type="text" id="mobilePhone" name="mobilePhone"  data-options="required:true"/>
							         		</td>
										</tr>
								</table>
			         		</td>
			         		<td>
								<table class="table-block" >							
										<tr>
											<td class="td-label"><label>行业版 : &nbsp;</label></td>
							         		<td class="td-content">
							         			<input id="industryVersion" name="industryVersion" class="easyui-combobox enterprise" data-options="required:true"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>自助申请 : &nbsp;</label></td>
							         		<td class="td-content">
							         			<!-- <input class="enterprise" name="attr1" type="checkbox" style="width:30px" onclick="a.value=this.checked?'Y':'N'"/>
		                						<input id="a" name="dealerApplySelf" type="hidden" class="easyui-validatebox enterprise" value="N" >
		                						 -->
								         		<input id="dealerApplySelf" name="dealerApplySelf" type="checkbox" class=" enterprise"  />
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>说明 :</label></td>
											<td class="td-content">
												<input id="comments" name="comments" class="easyui-textbox enterprise" data-options="multiline:true,required:false" 
													style="height: 60px;"/>
											</td>
										</tr>
								</table>
			         		</td>
						</tr>
					</table>
				</div>
				<div id="enterprise-tabs" class="easyui-tabs" style="width: 100%;height:400px;" data-options="border:false">
					<!-- tab1  基础信息 -->
					<div title="基础信息">
						<table class="form-table">
							<tr>
								<td>
									<table class="table-block">
										<tr>
											<td class="td-label"><label>开始时间： &nbsp;</label></td>
							         		<td class="td-content">
							         			<input id="beginDate" name="beginDate" class="easyui-datetimebox enterprise"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>结束时间： &nbsp;</label></td>
							         		<td class="td-content">
							         			<input id="endDate" name="endDate" class="easyui-datetimebox enterprise"/>
							         		</td>
										</tr>
									</table>
								</td>
								<td>
									<table class="table-block"> 
										<tr>
											<td class="td-label"><label>CRM用户数：&nbsp;</label></td>
							         		<td class="td-content">
							         			<input id="crmUserAmount" name="crmUserAmount" class="easyui-numberspinner enterprise"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>DMS用户数：&nbsp;</label></td>
							         		<td class="td-content">
							         			<input id="dmsUserAmount" name="dmsUserAmount" class="easyui-numberspinner enterprise"/>
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>APP用户数：&nbsp;</label></td>
							         		<td class="td-content">
							         			<input id="appUserAmount" name="appUserAmount" class="easyui-numberspinner enterprise" />
							         		</td>
										</tr>
									</table>
								</td>
								<td>
									<table class="table-block"> 
										<tr>
											<td class="td-label"><label>是否可用CRM： &nbsp;</label></td>
							         		<td class="td-content">
							         			<!-- <input class="enterprise" name="attr2" type="checkbox" style="width:30px" onclick="b.value=this.checked?'Y':'N'"/>
		                						<input class="enterprise" id="b" name="crmEnabled" type="hidden" value="N" >
		                						 -->
		                						<input id="crmEnabled" name="crmEnabled" type="checkbox" class="enterprise"  />
		                						
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>是否可用DMS： &nbsp;</label></td>
							         		<td class="td-content">
							         			<!-- <input class="enterprise"  name="attr3" type="checkbox" style="width:30px" onclick="c.value=this.checked?'Y':'N'"/>
		                						<input class="enterprise"  id="c" name="dmsEnabled" type="hidden" value="N" >
		                						 -->
		                						<input id="dmsEnabled" name="dmsEnabled" type="checkbox" class="enterprise"  />
		                						
							         		</td>
										</tr>
										<tr>
											<td class="td-label"><label>是否可用APP：&nbsp;</label></td>
							         		<td class="td-content">
							         			<!-- <input class="enterprise" name="attr4" type="checkbox" style="width:30px" onclick="d.value=this.checked?'Y':'N'"/>
		                						<input class="enterprise"  id="d" name="appEnabled" type="hidden" value="N" >
		                						 -->
		                						<input id="appEnabled" name="appEnabled" type="checkbox" class="enterprise" />
		                						
							         		</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<!-- tab2  企点设置 -->
					<div title="企点设置">
					<table class="form-table">
						<tr>
							<td style="width: 33%;">
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>授权方appid : &nbsp;</label></td>
						         		<td class="td-content">
						         			<input id="authAppid" name="authAppid" disabled="disabled" class="easyui-textbox"/>
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>刷新令牌 : &nbsp;</label></td>
						         		<td class="td-content">
						         			<input id="authRefreshToken" name="authRefreshToken" disabled="disabled" class="easyui-textbox"
						         				data-options="multiline:true" style="height: 60px;"/>
						         			
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>授权令牌 : &nbsp;</label></td>
						         		<td class="td-content">
						         			<input id="authAccessToken" name="authAccessToken" disabled="disabled" class="easyui-textbox"
						         				data-options="multiline:true" style="height: 60px;"/>
						         		</td>
									</tr>
									<tr>
                                        <td class="td-label"><label>授权令牌时间 : &nbsp;</label></td>
                                        <td class="td-content">
                                            <input id="tokenCreatedDate" name="tokenCreatedDate" disabled="disabled" class="easyui-textbox"/>
                                        </td>
                                    </tr>
								</table>
							</td>
							<td style="width: 33%;">
								<table class="table-block" >
									<tr>
										<td class="td-label"><label>token : &nbsp;</label></td>
						         		<td class="td-content">
						         			<input id="qdToken" name="qdToken" class="easyui-textbox" disabled="disabled"
						         				data-options="multiline:true" style="height: 60px;"/>
						         			
						         		</td>
									</tr>
									<tr>
										<td class="td-label"><label>aeskey : &nbsp;</label></td>
						         		<td class="td-content">
						         			<input id="qdAeskey" name="qdAeskey" class="easyui-textbox" disabled="disabled"
						         				data-options="multiline:true" style="height: 60px;"/>
						         			
						         		</td>
									</tr>
									<tr>
                                        <td class="td-label"><label>token的key : &nbsp;</label></td>
                                        <td class="td-content">
                                            <input id="enterpriseKey" name="enterpriseKey" disabled="disabled" class="easyui-textbox"
                                                data-options="multiline:true" style="height: 60px;"/>
                                        </td>
                                    </tr>
								</table>
							</td>
							<td style="width: 33%;">
								<table class="table-block" >
									<tr>
                                        <td class="td-label"><label>企点用户数：&nbsp;</label></td>
                                        <td class="td-content">
                                            <input id="qdUserAmount" name="qdUserAmount" class="easyui-numberspinner"/>
                                        </td>
                                    </tr>
									<tr>
						         		<td class="td-label"><label>工作流标志 : &nbsp;</label></td>
                                        <td class="td-content">
                                            <input id="qdTaskFlag" name="qdTaskFlag" type="checkbox" class="enterprise"  />
                                        </td>
									</tr>
									<tr>
										<td class="td-label"></td>
						         		<td class="td-content"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
						<div id="qidianComponentDiv" style="display: none; position: fixed; bottom: 100px; right: 50px;">
							<a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-reload" 
								id="qidianComponent" onclick="confirmComponentLogin()">企点授权&nbsp;&nbsp;&nbsp;</a>
						</div>
					</div>
					<!-- tab3  微信设置 -->
					<div title="微信设置">
						<table class="form-table">
							<tr>
								<td>
									<table class="table-block"> 
										<tr>
							         		<td colspan="2" style="vertical-align:bottom; text-align:center;">
							         			<input class="enterprise" id="qrCodeId" name="qrCodeId" type="hidden">
							         			<input class="enterprise" id="qrCodeUrl" name="qrCodeUrl" type="hidden">
												<img id="qrCodeImg" height="150px" width="150px" src="${AppContext.ctxPath}/static/images/empty.jpg" alt=""/>
							         		</td>
										</tr>
										<tr >
											<td colspan="2" style="vertical-align:bottom; text-align:center;">
												<a href="javascript:void(0);" class="file ui-btn fileQRCodeImg" style="margin-right: 5px;">上传二维码
													<input class="enterprise"  type='hidden' name='method' value='upload'/>
													<input class="enterprise"  type='file' id="fileInput" name='myfile' accept="image/jpeg,image/png,image/bmp"
														   onchange="preImg(this.id,'qrCodeImg')"/>
												</a>
												<a href="javascript:void(0);" class="file ui-btn" onclick="openQRCode()">打开二维码</a>
											</td>
										</tr> 
										
										
									</table>
								</td>
							</tr>
						</table>
					</div>
					<!-- tab4  邮箱设置 -->
					<div title="邮箱设置">
						<table class="form-table">
							<tr>
								<td>
									<table class="table-block"> 
										<tr>
											<td class="td-label"><label>服务器: &nbsp;</label></td>
											<td class="td-content">
												<input class="easyui-validatebox enterprise" id="emailServer" name="emailServer"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>用户名: &nbsp;</label></td>
											<td class="td-content">
												<input class="easyui-validatebox enterprise" id="emailUsername" name="emailUsername"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>密码: &nbsp;</label></td>
											<td class="td-content">
												<input class="easyui-validatebox enterprise" id="emailPsw" name="emailPsw"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="首页设置">
						<table style="width: 100%;text-align: center;margin-top: 60px;">
							<tr>
								<td>
								<div  class="td-label" style="display:inline-block;"><label>首页风格: &nbsp;</label></div>
								<div class="td-content" style="display:inline-block;">
										<input class="easyui-combobox enterprise" id="homePageCombobox" name="homePage"/></div>
								</td>
							</tr>
							<tr><td><a href="###" class="easyui-linkbutton" iconCls="icon-uploadImg" onclick="preview()">预览</a></td></tr>
						</table>
					</div>
					
					<div title="联系我们">
						<table style="width: 100%;text-align: center;margin-top: 60px;">
							<tr style="height:190px;">
								<td>
								<!-- <div  class="td-label" style="display:inline-block;"><label>首页风格: &nbsp;</label></div> -->
								
										<input class="easyui-textbox enterprise" id="contactUsText" name="contactUsText" 
										data-options="multiline:true,width:'90%',
									         							  height:'100%'"/>
								</td>
							</tr>
						</table>
					</div>
					
					<div title="企业参数" href="${AppContext.ctxPath}/portal/enterprise/modules/CfgPropertyList.jsp">
						
					</div>
					
				</div>
				<input class="enterprise" id="userId" name="userId" hidden="true" />
				<input class="enterprise" id="enterpriseId" name="id" hidden="true" />
				<input class="enterprise" id="row_status" name="row_status" hidden="true" />
			</form>
		</div>
	</div>
	<!-- table end -->
	<div id="floor" style="position:fixed; bottom: 0; left: 0; width: 100%; height: 40px; background:#e8f1ff;">
		<div style="float: right; margin-top: 7px; margin-right: 30px; margin-bottom: 20px;">
			<a href="###" class="easyui-linkbutton" iconCls="icon-undo" onclick="cancel()">取 消&nbsp;&nbsp;&nbsp;</a>
				&nbsp;
			<a href="###" class="easyui-linkbutton" iconCls="icon-redo" onclick="save()">保 存&nbsp;&nbsp;&nbsp;</a> 
				&nbsp;
			<!-- <a class="easyui-linkbutton" iconCls="icon-redo" onclick="initializeCompany()">企业初始化&nbsp;&nbsp;&nbsp;</a> --> 
		</div>
	</div>
	<script type="text/javascript">
	/* $(document).ready(function() { 
		initInfo();
	}); */ 
	var enterpriseCode = "";
	$form = $("#enterpriseForm");
	$priceListPickList   = $('#priceListName');//价格表
	$priceListIdInput  	= $('#defaultPrice');
	$crmDutyNamePickList   = $('#crmDutyName');//crm职责
	$crmDutyIdInput  	= $('#crmDutyId');
	$appDutyNamePickList   = $('#appDutyName');//app职责
	$appDutyIdInput  	= $('#appDutyId');
	$industryVersionCombobox = $("#industryVersion");//行业版
	$homePageCombobox = $("#homePageCombobox");
	
	$('#enterprise-tabs').tabs();
	$("[type='checkbox']", $form).change(function(){
		if($(this).prop("checked")){
			$(this).attr("value", "Y");
		}else{
			$(this).attr("value", "N");
		}
	});
	//初始化 客户状态 下拉列表
	$homePageCombobox.combobox({
		data : getLovArray('HOME_PAGE'),
		valueField : 'val',
		textField : 'name',
		editable : false, //不可编辑状态
		cache : false
	});
	$industryVersionCombobox.combobox({ 
		method:'get',
		data:getLovArray('INDUSTRY_VERSION'),
		valueField:'val',
		textField:'name',
	    editable:false, //不可编辑状态
	    panelHeight: 'auto',//自动高度适合
	    cache: false
	});
	
	//选择价格表
	/* $priceListPickList.picklist({
		title:'选择价格表',
		required:true,
		oauthFlag:false,
		completeFun:function(selectRow){
			$priceListIdInput.val(selectRow.id);
			return selectRow.priceListName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/picklist/priceListPickList.jsp'
	}); */
	
	$crmDutyNamePickList.picklist({
		title:'选择CRM职责',
		required:true,
		oauthFlag:false,
		completeFun:function(selectRow){
			$crmDutyIdInput.val(selectRow.id);
			return selectRow.name;
		},
		tableUrl:'${AppContext.ctxPath}/portal/enterprise/picklist/crmDutyPickList.jsp'
	});
	
	$appDutyNamePickList.picklist({
		title:'选择APP职责',
		required:true,
		oauthFlag:false,
		completeFun:function(selectRow){
			$appDutyIdInput.val(selectRow.id);
			return selectRow.respName;
		},
		tableUrl:'${AppContext.ctxPath}/portal/enterprise/picklist/appDutyPickList.jsp'
	});
	
	function preview(){
		var page = $homePageCombobox.combobox("getValue");
		if(page){
			var url =  "${AppContext.ctxPath}"+page;
			window.open(url);    
		}else{
			alert("请选择数据");
		}
	}
	function save(){
		var isPass = $form.form('validate');
		//用户具有可新建权限
		if(top.addFlag != "Y"){
			$.messager.alert("错误", "您没有新建的权限","error");
			return false;
		}
		if(!isPass){
			return isPass;
		}else{
			//IE兼容性修改
			var obj =getObject();
			/* $("input .enterprise", $form).each(function(i, item){
				obj[$(this).attr("name")] = $(this).val();
			}); */
			//console.info(obj);
		   	var options = {
					url:"${AppContext.ctxPath}/action/portal/enterprise/upsert",
					dataType:"json",
					//data:obj,
					method:"post",
					success:function(data){
						if(data.success){
							//console.info(data);
							window.parent.closeAddEnterpriseWin();
							window.parent.operationtip('保存成功！', 'success');
							window.parent.$datagrid.hdatagrid("reload");
						}else{
							console.info(data);
							window.parent.operationtip(data.result, 'error');
						}
					}
			   	};
			$form.ajaxSubmit(options);
		}
	}
	function initializeCompany(){
		$.messager.confirm("操作提示", '是否确定初始化企业？', function(data) {
			if(data){
				var isPass = $form.form('validate');
				//用户具有可新建权限
				if(top.addFlag != "Y"){
					$.messager.alert("错误", "您没有新建的权限","error");
					return false;
				}
				if(!isPass){
					return isPass;
				}else{
					//IE兼容性修改
					var obj = getObject();
					/* $("input .enterprise", $form).each(function(i, item){
						obj[$(this).attr("name")] = $(this).val();
					});
 */
					$.ajax({
						async: false,
						url:"${AppContext.ctxPath}/action/portal/enterprise/initializeCompany",
						dataType:"json",
						data:obj,
						method:"post",
						success:function(data){
							if(data.success){
								window.parent.closeAddEnterpriseWin();
								window.parent.operationtip('初始化成功！<br/>'+data.message, 'success');
								window.parent.$datagrid.hdatagrid("reload");
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						}
					});
				}
			}
		});
		
	}
	function cancel(){
		window.parent.closeAddEnterpriseWin();
	}
	
	/**
	 * 初始化数据
	 */
	 function initInfo(id, enterprise){
		//alert(enterprise);
		$form.form("clear");
		if(id){
			$.post('${AppContext.ctxPath}/action/portal/enterprise/queryById', 
					{
						id	: id
				    },
					function(data){
				    	if(data.success){
				    		var obj = data.result;
				    		if(!obj.row_status){
				    			obj.row_status = 'UPDATE';//设为更新状态
				    		}
				    		//$form.form("load", obj);
				    		loadObject(obj);
				    		enterpriseCode = obj.code;
				    		initCfgList();
						}else if(data.result){
							$.messager.alert('错误',data.result, "error");
						}else{
							$.messager.alert("错误", "加载数据出错啦!", "error");
						}
					});
		}else if(enterprise){
			var obj = enterprise;
			if(!obj.row_status){
				$.messager.alert("错误", "加载数据出错啦!<br>无法识别当前为更新或新建状态", "error");
				return;
			}
			if(obj.row_status == 'UPDATE'){
				$('#qidianComponentDiv').css("display", "");//显示【企点授权】按钮
			} else {
				$('#qidianComponentDiv').css("display", "none");//显示【企点授权】按钮
			}
			/* if(obj.dealerApplySelf == 'Y'){
				obj.attr1 = 'on';
			}else if(obj.dealerApplySelf == 'N'){
				obj.attr1 = 'off';
			}
			if(obj.crmEnabled == 'Y'){
				obj.attr2 = 'on';
			}else if(obj.crmEnabled == 'N'){
				obj.attr2 = 'off';
			}
			if(obj.dmsEnabled == 'Y'){
				obj.attr3 = 'on';
			}else if(obj.dmsEnabled == 'N'){
				obj.attr3 = 'off';
			}
			if(obj.appEnabled == 'Y'){
				obj.attr4 = 'on';
			}else if(obj.appEnabled == 'N'){
				obj.attr4 = 'off';
			} */
			
			if(obj.qrCodeUrl != null){
				$('img').attr("src",obj.qrCodeUrl);
			}
			//$form.form("load", obj);
			enterpriseCode = obj.code;
			loadObject(obj);
			initCfgList();
		}else{
			$.messager.alert("错误", "加载数据出错啦!<br>请传入正确参数", "error");
		}
	}
	function initCfgList(){
		if($("#cfg-table").length){
			$("#cfg-table").datagrid("reload");
		}
	}
	//打开二维码图片链接
	function openQRCode(){
		var url = $('#qrCodeUrl').val();
		if(url == '' || url == null){
			$.messager.alert("警告", "请先上传二维码图片！");
			return;
		}
		window.open(url);
	}
	
	/* $(".fileQRCodeImg").change(function(){
		$.messager.alert("提示", "已选中图片，保存后即可完成上传！");
	}); */
	
	/**文件预览方法**/
	function preImg(sourceId, targetId) {
		var url = getFileUrl(sourceId);
		if(!url){
			url = '';
		}
		$('#' + targetId).attr('src', url);
		var fileName = $('#' + sourceId).val();
		if(!fileName){
			fileName = '';
		}
		//$('#fileNameShowBox').text(fileName);
	}
	function getFileUrl(sourceId) {
		var url;
		if (navigator.userAgent.indexOf("MSIE")>=1) { // IE 
		url = document.getElementById(sourceId).value; 
		} else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox 
		url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
		} else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome 
		url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
		} 
		return url; 
	}
	
	/**
	 * 如果authAppid不为空，则提示是否确定授权
	 */
	function confirmComponentLogin(){
		if($('#authAppid').textbox('getValue')){
			$.messager.confirm("操作提示", '该企业账套已绑定了企点授权信息，是否重新获取企点授权信息？', function(data) {
				if(data){
					qidianComponentLogin();
				}
			});
		} else {
			qidianComponentLogin();
		}
	}
	
	/**
	 * 企点授权
	 */
	function qidianComponentLogin(){
		$('#qidianComponent').linkbutton('disable');
		var id = $('#enterpriseId').val();
		operationprogress('进度提示', '正在进行...');
		$.post("${AppContext.ctxPath}/action/qidian/authtoken/componentLoginPage", {
			id : id
		}, function(data){
			$.messager.progress('close');
			$('#qidianComponent').linkbutton('enable');
			if(data.success){
				window.open(data.url);
				$.messager.alert("提示", "是否授权成功", "info", function(){
					$.post('${AppContext.ctxPath}/action/portal/enterprise/queryById', {
								id	: id
					},function(data){
				    	if(data.success){
				    		var obj = data.result;
				    		$('#authAppid').textbox('setValue',obj.authAppid);
				    		$('#authAccessToken').textbox('setValue',obj.authAccessToken);
				    		$('#authRefreshToken').textbox('setValue',obj.authRefreshToken);
				    		$('#tokenCreatedDate').textbox('setValue',obj.tokenCreatedDate);
						}else {
							$.messager.alert('错误',data.result, "error");
						}
					});
				});
			}else{
				$.messager.alert("错误", data.result, "error");
			}
		});
	}
	
	function getObject(){
		var object = {};
		$("[name].enterprise", $form).each(function(){
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
		console.log(object);
		return object;
	}
	
	/**
	 * 把对象数据填充到表单上
	 */
	function loadObject(object){
		$form.form("clear");
		$form.form("load", object);
		for (key in object) {
			value = object[key];
			$("[name='" + key + "'][type='checkbox'].enterprise", $form)
					.each(
							function() {
								$(this).prop("checked", value=="Y" ? true : false);
								$(this).attr("value", value=="Y" ? "Y" : "N");
							});
		} 
	}
	</script>
</body>
</html>