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
				<th field="effStartDate" width="180px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">价格表有效期开始时间</th>
				<th field="effEndDate" width="180px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">价格表有效期结束时间</th>
				<th field="orgName" width="150px"  editor="{type:'picklistbox',options:{title:'选择组织',
	   			   																		     completeFun:orgPickListComplete,
	   			   																		     tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp',
		   			   																		 required:true}}">组织</th>
<!-- 				<th field="activated" width="100px" lov="ACTIVATED" editor="{type:'combobox',options:{valueField:'val',
																									textField:'name',
																									method:'get',
																									data:getLovArray('ACTIVATED'),
																									editable:false,
																									required:true}}" >是否激活</th> -->
				<th field="activated" width="100px" lov="ACTIVATED" editor="{type:'textbox',options:{disabled:true}}">是否激活</th>
				<th field="comments" width="400px"  editor="{type:'textbox'}">价格表说明</th>
				<th field="prodName" width="200px"  editor="{type:'picklistbox',options:{title:'选择产品',
	   			   																		     completeFun:prodPickListComplete,
	   			   																		     tableUrl:'${AppContext.ctxPath}/portal/picklist/ProductPickList.jsp',
		   			   																		 required:true}}">产品名称</th>
				<th field="prodCode" width="150px" editor="{type:'textbox',options:{disabled:true}}"  >产品编码</th>
				<th field="price" width="100px" currency="CNY"  editor="{type:'textbox'}">原价</th>
				<th field="promoPrice" width="100px" currency="CNY"  editor="{type:'textbox'}">促销价</th>
			    <th field="effStartDateItem" width="150px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false,required:true}}">产品有效开始时间</th>
			    <th field="effEndDateItem" width="150px" mark="DATE" editor="{type:'datetimebox',options:{showSeconds:false}}">产品有效结束时间</th>
				<th field="commentsItem" width="300px" editor="{type:'textbox'}">产品说明</th>			
			</tr>
		</thead>
	</table>
   
   </div>
   <script type="text/javascript">
   	$datagrid = $('#priceList-table');
   	getLovOfList("[ACTIVATED]");
   	
	$datagrid.hdatagrid({
		//updateable : true,
		toolbarShow:true,	//显示工具栏
		buttonSearch:true,	//搜索框功能
		buttonDelete:true,
		buttonMenu:true,
		oauthFlag:true,
		striped:true,
		title:'',
		border:false,
		url:'${AppContext.ctxPath}/action/portal/priceHeadItem/queryByExamplePage',
		onAddMoreButton:function(that,addButtonFun){
		},
		onUpdateAction:function(row,successFun,errFun,that){
			$.post('${AppContext.ctxPath}/action/portal/priceHeadItem/update',row,function(data){
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
					$.post('${AppContext.ctxPath}/action/portal/priceHeadItem/deleteById', {
							itemId : row.itemId
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

	/**
	 * 产品picklist回调事件
	 */
 	function prodPickListComplete(selectRow){
 		$datagrid.hdatagrid('getCurrentRow').prodId = selectRow.id;
 		$datagrid.hdatagrid('getCurrentRow').prodCode = selectRow.prodCode;
		var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
		$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'prodCode'}).target).textbox('setValue',selectRow.prodCode);
 		return selectRow.prodName;
 	}; 
 	//选择组织			
	function orgPickListComplete(selectRow){
		$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
 		$datagrid.hdatagrid('getCurrentRow').orgName = selectRow.text;
		var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
		$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'orgName'}).target).textbox('setValue',selectRow.text);
 		return selectRow.text;
 	}
   </script>
   
   
</body>