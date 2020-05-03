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
			<form id="accountForm" method="post" enctype ="multipart/form-data" style="margin-bottom: 0px;"> 
				<div>
					<table class="table-block">
					<tr>
						<td class="td-label"><label>商家名称 : &nbsp;</label></td>
						<td><label id="enterpriseName"></label></td>
						<td><label id="entpId" hidden="true"></label></td>
						<td><label id="corpid" hidden="true"></label></td>
					</tr>
					<tr>
						<td class="td-label"><label>商家保证金 : &nbsp;</label></td>
						<td class="td-content"><input id="deposit"name="deposit"readOnly="true" /></td>
						<td class="td-label"><label>手续费比例: &nbsp;</label></td>
						<td class="td-content"><input  id="servChargeProportion" name="servChargeProportion"readOnly="true" /></td>
					</tr>
					<tr>
						<td class="td-label"><label>未入账金额 : &nbsp;</label></td>
						<td class="td-content"><input id="noArrivalMoney" name="noArrivalMoney"readOnly="true" /></td>
						<td class="td-label"><label>可提现金额 : &nbsp;</label></td>
						<td class="td-content"><input id="withdrawalsMoney" name="withdrawalsMoney"readOnly="true" /></td>
					</tr>
					
					<tr>
						<td class="td-label"><label>申请中金额 : &nbsp;</label></td>
						<td class="td-content"><input id="applyMoney" name="applyMoney"readOnly="true" /></td>
						<td class="td-label"><label>申请中手续费 : &nbsp;</label></td>
						<td class="td-content"><input id="applyServCharge" name="applyServCharge"readOnly="true" /></td>
					</tr>
					<tr>
						<td class="td-label"><label>已提现金额 : &nbsp;</label></td>
						<td class="td-content"><input id="beenWithdrawalsMoney" name="beenWithdrawalsMoney"readOnly="true"/></td>
						<td class="td-label"><label>手续费总计 : &nbsp;</label></td>
						<td class="td-content"><input id="totalServiceMoney" name="totalServiceMoney"readOnly="true" /></td>
					</tr>
			</table>
			<div style="float: left; margin-top: 7px;margin-right: 30px;margin-left: 110px; margin-bottom: 10px;">
				<a href="###" class="easyui-linkbutton"  onclick="confirmDeposit()">缴纳保证金</a> 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="###" class="easyui-linkbutton" id="refresh" onclick="refresh()">刷&nbsp;&nbsp;新</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="###" class="easyui-linkbutton" id="goBack" onclick="goBack()">返&nbsp;&nbsp;回</a>
			</div>
		</div>
		<div id="fundsDetails-tabs" class="easyui-tabs" style="width: 100%;height:400px;" data-options="border:false">
			<div title="可提现订单" id="canCashOrder" href="${AppContext.ctxPath}/portal/accountmanagement/AvailableCashDetailsList.jsp">
			</div>
			<div title="待入账订单" id="waitEnterAccountOrder" href="${AppContext.ctxPath}/portal/accountmanagement/UnIntoAccountDetailsList.jsp">
			</div>
			<div title="申请中对账单" id="cashingOrder" href="${AppContext.ctxPath}/portal/accountmanagement/ApplyingCashDetailsList.jsp">
			</div>
			<div title="已提现对账单" id="cashedOrder" href="${AppContext.ctxPath}/portal/accountmanagement/MentionedCashDetailsList.jsp">
			</div>
			<div title="保证金明细" id="depositOrder" href="${AppContext.ctxPath}/portal/accountmanagement/DepositDetailsList.jsp">
			</div>
		</div>
		</form>
		</div>
	</div>
	<!-- easyui-window -->
	<div id="depositWin"class=" crmWin" style="width:100%;height:100%" data-options="closed:true">
	    <iframe src=""  id="depositWinFram" name="depositWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>
    
	
	<script type="text/javascript">
		$depositWinFram = $("#depositWinFram");
		$depositWin = $("#depositWin");
		$form = $("#accountForm");
		var entpId ="${param.entpId}";
		var corpid ="${param.corpid}";
		$('#fundsDetails-tabs').tabs();
		var $datagrid = $("#withdrawalsDetails-table");
		$datag = $('#account-table');
	// 根据id查企业数据
	 function accountInfoInit(entpId){
		$.post("${AppContext.ctxPath}/action/portal/account/queryById",{id:entpId},
				function(data){
						if(data.success){
							var account = data.result;
							$("#entpId").text(account.id);
							$("#corpid").text(account.corpid);
							$("#enterpriseName").text(account.enterpriseName);
							$("#deposit").val(account.deposit);
							$("#servChargeProportion").val(account.servChargeProportion);
							$("#noArrivalMoney").val(account.noArrivalMoney);
							$("#withdrawalsMoney").val(account.withdrawalsMoney>=0?account.withdrawalsMoney:-account.withdrawalsMoney);
							$("#applyMoney").val(account.applyMoney>=0?account.applyMoney:-account.applyMoney);
							$("#applyServCharge").val(account.applyServCharge>=0?account.applyServCharge:-account.applyServCharge);
							$("#beenWithdrawalsMoney").val(account.beenWithdrawalsMoney>=0?account.beenWithdrawalsMoney:-account.beenWithdrawalsMoney);
							$("#totalServiceMoney").val(account.totalServiceMoney>=0?account.totalServiceMoney:-account.totalServiceMoney);
							
							//$datagrid.datagrid('reload','${AppContext.ctxPath}/action/portal/availablecash/queryByExamplePage?'+"usercorpid="+ corpid);
							$datagrid.datagrid('reload');
						}else{
							window.parent.operationtip("初始化错误！", 'info');
							}
						});
	 } 
	//提现对账单详情
 	/* 
	//申请提现
	function applyForCash(){
		window.location.href = "/portal/accountmanagement/BillInfoManagerDetails.jsp";
	}
	 */
	//刷新
	function refresh(){
		//刷新时只刷新数据不重新加载页面
		$.post("${AppContext.ctxPath}/action/portal/account/queryById",{id:entpId},
				function(data){
						if(data.success){
							var account = data.result;
							$("#deposit").val(account.deposit);
							$("#servChargeProportion").val(account.servChargeProportion);
							$("#noArrivalMoney").val(account.noArrivalMoney);
							$("#withdrawalsMoney").val(account.withdrawalsMoney>=0?account.withdrawalsMoney:-account.withdrawalsMoney);
							$("#applyMoney").val(account.applyMoney>=0?account.applyMoney:-account.applyMoney);
							$("#applyServCharge").val(account.applyServCharge>=0?account.applyServCharge:-account.applyServCharge);
							$("#beenWithdrawalsMoney").val(account.beenWithdrawalsMoney>=0?account.beenWithdrawalsMoney:-account.beenWithdrawalsMoney);
							$("#totalServiceMoney").val(account.totalServiceMoney>=0?account.totalServiceMoney:-account.totalServiceMoney);
							$datagrid.datagrid('reload');
						}else{
							window.parent.operationtip("初始化错误！", 'info');
							}
						});
		
		/*  $.post("${AppContext.ctxPath}/action/portal/account/querySumMoney",{corpid:corpid},
					function(data){
							if(data.success){
								var sumMoney = data.result;
								$("#deposit").val(sumMoney.deposit);
								//$("#servChargeProportion").val(sumMoney.servChargeProportion);
								$("#noArrivalMoney").val(sumMoney.noArrivalMoney);
								$("#withdrawalsMoney").val(sumMoney.withdrawalsMoney);
								$("#applyMoney").val(sumMoney.applyMoney);
								$("#applyServCharge").val(sumMoney.applyServCharge);
								$("#beenWithdrawalsMoney").val(sumMoney.beenWithdrawalsMoney);
								$("#totalServiceMoney").val(sumMoney.totalServiceMoney);
								$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip("初始化错误！", 'info');
								}
							}); */
		 
	}
	 
	//返回
	function goBack(){
		window.parent.editWinClose();
		//window.location.href ="/portal/accountmanagement/AccountManagerList.jsp";
	}
	 
	//关闭窗口
	 function depositWinClose(){
		$depositWin.window('close', true);
	} 
	function confirmDeposit(){
		windowShow(entpId);
	}
	
	function windowShow(entpId){
		$depositWin.panel({title: "缴纳押金"});
		$depositWin.window('open');
		if(!entpId){
			$.messager.show("错误", "参数错误，无法获取企业id", "error");
			return;
		}
		$depositWinFram.attr("src","");
		if( !$depositWinFram.attr("src") ){
			$depositWinFram.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/ConfirmDeposit.jsp?"+"entpId=" + entpId);
			$depositWinFram[0].onload = function() {
				$depositWinFram[0].contentWindow.entpInfoInit(entpId, "reload");//等待窗口加载完毕
			}
		}else{
			$depositWinFram[0].contentWindow.entpInfoInit(entpId, "reload");
		}
		//$accntDetailWin.window("open");
		$depositWin.css("display", "block");
	}
	</script>
</body>
</html>