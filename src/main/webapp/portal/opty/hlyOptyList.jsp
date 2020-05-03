<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<script type="text/javascript"
	src="${AppContext.ctxPath}/partner/static/js/calculate.js?version=<%=version%>"></script>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
  	<fieldset class="x-fieldset" id="keyFilter">
		<legend class="x-fieldset-header" style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">快速筛选</span></legend>
				<div class="row keyfilter-border">
					<ul id="statusKeyfilter" data-toggle="keyfilter" data-title="商机状态" data-filter-filed="status"
data-table-Id="opty-table"></ul></div>
				<div class="row keyfilter-border">
					<ul id="rateKeyfilter" data-toggle="keyfilter" data-title="赢单率" data-filter-filed="rate"
data-table-Id="opty-table"></ul></div>
				<div class="row keyfilter-border">
					<ul id="sourceKeyfilter" data-toggle="keyfilter" data-title="商机来源" data-filter-filed="source"
data-table-Id="opty-table"></ul></div>
				<div class="row keyfilter-border">
					<ul id="salesAreaKeyfilter" data-toggle="keyfilter" data-title="销售区域" data-filter-filed="salesArea"
data-table-Id="opty-table"></ul></div>

</fieldset>

	
	<table id="opty-table" style="height:100%;width:100%" keyFilterDiv="keyFilter">
		<thead>
			<tr>
				<th field="id" width="100px" formatter="idFormatter">编号</th>
				<th field="created" width="140px" >创建时间</th>
				<%-- <th field="managerName" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'picklistbox',options:{title:'选择售前支持',
																						oauthFlag:false,
																						completeFun:managerPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/picklist/employeePickList.jsp',
																						required:true}}" >汇联易销售</th> --%>
																				
				<th field="managerOrgName" noSearch="false" defaultSearch="false"   width="100px"  >所属组别</th>
				<th field="optyName" noSearch="false" defaultSearch="false"   width="180px" editor="{type:'validatebox',options:{required:true}}"  >商机名称</th>
				<th field="optyAddr" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >所在地</th>
				<th field="accnt" noSearch="false" defaultSearch="false"   width="180px" editor="{type:'picklistbox',options:{title:'选择客户',completeFun:accntPicklistComplete,
																						tableUrl:'${AppContext.ctxPath}/portal/opty/picklist/accountPickList.jsp',
																						required:true}}" >客户名称</th>
				<th field="stage" noSearch="false" defaultSearch="false"   width="100px" lov="OPTY_STAGE" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_STAGE'),
																			editable:false,
																			required:true}}"  >商机阶段</th>
				<th field="status" noSearch="false" defaultSearch="false" lov="OPTY_STATUS" width="100px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_STATUS'),
																			editable:false,
																			required:true}}"  >商机状态</th>
				<th field="optyGrade" noSearch="false" defaultSearch="false" lov="OPTY_GRADE" width="100px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_GRADE'),
																			editable:false,
																			required:false}}" >商机等级</th>
				<th field="attr21" noSearch="false" defaultSearch="false"  width="120px" editor="{type:'numberbox',options:{precision:2,required:false}}"  >license数量预测</th>
				<th field="attr28" noSearch="false" defaultSearch="false"  width="120px" currency="CNY" editor="{type:'numberbox',options:{precision:2,required:false}}"  >license单价</th>
				<th field="attr22"  source="attr22*attr21" noSearch="false" defaultSearch="false"  width="120px" currency="CNY" >年license金额预测</th>
				
				<th field="attr26" noSearch="false" defaultSearch="false"  width="120px" currency="CNY" editor="{type:'numberbox',options:{precision:2,required:false}}"  >实施人天单价</th>
				<th field="attr27" noSearch="false" defaultSearch="false"  width="120px"  editor="{type:'numberbox',options:{precision:2,required:false}}"  >实施人天预测</th>
				<th field="amount" source="attr26 * attr27" noSearch="false" defaultSearch="false"  width="120px" currency="CNY"  >实施费用预测</th>
				
				<!-- <th field="amount" noSearch="false" defaultSearch="false"  width="120px" currency="CNY" editor="{type:'numberbox',options:{precision:2,required:false}}"  >实施费用预测</th> -->
				<th field="attr23" noSearch="false" defaultSearch="false"  width="120px" currency="CNY" editor="{type:'numberbox',options:{precision:2,required:false}}"  >客户本年需支付费用</th>
				<th field="attr24" noSearch="false" defaultSearch="false"  width="120px" currency="CNY" editor="{type:'numberbox',options:{precision:2,required:false}}"  >三年合同额预测</th>
				<th field="optyDt" noSearch="false" defaultSearch="false"  formatter="dateFormatter" width="100px" editor="{type:'datebox',options:{showSeconds:false, 
required:true}}"  >预计成单日期</th>
				<th field="rate" noSearch="false" defaultSearch="false" lov="OPTY_SUCCESS_RATE" width="100px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_SUCCESS_RATE'),
																			editable:false,
																			required:true}}" >赢单率</th>
				<th field="source" noSearch="false" defaultSearch="false" lov="OPTY_SOURCE" width="100px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_SOURCE'),
																			editable:false,
																			required:true}}" >商机来源</th>
				<th field="salesArea" noSearch="false" defaultSearch="false" lov="SALES_AREA" width="100px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('SALES_AREA'),
																			editable:false,
																			required:false}}"  >销售区域</th>
				<th field="attr03" noSearch="false" defaultSearch="false"   width="180px" editor="{type:'validatebox',options:{required:false}}"  >销售Team</th>
				<th field="salesman" noSearch="false" defaultSearch="false"   width="180px" editor="{type:'validatebox',options:{required:false}}"  >汉得销售</th>
				<th field="attr25" noSearch="false" defaultSearch="false"  width="100px" currency="CNY" editor="{type:'numberbox',options:{precision:2,required:false}}"  >预计汉得销售及Team业绩</th>
				<th field="attr04" noSearch="false" defaultSearch="false"   width="150px" editor="{type:'validatebox',options:{required:false}}">售前支持</th>
				
				<th field="managerName" width="130px" editor="{type:'picklistbox',options:{title:'选择销售人员',
															oauthFlag:false,
															completeFun:postnPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp',
															required:true}}">汇联易销售</th>		
				<th field="attr05" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >关键决策人</th>
				<th field="businessScope" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >业务范围</th>
				<th field="competitor" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >竞争对手及产品</th>
				<th field="attr06" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >简要描述</th>
				<th field="attr07" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >风险</th>
				<th field="attr08" noSearch="false" defaultSearch="false"   width="100px" lov="RISK_ASSESS" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('RISK_ASSESS'),
																			editable:false,
																			required:false}}" >风险评估</th>
				<th field="resultFactor" noSearch="false" defaultSearch="false" lov="OPTY_RESULT_FACTOR" width="100px" editor="{type:'combobox',options:{valueField:'val',
																			textField:'name',
																			method:'get',
																			data:getLovArray('OPTY_RESULT_FACTOR'),
																			editable:false,
																			required:false}}"  >赢/丢单主要原因</th>
				<th field="resultReason" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >赢/丢单说明</th>
				<th field="attr09" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >下一步计划</th>
				<th field="comments" noSearch="false" defaultSearch="false"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >备注</th>
				<th field="deadline" noSearch="false" defaultSearch="false"  formatter="dateFormatter" width="100px" editor="{type:'datebox',options:{required:false}}"  >跟进截止日期</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
	getLovOfList("[OPTY_STAGE,OPTY_STATUS,OPTY_SOURCE,OPTY_TYPE_CD,OPTY_SUCCESS_RATE,OPTY_RESULT_FACTOR,CRM_BU,OPTY_GRADE,SALES_AREA]");
	
		$datagrid = $('#opty-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : false,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/opty/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				delete row.prodList;
				if(!row.amount){
					delete row.amount;
				}
				row.attr22 = mul(row.attr21 , row.attr28);
				row.amount = mul(row.attr26 , row.attr27);
				
				$.post('${AppContext.ctxPath}/action/portal/opty/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/opty/deleteById', {
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
			},
			onChangeSelectedItem:function(row){
				//$datagrid.hdatagrid("changeParentItemAndParams",{OptyId:row.id});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName,
					managerName : appCtx.firstName,
					managerId: appCtx.userId,
					stage: 'FIRST_VIEW',
					status: 'New',
					optyGrade :'A',
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				//addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="editOptyPrice()" iconCls="icon-edit" plain="true">修订</a>',that);
				//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);
			
			},
			/**
			 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
			 */
			//readOnlyCondition: function(row, that){
			//	return false;
			//},
		});

	   	$('#statusKeyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_STATUS'});
		$('#optyGradeKeyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_GRADE'});
		$('#rateKeyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_SUCCESS_RATE'});
		$('#sourceKeyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_SOURCE'});
		$('#salesAreaKeyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/SALES_AREA'});
		$('#resultFactorKeyfilter').keyFilter({remoteData:true,filterByValue:true,remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/OPTY_RESULT_FACTOR'});

		
		
		var editFormatter = function(value,row,index){
			return value;
		}
		
		function accntPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').accntId = selectRow.id;
			return selectRow.acctName;
		}
		function preSalesSupportPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').preSalesSupportId = selectRow.id;
			return selectRow.firstName;
		}
		function managerPicklistComplete(selectRow) {
			$datagrid.hdatagrid('getCurrentRow').managerId = selectRow.id;
			return selectRow.firstName;
		}
		function decisionMakerPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').decisionMakerId = selectRow.id;
			return selectRow.firstName;
		}
		function dateFormatter(val, row, index){
			if(val){
				return val.substring(0, 10);
			}else{
				return val;
			}
		}
		function idFormatter(val, row) {
			if (val != null) {
				return "<a href='${AppContext.ctxPath}/portal/opty/hlyOptyDetail.jsp?optyId="
						+ row.id + "'>" + val + "</a>";
			} 
			//return val;
		};
		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			$datagrid.hdatagrid('getCurrentRow').managerId= selectRow.userId,
	 		$datagrid.hdatagrid('getCurrentRow').managerName = selectRow.fstName;
			//var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			//$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'fstName'}).target).textbox('setValue',selectRow.fstName);
			return selectRow.fstName;
		}
	</script>
</body>
</html>
