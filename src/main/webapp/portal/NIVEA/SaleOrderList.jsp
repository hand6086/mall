<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
	 <fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">订单筛选条件</span>
		</legend>
		 
		<div class="row keyfilter-border">
			<ul data-toggle="keyfilter" data-title="订单状态" 
				data-filter-filed="status"
				data-table-Id="sale-order-table">
				<li data-value="新建">新建</li>
				<li data-value="已提交">已提交</li>
				<li data-value="已批准">已批准</li>
				<li data-value="已拒绝">已拒绝</li>
				<li data-value="已完成">已完成</li>
				<li data-value="已取消">已取消</li>
			</ul>
		</div>
	</fieldset>
	<div data-options="region:'center'" border="false" style="width: 100%; padding: 0px;">
	<table id="sale-order-table" keyFilterDiv="keyFilter" fit="true" >
		<thead>
			<tr>
			<th field="acctId" width="100px" editor="{type:'validatebox', options:{required:false}}">消费者编码</th>
<th field="consignee" width="100px" defaultSearch="true" editor="{type:'validatebox', options:{required:false}}">消费者名称</th>
<th field="province" width="100px" editor="{type:'validatebox', options:{required:false}}">省</th>
<th field="city" width="100px" editor="{type:'validatebox', options:{required:false}}">市</th>
<th field="Qty" width="100px" editor="{type:'validatebox', options:{required:false}}">数量</th>
<th field="orderTotalAmount" currency="CNY" width="100px" editor="{type:'validatebox', options:{required:false}}">单价</th>
<th field="orderNo" width="100px" editor="{type:'validatebox', options:{required:false}}">订单编码</th>
<th field="id" width="100px" editor="{type:'validatebox', options:{required:false}}">订单行编码</th>
<th field="orderTotalAmount" currency="CNY" width="100px" editor="{type:'validatebox', options:{required:false}}">金额</th>
<th field="prodCode" width="100px" editor="{type:'validatebox', options:{required:false}}">产品编码</th>
<th field="ProdName" width="100px" editor="{type:'validatebox', options:{required:false}}">产品名称</th>
<th field="Band" width="100px" editor="{type:'validatebox', options:{required:false}}">分类</th>
<th field="SubBand" width="100px" editor="{type:'validatebox', options:{required:false}}">子类</th>
<th field="created" width="100px" editor="{type:'validatebox', options:{required:false}}">订单日期</th>
<th field="submitDate" width="100px" editor="{type:'validatebox', options:{required:false}}">下单时间</th>
		 
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
       
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="goFlow()">确定</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div>
    
	<script type="text/javascript">
		var sid="noMatchId";        //订单ID	    
		$('.fixed-keyfilter-ul').keyFilter();
		$datagrid = $('#sale-order-table');
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			striped : true,
			border : false,
			url : '${AppContext.ctxPath}/action/portal/saleorder/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addSaleOrder()">新建</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_copy" class="easyui-linkbutton" iconCls="icon-copy" plain="true" onclick="copySaleOrder()">复制</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="orderSubmit()">提交订单</a>',that);
				addButtonFun(94,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="orderCancel()">取消订单</a>',that);
				addButtonFun(95,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-css-go" plain="true" onclick="sendComplete()">发货完成</a>',that);
			},
			onChangeSelectedItem:function(row,that){
				sid = row.id;
			},  
		 
			 
			onLoadSuccess:function(data){
				if(data.success){
					var rows = data.rows;
					
					for(var i=0;rows != null && i<rows.length;i++){
						$datagrid.datagrid('updateRow',{index:i,row: {
							province:"上海",
							city:"上海市",
							Qty:i+i,
							prodCode:'A009',
							ProdName:'妮维雅多用蓝罐德国原装进口 长效滋润霜',
							Band:'妮维雅',
							SubBand:'滋润霜',
							}
						});
					}
				}
			}
		});
		
		
		function orderNumFormatter(val, row) {
			if (val != null) {
				var content = "订单编号:" + row.orderNo + "\n订单客户:" + row.acctName;
				return "<a href='###' class='easyui-tooltip' title='"
						+ content
						+ "' onclick='gotoContentPage(\"${AppContext.ctxPath}/action/portal/saleorder/detail/"
						+ row.id + "\")'>" + val + "</a>";
			}
		}
		function addSaleOrder() {
			window.location.href = '${AppContext.ctxPath}/action/portal/saleorder/init';
		}
		//深度复制头和行
		function copySaleOrder(){
			var row = $datagrid.datagrid('getSelected');
			window.location.href = '${AppContext.ctxPath}/action/portal/saleorder/copy/'+row.id;
		}
		function orderSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(row.status == '新建' || row.status == '已拒绝'){
				//执行提交订单事件
				$.post('${AppContext.ctxPath}/action/portal/saleorder/commit', {
						id	: row.id
					},function(data){
						if(data.success){
							$datagrid.datagrid('reload');
						}else{
							window.parent.operationtip(data.result, 'error');
						}
					}); 
			}else{
				$.messager.alert('提示',"只有新建、已拒绝状态订单才能进行提交操作！")
			}
		
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
	</script>
</body>
</html>