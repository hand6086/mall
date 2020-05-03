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
						<td><label id="applicantPhone" hidden="true"></label></td>
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
			<div style="float: left; margin-top: 7px;margin-right: 30px;margin-left: 90px; margin-bottom: 10px;">
				<a href="###" class="easyui-linkbutton" id="applyForCash" onclick="applyForCash()">申&nbsp;请&nbsp;提&nbsp;现</a>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<a href="###" class="easyui-linkbutton" id="refresh" onclick="refresh()">刷&nbsp;&nbsp;新</a> 
			</div>
		</div>
		<div id="fundsDetails-tabs" class="easyui-tabs" style="width: 100%;height:300px;" data-options="border:false">
			<div title="可提现订单" href="${AppContext.ctxPath}/portal/accountmanagement/AvailableCashDetailsList.jsp">
			</div>
			<div title="待入账订单" href="${AppContext.ctxPath}/portal/accountmanagement/UnIntoAccountDetailsList.jsp">
			</div>
			<div title="申请中对账单" href="${AppContext.ctxPath}/portal/accountmanagement/ApplyingCashDetailsList.jsp">
			</div>
			<div title="已提现对账单" href="${AppContext.ctxPath}/portal/accountmanagement/MentionedCashDetailsList.jsp">
			</div>
			<div title="保证金明细" href="${AppContext.ctxPath}/portal/accountmanagement/DepositDetailsList.jsp">
			</div>
			
		</div>
		</form>
		</div>
	</div>
	
	<script type="text/javascript">
		window.onload = initAccount;
		$form = $("#accountForm");
		/*  $('#fundsDetails-tabs').tabs({//tab页加上点击事件
			border:false,
		    onSelect:function(title,index){
		      //  alert(title+index+' is selected');
		      if(index == 3){
		          $('#fundsDetails-tabs').tabs('close','申请中对账单');
		          //$('#fundsDetails-tabs').tabs('select',2);
		      } 
		      //当前tab
		      var current_tab = $('#fundsDetails-tabs').tabs('getSelected',2);
		      var url = $(current_tab.panel('options')).attr('href');
		      alert(url);
		        $('#fundsDetails-tabs').tabs('update',{
		        tab:current_tab,
		        options : {
		        content : '<iframe scrolling="auto" frameborder="0" src="'+URL+'" style="width:100%;height:100%;"></iframe>',
		        //或者 href : '';
		        }
		        }); 
		    }
		});  */
		//提现对账单详情
	 	var $datagrid = $("#withdrawalsDetails-table");
		var corpid = '';
		
		
	// 查询页面数据account
	 function initAccount(){
		$.post("${AppContext.ctxPath}/action/portal/account/queryByExample",{},
				function(data){
						if(data.success){
							var account = data.result[0];
							var sumMoney =data.result2;
							$("#entpId").text(account.id);
							$("#corpid").text(account.corpid);
							$("#applicantPhone").text(account.applicantPhone);
							$("#enterpriseName").text(account.enterpriseName);
							$("#deposit").val(sumMoney.deposit);
							$("#servChargeProportion").val(account.servChargeProportion);
							$("#noArrivalMoney").val(sumMoney.noArrivalMoney);
							$("#withdrawalsMoney").val(sumMoney.withdrawalsMoney>=0?sumMoney.withdrawalsMoney:-sumMoney.withdrawalsMoney);
							$("#applyMoney").val(sumMoney.applyMoney>=0?sumMoney.applyMoney:-sumMoney.applyMoney);
							$("#applyServCharge").val(sumMoney.applyServCharge>=0?sumMoney.applyServCharge:-sumMoney.applyServCharge);
							$("#beenWithdrawalsMoney").val(sumMoney.beenWithdrawalsMoney>=0?sumMoney.beenWithdrawalsMoney:-sumMoney.beenWithdrawalsMoney);
							$("#totalServiceMoney").val(sumMoney.totalServiceMoney>=0?sumMoney.totalServiceMoney:-sumMoney.totalServiceMoney);
							corpid = account.corpid;
							$datagrid.datagrid('reload');
							/* if(sumMoney.withdrawalsMoney==0){
								$('#applyForCash').linkbutton('disable');
							}else{
								$('#applyForCash').linkbutton('enable');
							} */
						}else{
							window.parent.operationtip("初始化错误！", 'info');
							}
						}); 
	 
	 } 
 	//申请提现
 	function applyForCash(){
		var entpId=$("#entpId").text();
		var corpid=appCtx.corpId;
		var serChargeProp=$("#servChargeProportion").val();
		$.post("${AppContext.ctxPath}/action/portal/applyingcash/queryPendingReviewBill",{usercorpid:corpid},
				function(data){
					if(data){
						if(data.success){
							var rows= data.result.length;
							if(rows>0){
								window.parent.operationtip("您有一笔在申请中的对账单，不能再次申请！", 'info');
								$('#applyForCash').linkbutton('disable');
							}else{
								window.location.href = "/portal/accountmanagement/BillInfoDetails.jsp?" + "entpId="+entpId +"&" +"serChargeProp="+serChargeProp;
							}
							
						}else{
							window.parent.operationtip("申请提现失败！", 'info');
						}
					}
		}); 
 	}
 	
 	//刷新
	function refresh(){
		 location.reload(); 
	}
	</script>
</body>
</html>