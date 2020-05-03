<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
	
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
   <table id="priceList-table" singleSelect="true" rownumbers="true"  pagination="true" fit="true">
		<thead>
			<tr>
				<th field="priceListName" width="150px"  editor="{type:'textbox',options:{required:true}}" defaultSearch="true" formatter="captionFormatter">价格表名称</th>
				<th field="effStartDate" width="180px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">有效期开始时间</th>
				<th field="effEndDate" width="180px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">有效期结束时间</th>
				<th field="orgName" width="150px"  editor="{type:'textbox',options:{disabled:true}}">组织</th>
<!-- 				<th field="activated" width="100px" lov="ACTIVATED" editor="{type:'combobox',options:{valueField:'val',
																									textField:'name',
																									method:'get',
																									data:getLovArray('ACTIVATED'),
																									editable:false,
																									required:true}}" >是否激活</th> -->
				<th field="activated" width="100px" lov="ACTIVATED" editor="{type:'textbox',options:{disabled:true}}">是否激活</th>
				<th field="comments" width="400px"  editor="{type:'textbox'}">说明</th>
			</tr>
		</thead>
	</table>
   
   </div>
   <script type="text/javascript">
   	$datagrid = $('#priceList-table');
   	getLovOfList("[ACTIVATED]");
   	
	$datagrid.hdatagrid({
		updateable : true,
		toolbarShow:true,	//显示工具栏
		buttonSearch:true,	//搜索框功能
		buttonDelete:true,
		buttonMenu:true,
		oauthFlag:true,
		striped:true,
		title:'',
		border:false,
		url:'${AppContext.ctxPath}/action/portal/priceList/queryByExamplePage',
		onAddMoreButton:function(that,addButtonFun){
			addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addPriceList()">新建</a>',that);
			addButtonFun(43,'<a href="javascript:void(0)" id="btn_addActivated" class=" easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="addActivated()">激活</a>',that);
			addButtonFun(42,'<a href="javascript:void(0)" id="btn_moveActivated" class=" easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="moveActivated()">失效</a>',that);
		},
		buttonBatchEdit : true,
		onBatchUpdateAction : function(rows, successFun, errFun, that){
			var rows_2 = [];
			for(var i=0; i< rows.length; i++){
				var row = rows[i];
				var row_2 = {
						row_status   	: "UPDATE",
						id 			   :     row.id,
						 priceListName     :     row.priceListName,
						 effStartDate      :     row.effStartDate,
						 effEndDate 	   :     row.effEndDate,
						 orgId             :     row.orgId,
						 activated         :     row.activated,
						 comments          :     row.comments
				}
				rows_2.push(row_2);
			}
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/priceList/batchUpdate",
				type:"post",
				data:JSON.stringify(rows_2),
				dataType:"json",
				contentType: "application/json",
				success: function(data){
					if(data.success){
						successFun(that, data);
					}else{
						errFun(that, data);
					}
				},
				error: function(xhr, code, msg){
					errFun(that, "msg");
				}
			});
		},
		onUpdateAction:function(row,successFun,errFun,that){
			$.post('${AppContext.ctxPath}/action/portal/priceList/update',{
				 id 			   :     row.id,
				 priceListName     :     row.priceListName,
				 effStartDate      :     row.effStartDate,
				 effEndDate 	   :     row.effEndDate,
				 orgId             :     row.orgId,
				 activated         :     row.activated,
				 comments          :     row.comments
			},function(data){
				if (!data.success) {
					errFun(data.result,that);
				}else{
					successFun(that, data);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/priceList/deleteById', {
							id : row.id
					}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							} else {
								successFun(that, data);
								
							}
					});
				}
			});
		},
	   readOnlyCondition: function(row, that){
			if(row.activated == getLovShowName('ACTIVATED','Y')){
				return true;
			}
			else{
				return false;
			}
		   	
		}

	});
	
	function captionFormatter(val,row){
		var url = '';
		if(row.activated == getLovShowName('ACTIVATED','Y')){
			url = '${AppContext.ctxPath}/portal/product/PriceListDetailActivated.jsp';
		} else {
			url = '${AppContext.ctxPath}/portal/product/PriceListDetail.jsp';
		}
		return "<a href='###' onclick='gotoContentPage(\" " + url + "?id=" + row.id +"\")'>" + row.priceListName + "</a>";
	};

	function addPriceList(){
		var recordId = "noMatchSelect";
		gotoContentPage("${AppContext.ctxPath}/portal/product/PriceListDetail.jsp?id="+recordId);
	};

	function addActivated(){
 		var row = $datagrid.hdatagrid('getSelected');
 		if(!row){
 			$.messager.alert("提示", "请先选中一条数据!");
 			return;
 		} 	
		row.activated = getLovShowName('ACTIVATED','Y');
 		$.post("${AppContext.ctxPath}/action/portal/priceList/update", row, function(data){
			if (!data.success) {
	 			$.messager.alert("提示", data.result);
	 			return;
			}else{                       
				$datagrid.datagrid('reload');
			}
		});	
	}
	function moveActivated(){
 		var row = $datagrid.hdatagrid('getSelected');
 		if(!row){
 			$.messager.alert("提示", "请先选中一条数据!");
 			return;
 		} 		
		row.activated = getLovShowName('ACTIVATED','N');
 		$.post("${AppContext.ctxPath}/action/portal/priceList/update", row, function(data){
			if (!data.success) {
	 			$.messager.alert("提示", data.result);
	 			return;
			}else{                
				$datagrid.datagrid('reload');
			}
		});	
	}
   
   </script>
   
   
</body>