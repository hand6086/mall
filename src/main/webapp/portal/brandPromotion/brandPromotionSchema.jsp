<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>
<style type="text/css" >
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
</style>
<body class="easyui-layout" data-options="fit:true" border="false">
 <div data-options="region:'north',split:true" fit="true" border="false">
   <div  border="false" style="height:70%;width:100%" title="促销方案发布">
  
	<table id="schema-table" fit="true" >
		<thead>
			<tr>
				<th field="id" hidden="true"></th>
				<th field="schemaName" width="200px" editor="{type:'textbox',options:{required:true}}" >促销方案名称</th>
				<th field="path" width="150px" formatter="pathFormatter">促销方案图片</th>
				<th field="tattr13" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >报名开始时间</th>
				<th field="tattr14" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >报名结束时间</th>
				<th field="type" width="130px" lov="TB_O2O_CAMPAIGN_TYPE" editor="{type:'combobox',	
																					options:{valueField:'val',
																					textField:'name',
																					method:'get',
																					data:getLov2(),
																					required:true}}">促销形式</th>
				<th field="startDate" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
				<th field="endDate" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>						
				<th field="brandStatus" width="120px" lov='TB_BRAND_SCHEMA_STATUS'>方案状态</th>
				<th field="comments" width="300px" editor="{type:'textarea',options:{required:true}}" >方案说明</th>
			</tr>
		</thead>
	</table>
 </div>
	<div border="false" style="width:100%;height:70%;" title="促销活动报名">
		<table id="activity-table" fit="true" >
			<thead>
				<tr>
					<th field="ck" checkbox="true"></th>
					<th field="storeName" width="150px">店铺名称</th>
					<th field="activityCode" width="100px">促销活动编码</th>
					<th field="activityName" width="200px" editor="{type:'textbox',options:{required:true}}">促销活动名称</th>
					<th field="startTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动开始时间</th>
					<th field="endTime" width="140px" mark="DATE" editor="{type:'datetimebox',options:{required:true}}" >活动结束时间</th>
					<th field="status" width="120px" lov="TB_O2O_STATUS">活动状态</th>
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
					<th field="promotionPrice" width="120px" editor="{options:{min:0,precision:2,required:true}}">促销价</th>
					<th field="lmtAmt" width="120px"
						editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">每人限购数量</th>
					<th field="groupsNumber" width="120px"
						editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">成团人数</th>
					<th field="totalQty" width="110px"
						editor="{type:'numberbox',options:{min:0,precision:0,required:true}}">限购总量</th>
					<th field="lmtBInfo" width="280px">限购信息</th>
				</tr>
			</thead>
		</table>
	</div>
</div>
<div id="dlg" class="easyui-dialog" title="请填写审批意见" data-options="closed:true,buttons:'#dlg-buttons'" style="width:450px;height:300px">
	<form id="activityForm" method="post" style="width:100%;height:100%">
		<table style="width:100%;height:100%">
			<tr style="width:100%;height:100%">
				<td style="width:100%;height:100%">
					<textarea style="width:99%;height:98%" placeholder='请在此输入审批意见' class="easyui-validatebox"
					 name="approvalSuggest" type="text" id="approvalSuggestId" required="true"></textarea>
				</td>
			</tr>
		</table>
	</form>
   </div>
   <div id="dlg-buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="save()">确定</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
</div>
	<script type="text/javascript">
	   $dlg = $('#dlg');
	   $activityForm = $('#activityForm');
	   $datagrid = $('#schema-table');
	   $dataItemgrid=$('#activity-table');
	   $dataGoodsgrid = $('#goods-table');
	   
	   var initHeadId = getUrlParams("headId");
	   var initId = getUrlParams("id");
	   $datagrid.hdatagrid({
			buttonNew:true,
			buttonDelete:true,
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonExport:true,
			title:"促销方案发布",
			pageSize: 5,//每页显示的记录条数，默认为20 
		    pageList: [5,30,50],//可以设置每页记录条数的列表 
		    newDefaultValue:true,
		    striped:true,
			subGridIds: ['activity-table'],
			url:'${AppContext.ctxPath}/action/portal/salesPromotionSchema/queryByExamplePage',
			buttonBatchEdit : false,
			onBeforeLoad:function(param){
				if(initHeadId != '' && initHeadId != null && typeof(initHeadId) != 'undefined'){
					param.id = initHeadId;
				}
			},
			
			onLoadSuccess: function (data) {
				if(initHeadId != '' && initHeadId != null && typeof(initHeadId) != 'undefined'){
					initHeadId = '';
				}
	        },
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				row.brandStatus = 'GOING';
				$.post('${AppContext.ctxPath}/action/portal/salesPromotionSchema/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						$datagrid.hdatagrid("load");
						successFun(that, data);
					}
				});
			},
			onDeleteAction : function(row,successFun,errFun,that){
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						row.deleteFlg = 'Y';
						row.brandStatus = 'PAUSE';
						$.post('${AppContext.ctxPath}/action/portal/salesPromotionSchema/update', row, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							} else {
								$.post('${AppContext.ctxPath}/action/portal/promotion/updateStatusBySchemaId', {schemaId:row.id}, function(data){
									if(!data.success){
										errFun(data.result,that);
									} else {
										$dataItemgrid.datagrid('reload');
										successFun(that, data);
									}
								});
								successFun(that, data);
							}
						});
					}
				})
		    },
			onInitNewData : function(that){
				return{
					brandStatus:'NO_START'
				}
			},
			/**
			 * 切换行，或加载数据成功后，触发选中行信息
			 */
			onChangeSelectedItem:function(row,that){
				if(row.brandStatus == '暂停中' || row.brandStatus == 'PAUSE' ){
					$("#btn_pause").linkbutton({text:'启动'});
					$("#btn_pause").linkbutton({iconCls:'icon_control_play'});
					$('.easyui-linkbutton-delete-list-table',$('#schema-table').datagrid('getPanel')).linkbutton('enable');
				} else{
					$("#btn_pause").linkbutton({text:'暂停'});
					$("#btn_pause").linkbutton({iconCls:'icon_control_pause'});
					$('.easyui-linkbutton-delete-list-table',$('#schema-table').datagrid('getPanel')).linkbutton('disable');
				}
			},
			readOnlyCondition: function(row, that){
				if(row.brandStatus != '暂停中' && row.brandStatus != 'PAUSE'){
					return true;
				}
				return false;
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileSchemaImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="schemaId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_pause" class="easyui-linkbutton" iconCls="icon_control_pause" plain="true" onclick="pause()">暂停</a>',that);
			}
		});
		$dataItemgrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			nowrap:false,
			buttonBatchEdit:false,
			updateable:true,
			buttonSearch:true,
			buttonExport:true,
			newDefaultValue:true,
			singleSelect:false,
			striped:true,
			title:"促销活动报名审批",
			pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表
			url:'${AppContext.ctxPath}/action/portal/promotion/queryByExamplePage',
			parentGridId : 'schema-table',
			subGridIds: ['goods-table'],
		    parentGridField : 'id',
		    linkGridField : 'schemaId',
			onBeforeLoad:function(param){
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					param.id = initId;
				}
				param.isApproved = 'Approved'
			},
			onLoadSuccess: function (data) {
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					initId = '';
				}
	        },
			readOnlyCondition: function(row, that){
				//先清除所有选择行,在选择当前编辑行
				$dataItemgrid.hdatagrid('clearSelections');
				var index = $dataItemgrid.hdatagrid('getRowIndex', row);
				$dataItemgrid.datagrid('selectRow',index)
				return false;
			},
			onUnselect: function(index, row){
				var selectRows = $dataItemgrid.datagrid('getSelections');
				var ifenable = 'enable';
				for(var i=0; i<selectRows.length; i++){
					if(selectRows[i].approvalStatus == 'Approved' || selectRows[i].approvalStatus == 'Rejected'){
						ifenable = 'disable';
					}
				}
				$('#btn_ok').linkbutton(ifenable);
				$('#btn_cancel').linkbutton(ifenable);
			},
			onSelect:function(index, row){
				var selectRows = $dataItemgrid.datagrid('getSelections');
				var ifenable = 'enable';
				for(var i=0; i<selectRows.length; i++){
					if(selectRows[i].approvalStatus == 'Approved' || selectRows[i].approvalStatus == 'Rejected'){
						ifenable = 'disable';
					}
				}
				$('#btn_ok').linkbutton(ifenable);
				$('#btn_cancel').linkbutton(ifenable);
				
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				var headRow = $datagrid.hdatagrid('getCurrentRow');
				row.schemaId = headRow.id;
				row.merchStartTime = headRow.startDate;
				row.merchEndTime = headRow.endDate;

				row.attr1 = 'brandPromotionSchema';
				$.post('${AppContext.ctxPath}/action/portal/promotion/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(99,'<a href="javascript:void(0)" id="btn_ok" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="approved(' + '\'Approved\'' + ')">审批通过</a>',that);
				addButtonFun(100,'<a href="javascript:void(0)" id="btn_cancel" class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="approved(' + '\'Rejected\'' + ')">审批拒绝</a>',that);
			}
		});
		$dataGoodsgrid.hdatagrid({
			toolbarShow : true,
			buttonSearch : true,
			nowrap:false,
			title:"报名商品",
			pageSize : 10,//每页显示的记录条数，默认为20 
			pageList : [ 10, 30, 50 ],//可以设置每页记录条数的列表
			url : '${AppContext.ctxPath}/action/portal/promotionGoods/queryByExamplePage',
			parentGridId : 'activity-table',
			parentGridField : 'id',
			linkGridField : 'headId',
		});
		
		//方案图片
		function pathFormatter(val,row){   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.path +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		//上传图片
		$(".fileSchemaImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alter("没有选中任何方案信息！");
				return;
			};
			$('#schemaId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/salesPromotionSchema/uploadImg',
	   			type:'post',
	   			data : {
	   				schemaName  :  row.schemaName,
	   				picId       :  row.picId,
	   				tattr13     :  row.tattr13,
	   				tattr14     :  row.tattr14,
	   				type        :  row.type,
	   				startDate   :  row.startDate,
	   				endDate     :  row.endDate,
	   				brandStatus :  row.brandStatus,
	   				comments    :  row.comments
	   			},
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						$datagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
		
		//方案暂停、启用
		function pause() {
			var row = $datagrid.datagrid('getSelected');
			$.messager.confirm('操作提示', '本次操作将使得方案状态改变,确定要这样操作吗?', function(data) {
				if(data){
					if (row.brandStatus != '暂停中' && row.brandStatus != 'PAUSE') {
						row.brandStatus = 'PAUSE';
					} else{
					/* 						
					    //报名开始时间
						var tattr13 = new Date(row.tattr13);
						//报名结束时间
						var tattr14 = new Date(row.tattr14);
						//活动开始时间
						var startDate = new Date(row.startDate);
						//活动结束时间
						var endDate = new Date(row.endDate);
						
						var currentDate = new Date();
						
						if(currentDate < tattr13){
							row.brandStatus = 'NO_START';
						}
						if( tattr13<= currentDate && currentDate <= tattr14){
							row.brandStatus = 'STARTING';
						}
						if( tattr14< currentDate && currentDate < startDate){
							row.brandStatus = 'END_ENROLL';
						}
						if( startDate<= currentDate && currentDate <= endDate){
							row.brandStatus = 'GOING';
						}
						if( endDate< currentDate){
							row.brandStatus = 'END';
						} 
					*/
						row.brandStatus = 'GOING';
					}
					$.post('${AppContext.ctxPath}/action/portal/salesPromotionSchema/update', row, function(data) {
						   if (!data.success) {
							   $.messager.alert("错误", "修改方案状态时出错", "error");
							}else{
								var index = $datagrid.hdatagrid('getRowIndex', row);
								if( row.brandStatus != 'PAUSE' ){
								    //报名开始时间
									var tattr13 = new Date(row.tattr13);
									//报名结束时间
									var tattr14 = new Date(row.tattr14);
									//活动开始时间
									var startDate = new Date(row.startDate);
									//活动结束时间
									var endDate = new Date(row.endDate);
									
									var currentDate = new Date();
									
									if(currentDate < tattr13){
										row.brandStatus = 'NO_START';
									}
									if( tattr13<= currentDate && currentDate <= tattr14){
										row.brandStatus = 'STARTING';
									}
									if( tattr14< currentDate && currentDate < startDate){
										row.brandStatus = 'END_ENROLL';
									}
									if( startDate<= currentDate && currentDate <= endDate){
										row.brandStatus = 'GOING';
									}
									if( endDate< currentDate){
										row.brandStatus = 'END';
									}
								}
								$datagrid.hdatagrid("refreshRow", index);
								$datagrid.datagrid('selectRow', index);
								$.messager.alert("操作提示", "操作成功！","info");
							}
						});
					}
				});
		}

		/**
		* 审批拒绝、审批通过 按钮执行方式
		* @param 值为Approved Rejected
		*/
		function approved(param){
			var rows = $dataItemgrid.datagrid('getSelections');
			if(rows.length <= 0){
				$.messager.alert("操作提示", "未选中行,不能进行该操作!","error");
				return true;
			}
			for(var i=0; i<rows.length; i++){
				if(param == 'Rejected'){
					$dlg.dialog('open');
					return true;
				} else{
					rows[i].approvalStatus = param;
					rows[i].status = 'Active';
					rows[i].attr1 = 'salesPromotionSchemaApproval';
					window.parent.operationtip('审批通过！', 'info');
				} 
			}
			
			$.ajax({
				url: "${AppContext.ctxPath}/action/portal/promotion/batchUpdate",
				type:"post",
				data:JSON.stringify(rows),
				dataType:"json",
				contentType: "application/json",
				success: function(data){
					if(data.success){
						var rows = $dataItemgrid.datagrid('getSelections');
						for(var i=0; i<rows.length; i++){
							var index = $dataItemgrid.hdatagrid('getRowIndex', rows[i]);
							$dataItemgrid.hdatagrid("refreshRow", index);
						}
						$('#btn_ok').linkbutton('disable');
						$('#btn_cancel').linkbutton('disable');
						successFun(that, data);
					}else{
						errFun(that, data);
					}
				},
				error: function(xhr, code, msg){
					errFun(that, "msg");
				}
			});
		}
		
		 function save(){
				var rows = $dataItemgrid.datagrid('getSelections');
				var approvalSuggest = $("#approvalSuggestId").val();
				if(approvalSuggest != null && approvalSuggest != ''){
					for(var i=0; i<rows.length; i++){
						rows[i].approvalSuggest = approvalSuggest;
						rows[i].approvalStatus = 'Rejected';
						rows[i].attr1 = 'salesPromotionSchemaApproval';
					}
				   
					$.ajax({
						url: "${AppContext.ctxPath}/action/portal/promotion/batchUpdate",
						type:"post",
						data:JSON.stringify(rows),
						dataType:"json",
						contentType: "application/json",
						success: function(data){
							if(data.success){
								$('#dlg').dialog('close');
								var rows = $dataItemgrid.datagrid('getSelections');
								for(var i=0; i<rows.length; i++){
									var index = $dataItemgrid.hdatagrid('getRowIndex', rows[i]);
									$dataItemgrid.hdatagrid("refreshRow", index);
								}
								$('#btn_ok').linkbutton('disable');
								$('#btn_cancel').linkbutton('disable');
								successFun(that, data);
							}else{
								errFun(that, data);
							}
						},
						error: function(xhr, code, msg){
							errFun(that, "msg");
						}
					});
				}else{
					$.messager.alert("操作提示", "审批意见不能为空!","error");
				}
		   }

		//促销形式值列表 只需要秒杀和拼团
		function getLov2() {
			var data2 = getLovArray('TB_O2O_CAMPAIGN_TYPE');
			//倒序移除非必须元素
			for (var i = data2.length - 1; i >=0; i--) {
				if (data2[i].val != 'Second Kill' && data2[i].val != 'FightGroup') {
					data2.splice(i,1);
				}
			}
			return data2;
		}
	</script>
</body>
</html>