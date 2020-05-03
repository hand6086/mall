<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">


</style>
<body >
<div class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
	<table id="account-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="enterpriseName" width="150px" formatter="detailFormatter">商家名称</th>
				<th field="deposit" width="80px" sortable="true"  editor="{type:'textbox', options:{required:true}}">店铺保证金</th>
				<th field="noArrivalMoney" width="80px" editor="{type:'textbox', options:{required:true}}">未入账金额</th>
                <th field="withdrawalsMoney" width="80px" >可提现金额</th>
				<th field="applyMoney" width="80px" >申请中金额</th>
				<th field="beenWithdrawalsMoney" width="80px" >已提现金额</th>
				<th field="applyServCharge" width="80px" >申请中手续费</th>
				<th field="totalServiceMoney" width="80px" >手续费总计</th>
				<th field="bank" width="100px" lov="TB_O2O_BANK" editor="{type:'combobox',options:{valueField:'val',
																					textField:'name',
																					data : getLovArray('TB_O2O_BANK'),
																					editable:true,
																					required:true}}">开户行</th>
				<th field="cardNum" width="200px" >银行卡号</th>
				<th field="accntHolder" width="80px" >开户人</th>
			</tr>
		</thead>
	</table>
	</div>
</div>
<!-- 弹出窗 class="easyui-window" 时会在页面加载时加载一个新的弹窗，一般改成class="crmWin"-->
    <div id="editWin" class="crmWin" style="width:100%;height:100%" >
    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="95%" frameborder="0" scrolling="no" >
    </iframe>
    </div>
   
	<script type="text/javascript">		
		$datagrid = $('#account-table');
		$editWinFram = $("#editWinFram");
		$editWin = $("#editWin");
		$datagrid.hdatagrid({
			updateable : false,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonExport:true,
			buttonDelete:false,
			buttonCopy:false,
			buttonMenu:true,
			striped:true,
			title:'',
			border:false,//边框
			url:'${AppContext.ctxPath}/action/portal/account/queryByExamplePage',

/* 			onInsertAction : function(row,successFun,errFun,that) {
				delete row.children;
				$.post('${AppContext.ctxPath}/action/portal/accnt/insert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onUpdateAction : function(row,successFun,errFun,that) {
				delete row.children;
				$.post('${AppContext.ctxPath}/action/portal/accnt/update', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			}, 
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/dealerAccount/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/accnt/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that);
								}
						});
					}
				});
			}*/
		});
		
		function detailFormatter(val, row) {
			if (val != null) {
				var content = "";
			    return "<a class='easyui-tooltip' title='"
			    		+content+
			    		"' href='javascript:void(0)' onclick='windowShow(\"" + row.id + "\",\"" + row.corpid + "\")'>" + val + "</a>";
			}
		} 
		  
		
		function windowShow(entpId,corpid){
			if(!entpId){
				$.messager.show("错误", "参数错误，无法获取企业id", "error");
				return;
			}
			$editWinFram.attr("src","");
			if( !$editWinFram.attr("src") ){
				$editWinFram.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/AccountMangerDetails.jsp?"+"entpId=" + entpId+"&"+"corpid="+corpid);
				$editWinFram[0].onload = function() {
					$editWinFram[0].contentWindow.accountInfoInit(entpId, "reload");//等待窗口加载完毕
				}
			}else{
				$editWinFram[0].contentWindow.accountInfoInit(entpId, "reload");
			}
			$editWin.css("display", "block");
		}
		
		//关闭窗口
		function editWinClose(){
			$editWin.css("display", "none");
			$datagrid.datagrid('reload');//窗口关闭的时候重新加载页面刷新数据
		}
	</script>
</body>
</html>