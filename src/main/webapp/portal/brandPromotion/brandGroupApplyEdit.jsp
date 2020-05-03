<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
.form-table{
	margin: 5px auto; 
	width: 1100px;
}
.table-block {
	margin: 5px auto;
	width:1100px;
}
fieldset{
	margin: 0px 0px 0px 0px;
	width:100%;
}
fieldset legend{
	font-size: 16px;
}
.td-label {
	width:120px;
	font-size: 14px;
	text-align: right;
	height: 30px;
}
.td-content {
	padding-right:6px;
}
.td-content input{
	width:180px;
}
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'center'" title="" style="width: 100%; height: 100%; padding: 0px;">
				<form id="activityHeaderForm" method="post">
					<table class="form-table">
					    <tr>
						   <td>
						   		<fieldset>
									<legend>促销活动信息</legend>
									<table class="table-block">
										<tr>
											<td class="td-label"><label>活动名称:</label></td>
											<td class="td-input">
												<input  class="easyui-validatebox" name="schemaName" type="text" id="schemaName" size="25" readonly="readonly"/>
											</td>
											
											<td class="td-label"><label>活动时间 :</label></td>
											<td class="td-input">
												<input class="easyui-validatebox" name="startDate" type="text" id="startDate" size="25" readonly="readonly"/>
												<label>—</label>
												<input class="easyui-validatebox" name="endDate" type="text" id="endDate" size="25" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>活动说明:</label></td>
											<td class="td-input">
												<input class="easyui-textbox" name="comments" type="text" id="comments" data-options="multiline:true" style="width:100%;height:100px" readonly="readonly" />
											</td>
											<td class="td-input">
												<input type="hidden" name="type" id="type">
											</td>
											<td class="td-input">
												<input type="hidden" name="id" id="schemaId">
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
					 	</tr>
					</table>
				</form>

				<form id="goodsHeaderForm" method="post">
					<table class="form-table">
					    <tr>
						   <td>
						   		<fieldset>
									<legend>促销商品信息</legend>
									<table class="table-block">
										<tr>
											<td class="td-label"><label>商品名称:</label></td>
											<td class="td-input">
												<input class="easyui-validatebox" name="buyMerchName" type="text" id="buyMerchName" size="25" />
											</td>
											<td class="td-label"><label>商品拼团价 :</label></td>
											<td class="td-input">
												<input class="easyui-validatebox" name="promotionPrice" type="text" id="promotionPrice" size="25" required="required" />
											</td>
											<td class="td-input">
												<input type="hidden" name="o2oGoodsId" id="o2oGoodsId">
											</td>
										</tr>
										<tr>
											<td class="td-label"><label>成团人数 :</label></td>
											<td class="td-input">
												<input class="easyui-numberbox" name="groupsNumber" data-options="min:2,precision:0" id="groupsNumber" size="25" required="required"/>
											</td>
											<td class="td-label"><label>限购总量 :</label></td>
											<td class="td-input">
												<input class="easyui-validatebox" name="totalQty" type="text" id="totalQty" size="25" required="required"/>
											</td>
										</tr>
									</table>
								</fieldset>
							</td>
					 	</tr>
					</table>
				</form>
				<div>
					<center>
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 120px;" class="easyui-linkbutton" iconCls="icon-save" plain="true"  id="btn_submit" onclick="save()">保存并继续添加</a>
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 120px;" class="easyui-linkbutton" iconCls="icon-edit" plain="true"  id="btn_edit" onclick="submitForm()">提交审批</a>
						&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" style="background-color: #e0ecff; width: 100px;" class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="javascript:window.parent.closeCampaignApplyWin()">返回</a>
					</center>
				</div>
				
				<div class="form-group form-group-sm">
					<div class="col-md-12">
						<label>&nbsp;</label>
					</div>
				</div>
		<div border="false" style="width: 100%; height: 70%;">
				<table id="goods-table" fit="true">
					<thead>
						<tr>
							<th field="buyMerchName" width="280px">商品名称</th>
							<th field="merchCode" width="170px" hidden="true">商品编码</th>
							<th field="path" width="150px" formatter="pathFormatter">商品图片</th>
							<th field="originalPrice" width="120px" editor="{options:{min:0,precision:2,required:true}}">零售价</th>
							<th field="promotionPrice" width="120px" editor="{options:{min:0,precision:2,required:true}}">拼团价</th>
							<th field="groupsNumber" width="120px"
								editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">成团人数</th>
							<th field="totalQty" width="110px"
								editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限购总量</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$buyMerchNamePicklist = $('#buyMerchName');
	$dataGoodsgrid = $('#goods-table');
	var headId = "${param.headId}";

	//初始化页面活动信息form表单
	function secKillCampaignInit(schemaId, approvalStatus, refreshDatagrid){
		if(!schemaId){
			$.messager.alert("错误","参数错误, 无法获取方案id", "error");
			return;
		}
		if(approvalStatus != 'New' && approvalStatus != 'Rejected'){
			$('.easyui-linkbutton-delete-list-table',$dataGoodsgrid.datagrid('getPanel')).linkbutton('disable');
		}
		$.post("${AppContext.ctxPath}/action/portal/salesPromotionSchema/queryById",{id:schemaId},
			function(data){
				if(data){
					if(data.success){
						brandPromotionSchema = data.result;
						//初始化活动信息表单
						loadObject(brandPromotionSchema);
					}
				}
			});
	}
	/**
	 * 把对象数据填充到表单上
	 */
	function loadObject(object) {
		$("#activityHeaderForm").form("clear");
		$("#activityHeaderForm").form("load", object);
		for (key in object) {
			value = object[key];
			$("[name='" + key + "'][type='checkbox']", $("#activityHeaderForm"))
					.each(function() {
						$(this).prop("checked", value == "Y" ? true : false);
					});
		}
	}
	$dataGoodsgrid.hdatagrid({
		toolbarShow : true,
		buttonSearch : true,
		buttonDelete : true,
		nowrap : false,
		title : "拼团报名商品",
		pageSize : 10,//每页显示的记录条数，默认为20 
		pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
		url : '${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
		onBeforeLoad:function(param){
	    	param.headId=headId;
		},
		onDeleteAction : function(row,successFun,errFun,that){
			$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					row.deleteFlg = 'Y';
					row.status = 'Inactive';
					row.attr1 = 'delete';
					$.post('${AppContext.ctxPath}/action/portal/promotionGoods/update', row, function(data) {
						if (!data.success) {
							errFun(data.result,that);
						} else {
							successFun(that, data);
						}
					})
				}
			})
	    },
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
	
	$buyMerchNamePicklist.picklist({
		title : '选择商品',
		tableUrl : '/portal/picklist/TbBrandMerchandisePickList.jsp',
		initParam : function(){
			var attr1 = 'promotion';
			var startTime = $('#startDate').val();
			var endTime = $('#endDate').val();
			return {
				attr1:attr1,
				startTime:startTime,
				endTime:endTime
			};
		},
		required : true,
		completeFun : function(selectRow) {
			$('#o2oGoodsId').val(selectRow.id);
			return selectRow.o2oDisplayName;
		}
	});
	//保存并继续添加
	function save(){
		schemaId = $('#schemaId').val();
		schemaName = $('#schemaName').val();
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();
		type = $('#type').val();
		comments = $('#comments').val();
		
		if(schemaName =='' || schemaName == null){
			 $.messager.alert("错误", "活动名不能为空", "error");
		}
		if(startDate =='' || startDate == null){
			 $.messager.alert("错误", "活动开始时间不能为空", "error");
		}
		if(endDate =='' || endDate == null){
			 $.messager.alert("错误", "活动结束时间不能为空", "error");
		}
		
		buyMerchName = $('#buyMerchName').val();
		buyMerchId = $('#o2oGoodsId').val();
		promotionPrice = $('#promotionPrice').val();
		groupsNumber = $('#groupsNumber').val();
		totalQty = $('#totalQty').val();
		
		if(buyMerchId =='' || buyMerchId == null){
			 $.messager.alert("错误", "商品不能为空", "error");
			 return false;
		}
		if(promotionPrice =='' || promotionPrice == null){
			 $.messager.alert("错误", "拼团价不能为空", "error");
			 return false;
		}
		if(groupsNumber =='' || groupsNumber == null){
			 $.messager.alert("错误", "成团人数不能为空", "error");
			 return false;
		}
		if(totalQty =='' || totalQty == null){
			 $.messager.alert("错误", "限购总量不能为空", "error");
			 return false;
		}
		$('#btn_submit').linkbutton('disable');
		//查询是方案下是否有活动 即是否已报名
		$.post("${AppContext.ctxPath}/action/portal/promotion/brandQueryBySchemaId",{
				schemaId : schemaId,
				activityName : schemaName,
				startTime : startDate,
				endTime : endDate,
				type : type,
				status :'Inactive',
				approvalStatus : 'New',
				activityNotes : comments
			},function(data){
				if(data){
					if(data.success){
						promotion = data.result;
						if(promotion !='' && promotion != null && promotion.id !='' && promotion.id != null ){
							// add by zhenghongda
							if(promotion.approvalStatus == 'New' || data.result.approvalStatus == 'Rejected'){
								$('.easyui-linkbutton-delete-list-table',$dataGoodsgrid.datagrid('getPanel')).linkbutton('enable');
							} 
							// add by zhenghongda
							//添加商品后 将活动id赋值给活动行的headId(主要是在添加第一个商品时)
							headId = promotion.id;
							if(promotion.status == 'Inactive' && promotion.approvalStatus == 'New' || promotion.approvalStatus == 'Rejected'){
								$.post("${AppContext.ctxPath}/action/portal/promotionGoods/insert",{
									headId         :   promotion.id,
									merchStartTime :   startDate,
									merchEndTime   :   endDate,
									buyMerchId     :   buyMerchId,
									promotionPrice :   promotionPrice,
									groupsNumber   :   groupsNumber,
									totalQty       :   totalQty,
									status         :   'Active'
								},function(data){
									if(data.success){
										$('#btn_submit').linkbutton('enable');
										$.messager.alert("成功", "操作成功", "info");
										//重置输入框
										buyMerchName = $('#buyMerchName').textbox('setValue','');
										buyMerchId = $ ('#o2oGoodsId').val('');
										promotionPrice = $('#promotionPrice').val('');
										groupsNumber = $('#groupsNumber').val('');
										totalQty = $('#totalQty').val('');
										$dataGoodsgrid.datagrid('reload');
									}
								});
							}else{
								$.messager.alert("错误", "该活动不能进行操作", "error");
								 return false;
							}
						} else{
							$.messager.alert("错误", "无法关联活动", "error");
							 return false;
						}
					}
				}
		});
	}
	
	// 提交审批
	function submitForm(){
		var row = $dataGoodsgrid.datagrid('getSelected');
		if( row != null && row != '' ){
			$.post('${AppContext.ctxPath}/action/portal/promotion/queryById', {
				id 	           : row.headId,
			}, function(data) {
			   if (!data.success) {
				   window.parent.operationtip(data.result,'error');
				}else{
					//提交审批操作
					if( data.result.approvalStatus == 'New' || data.result.approvalStatus == 'Rejected'){
						$.post('${AppContext.ctxPath}/action/portal/promotion/brandSubmit', {
							approvalStatus : 'Pending',
							schemaId	   : data.result.schemaId,
							id 	           : row.headId,
						}, function(data) {
						   if (!data.success) {
							   window.parent.operationtip(data.result,'error');
							}else{
								$('.easyui-linkbutton-delete-list-table',$dataGoodsgrid.datagrid('getPanel')).linkbutton('disable');
								$.messager.confirm("操作提示", '促销活动已提交,是否要跳转到已报名列表？', function(data) {
									if(data){
										window.top.quickEnter('拼团已报名列表','拼团已报名列表','BRAND_CAMPAIGN_MANAGEMENT','${AppContext.ctxPath}/portal/brandPromotion/brandGroupCampaignApplyList.jsp');
									}
								});
							}
						});
					} else{
						$.messager.alert("错误", "该活动不能再次提交", "error");
					}
				}
			});
		} else{
			$.messager.alert("错误", "未选中行", "error");
		}
	}
</script>
</body>
</html>