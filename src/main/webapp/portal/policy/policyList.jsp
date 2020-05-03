<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js?version=<%=version%>"></script>
<style type="text/css" >
/* 图片上传 */
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
    width: 100%;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
</style>
<body class="easyui-layout" id="plicyLayout" data-options="fit:true" border="false">
	<div data-options="region:'center'" border="false" style="width: 100%; height: 100%; padding: 0px;">
		<div class="easyui-panel" style="width:'$(window).width() - 18'; height: 50%;">
			<table id="policy-table" fit="true">
				<thead>
					<tr>
						<th field="imagePath" width="150px" formatter="imageFormatter">政策图片</th>
						<th field="created" width="120px" >创建时间</th>
						<th field="pcyName" width="200px" editor="{type:'validatebox',options:{required:false}}">政策名称</th>
						<th field="majorType" width="100px" lov="PCY_MAJOR_TYPE" editor="{type:'combobox',options:{valueField:'val',
						textField:'name',data:getLovArray('PCY_MAJOR_TYPE'),editable:false,required:false}}">政策大类</th>
						<th field="subType" width="100px" lov="PCY_SUB_TYPE" editor="{type:'combobox',options:{valueField:'val',
						textField:'name',data:getLovArray('PCY_SUB_TYPE'),editable:false,required:false}}">政策类型</th>
						<th field="guideName" width="100px" lov="PCY_GUIDE_NAME" editor="{type:'combobox',options:{valueField:'val',
						textField:'name',data:getLovArray('PCY_GUIDE_NAME'),editable:false,required:false}}">向导名称</th>
						<th field="startTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">开始时间</th>
						<th field="endTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">结束时间</th>
						<th field="rcmdSeq" width="70px" editor="{type:'numberbox',options:{min:0}}">推荐顺序</th>
						<th field="isOneTime" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否首单</th>
						<th field="isRcmd" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否推荐</th>
						<th field="pcyStatus" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">状态</th>
						<th field="comments" width="250px" editor="{type:'validatebox',options:{required:false}}">备注</th>
					</tr>
				</thead>
			</table>
		</div>
	
		<div class="easyui-tabs" id="itemTabs" style="width:'$(window).width() - 18';height:100%"
			data-options="border:false">
			<div title="政策规则">
				<div class="easyui-layout" id="pcyRuleLayout" data-options="fit:true" border="false">
					<div data-options="region:'north'" border="false" style="width: 100%; height: 50%;">
						<table id="pcyRule-table" fit="true">
							<thead>
								<tr>
									<th field="created" width="20%">创建时间</th>
									<th field="ruleName" width="20%" editor="{type:'validatebox',options:{required:false}}">规则名称</th>
									<th field="ruleType" width="20%" lov="PCY_RULE_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_RULE_TYPE'),editable:false,required:false}}">规则类型</th>
									<th field="comments" width="20%" editor="{type:'validatebox',options:{required:false}}">备注</th>
								</tr>
							</thead>
						</table>
					</div>
					<div data-options="region:'center'"></div><!-- 边框线 -->
					<div data-options="region:'west'" border="false" style="width: 50%; height: 50%;">
						<table id="pcyCnd-table" fit="true">
							<thead>
								<tr>
									<th field="created" width="120px" >创建时间</th>
									<th field="cndType" width="100px" lov="PCY_CND_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_CND_TYPE'),editable:false,required:false}}">条件类型</th>
									<th field="cndBasis" width="100px" lov="PCY_CND_BASIS" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_CND_BASIS'),editable:false,required:false}}">条件基数</th>
									<th field="cndObjType" width="100px" lov="PCY_CND_OBJ_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_CND_OBJ_TYPE'),editable:false,required:false}}">条件对象类型</th>
									<th field="valueType" width="100px" lov="PCY_VALUE_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_VALUE_TYPE'),editable:false,required:false}}">值类型</th>
									<th field="startTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">开始时间</th>
									<th field="endTime" width="100px" editor="{type:'datebox',options:{showSeconds:false}}">结束时间</th>
									<th field="cndOpr" width="100px" lov="PCY_CND_OPR" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_CND_OPR'),editable:false,required:false}}">运算符</th>
									<th field="cndMinimum" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">最小值</th>
									<th field="cndMaximum" width="100px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">最大值</th>
									<th field="circulated" width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}">是否循环</th>
									<th field="priority" width="100px" editor="{type:'numberbox',options:{min:0}}">优先级</th>
									<th field="prodMatSeries" width="100px" lov="PROD_MAT_SERIES" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PROD_MAT_SERIES'),editable:false,required:false}}">产品类别</th>
									<th field="prodName" width="150px" editor="{type:'mvgPickbox',
										options:{title:'产品',completeFun:cndProdMvgPickComplete,
												mvgMapperName:'pcyCndprod',
												tableId:'pcyCnd-table',
												optionsLeft:{
													tableUrl:'${AppContext.ctxPath}/portal/policy/mvgPick/ProdMvgPick.jsp',
													initParam:cndProdMvgPickParam
												}
												}}">产品名称</th>
									<th field="prodCode" width="100px">产品编码</th>
									<th field="comments" width="200px" editor="{type:'validatebox',options:{required:false}}">备注</th>
								</tr>
							</thead>
						</table>
					</div>
					<div data-options="region:'east'" border="false" style="width: 50%; height: 50%;">
						<table id="pcyResult-table" fit="true">
							<thead>
								<tr>
									<th field="created" width="120px" >创建时间</th>
									<th field="promType" width="100px" lov="PCY_PROM_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_PROM_TYPE'),editable:false,required:false}}">促销类型</th>
									<th field="promObjType" width="170px" lov="PCY_PROM_OBJ_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_PROM_OBJ_TYPE'),editable:false,required:false}}">促销对象类型/限购范围类型</th>
									<th field="limitType" width="100px" lov="PCY_LIMIT_TYPE" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_LIMIT_TYPE'),editable:false,required:false}}">限制类型</th>
									<th field="promMethod" width="100px" lov="PCY_PROM_METHOD" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PCY_PROM_METHOD'),editable:false,required:false}}">促销方式</th>
									<th field="proportion" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				max:1,
																				precision:2}}">折扣比例</th>
									<th field="qty" width="80px" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">数量</th>
									<th field="spclPrice" width="100px" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">特价</th>
									<th field="subjectId" width="100px" editor="{type:'validatebox',options:{required:false}}">科目ID</th>
									<th field="campaignId" width="100px" editor="{type:'validatebox',options:{required:false}}">活动ID</th>
									<th field="prodMatSeries" width="100px" lov="PROD_MAT_SERIES" editor="{type:'combobox',options:{valueField:'val',
									textField:'name',data:getLovArray('PROD_MAT_SERIES'),editable:false,required:false}}">产品类别</th>
									<th field="prodName" width="150px" editor="{type:'mvgPickbox',
										options:{title:'产品',completeFun:rltProdMvgPickComplete,
												mvgMapperName:'pcyrltProd',
												tableId:'pcyResult-table',
												optionsLeft:{
													tableUrl:'${AppContext.ctxPath}/portal/policy/mvgPick/ProdMvgPick.jsp',
													initParam:rltProdMvgPickParam
												}
												}}">产品名称</th>
									<th field="prodCode" width="100px">产品编码</th>
									<th field="comments" width="200px" editor="{type:'validatebox',options:{required:false}}">备注</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div title="客户范围">
				<table id="pcyScpAcc-table" fit="true">
					<thead>
						<tr>
							<th field="created" width="20%" >创建时间</th>
							<th field="accntType" width="20%" lov="ACCT_TYPE" editor="{type:'combobox',options:{valueField:'val',
							textField:'name',data:getLovArray('ACCT_TYPE'),editable:false}}">客户类型</th>
							<th field="accntName" width="20%" editor="{type:'picklistbox',options:{title:'选择客户',
															completeFun:scpAccPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/accountPickList.jsp'
															}}">客户名称</th>
							<th field="comments" width="20%" editor="{type:'validatebox'}">备注</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="组织范围">
				<table id="pcyScpOrg-table" fit="true">
					<thead>
						<tr>
							<th field="created" width="30%" >创建时间</th>
							<th field="orgName" width="30%" editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:scpOrgPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp',
															required:true}}">组织</th>
							<th field="comments" width="30%" editor="{type:'validatebox'}">备注</th>
			
						</tr>
					</thead>
				</table>
			</div>
			<div title="地域范围">
				<table id="pcyScpRgn-table" fit="true">
					<thead>
						<tr>
							<th field="created" width="30%">创建时间</th>
							<th field="addrName" width="30%" editor="{type:'picklistbox',options:{title:'地理区域列表',
																            completeFun:scpRgnPicklistComplete,
																            tableUrl:'${AppContext.ctxPath}/portal/picklist/addrpstPickList.jsp',
																			required:true}}">地理区域名称</th>
							<th field="comments" width="30%" editor="{type:'validatebox'}">备注</th>
			
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	<!-- 要放大显示的div -->
	<div id="bigImg" style="display: none;">
		<img id="popUpImg" />
	</div>
	<!-- 向导窗口 -->
    <div id="guideWin" class="crmWin" style="display:none">
    	<iframe src=""  id="guideWinFram" style="width: 100%;height: 100%;" frameborder="0" scrolling="no"></iframe>
    </div>
	<script type="text/javascript">
	$('#plicyLayout').layout();
	$('#pcyRuleLayout').layout();
	$('#itemTabs').tabs();
	getLovOfList("[PCY_GUIDE_NAME,PCY_PROM_METHOD,PCY_LIMIT_TYPE,PCY_PROM_OBJ_TYPE"
	               + ",PCY_PROM_TYPE,PCY_CND_OPR,PCY_VALUE_TYPE,PCY_CND_OBJ_TYPE"
	               + ",PCY_CND_BASIS,PCY_CND_TYPE,PCY_RULE_TYPE,PCY_SUB_TYPE,PCY_MAJOR_TYPE,ACCT_TYPE]");
	$policyDatagrid = $('#policy-table');
	$pcyRuleDatagrid = $('#pcyRule-table');
	$pcyCndDatagrid = $('#pcyCnd-table');
	$pcyResultDatagrid = $('#pcyResult-table');
	$pcyScpAccDatagrid = $('#pcyScpAcc-table');
	$pcyScpOrgDatagrid = $('#pcyScpOrg-table');
	$pcyScpRgnDatagrid = $('#pcyScpRgn-table');
	
	/* --------------------客户范围列表：开始------------------------------ */
	$pcyScpAccDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		parentGridId : 'policy-table',
	    parentGridField : 'id',
	    linkGridField : 'pcyId',
		url:'${AppContext.ctxPath}/action/portal/pcyScpAcc/queryByExamplePage',
		onInitNewData:function(that){
			var headRow = $policyDatagrid.datagrid('getSelected');
			return {
				pcyId	: headRow.id,
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/pcyScpAcc/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			$.post('${AppContext.ctxPath}/action/portal/pcyScpAcc/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/pcyScpAcc/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		}
	});
	/**
	 * 组织picklist回调方法
	 */
	function scpAccPicklistComplete(selectRow){
		$pcyScpAccDatagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
		return selectRow.acctName;
	}
	
	/* --------------------组织范围列表：开始------------------------------ */
	$pcyScpOrgDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		parentGridId : 'policy-table',
	    parentGridField : 'id',
	    linkGridField : 'pcyId',
		url:'${AppContext.ctxPath}/action/portal/pcyScpOrg/queryByExamplePage',
		onInitNewData:function(that){
			var headRow = $policyDatagrid.datagrid('getSelected');
			return {
				pcyId	: headRow.id,
				created : appCtx.sysdate(),
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/pcyScpOrg/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			$.post('${AppContext.ctxPath}/action/portal/pcyScpOrg/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/pcyScpOrg/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		}
	});
	/**
	 * 组织picklist回调方法
	 */
	function scpOrgPicklistComplete(selectRow){
		$pcyScpOrgDatagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
		return selectRow.text;
	}
	
	/* --------------------地域范围列表：开始------------------------------ */
	$pcyScpRgnDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		parentGridId : 'policy-table',
	    parentGridField : 'id',
	    linkGridField : 'pcyId',
		url:'${AppContext.ctxPath}/action/portal/pcyScpRgn/queryByExamplePage',
		onInitNewData:function(that){
			var headRow = $policyDatagrid.datagrid('getSelected');
			return {
				pcyId	: headRow.id,
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/pcyScpRgn/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			$.post('${AppContext.ctxPath}/action/portal/pcyScpRgn/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/pcyScpRgn/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		}
	});
	
	/**
	 * 地理区域picklist回调方法
	 */
	function scpRgnPicklistComplete(selectRow){
		$pcyScpRgnDatagrid.hdatagrid('getCurrentRow').addrId = selectRow.id;
		return selectRow.addrName;
	}
	
	/* --------------------规则条件列表：开始------------------------------ */
	$pcyCndDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		newDefaultValue:true,
		parentGridId : 'pcyRule-table',
	    parentGridField : 'id',
	    linkGridField : 'ruleId',
	    title:'规则条件',
		url:'${AppContext.ctxPath}/action/portal/pcyCnd/queryByExamplePage',
		onInitNewData:function(that){
			var headRow = $pcyRuleDatagrid.datagrid('getSelected');
			return {
				ruleId	: headRow.id,
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/pcyCnd/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			$.post('${AppContext.ctxPath}/action/portal/pcyCnd/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/pcyCnd/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		}
	});
	/**
	 * 条件产品mvgPick 列表数据初始化参数
	 */
	function cndProdMvgPickParam(){
		var currentRow = $pcyCndDatagrid.hdatagrid('getCurrentRow');
		return {mvgParentId:currentRow.id};
	}
	/**
	 * 条件产品mvgPick 按【确定】后执行的方法
	 */
	function cndProdMvgPickComplete(rightRowsMvg) {
		var currentRow = $pcyCndDatagrid.hdatagrid('getCurrentRow');
		if(rightRowsMvg != null){
			currentRow.prodId = rightRowsMvg.id;
			currentRow.prodName = rightRowsMvg.prodName;
		}
		return currentRow.prodName;
	}
	
	/* --------------------规则结果列表：开始------------------------------ */
	$pcyResultDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		newDefaultValue:true,
		parentGridId : 'pcyRule-table',
	    parentGridField : 'id',
	    linkGridField : 'ruleId',
	    title:'规则结果',
		url:'${AppContext.ctxPath}/action/portal/pcyResult/queryByExamplePage',
		onInitNewData:function(that){
			var headRow = $pcyRuleDatagrid.datagrid('getSelected');
			return {
				ruleId	: headRow.id,
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/pcyResult/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			$.post('${AppContext.ctxPath}/action/portal/pcyResult/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/pcyResult/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		}
	});
	/**
	 * 结果产品mvgPick 列表数据初始化参数
	 */
	function rltProdMvgPickParam(){
		var currentRow = $pcyResultDatagrid.hdatagrid('getCurrentRow');
		return {mvgParentId:currentRow.id};
	}
	/**
	 * 结果产品mvgPick 按【确定】后执行的方法
	 */
	function rltProdMvgPickComplete(rightRowsMvg) {
		var currentRow = $pcyResultDatagrid.hdatagrid('getCurrentRow');
		if(rightRowsMvg != null){
			currentRow.prodId = rightRowsMvg.id;
			currentRow.prodName = rightRowsMvg.prodName;
		}
		return currentRow.prodName;
	}
	
	/* --------------------政策规则列表：开始------------------------------ */
	$pcyRuleDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		parentGridId : 'policy-table',
	    parentGridField : 'id',
	    linkGridField : 'pcyId',
	    subGridIds: ['pcyCnd-table','pcyResult-table'],
		url:'${AppContext.ctxPath}/action/portal/pcyRule/queryByExamplePage',
		onInitNewData:function(that){
			var headRow = $policyDatagrid.datagrid('getSelected');
			return {
				pcyId	: headRow.id,
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/pcyRule/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			delete row.conditionList;
			delete row.resultList;
			$.post('${AppContext.ctxPath}/action/portal/pcyRule/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/pcyRule/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		}
	});
	
	/* --------------------政策头：开始------------------------------ */
	$policyDatagrid.hdatagrid({
		updateable:true,
		toolbarShow:true,
		buttonSearch:true,
		buttonNew:true,
		buttonDelete:true,
		oauthFlag:true,
		subGridIds: ['pcyRule-table','pcyScpAcc-table','pcyScpOrg-table','pcyScpRgn-table'],
		url : '${AppContext.ctxPath}/action/portal/policy/queryByExamplePage',
		onAddMoreButton:function(that,addButtonFun){
			var uploadBtnHtml = '<div style = "width:98px;display:inline-block"> <form id="pcyImgForm" method="post" enctype="multipart/form-data">'
								+' <a href="javascript:;" class="file easyui-linkbutton fileImg" iconCls="icon-uploadImg" plain="true">上传图片 '
								+ '<input type="hidden" id="entityId" name="id"/>'
								+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfile'/></a></form></div>";
			addButtonFun(91,uploadBtnHtml,that);
			addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="guideNewPcy()">向导式新建</a>',that);
			addButtonFun(93,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-followUp" plain="true" onclick="guideUpdatePcy()">向导式修改</a>',that);
		},
		buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/policy/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
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
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
			delete row.ruleList;
			delete row.scpAccList;
			delete row.scpRgnList;
			delete row.scpOrgList;
			$.post('${AppContext.ctxPath}/action/portal/policy/upsert',row , function(data) {
				if (data.success) {
					successFun(that, data);
				} else {
					errFun(data.result,that);
				}
			});
		},
		onDeleteAction:function(row,successFun,errFun,that) {
			 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/policy/deleteById', {
							id : row.id
					}, function(data) {
						if (data.success) {
							successFun(that, data);
						} else {
							errFun(data.result,that);
						}
					});
				}
			});		 
		},
		onInitNewData:function(that){
			return {
				created : appCtx.sysdate(),
				orgId : appCtx.orgId,
				orgName : appCtx.orgName,
				postnId : appCtx.postnId,
				postnName : appCtx.postnName
			};
		},
		onLoadSuccess:function(data){
			//调用图片展示组件
			$('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
		}
	});
	function imageFormatter(val,row,index)
	{   
		var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
		var imgUrl_B = "\" /></a></div>";
		if(val)
		{
			return imgUrl_A +row.imagePath +imgUrl_B;
		} 
		return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
	}
	
	/**
	 * 图片上传
	 */
	$(".fileImg").change(function(){
		var row = $policyDatagrid.datagrid('getSelected');
		if(row == null || row.id == null){
			$.messager.alert("没有选中任何行信息！");
			return;
		};
		$('#entityId').val(row.id);
		var options = {
   			url:'${AppContext.ctxPath}/action/portal/policy/uploadImg',
   			type:'post',
   			dataType:'json',
   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
   			success : function(data) {
   					if(data.success){
   						$policyDatagrid.datagrid('reload');
   				  	}
   			}
   		};
   		$('#pcyImgForm').ajaxSubmit(options);
	});
	
	
	/* --------------------向导式操作：开始------------------------------ */
	var $guideWin = $("#guideWin");
	var $guideWinFram = $("#guideWinFram");
	/**
	 * 新建政策
	 */
	function guideNewPcy() {
		$.post('${AppContext.ctxPath}/action/portal/policy/preDefaultValue',{},function(data){
			if (data.success) {
				var policy = data.result;
				policy.row_status = 'NEW';
				policy.created = appCtx.sysdate();
				policy.orgId = appCtx.orgId;
				policy.orgName = appCtx.orgName;
				policy.postnId = appCtx.postnId;
				policy.postnName = appCtx.postnName;
				checkPolicy(policy);
				openGuide(policy);
			} else {
				$.messager.alert("错误", data.result, "error");
			}
		});
	}
	
	/**
	 * 修改政策
	 */
	function guideUpdatePcy() {
		var row = $policyDatagrid.datagrid("getSelected");
		if(!row){
			$.messager.alert("错误", "请选中一行。");
		}
		$.post('${AppContext.ctxPath}/action/portal/policy/getPolicyById',{
			id : row.id
		},function(data){
			if (data.success) {
				var policy = data.result;
				policy.row_status = 'UPDATE';
				checkPolicy(policy);
				openGuide(policy);
			} else {
				$.messager.alert("错误", data.result, "error");
			}
		});
	}
	
	/**
	 * 打开向导式新建政策的窗口
	 */
	function openGuide(policy) {
		$guideWinFram.wholePolicy = policy;
		$guideWinFram.attr("src", "${AppContext.ctxPath}/portal/policy/guide/pcyStep1.jsp");
		$guideWin.css("display", "block");
	}
	/**
	* 关闭向导式窗口,参数为CANCEL时仅关闭窗口，为CMPL则关闭窗口同时刷新列表
	* @param operate 操作类型(CANCEL/CMPL)
	*/
	function closeGuide(operate){
		delete $guideWinFram.wholePolicy;
		$guideWinFram.attr("src", "");
		$guideWin.css("display", "none");
		if('CANCEL' == operate){//取消向导操作
			//nothing
		}
		else if('CMPL' == operate){//完成向导操作
			$policyDatagrid.datagrid("reload");
		}
	}
	
	/**
	 * 修改对象的默认值
	 */
	function checkPolicy(policy) {
		var obj = policy;
		initPcyArray(policy,['ruleList', 'scpAccList', 'scpOrgList', 'scpRgnList']);
		if(!obj.ruleList){
			obj.ruleList = [];
		}
		delPcyAttr(obj);
		//政策规则--遍历
		for (var i = 0; i < obj.ruleList.length; i++) {
			var ruleRow = obj.ruleList[i];
			initPcyArray(ruleRow,['conditionList', 'resultList']);
			delPcyAttr(ruleRow);
			loopPcyArray(ruleRow.conditionList);
			loopPcyArray(ruleRow.resultList);
		}
		loopPcyArray(obj.scpAccList);
		loopPcyArray(obj.scpOrgList);
		loopPcyArray(obj.scpRgnList);
		for (var i = 0; i < obj.scpAccList.length; i++) {
			var acctObj = obj.scpAccList[i];
			if(acctObj.accntType){
				if(acctObj.accntName){
					acctObj.accntName = '类型：['+getLovShowName('ACCT_TYPE',acctObj.accntType)+']；' + acctObj.accntName;
				}
				else {
					acctObj.accntName = '类型：['+getLovShowName('ACCT_TYPE',acctObj.accntType)+']';
				}
			}
			
		}
	}
	/**
	 * 遍历对象，如果为空则初始化为'[]'
	 */
	function initPcyArray(object,strArray){
		var obj = object;
		if(!obj){
			return;
		}
		for (var i = 0; i < strArray.length; i++) {
			if(!obj[strArray[i]]){
				obj[strArray[i]] = [];
			}
		}
	}
	/**
	 * 遍历对象，并删除其冗余属性
	 */
	function loopPcyArray(array){
		var arrayObj = array;
		if(!arrayObj){
			return;
		}
		for (var i = 0; i < arrayObj.length; i++) {
			delPcyAttr(arrayObj[i]);
		}
	}
	/**
	 * 删除对象的冗余属性
	 */
	function delPcyAttr(object){
		var obj = object;
		if(!obj){
			return;
		}
		delete obj.startRow;
		delete obj.endRow;
	}
	/* --------------------向导式操作：结束------------------------------ */
	</script>
</body>
</html>