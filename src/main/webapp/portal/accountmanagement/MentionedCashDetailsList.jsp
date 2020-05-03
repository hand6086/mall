<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<table id="mentionedCash-table" fit="true" rownumbers="true" pagination="true">
			<thead>
			<tr>
			<th field="receiptCode" width="100px" formatter="detailApplyFormatter">单据编号</th>
			<th field="receiptType" width="100px">单据类型</th>
			<th field="fundingDirection" width="80px" editor="{type:'validatebox',options:{required:true}}">资金往来方向</th>
			<th field="arrivedAmount" width="80px" editor="{type:'checkbox',options:{on:'Y', off:'N'}}" align="center">到账金额</th>
			<th field="serviceCharge" width="80px" align="center">手续费</th>
			<th field="created" width="200px" editor="{type:'textarea'}">创建时间</th>
			<th field="createdBy" width="100px" editor="{type:'textarea'}" >创建人</th>
			<th field="merchantAccount" width="120px" editor="{type:'textarea'}" >商户账户</th>
			<th field="bank" width="120px" editor="{type:'textarea'}" >开户行</th>
			<th field="status" width="80px"lov="BILL_STATUS"editor="{type:'textbox',options:{	valueField:'val',
															textField:'name',
															data:getLovArray('BILL_STATUS'),
															editable:false}}">状态</th>
			<th field="remarks" width="100px" editor="{type:'textarea'}" >备注</th>
			<th field="id" width="100px" editor="{type:'textarea'}" >提现对账单号</th>
			</tr>
			</thead>
			</table>
			<!-- 弹出窗 class="easyui-window  crmWin" 时会在页面加载时加载一个新的弹窗，一般改成class="crmWin"-->
    		<div id="editWin2" class="crmWin" style="width:100%;height:100%">
	    		<iframe src=""  id="editWinFram2" name=editWinFram2 width="100%" height="95%" frameborder="0" scrolling="no" >
	    		</iframe>
    		</div>

<script type="text/javascript">

	$editWinFram2 = $("#editWinFram2");
	$editWin2 = $("#editWin2");
	var $datagrid = $("#mentionedCash-table");
	
	$datagrid.hdatagrid({
		updateable:false,
		toolbarShow:true,
		buttonSearch:true,
		selectFirstRow:false,
		//buttonNew:true,
		//buttonDelete:true,
		striped : true,
		border : false,
		buttonExport:true,
		pagination : true,
		pageSize : 10,//每页显示的记录条数，默认为20 
		pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表
		url :'${AppContext.ctxPath}/action/portal/mentionedcash/queryByExamplePage',
		onBeforeLoad:function(param){
			if(!corpid){
	    		param.usercorpid = "noMatchId";
	    	}else{
	    		param.usercorpid=corpid;
	    	}
		}
	});	
	
	
	function detailApplyFormatter(val, row) {
		if (val != null) {
			var content = "";
		    return "<a class='easyui-tooltip' title='"
		    		+content+
		    		"' href='javascript:void(0)' onclick='windowShow2(\"" + row.id + "\",\"" + row.corpid + "\")'>" + val + "</a>";
		}
	} 
	
	function windowShow2(billId,corpid){
		
		if(!billId){
			$.messager.show("错误", "参数错误，无法获取企业id", "error");
			return;
		}
		$editWinFram2.attr("src","");
		
		if( !$editWinFram2.attr("src") ){
			$editWinFram2.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/BillLineDetail2.jsp?"+"billId=" + billId +"&"+"corpid="+corpid);
			$editWinFram2[0].onload = function() {
				$editWinFram2[0].contentWindow.billInit(billId, "reload");//等待窗口加载完毕
			}
		}else{
			$editWinFram2[0].contentWindow.billInit(billId, "reload");
		}
		$editWin2.css("display", "block");
	}
	//关闭窗口
	function editWinClose2(){
		$editWinFram2.attr("src","");
		$editWin2.css("display", "none");
	}
</script>
</body>
</html>