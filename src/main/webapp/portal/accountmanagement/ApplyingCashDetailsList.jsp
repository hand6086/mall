<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

</head>
<body>
<table id="applyMoneyDetails-table" fit="true" rownumbers="true" pagination="true">
			<thead>
			<tr>
			<th field="receiptCode" width="100px" formatter="detailFormatter" >单据编号</th>
			<th field="receiptType" width="100px" value="提现对账单">单据类型</th>
			<th field="fundingDirection" width="80px" editor="{type:'validatebox',options:{required:true}}" formatter="fundingFormatter">资金往来方向</th>
			<th field="arrivedAmount" width="80px" editor="{type:'checkbox',options:{on:'Y', off:'N'}}" align="center">到账金额</th>
			<th field="serviceCharge" width="80px" align="center">手续费</th>
			<th field="created" width="200px" mark="DATE">创建时间</th>
			<th field="createdBy" width="100px" editor="{type:'textarea'}" >创建人</th>
			<th field="merchantAccount" width="120px" editor="{type:'textarea'}" >商户账户</th>
			<th field="bank" width="120px" editor="{type:'textarea'}" >开户行</th>
			<th field="status" width="80px" lov="BILL_STATUS" editor="{type:'combobox',options:{valueField:'val',
																					textField:'name',
																					data : getLovArray('BILL_STATUS'),
																					editable:true,
																					required:true}}">状态</th>
			<th field="remarks" width="100px" editor="{type:'textarea'}" >备注</th>
			<th field="id" width="100px" editor="{type:'textarea'}" >提现对账单号</th>
			<th field="approvalOpinion" width="200px" formatter="titleFormatter">审批意见</th>
			</tr>
			</thead>
			</table>
			<!-- 弹出窗 class="easyui-window" 时会在页面加载时加载一个新的弹窗，一般改成class="crmWin"-->
    		<div id="editWin" class="crmWin" style="width:100%;height:100%">
	    		<iframe src=""  id="editWinFram" name=editWinFram width="100%" height="95%" frameborder="0" scrolling="no" >
	    		</iframe>
    		</div>

<script type="text/javascript">

	$editWinFram = $("#editWinFram");
	$editWin = $("#editWin");
	var $datagrid = $("#applyMoneyDetails-table");
	
	$datagrid.hdatagrid({
		updateable:false,
		toolbarShow:true,
		buttonSearch:true,
		selectFirstRow:false,
		//buttonNew:true,
		//buttonDelete:true,
		striped : true,
		border : false,
		pagination : true,
		buttonExport:true,
		pageSize : 10,//每页显示的记录条数，默认为20 
		pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表
		url :'${AppContext.ctxPath}/action/portal/applyingcash/queryApplyingCashPage',
		onBeforeLoad:function(param){
			if(!corpid){
	    		param.usercorpid = "noMatchId";
	    	}else{
	    		param.usercorpid=corpid;
	    	}
		},
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(99,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="cancel()">撤回</a>',that);
		},
	});	
	//审批意见title
	function titleFormatter(val,row){
	     if(val != null){
	        var content = '';
	        var content = val.replace(/\\n/g,'\n');
	        var val = val.replace(/\\n/g,'; ');
	     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
	     }
	}
	function detailFormatter(val, row) {
		if (val != null) {
			var content = "";
		    return "<a class='easyui-tooltip' title='"
		    		+content+
		    		"' href='javascript:void(0)' onclick='windowShow(\"" + row.id + "\",\"" + row.corpid + "\")'>" + val + "</a>";
		}
	} 
	
	function windowShow(billId,corpid){
		if(!billId){
			$.messager.show("错误", "参数错误，无法获取企业id", "error");
			return;
		}
		$editWinFram.attr("src","");
		if( !$editWinFram.attr("src") ){
			$editWinFram.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/BillLineDetail.jsp?"+"billId=" + billId +"&"+"corpid="+corpid);
			$editWinFram[0].onload = function() {
				$editWinFram[0].contentWindow.billInit(billId, "reload");//等待窗口加载完毕
			}
		}else{
			$editWinFram[0].contentWindow.billInit(billId, "reload");
		}
		$editWin.css("display", "block");
	}
	//关闭窗口
	function editWinClose(){
		$editWinFram.attr("src","");
		$editWin.css("display", "none");
	}
	//撤销按钮
	function cancel(){
		var row = $datagrid.hdatagrid('getCurrentRow');
		if(row.status=='pending_review'){
			row.status = 'New';
			$.post('${AppContext.ctxPath}/action/portal/applyingcash/billStatusUpdate', row, function(data) {
				   if (!data.success) {
					   window.parent.operationtip(data.result,'error');
					}else{
						$datagrid.hdatagrid('reload');
						window.parent.operationtip('已撤回！', 'info');
						successFun(that, data);
					}
				});
		}else{
			window.parent.operationtip("对不起，撤回功能只能对待审核状态对账单生效",'info');
		}
	}
	
function fundingFormatter(val,row){
	if(val=='-'){
		return "提现";
	}
}
</script>
</body>
</html>