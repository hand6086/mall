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
	width:90px;
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
		<div data-options="region:'north',split:true,collapsible:false" title="账户概况" border="false" width="100%" height="100%">
			<form id="billForm" method="post" enctype ="multipart/form-data" style="margin-bottom: 0px;" > 
				<div>
					<table class="table-block">
						<tr>
							<td class="td-label"><label>单据类型 : &nbsp;</label></td>
							<td><label >提现对账单</label></td>
							<td class="td-label"><label>单据编号 : &nbsp;</label></td>
							<td><label id="id"></label></td>
							<td><label id="count" hidden="true"></label></td>
						</tr>
						<tr>
							<td class="td-label"><label>商家名称 : &nbsp;</label></td>
							<td><label id="enterpriseName"></label></td>
						</tr>
						<tr>
							<td class="td-label"><label>提现银行卡 : &nbsp;</label></td>
							<td><input id="merchantAccount" name="merchantAccount" style="width: 300px" /></td>
							<td>
							<a href="###"  onclick="addAccount()">账户维护</a>
							</td>
						</tr>
						<tr>
							<td class="td-label"><label>到账金额 : &nbsp;</label></td>
							<td class="td-content"><input id="arrivedAmount" name="arrivedAmount"readOnly="true" /></td>
							<td class="td-label"><label>手续费: &nbsp;</label></td>
							<td class="td-content"><input id="serviceCharge" name="serviceCharge"readOnly="true" /></td>
						</tr>
						
						<tr>
							<td class="td-label"><label>绑定手机号 : &nbsp;</label></td>
							<td class="td-content"><input id="applicantPhone" name="applicantPhone"readOnly="true" /></td>
							<td class="td-label"><label>创建时间 : &nbsp;</label></td>
							<td class="td-content"><input id="created" name="created"readOnly="true" /></td>
							<td class="td-label"><label>状态: &nbsp;</label></td>
							<td class="td-content"><input id="status" name="status"readOnly="true" /></td>
						</tr>
						<tr>
							<td class="td-label"><label>短信验证码: &nbsp;</label></td>
							<td class="td-content"><input id="code" name="code"/></td>
							<td>
								<a href="###" class="easyui-linkbutton" id="sendMessage" onclick="sendMessage()">发送短信验证码&nbsp;&nbsp;&nbsp;</a>
							</td>
						</tr>
						<tr>
							<td class="td-label">
								<a href="###" class="easyui-linkbutton"  onclick="confirmSubmit()">确认提交</a>
							</td>
							<td>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="###" class="easyui-linkbutton"  onclick="goBack()">返&nbsp;&nbsp;回</a>
							</td>
						</tr>
				</table>
			</div>
		</form>
		<div id="fundsDetails-tabs" class="easyui-tabs" style="width: 100%;height:400px;" data-options="border:false">
				<div title="单据明细">
				 <!--  <div style="float:center; margin-top: 7px;margin-right: 30px;margin-left: 110px; margin-bottom: 10px;">
					<a href="###" class="easyui-linkbutton" iconCls="icon-reload" onclick="applyForCash()">刷&nbsp;新&nbsp;&nbsp;&nbsp;&nbsp; </a> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="###" class="easyui-linkbutton"  onclick="applyForCash()">查看订单信息</a> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="###" class="easyui-linkbutton"  onclick="applyForCash()">导&nbsp;出&nbsp;&nbsp;&nbsp;&nbsp; </a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
					<a href="###" class="easyui-linkbutton"  onclick="applyForCash()">确认提交&nbsp;</a> 
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="###" class="easyui-linkbutton"  onclick="applyForCash()">返&nbsp;回&nbsp;&nbsp;&nbsp;&nbsp; </a> 
				</div>  -->
				<div>
					<table id="fundsDetails-table"style="width: 100%;height:400px;border:1px ">
						<thead>
							<tr>
								<th field="receiptCode" width="100px">订单编号</th>
								<th field="prodName" width="100px">产品名称</th>
								<th field="number" width="80px" >数量</th>
								<th field="arrivedAmount" width="80px" >金额</th>
								<th field="totalMoney" width="80px" >总金额</th>
							</tr>
						</thead>
					</table> 
				</div>
			</div>
		</div>
	</div>
</div>
	<!-- 弹窗 -->
	<div id="addAccountWin" class="easyui-window" style="width:50%;height:80%" data-options="closed:true">
	    <iframe src=""  id="addAccountWinFram" name="addAccountWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>

	
	<script type="text/javascript">
	
		window.onload =billInit;
		$addAccountWinFram = $("#addAccountWinFram");
		$addAccountWin = $("#addAccountWin");
		var entpId="${param.entpId}";
		var serChargeProp="${param.serChargeProp}";
		var $datagrid = $("#fundsDetails-table");
		var interval;
		var billId='';
		var amount=0;
		var serviceCharge=0;
		$merchantAccountPickList   = $('#merchantAccount');//提现账户picklist
		$statusCombobox = $("#status");//状态
		
		
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			selectFirstRow:false,
			buttonExport : true,
			buttonDelete:false,
			striped : true,
			border : false,
			pagination : true,
			pageSize : 10,//每页显示的记录条数，默认为20 
			pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表
			url :'',
			onBeforeLoad:function(param){
				//var entpId=$("#entpId").text();
				if(!entpId){
		    		param.enterpId = "noMatchId";
		    	}else{
		    		param.enterpId=entpId;
		    	}
			},
			onAddMoreButton: function(that, addButtonFun){
				//addButtonFun(90,'<a href="javascript:void(0)" id="refresh" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="refresh()">刷新</a>',that);
				//addButtonFun(90,'<a href="javascript:void(0)" id="selectOrderBtn" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="selectOrderWindow()">查看订单信息</a>',that);
				//addButtonFun(90,'<a href="javascript:void(0)" id="btn_reply" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="confirmSubmit()">确认提交</a>',that);
				//addButtonFun(90,'<a href="javascript:void(0)" id="btn_redo" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="goBack()">返回</a>',that);
			},
		});	
		
		$merchantAccountPickList.picklist({
			title:'选择提现账户',
			required:true,
			oauthFlag:false,
			completeFun:function(selectRow){
				 $("#merchantAccount").val(selectRow.id);
				return selectRow.merchantAccount;
			},
			tableUrl:'${AppContext.ctxPath}/portal/picklist/merchantAccountPickList.jsp'
		});
		
		 $statusCombobox.combobox({ 
			method:'get',
			data:getLovArray('BILL_STATUS'),
			valueField:'val',
			textField:'name',
		    editable:false, //不可编辑状态
		    panelHeight: 'auto',//自动高度适合
		    cache: false
		}); 
		//刷新
		function refresh(){
			 location.reload(); 
			// interval();
		}
		
		//返回
		function goBack(){
			window.location.href = "/portal/accountmanagement/AccountManagement.jsp";
		}
		
		//查看订单信息弹窗
		function selectOrderWindow(){
			var dutyRecord = $datagrid.hdatagrid('getSelected');
			$('#selectOrderBtn').multiSelect({
				title:'添加菜单项',
				initParam:function(){
					return {id:dutyRecord.id};
				},
				tableUrl:'${AppContext.ctxPath}/portal/accountmanagement/OrderInfoSelect.jsp',
				completeFun:function(selectedRow){
					var dutyRow = $datagrid.hdatagrid('getSelected');
					var records = [];
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						records.push({
							rearObjId:selectedRow[i].id,
							preObjId:dutyRow.id
						});
					}
					$.ajax({	
							type: "POST",
				            url: "${AppContext.ctxPath}/action/portal/duty/addMenuOfDuty",
				            data: JSON.stringify(records),
				            dataType: "json",	
				            contentType: 'application/json', 
				            success:function(data){
								if(data.success){
									$datamenuitemgrid.hdatagrid("reload");
								}else{
									$.messager.alert("警告",data.result);
								}
							}
					});
				}
			});
		}
		
		 //初始化对账单
		function billInit(){
			$.post("${AppContext.ctxPath}/action/portal/applyingcash/billInit",{enterpId:entpId},
			function(data){
				if(data.success){
					var bill = data.result;
					if(bill !=null){
						$("#id").text(bill.id);
						$("#created").val(bill.created);
						$("#status").combobox('setValue',bill.status);
						$("#enterpriseName").text(bill.entpName);
						$("#applicantPhone").val(bill.phone);
						$("#merchantAccount").picklist('setValue',bill.merchantAccount);
						$("#arrivedAmount").val(bill.arrivedAmount);
						$("#serviceCharge").val(bill.serviceCharge);
						billId=bill.id;
						amount=bill.arrivedAmount;
						serviceCharge=bill.serviceCharge;
						//$datagrid.datagrid('reload','${AppContext.ctxPath}/action/portal/account/queryCanCashOrderPage?'+"billId="+billId+"&" +"amount="+amount+"&" +"serviceCharge="+serviceCharge);
						$datagrid.datagrid('reload','${AppContext.ctxPath}/action/portal/availablecash/queryByBillId?'+"billId="+billId);
					}
				}
			});
		} 
		 
		/* //初始化对账单
		function billInit(){
			$.post("${AppContext.ctxPath}/action/portal/applyingcash/queryNewOrRejectBill",{},
			function(data){
				if(data.success){
					var bill = data.result;
					if(bill !=null){
						$("#id").text(bill.id);
						$("#created").val(bill.created);
						$("#status").combobox('setValue',bill.status);
						$("#enterpriseName").text(bill.entpName);
						$("#applicantPhone").val(bill.phone);
						$("#merchantAccount").picklist('setValue',bill.merchantAccount);
						$("#arrivedAmount").val(bill.arrivedAmount);
						$("#serviceCharge").val(bill.serviceCharge);
						billId=bill.id;
						amount=bill.arrivedAmount;
						serviceCharge=bill.serviceCharge;
						$datagrid.datagrid('reload','${AppContext.ctxPath}/action/portal/account/queryCanCashOrderPage?'+"billId="+billId+"&" +"amount="+amount+"&" +"serviceCharge="+serviceCharge);
					}else{
						$.post("${AppContext.ctxPath}/action/portal/account/billInit",{id:entpId},
						function(data){
							if(data.success){
								var bill = data.result;
								$("#id").text(bill.id);
								$("#created").val(bill.created);
								$("#status").val(bill.status);
								$("#enterpriseName").text(bill.enterpriseName);
								$("#applicantPhone").val(bill.applicantPhone);
								$("#merchantAccount").picklist('setValue',bill.merchantAccount);
								$("#arrivedAmount").val(bill.totalMoney);
								$("#serviceCharge").val(bill.applyServCharge);
								addBill();//新建对账单
								billId=bill.id;
								amount=bill.totalMoney;
								serviceCharge=bill.applyServCharge;
								$datagrid.datagrid('reload','${AppContext.ctxPath}/action/portal/account/queryCanCashOrderPage?'+"billId="+billId+"&" +"amount="+amount+"&" +"serviceCharge="+serviceCharge);
							}else{
								window.parent.operationtip("初始化错误！", 'info');
								}
							});
						}
					}
			});
		} */
		
		
		//新建账户
		function addAccount(){
			windowShow(entpId);
		}
		
		
		//发送短信
		function sendMessage(){
			$('#sendMessage').linkbutton('disable');
			$('#refresh').linkbutton('disable');
			var phone =$("#applicantPhone").val();
			$.post('${AppContext.ctxPath}/action/portal/sms/getCode',{
				contactPhone:phone
			},function(data){
				if(data.success){
					//$('#sendMessage').attr("disabled","disabled");
					$('#sendMessage').linkbutton('disable');
					var num =60;
					interval = setInterval(function() {
					$('#sendMessage').text(num + 's 后再次发送');
					console.log("num"+num)
					num--;
					if (num < 0) {
						//$('#phonenumber').attr("disabled", false);
						//$('#sendMessage').removeAttr("disabled");
						$('#sendMessage').linkbutton('enable');
						$('#refresh').linkbutton('enable');
						$('#sendMessage').text('发送短信验证码');
						clearInterval(interval);
						}
					}, 1000);
				}else{
					window.parent.operationtip("验证码发送失败！", 'info');
					}
				});
		}
		
		function addBill(){
			$.post('${AppContext.ctxPath}/action/portal/applyingcash/insert', {
				id : $('#id').text(),
				enterpId : entpId,
				bank :'',
				fundingDirection :'-',
				receiptCode : $('#id').text(),
				receiptType : '提现对账单',
				serviceCharge : $("#serviceCharge").val(),
				servChargeProportion:serChargeProp,
				arrivedAmount : $("#arrivedAmount").val(),
				merchantAccount :$("#merchantAccount").val(),
				log :'',
				status :'New',
				withdrawalsNum :'',
				remarks :'',
				entpName :$("#enterpriseName").text(),
				phone :$("#applicantPhone").val(),
				approvalOpinion :'',
			}, function(data) {
				if (!data.success) {
					window.parent.operationtip("申请提交失败！", 'info');
				}else{
					//window.parent.operationtip("提现申请提交成功，请等待审核！", 'info');
				}
			});
		}
		//确认提交
		function confirmSubmit(){
			var code =$("#code").val();
			var phone =$("#applicantPhone").val();
			 $.post('${AppContext.ctxPath}/action/portal/sms/verifyCode',
					{
						VerifyCode : code,
						contactPhone:phone
					},
					function(data) {
						if (data.success) { 
							if($("#arrivedAmount").val()>0){
								$.post('${AppContext.ctxPath}/action/portal/applyingcash/submitBill', {
									id : $('#id').text(),
									status:	'pending_review',
									merchantAccount : $("#merchantAccount").val()
								}, function(data) {
									if (!data.success) {
										window.parent.operationtip("申请提交失败！", 'info');
									}else{
										goBack();
										window.parent.operationtip("您的提现申请已提交，请等待审核！", 'info');
									}
								});
							}else{
								$.messager.alert('提示', '当前没有可提现的金额！');
							}
						 }else{
							window.parent.operationtip("验证码错误！", 'info');
							} 
					});
		}
		//打开弹窗
		function windowShow(entpId){
			$addAccountWin.panel({title: "新增银行账户"});
			$addAccountWin.window('open');
			if(!entpId){
				$.messager.show("错误", "参数错误，无法获取企业id", "error");
				return;
			}
			$addAccountWinFram.attr("src","");
			if( !$addAccountWinFram.attr("src") ){
				$addAccountWinFram.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/AddAccount.jsp?"+"entpId=" + entpId);
				/* $addAccountWinFram[0].onload = function() {
				$addAccountWinFram[0].contentWindow.entpInfoInit(entpId, "reload");//等待窗口加载完毕
				} */
			}else{
				$addAccountWinFram.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/AddAccount.jsp?"+"entpId=" + entpId);
				//$addAccountWinFram[0].contentWindow.entpInfoInit(entpId, "reload");
			}
			//$accntDetailWin.window("open");
			$addAccountWin.css("display", "block");
		}
		
		//关闭窗口
		 function addAccountWinClose(){
			$addAccountWin.window('close', true);
		} 
			
	</script>
</body>
</html>