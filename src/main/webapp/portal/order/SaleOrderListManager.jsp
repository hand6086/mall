<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
</style>
<body >
<div class="easyui-layout" data-options="fit:true" border="false">
	 <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">订单筛选条件</span>
		</legend>
		<div class="row keyfilter-border">
			<ul id="orderTypeKeyfilter" data-toggle="keyfilter"
				data-title="订单类型" data-filter-filed="orderTypeLovType"
				data-table-Id="sale-order-table">
			</ul>
		</div>
		<!-- <div class="row keyfilter-border">
			<ul id="statusKeyfilter" data-toggle="keyfilter"
				data-title="订单状态" data-filter-filed="statusLovType"
				data-table-Id="sale-order-table">
			</ul>
		</div> -->
		<div class="row keyfilter-border">
			<ul data-toggle="keyfilter" data-title="订单状态" 
				data-filter-filed="statusLovType"
				data-table-Id="sale-order-table">
				<li data-value="New">新建</li>
				<li data-value="Submitted">已提交</li>
				<li data-value="Approved">已批准</li>
				<li data-value="Rejected">已拒绝</li>
				<li data-value="Closed">已完成</li>
				<li data-value="Cancelled">已取消</li>
			</ul>
		</div>
	</fieldset>
	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
	<table id="sale-order-table" keyFilterDiv="keyFilter" fit="true" >
		<thead>
			<tr>
				<th field="orderNo" width="120px" formatter="orderNumFormatter">订单编号</th>
				<th field="orderType" lov="ORDER_TYPE" width="60px">订单类型</th>
				<th field="acctId" width="90px">客户编码</th>
				<th field="acctName" width="200px">客户名称</th>
				<th field="status" width="60px" lov="ORDER_STATUS">订单状态</th>
				<th field="orgName" width="80px">组织</th>
				<th field="postnName" width="80px">职位</th>
				<th field="orderTotalAmount" width="80px" currency="CNY">订单总金额</th>
				<th field="created" width="130px" mark="DATE">下单日期</th>
				<th field="submitDate" width="130px" mark="DATE">提交日期</th>
				<th field="expectDate" width="130px" mark="DATE">期望发货日期</th>
				<th field="loadingDate" width="130px" mark="DATE">发货日期</th>
				<th field="deliverType" width="80px" lov="DELIVER_TYPE">送货方式</th>
				<th field="rebatePercent" width="80px">返利百分比</th>
				<th field="rebateMoney" width="80px" currency="CNY">返利金额</th>
				<th field="cash" width="80px" currency="CNY">现金金额</th>
				<th field="freight" width="60px" currency="CNY">运费</th>
				<th field="logisticsCompany" width="100px" lov="LOGISTICS_COMPANY">物流公司</th>
				<th field="logisticsNo" width="130px">物流编号</th>
				<th field="fullAddr" width="200px">收货地址</th>
				<th field="customConsignee" width="80px">收货联系人</th>
				<th field="customMobilePhone" width="200px">收货电话</th>
			</tr>
		</thead>
	</table>
	</div>
	
	<div id="dlg" display=false class="easyui-dialog" title="审批操作" closed="true" style="width:300px;height:200px;padding:10px"
            data-options="
                iconCls: 'icon-save',
                toolbar: '#dlg-toolbar',
                buttons: '#dlg-buttons'
            ">
				<table id="editorTable" border="0" height="100%" width="100%" >
				    <tr>
				        <td width="20%"></td>
				        <td width="20%" class="td-label">备注:</td>
				        <td width="30%">
				        	<input id="flowComments" name="flowComments" class="easyui-textbox" data-options="multiline:true" style="height:100px; width:100%"></input>
				        </td>
				        <td width="30%"></td>
				    </tr>	    	  
				</table>
    </div>
       
  	<div id="nextUserDiv" style="display:none">
  		<input id="nextUser">
  	</div>
  	
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="goFlow()">确定</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
    <!-- 物流信息框开始 -->
    <div id="logistic-dlg" class="easyui-dialog" style="width:800px;padding:20px 20px"
		closed="true" buttons="#msg-dlg-buttons" modal="true" cache="false">
		<div class="ftitle" id="logisticMessage"></div>
	</div>
	<!-- 物流信息框结束 -->
    </div>

    <!-- 弹出窗 -->
    <div id="readOnlyWin" class="crmWin" style="width:100%; height:100%;">
    <iframe src=""  id="readOnlyWinFram" name=readOnlyWinFram width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
    
    <!-- 弹出窗2 -->
    <div id="editWin" class="crmWin" style="width:100%; height:100%">
    <iframe src=""  id="editWinFram" name=editWinFram width="100%" height="100%" frameborder="0" scrolling="no">
    </iframe>
    </div>
	<div id="mvgid"></div>
	<script type="text/javascript">
		getLovOfList("[ORDER_STATUS,ORDER_TYPE]");
		var sid="noMatchId";        //订单ID	    
		$readOnlyWin = $("#readOnlyWin");
		$readOnlyWinFram = $("#readOnlyWinFram");
		$editWin = $("#editWin");
		$editWinFram = $("#editWinFram");
		
		$datagrid = $('#sale-order-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			oauthFlag:true,
			url : '${AppContext.ctxPath}/action/portal/saleorder/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addSaleOrder()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_copy" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copySaleOrder()">复制</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="orderSubmit()">提交订单</a>',that);
				addButtonFun(94,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="orderApproved()">审核通过</a>',that);
				addButtonFun(95,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-css-go" plain="true" onclick="confirmSend()">确认发货</a>',that);

				addButtonFun(97,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="orderCancel()">取消订单</a>',that);
				addButtonFun(98,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-css-go" plain="true" onclick="sendComplete()">完成订单</a>',that);
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-css-go" plain="true" onclick="queryLogistics()">查看物流</a>',that);

			},
			onChangeSelectedItem:function(row,that){
				sid = row.id;
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除该订单？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/saleorder/deleteById', {
								id : row.id
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			}
		});
 		/* $readOnlyWin.window({
			title: "订单明细",
			top: 0,
			closed:true,
			border:false,//边框
			shadow:false,
			draggable:false,//拖曳
			minimizable:false,//最小化按钮
			maximizable:false,
			resizable: true,//改变大小
			//noheader:true,
			//modal:true,//模态窗口
		}); */
		function orderNumFormatter(val, row) {
			if (val != null) {
				var content = "订单编号:" + row.orderNo + "\n订单客户:" + row.acctName;
			    return "<a class='easyui-tooltip' title='"
			    		+content+
			    		"' href='javascript:void(0)' onclick='windowShow(\""+row.id+"\")'>" + val + "</a>";
			}
		}
		/**
		* 点击表格行超链接，弹出窗口
		* @id 订单id
		*/
		function windowShow(id){
 			if(id){
				$.post("${AppContext.ctxPath}/action/portal/saleorder/queryById", {id:id}, function(data){
					if(data.success){
						var order = data.result;
						if( data.result.statusLovType != "New"){//如果是只读状态，则展示只读页面
							if( !$readOnlyWinFram.attr("src") ){
								//$readOnlyWin.window("panel").addClass("noheader");
								$readOnlyWinFram.attr("src", "${AppContext.ctxPath}/portal/order/SaleOrderInfoReadOnly2.jsp");
								$readOnlyWinFram[0].onload = function() {
									$readOnlyWinFram[0].contentWindow.orderInfoInit('', data.result);//等待窗口加载完毕
								}
							}else{
								$readOnlyWinFram[0].contentWindow.orderInfoInit('', data.result);
								//document.getElementById("winFram").contentWindow.orderInfoInit('', data.result);
							}
							//$readOnlyWin.window("open");
							$readOnlyWin.css("display", "block");
						}
						else{//可编辑状态
							if(!data.result.row_status){
								data.result.row_status = "UPDATE";
							}
							if( !$editWinFram.attr("src") ){
								$editWinFram.attr("src", "${AppContext.ctxPath}/portal/order/InterSaleOrderInfoNew2.jsp");
								$editWinFram[0].onload = function() {
									$editWinFram[0].contentWindow.initInfo('', data.result);//等待窗口加载完毕
								}
							}else{
								$editWinFram[0].contentWindow.initInfo('', data.result);
							}
							//$editWin.window("open");
							$editWin.css("display", "block");
						}
					}
				});
				
			}else{
				$.messager.alert("错误", "请传入正确参数", "error");
			} 
			/* $("#editWin2").css("display", "block");
			if(!$("#editWinFram2").attr("src"))
				$("#editWinFram2").attr("src", "${AppContext.ctxPath}/portal/order/InterSaleOrderInfoNew2.jsp"); */
		}
		/**
		* 关闭弹出窗口
		*/
		function editWinClose(operate,order){
			//$editWin.window("close");
			$editWin.css("display", "none");
			if(operate == "CANCEL"){
				return;
			}
			if(!order){
				$.messager.alert("警告", "获取新数据失败，请刷新数据", "warning");
				return;
			}
			if(operate == "NEW"){
				//$datagrid.datagrid('rejectChanges');
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.datagrid('getRowIndex', row);
				$datagrid.datagrid('insertRow',{index: index, row: order});	
				$datagrid.datagrid('acceptChanges');
				$datagrid.datagrid("selectRow", index);
			}else if(operate == "UPDATE"){
				//关闭编辑窗口时刷新编辑后数据
				//$datagrid.datagrid('rejectChanges');
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.hdatagrid('getRowIndex', row);
				$datagrid.datagrid('updateRow', {index: index, row:order});
				$datagrid.datagrid('acceptChanges');
			}else{
				$.messager.alert("警告", "无法识别操作，刷新数据失败！", "warning");
			}
		}
		
		function closeReadOnlyWin(){
			$readOnlyWin.css("display", "none");
		}
		/**
		* 新建订单
		*/
		function addSaleOrder() {
			//window.location.href = '${AppContext.ctxPath}/action/portal/saleorder/init';
			$.post("${AppContext.ctxPath}/action/portal/saleorder/initNew", {}, function(data){
				if(data.success){
					if( !$editWinFram.attr("src") ){//弹出窗口
						$editWinFram.attr("src", "${AppContext.ctxPath}/portal/order/InterSaleOrderInfoNew2.jsp");
						$editWinFram[0].onload = function() {
							$editWinFram[0].contentWindow.initInfo('', data.result);//等待窗口加载完毕
						}
					}else{
						$editWinFram[0].contentWindow.initInfo('', data.result);
					}
					//$editWin.window("open");
					$editWin.css("display", "block");
				}else{
					$.messager.alert("错误", data.result, "error");
				}
			});
		}
		//深度复制头和行
		function copySaleOrder(){
			var row = $datagrid.datagrid('getSelected');
			//window.location.href = '${AppContext.ctxPath}/action/portal/saleorder/copy/'+row.id;
			$.post("${AppContext.ctxPath}/action/portal/saleorder/deepCopy", {id: row.id}, function(data){
				if(data.success){
					if( !$editWinFram.attr("src") ){//弹出窗口
						$editWinFram.attr("src", "${AppContext.ctxPath}/portal/order/InterSaleOrderInfoNew2.jsp");
						$editWinFram[0].onload = function() {
							$editWinFram[0].contentWindow.initInfo('', data.result);//等待窗口加载完毕
						}
					}else{
						$editWinFram[0].contentWindow.initInfo('', data.result);
					}
					//$editWin.window("open");
					$editWin.css("display", "block");
				}else{
					$.messager.alert("错误", data.result, "error");
				}
			});
		}
		function orderSubmit(){
			var row = $datagrid.datagrid('getSelected');
			//执行提交订单事件
			$.post('${AppContext.ctxPath}/action/portal/saleorder/commit', {
					id	: row.id
				},function(data){
					if(data.success){
						$datagrid.datagrid('reload');
					}else{
						if(data.mustSelectUser){
							$('#nextUser').picklist("destroy")
							$('#nextUser').picklist({
								title:'选择审批人',
						        required:false,
						        initParam:function(){
						        	return {
						        		nodeId:data.nodeId,
						        		userId:data.userId
						        	};
						        },
						        completeFun:function(selectedRow){
						    		$.post("${AppContext.ctxPath}/action/portal/saleorder/commit",{
						    			id	: row.id,
						    			selectUserId	:selectedRow.id
						    		}, function(data){
						    			if(data.success){
						    				$.messager.alert("提示","审批完成！");
											$datagrid.datagrid('reload');
						    			}else{
											$.messager.alert("提示",data.result);
										}
						    		});
						        },
						        tableUrl:'${AppContext.ctxPath}/portal/approval/pickList/userSelectPickList.jsp'
							});
							$('.searchbox-button','#nextUserDiv').click();
						}else{
							$.messager.alert("提示",data.result);
						}
					}
				}); 
		}		
		
		function orderCancel(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/saleorder/cancel', 
			{
				id	: row.id
		    },
			function(data){
		    	if(data.success){
		    		$datagrid.datagrid('reload');
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
		
		function orderApproved(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/saleorder/approved', 
			{
				id	: row.id
		    },
			function(data){
		    	if(data.success){
		    		if(data.newRow){
		    			//var row = $datagrid.hdatagrid('getSelected');
		    			var index = $datagrid.hdatagrid('getRowIndex', row);
		    			$datagrid.datagrid('updateRow', {index: index, row:data.newRow})
		    		}else{
		    			$datagrid.datagrid("reload");
		    		}
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
		
		function confirmSend(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/saleorder/shipped', 
			{
				id	: row.id
		    },
			function(data){
		    	if(data.success){
		    		if(data.newRow){
		    			var index = $datagrid.hdatagrid('getRowIndex', row);
		    			$datagrid.datagrid('updateRow', {index: index, row:data.newRow})
		    			//$datagrid.datagrid('acceptChanges');
		    		}else{
		    			$datagrid.datagrid("reload");
		    		}
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
		
		function sendComplete(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/saleorder/sendComplete', 
			{
				id	: row.id
		    },
			function(data){
		    	if(data.success){
		    		$datagrid.datagrid('reload');
				}else{
					window.parent.operationtip(data.result, 'error');
				}
			});
		}
		
		function goFlow(){
			
			$('#dlg').dialog('close');
		}
		$('#orderTypeKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/ORDER_TYPE'
		});
		/* $('#statusKeyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/ORDER_STATUS'
		}); */
		
		function queryLogistics(){
			var row = $datagrid.datagrid('getSelected');
			//alert(row.id);
			//return
			$.post('${AppContext.ctxPath}/action/portal/saleorder/logistics',
					{id : row.id},
					function(data){
						if(data.success){
							var obj = eval("("+ data.result +")");
							var logisticData = obj["showapi_res_body"]["data"];
							var html = "";
							for(var i=0; i < logisticData.length; i++){
								html += "<tr><td width='20%'>" + logisticData[i]["time"] + "</td><td width='80%'>" +logisticData[i]["context"] + "</td></tr>";
							}
							
							$("#logistic-dlg").dialog('open').dialog('setTitle','物流信息');
							$("#logisticMessage").html(html);
						}else{
							$("#logistic-dlg").dialog('open').dialog('setTitle','物流信息');
							$("#logisticMessage").html(data.result);
						}
					}
			)
		}
	</script>
</body>
</html>