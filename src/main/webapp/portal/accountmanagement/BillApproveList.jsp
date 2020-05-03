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
	 <fieldset class="x-fieldset" id="keyFilter">
				<legend class="x-fieldset-header"
					style="width: 95px; margin-bottom: 0px; border: none;">
					<span class="x-fieldset-title">快速筛选</span>
				</legend>

				<div class="row keyfilter-border">
					<ul id="statusKeyfilter" data-toggle="keyfilter" data-title="状态"
						data-filter-filed="status" data-table-Id="account-table">
				</ul>
				</div> 
		</fieldset>
	<table id="account-table" keyFilterDiv="keyFilter"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="receiptCode" width="100px" formatter="detailFormatter">单据编号</th>
				<th field="receiptType" width="100px"  editor="{type:'textbox', options:{required:true}}">单据类型</th>
				<th field="entpName" width="150px" editor="{type:'textbox', options:{required:true}}">商户名称</th>
                <th field="fundingDirection" width="80px" >资金往来方向</th>
				<th field="arrivedAmount" width="80px" editor="{type:'numberbox'}">到账金额</th>
				<th field="serviceCharge" width="80px" editor="{type:'numberbox'}">手续费</th>
				<th field="created" width="200px" mark="DATE">创建时间</th>
				<th field="merchantAccount" width="200px" >商户账户</th>
				<th field="bank" width="200px" >开户行</th>
				<th field="status" width="80px" lov="BILL_STATUS" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('BILL_STATUS'),
																		editable:true,
																		required:true}}">状态</th>
				<th field="approvalOpinion" width="200px" formatter="titleFormatter">审批意见</th>
				<th field="remarks" width="150px" >备注</th>
				
			</tr>
		</thead>
	</table>
	</div>
</div>
<!-- 弹出窗 class="easyui-window" 时会在页面加载时加载一个新的弹窗，一般改成class="crmWin"-->
    <div id="editWin" class="crmWin" style="width:100%;height:100%">
	    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="95%" frameborder="0" scrolling="no" >
	    </iframe>
    </div>
   
	<script type="text/javascript">		
		$datagrid = $('#account-table');
		$editWinFram = $("#editWinFram");
		$editWin = $("#editWin");
		
		//var  apply =false;
		
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
			url:'${AppContext.ctxPath}/action/portal/applyingcash/queryByExamplePage',
			/* onBeforeLoad:function(param){
		    	param.usercorpid='admin';
			}, */
			onSelect:function(row){
				var status =$datagrid.hdatagrid('getCurrentRow').status;
				if('pending_review'!=status){
					$('#isPassed').linkbutton('disable');
					//apply=true;
				}else{
					$('#isPassed').linkbutton('enable');
				}
				if('approved'!=status){
					$('#transOfAccount').linkbutton('disable');
					//apply=true;
				}else{
					$('#transOfAccount').linkbutton('enable');
				}
			},
			onAddMoreButton: function(that, addButtonFun){
				addButtonFun(90,'<a href="javascript:void(0)" id="isPassed" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="isPassed()">审批通过</a>',that);
				addButtonFun(90,'<a href="javascript:void(0)" id="transOfAccount" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="transOfAccount()">转账</a>',that);
			},
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
		//快速筛选状态
		 $('#statusKeyfilter').keyFilter({		   
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/BILL_STATUS'
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
				$editWinFram.attr("src", "${AppContext.ctxPath}/portal/accountmanagement/BillInfoManagerDetails.jsp?"+"billId=" + billId +"&"+"corpid="+corpid);
				$editWinFram[0].onload = function() {
					$editWinFram[0].contentWindow.billInfoInit(billId, "reload");//等待窗口加载完毕
				}
			}else{
				$editWinFram[0].contentWindow.billInfoInit(billId, "reload");
			}
			//$accntDetailWin.window("open");
			$editWin.css("display", "block");
		}
			
		//审批通过
		function isPassed(){
			var row =$datagrid.hdatagrid('getSelected');
			var id =$datagrid.hdatagrid('getCurrentRow').id;
			/* var status =$datagrid.hdatagrid('getCurrentRow').status;
			
			if(status !="pending_review"){
				$('#isPassed').linkbutton('disable');
			}*/ 
			 $.post("${AppContext.ctxPath}/action/portal/applyingcash/update",{id:id},
					function(data){
						if(data){
							if(data.success){
								//$datagrid.hdatagrid('reload');
								var index = $datagrid.hdatagrid('getRowIndex', row);
								row.status = data.newRow.status;//给被选中行的某个字段重新赋值(controller中updateSubDetail方法返回数据中的值)，再刷新
								$datagrid.hdatagrid("refreshRow", index);
								$('#isPassed').linkbutton('disable');
								$('#transOfAccount').linkbutton('enable');
								window.parent.operationtip("状态修改成功！", 'info');
							}else{
								window.parent.operationtip("状态修改失败！", 'info');
							}
						}
			}); 
		}
		//转账
		function transOfAccount(){
			var row =$datagrid.hdatagrid('getSelected');
			var id =$datagrid.hdatagrid('getCurrentRow').id;
			
			 $.post("${AppContext.ctxPath}/action/portal/applyingcash/billStatusUpdate",
					 {
				 		id:id,
				 		status:'in_transfer'
					 },
					function(data){
						if(data){
							if(data.success){
								//$datagrid.hdatagrid('reload');
								var index = $datagrid.hdatagrid('getRowIndex', row);
								row.status = data.newRow.status;//给被选中行的某个字段重新赋值(controller中updateSubDetail方法返回数据中的值)，再刷新
								$datagrid.hdatagrid("refreshRow", index);
								$('#transOfAccount').linkbutton('disable');
								window.parent.operationtip("转账中！", 'info');
							}else{
								window.parent.operationtip("操作失败！", 'info');
							}
						}
			}); 
		}
		//关闭窗口
		function editWinClose(){
			$editWin.css("display", "none");
			$datagrid.datagrid('reload');//窗口关闭的时候重新加载页面刷新数据
		}
		
	</script>
</body>
</html>