<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.validate.js?version=<%=version%>"></script>
<body>
	<div  class="easyui-layout" data-options="fit:true" border="false">
	   <div data-options="region:'north',split:true" fit="true" border="false">
			<table id="user-table" width="100%" height="100%" title=""
				singleSelect="true" rownumbers="true" toolbar="#user-table-toolbar"
				pagination="true">
				<thead>
					<tr>
						<th field="firstName" width="100px" editor="{type:'textbox', options:{required:true}}">姓名</th>
						<th field="username" width="100px" editor="{type:'textbox', options:{required:true}}">用户名</th>
						<th field="contactPhone" width="100px"
							editor="{type:'textbox',options:{required:true, validType:'mobile',}}">联系电话</th>
						<th field="email" width="100px" editor="{type:'textbox', options:{required:true}}">邮件</th>
						<th field="postnName" width="150px" editor="{type:'mvgPickbox',
							options:{title:'职位',completeFun:postnMvgPickComplete,
									mvgMapperName:'userPostn',
									tableId:'user-table',
									optionsLeft:{
										tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnLeftMvgPick.jsp',
										initParam:postnMvgPickParam
									},
									optionsRight:{
										tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/PostnRightMvgPick.jsp'
									}
									}}">主要职位</th>
						<th field="postnId" hidden="true">职位ID</th>			
						<th field="orgName" width="140px">组织名称</th>
						<th field="unitname" width="100px" editor="{type:'textbox'}">部门</th>
						<th field="dutyName" width="140px" editor="{
							type:'mvgPickbox',
							options:{
								title:'职责',completeFun:dutyMvgPickComplete,
								mvgMapperName:'userDuty',
								tableId:'user-table',
								onBeforeOpenDialog:dutyOnBeforeOpenDialog,
								optionsLeft:{
									tableUrl:'${AppContext.ctxPath}/portal/user/mvgPick/DutyLeftMvgPick.jsp',
									initParam:dutyMvgPickParam
								},
								 init: function(container, options){
							        	alert(2);
							            return false;
							     }
							}
						}">职责</th>
						<th field="dutyId" hidden="true">职责ID</th>
						<%--<th field="zhEmail" width="100px" editor="{type:'textbox'}">智齿邮箱</th>--%>
						<%--智齿邮箱--%>
						<th field="zhEmail" width="100px" lov="ZHICHI_MAILBOX"
							editor="{type:'combobox',
											options:{valueField:'name',
											textField:'name',
											method:'get',
											data:getLovArray('ZHICHI_MAILBOX'),
											editable:false }}">智齿邮箱</th>

						<th field="role" width="100px" lov="ROLE"
							editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('ROLE'),
											editable:false,
											required:true}}">角色</th>
						 <%-- <th field="appResp" width="0px" editor="{type:'picklistbox',options:{title:'选择App职责',
															completeFun:appDutyPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/appDutyPickList.jsp'}}"></th>  --%>
						<th field="contact" width="100px" editor="{type:'textbox'}"
							style="display: none;">联系人</th>
						<th field="scancardFlag" width="100px" align="center" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">扫描名片</th>
						<th field="qixinbaoFlag" align="center" editor="{type:'checkbox', options:{on:'Y', off:'N'}}">启信宝</th>
						<th field="basename" width="100px" editor="{type:'textbox'}">base地点</th>
						<th field="formuladate" width="100px" mark="DATE" editor="{type:'textbox'}">聘用日期</th>
						<th field="hometown" width="100px" editor="{type:'textbox'}">常住地</th>
						<th field="joblevel" width="100px" editor="{type:'textbox'}">级别</th>
						<th field="joindate" width="100px" mark="DATE" editor="{type:'textbox'}">入职日期</th>
						<!-- <th field="joingroupdate" width="100px" hidden="true" editor="{type:'textbox'}">入职日期</th> -->
						<th field="nextproj" width="100px" editor="{type:'textbox'}">下一项目</th>
						<th field="positionname" width="100px" editor="{type:'textbox'}">职务</th>
						<th field="gender" width="60px" lov="GENDER" editor="{type:'combobox',options:{valueField:'val',
																	textField:'name',
																	data:getLovArray('GENDER'),
																	editable:false}}">性别</th>
						<th field="trialdate" width="100px" mark="DATE" editor="{type:'textbox'}">开始试用期</th>
						<th field="workdate" width="100px" mark="DATE" editor="{type:'textbox'}">转正日期</th>
						<th field="status" width="100px" lov="USER_STATUS"
							editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('USER_STATUS'),
											editable:false}}">状态</th>
						<th field="empType" lov="EMP_TYPE" width="100px">类型</th>
						<%-- <c:set var="systemRole" scope="session" value="${appCtx.systemRole}"/>  --%>
						<c:if test="${UserContext.systemRole == 'super_administrator'}">
						<th field="corpName" width="120px" editor="{type:'picklistbox',options:{title:'选择企业帐套',
															completeFun:enterpPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/enterprisePickList.jsp'}}">公司账套</th>
						<!-- <th field="errorTimes" width="100px">登陆错误次数</th> -->
						<th field="systemRole" width="100px" lov="SYSTEM_ROLE"
							editor="{type:'combobox',
											options:{valueField:'val',
											textField:'name',
											method:'get',
											data:getLovArray('SYSTEM_ROLE'),
											editable:false}}">系统角色</th>
						 </c:if>
					</tr>
				</thead>
			</table>

		</div>
	</div>
	<!-- ------------------------弹出框：开始----------------------------  -->
	<div id="changePdDiv">
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'center',border:false" style="padding:10px;background:#fff;border:1px solid #ccc;">
				<form method="post" id="changePdForm" style="text-align:center;margin-top: 30px;" 
					enctype="multipart/form-data" >
					<table class="table-block" style="text-align:center;margin: 0px auto;">
						<tr>
							<td class="td-label"><label>新密码 : &nbsp;</label></td>
							<td class="td-content">
								<input id="newPassword" name="newPassword" type='password' required="true" class="easyui-textbox"/>
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>确认密码 : &nbsp;</label></td>
							<td class="td-content">
								<input id="confirmPassword" name="confirmPassword" type='password' required="true" class="easyui-textbox"/>
							</td>
						</tr>
					</table>
					<input name="id" hidden="true" />
					<input name="empType" hidden="true" />
				</form>
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0px;">
				<a class="easyui-linkbutton upload" style="width:100px;margin-right: 30px;" 
					data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="changePassword()">确定修改</a>
				<a class="easyui-linkbutton" style="width:100px;margin-right: 30px;" 
					data-options="iconCls:'icon-cancel'" href="javascript:void(0)" 
					onclick="closeDiv()">取消</a>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		$datagrid = $('#user-table');
		var $changePdDiv = $('#changePdDiv');//修改密码的弹出框
		var $changePdForm = $('#changePdForm');//弹出框的表单
		getLovOfList("[CORP_ID,USER_STATUS,EMP_APP_ROLE,ROLE]");
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			
			newDefaultValue:true,
			oauthFlag:true,
			url : '${AppContext.ctxPath}/action/portal/user/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setPsw()">初始化密码</a>',that);
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="openChangePdDiv()">修改密码</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setLoginErrorTimes()">重置登录次数</a>',that);
			},
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				var rows_2 = [];
				for(var i=0; i< rows.length; i++){
					var row = rows[i];
					var row_2 = {
							row_status   	: "UPDATE",
							id 				: row.id,
							username 		: row.username,
							firstName 		: row.firstName,
							companyCode 	: row.companyCode,
							role 			: row.role,
							appRole 		: row.appRole,
							corpid 			: row.corpid,
							contact 		: row.contact,
							contactPhone 	: row.contactPhone,
							email 			: row.email,
							basename 		: row.basename,
							formuladate 	: row.formuladate,
							hometown 		: row.hometown,
							joblevel 		: row.joblevel,
							joindate 		: row.joindate,
							joingroupdate 	: row.joingroupdate,
							nextproj 		: row.nextproj,
							positionname 	: row.positionname,
							trialdate 		: row.trialdate,
							unitname 		: row.unitname,
							workdate 		: row.workdate,
							status 			: row.status,
							empType			:'INTER_EMP',
							uKeyId 			: row.uKeyId,
							zqsfmy1 		: row.zqsfmy1,
							postnId 		: row.postnId,
							dutyId			: row.dutyId,
							appResp       : row.appResp,
							scancardFlag: row.scancardFlag,
							joindate:row.joindate,
							updateVersion:row.updateVersion,
							currentProject:row.currentProject,
							proRole:row.proRole,
							enterProjDate:row.enterProjDate,
							releaseDate:row.releaseDate,
							sourceStatus:row.sourceStatus,
							planComments:row.planComments,
							timesheet:row.timesheet,
							gender			: row.gender,
							qixinbaoFlag    : row.qixinbaoFlag,
							systemRole      : row.systemRole,
                        	zhEmail      : row.zhEmail,

					}
					rows_2.push(row_2);
				}
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/user/batchUpdate",
					type:"post",
					data:JSON.stringify(rows_2),
					dataType:"json",
					contentType: "application/json",
					success: function(data){
						if(data.success){
							successFun(that, data);
						}else{
							errFun(that, data);
						}
					},
					error: function(xhr, code, msg){
						errFun(that, "msg");
					}
				});
			},				
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/user/upsert', {
					row_status   	: row.row_status,
					id 				: row.id,
					username 		: row.username,
					firstName 		: row.firstName,
					companyCode 	: row.companyCode,
					role 			: row.role,
					appRole 		: row.appRole,
					corpid 			: row.corpid,
					contact 		: row.contact,
					contactPhone 	: row.contactPhone,
					email 			: row.email,
					basename 		: row.basename,
					formuladate 	: row.formuladate,
					hometown 		: row.hometown,
					joblevel 		: row.joblevel,
					joindate 		: row.joindate,
					joingroupdate 	: row.joingroupdate,
					nextproj 		: row.nextproj,
					positionname 	: row.positionname,
					trialdate 		: row.trialdate,
					unitname 		: row.unitname,
					workdate 		: row.workdate,
					status 			: row.status,
					empType			:'INTER_EMP',
					uKeyId 			: row.uKeyId,
					zqsfmy1 		: row.zqsfmy1,
					postnId 		: row.postnId,
					dutyId			: row.dutyId,
					appResp       : row.appResp,
					scancardFlag: row.scancardFlag,
					joindate:row.joindate,
					leaderId:row.leaderId,
					updateVersion:row.updateVersion,
					currentProject:row.currentProject,
					proRole:row.proRole,
					enterProjDate:row.enterProjDate,
					releaseDate:row.releaseDate,
					sourceStatus:row.sourceStatus,
					planComments:row.planComments,
					timesheet:row.timesheet,
					gender			: row.gender,
					qixinbaoFlag    : row.qixinbaoFlag,
					systemRole      : row.systemRole,
                    zhEmail     	  : row.zhEmail,
				}, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/user/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that, data);
							}
						});
					}
				});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				if(appCtx.systemRole != 'super_administrator'){
					return {
						empType:"内部用户",
						corpid:appCtx.corpId
					};
				}else{
					return {
						empType:"内部用户",
					};
				}
			}
		});
		
		/**
		 * 职位mvgPick 按【确定】后执行的方法
		 */
		function postnMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.postnId = rightRowsMvg.id;
				currentRow.postnName = rightRowsMvg.postnName;
			}
			return currentRow.postnName;
		}
		/**
		 * 职位mvgPick 列表数据初始化参数
		 */
		function postnMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id};
		}
		//职位Mvg的添加 end
		
	function appDutyPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').appResp = selectRow.respName;
			return selectRow.respName;
		} 
		
		function dutyOnBeforeOpenDialog(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(!currentRow.corpid){
				$.messager.alert("错误", "请先选择账套", "error");
				return null;
			}else{
				return true;
				
			}
		}
		/**
		 * 职责mvgPick 按【确定】后执行的方法
		 */
		function dutyMvgPickComplete(rightRowsMvg) {
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			if(rightRowsMvg != null){
				currentRow.dutyId = rightRowsMvg.id;
				currentRow.dutyName = rightRowsMvg.name;
			}
			return currentRow.dutyName;
		}
		/**
		 * 职责mvgPick 列表数据初始化参数
		 */
		function dutyMvgPickParam(){
			var currentRow = $datagrid.hdatagrid('getCurrentRow');
			return {mvgParentId:currentRow.id
			,attr1:currentRow.corpid};

		}
		
		function enterpPicklistComplete(selectRow){
			var row = $datagrid.datagrid('getSelected');
			row.corpid = selectRow.code;
			return selectRow.name;
		}
		function setPsw(){
			var row = $datagrid.hdatagrid("getSelected");
			if(!row){
				$.messager.alert("错误", "请选择一行", "error");
				return;
			}
			$.post("${AppContext.ctxPath}/action/portal/user/genPsw", {id: row.id}, function(data){
				if(data.success){
					$.messager.alert("成功", "初始化成功，密码为联系电话后六位", "info");
				}else{
					$.messager.alert("成功", data.result, "info");
				}
			});
		}
		function openChangePdDiv(){
			$changePdDiv.dialog({
				title:'修改密码',
			    width:'400px',
			    height:'250px',
			    closable:false,
			    minimizable:false,
			    collapsible:false,
			    modal:true,
			    closed:true
			});
			$changePdDiv.window('open');
		}
		
		$changePdForm.form({
			url : '${AppContext.ctxPath}/action/portal/userUtil/changeEmployeePassword',
			onSubmit : function(){
				return $changePdForm.form('validate');
			},
			success : function(data){
				var data = eval('(' + data + ')'); // change the JSON string to javascript object
				if (data.success) {
					$.messager.alert('提示','修改成功！');
					closeDiv();
				} else {
					$.messager.alert('提示', data.result);
				}
			}
		});
		
		/**
		 * 修改选中行的密码
		 */
		function changePassword() {
			var row = $datagrid.hdatagrid('getSelected');
			if(!row){
				$.messager.alert('提示', '请选择行。');
				return false;
			}
			$('input[name=id]',$changePdDiv).val(row.id);
			$('input[name=empType]',$changePdDiv).val(row.empType);
			$changePdForm.submit();
		}
		
		/**
		 * 关闭并清空弹出框内容
		 */
		function closeDiv(){
			$('input[name=id]',$changePdDiv).val('');
			$('input[name=empType]',$changePdDiv).val('');
			$('#newPassword',$changePdDiv).textbox('setValue','');
			$('#confirmPassword',$changePdDiv).textbox('setValue', '');
			$changePdDiv.window('close');
		}
		
		function setLoginErrorTimes(){
			var row = $datagrid.hdatagrid("getSelected");
			if(!row){
				$.messager.alert("错误", "请选择一行", "error");
				return;
			}
			$.post("${AppContext.ctxPath}/action/portal/user/resetErrorTimes", {id: row.id}, function(data){
				if(data.success){
					$.messager.alert("成功", "重置成功，已将登录错误次数重置为0", "info");
				}else{
					$.messager.alert("错误", data.result, "info");
				}
			});
		}
	</script>
</body>
</html>