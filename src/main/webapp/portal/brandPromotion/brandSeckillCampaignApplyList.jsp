<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
	<div border="false" style="width:100%;height:70%;" title="促销活动报名">
		<table id="activity-table" fit="true" >
			<thead>
				<tr>
					<th field="storeName" width="200px" >店铺名称</th>
					<th field="activityName" width="200px" >促销活动名称</th>
					<th field="path" width="150px" formatter="pathFormatter">促销方案图片</th>
					<th field="startTime" width="140px" mark="DATE" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" >活动结束时间</th>
					<th field="type" width="120px" lov="TB_O2O_CAMPAIGN_TYPE" >促销形式</th>
					<th field="approvalStatus" width="120px" lov="TB_O2O_APPROVAL_STATUS" >审批状态</th>
					<th field="approvalSuggest" width="240px" >审批意见</th>
				</tr>
			</thead>
		</table>
		</div>
		<div border="false" style="width: 100%; height: 70%;">
			<table id="goods-table" fit="true">
				<thead>
					<tr>
						<th field="buyMerchName" width="280px">商品名称</th>
						<th field="merchCode" width="170px" hidden="true">商品编码</th>
						<th field="path" width="150px" formatter="pathFormatter">商品图片</th>
						<th field="originalPrice" width="120px" editor="{options:{min:0,precision:2,required:true}}">零售价</th>
						<th field="promotionPrice" width="120px" editor="{options:{min:0,precision:2,required:true}}">秒杀价</th>
						<th field="lmtAmt" width="120px"
							editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">每人限购数量</th>
						<th field="totalQty" width="110px"
							editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限购总量</th>
						<th field="lmtBInfo" width="280px">限购信息</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	   $activityForm = $('#activityForm');
	   $datagrid = $('#activity-table');
	   $dataItemgrid=$('#goods-table');
	  
	   $datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			newDefaultValue:true,
			striped:true,
			title:"我参与的平台活动",
			pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
			subGridIds: ['goods-table'],
			onBeforeLoad:function(param){
				param.type ='Second Kill';
			},
			readOnlyCondition: function(row, that){
				//先清除所有选择行,在选择当前编辑行
				$datagrid.hdatagrid('clearSelections');
				var index = $datagrid.hdatagrid('getRowIndex', row);
				$datagrid.datagrid('selectRow',index);
				return false;
			},
			onSelect:function(index, row){
				var row = $datagrid.datagrid('getSelected');
				if(row.approvalStatus == 'New' || row.approvalStatus == 'Rejected'){
					$("#btn_submit").linkbutton('enable');
					$("#btn_submit").linkbutton({text:'提交'});
					$("#btn_submit").linkbutton({iconCls:'icon-ok'});
                    $("#btn_remove").linkbutton('enable');
				} else if(row.approvalStatus != 'Approved'){
					$("#btn_submit").linkbutton('enable');
					$("#btn_submit").linkbutton({text:'撤回'});
					$("#btn_submit").linkbutton({iconCls:'icon-undo'});
                    $("#btn_remove").linkbutton('disable');
				} else{
					$("#btn_submit").linkbutton('disable');
                    $("#btn_remove").linkbutton('disable');
				}
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="submit()">提交</a>',that);
				addButtonFun(100,'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteById()">删除</a>',that);
			},
		});
		$dataItemgrid.hdatagrid({
			toolbarShow : true,
			buttonSearch : true,
			nowrap:false,
			title:"秒杀报名商品",
			pageSize : 10,//每页显示的记录条数，默认为20 
			pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
			url : '${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
			parentGridId : 'activity-table',
			parentGridField : 'id',
			linkGridField : 'headId',
		});
		
		function pathFormatter(val,row){   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.path +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		//提交审批
		function submit(){
			var row = $datagrid.hdatagrid('getCurrentRow');
			var approvalStatus = row.approvalStatus;
			if(row.status == 'Inactive' && row.approvalStatus == 'New' || row.approvalStatus == 'Rejected'){
				row.approvalStatus='Pending';
				submitOrCancel(row,approvalStatus);
			} else if(row.approvalStatus != 'Approved'){
				$.messager.confirm("操作提示", '是否确定撤回该活动？', function(data) {
					if(data){
						row.approvalStatus='New';
						submitOrCancel(row,approvalStatus);
					}
				});
			}
		}

		//提交审批
		function deleteById(){
			var row = $datagrid.hdatagrid('getCurrentRow');
            row.deleteFlg = 'Y';
            row.status = 'Inactive';
            row.attr1 = 'salesPromotionSchemaApproval';
            $.post('${AppContext.ctxPath}/action/portal/promotion/update', row, function(data) {
                if (!data.success) {
                    window.parent.operationtip(data.result,'error');
                }else{
                    $datagrid.hdatagrid("reload");
                }
            });
		}
		
		//提交或撤回按钮
		function submitOrCancel(row,approvalStatus){
			$.post('${AppContext.ctxPath}/action/portal/promotion/brandSubmit', row, function(data) {
				   if (!data.success) {
					   // 提交不成功后前端审批状态显示会原先内容
					   row.approvalStatus = approvalStatus;
					   var index = $datagrid.hdatagrid('getRowIndex', row);
					   $datagrid.hdatagrid("refreshRow", index);
					   $datagrid.datagrid('selectRow',index);
					   window.parent.operationtip(data.result,'error');
					}else{
						var index = $datagrid.hdatagrid('getRowIndex', row);
						$datagrid.hdatagrid("refreshRow", index);
						$datagrid.datagrid('selectRow',index);
						window.parent.operationtip('操作成功！', 'info');
						successFun(that, data);
					}
				});
		}
	</script>
</body>
</html>