<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<style type="text/css"></style>

<body>		
	<div id="menu_layout"  class="easyui-layout" border="false" fit="true">
   		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<table id="deposit-table"  singleSelect="true" rownumbers="true"  pagination="true" style="width:98%;height:347px;">
				<thead>
				<tr>
				<th field="id" defaultSearch="false" width="100px">网店编码</th>
				<th field="name" width="200px"}"  >网店名称</th>
				<th field="applicantName"   width="100px" editor="{type:'textbox',options:{required:true}}"  >管理员姓名</th>
				<th field="userId"   width="100px">管理员编码</th>
				<th field="applicantPhone"   width="100px" editor="{type:'validatebox',options:{required:true,validType:'mobile',}}"  >管理员电话</th>
				<th field="applicantMailbox" width="130px" editor="{type:'validatebox',options:{required:true,validType:'email',}}">管理人邮箱</th>
				<th field="applicantStatus" defaultSearch="false"  width="120px" lov="STORE_MANAGER_STATUS"editor="{type:'combobox',options:{valueField:'val',
															textField:'name',
															data:getLovArray('STORE_MANAGER_STATUS'),
															editable:false}}">管理人状态</th>
				</tr>
			</thead>
		</table>
		<table id="deposit-table-record" title="店铺客服人员" style="width:98%;height:55%;">
			<thead>
				<tr>
				<th field="custName" width="18%" editor="{type:'textbox', options:{required:true}}">客服姓名</th>
				<th field="nickname" width="18%" editor="{type:'textbox',options:{required:false}}">客服昵称</th>
				<th field="custCode" width="18%" editor="{type:'textbox',options:{required:true}}">客服编码</th>
				<th field="custPhone" width="18%" editor="{type:'textbox'}">客服电话</th>
				<th field="custSstatus"  width="18%" editor="{type:'textbox',options:{required:false}}">客服人员状态</th>
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
		$('.easyui-layout').layout();
		$datagrid = $('#deposit-table');
		$dataItemgrid = $('#deposit-table-record');
		
		var $changePdDiv = $('#changePdDiv');//修改密码的弹出框
		var $changePdForm = $('#changePdForm');//弹出框的表单
		$datagrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true, //显示工具栏
					buttonSearch : true, //搜索框功能
					buttonExport : true,
					buttonDelete :true,
					buttonCopy : false,
					buttonMenu : true,
					buttonNew : true,
					oauthFlag : true,
					menuButtonCount : true,
					striped : true,
					title : '',
					border : false,
					pageSize: 10,//每页显示的记录条数，默认为10 
				    pageList: [5,10,15],//可以设置每页记录条数的列表 
				    url:'${AppContext.ctxPath}/action/portal/enterprise/queryShopKeeperPage',
					subGridIds: ['deposit-table-record'],					
		 			
					onAddMoreButton:function(that,addButtonFun){
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="receiveDeposit()" iconCls="icon-undo" plain="true">押金到账</a>',that);
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="setPsw()">初始化密码</a>',that);
						addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cog" plain="true" onclick="openChangePdDiv()">修改密码</a>',that);
		 			}, 
					onUpdateAction : function(row, successFun, errFun, that) {
						$.post('${AppContext.ctxPath}/action/portal/enterprise/update',
						row, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
								}
							});
					},
					onInsertAction : function(row, successFun, errFun, that) {
						$.post('${AppContext.ctxPath}/action/portal/enterprise/shopKeeperInsert',
						row, function(data) {
								if (!data.success) {
									errFun(data.result, that);
								} else {
									successFun(that, data);
									$.messager.alert("成功", "新建管理员成功，登录名为电话号码，请设置密码！", "info");
								}
							});
					},
				});

		$dataItemgrid
				.hdatagrid({
					updateable : true,
					toolbarShow : true,
					buttonSearch : true,
					buttonNew : true,
					//pagination:false,//是否分页
					parentGridId : 'deposit-table',
					parentGridField : 'id',
					linkGridField : 'entpId',
					url : '${AppContext.ctxPath}/action/portal/enterprise/queryCustomerServicePage',
					pageSize : 10,//每页显示的记录条数，默认为10 
					pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表 

					onInsertAction : function(row, successFun, errFun, that) {
						//获取头的row_id
						row.entpId = $datagrid.hdatagrid('getCurrentRow').id;
						$.post('${AppContext.ctxPath}/action/portal/enterprise/customerServiceInsert',
										row, function(data) {
											if (!data.success) {
												errFun(data.result, that);
											} else {
												successFun(that, data);
											}
										});
					},
				});
		
		//押金支付
		function receiveDeposit(){
			var userId =$datagrid.hdatagrid('getCurrentRow').userId;
			$.post("${AppContext.ctxPath}/action/portal/enterprise/storeStatusPayUpdate",{userId:userId},
					function(data){
						if(data){
							if(data.success){
								alert("success");
							}
						}
			});
		}
		//初始化密码
		function setPsw(){
			var row = $datagrid.hdatagrid("getSelected");
			if(!row){
				$.messager.alert("错误", "请选择一行", "error");
				return;
			}
			$.post("${AppContext.ctxPath}/action/portal/user/genPsw", {id: row.userId}, function(data){
				if(data.success){
					$.messager.alert("成功", "初始化成功，密码为联系电话后六位", "info");
				}else{
					$.messager.alert("成功", data.result, "info");
				}
			});
		}
		//重置密码
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
			$('input[name=id]',$changePdDiv).val(row.userId);
			$('input[name=empType]',$changePdDiv).val('BRAND_EMP');
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
	</script>
</body>
</html>