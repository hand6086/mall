<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<div border="false" style="height: 100%; width: 100%">
 <table id="activity-table-goods" style="height:100%;width:100%" fit="true">
			<thead>
				<tr>
					<th field="merchName" width="120px" editor="{type:'picklistbox',options:{required:true,title:'选择商品',
					completeFun:completePickGoods,
					tableUrl:'${AppContext.ctxPath}/portal/picklist/GoodsPicklist.jsp'}}">商品名称</th>
					<th field="merchCode" width="150px" >商品编码</th>
					<th field="merchId" width="150px" hidden="true">商品ID</th>
				</tr>
			</thead>
		</table>
		</div>
<script type="text/javascript">
$dataItemgoods=$('#activity-table-goods');
$dataItemgoods.hdatagrid({
	buttonDelete:true,
	updateable:true,
	toolbarShow:true,
	buttonSearch:true,
	buttonBatchEdit:false,
	oauthFlag:false,
	buttonNew:true,
	pageSize: 10,//每页显示的记录条数，默认为20 
    pageList: [10,30,50],//可以设置每页记录条数的列表 
	url:'${AppContext.ctxPath}/action/portal/goodsinformation/queryByExamplePage',
	parentGridId : 'activity-table',
    parentGridField :'id',
    linkGridField :'promotionCodeId',
    
    onBeforeAdd : function(row, that) {
		var headRow = $dataItemgrid.hdatagrid('getSelected');
		if (headRow.goodsAvailable == 'Y') {
			flag = true;
		} else {
			window.parent.operationtip('优惠券未勾选指定商品可用!', 'info');
			return false;
		}
	},
	onInitNewData:function(that){
    
	},
	 onInsertAction : function(row, successFun, errFun, that) {
		 row.promotionCodeId=$dataItemgrid.hdatagrid('getCurrentRow').id;
	       $.post('${AppContext.ctxPath}/action/portal/goodsinformation/insert',
					row, function(data) {
						if (!data.success) {
							errFun(data.result, that);
						} else {
							successFun(that, data);
							
						}
					});
	},
	onUpdateAction : function(row, successFun, errFun, that) {
	$.post('${AppContext.ctxPath}/action/portal/goodsinformation/update',
					row, function(data) {
						if (!data.success) {
							errFun(data.result, that);
						} else {
							successFun(that, data);
							
						}
					});
	}, 
/* 删除 */
onDeleteAction:function(row,successFun,errFun,that) {
	var headRow = $dataItemgrid.hdatagrid('getSelected');
	if (headRow.goodsAvailable == 'Y') {
	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
		if(data){
			$.post('${AppContext.ctxPath}/action/portal/goodsinformation/deleteById', {
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
	} else {
		window.parent.operationtip('优惠券未勾选指定商品可用!', 'info');
		return false;
	}
	
},


});
 
function completePickGoods(selectRow){
	$dataItemgoods.hdatagrid('getCurrentRow').merchName = selectRow.merchName;
	$dataItemgoods.hdatagrid('getCurrentRow').merchId = selectRow.merchId;
	return selectRow.merchName;
}

</script>
</body>
</html>