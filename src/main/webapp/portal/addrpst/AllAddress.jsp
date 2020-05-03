<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>
<script src="${AppContext.ctxPath}/static/js/jquery.form.js?version=<%=version%>"></script>
<body>
   	<div class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<!-- 地址信息 -->
			<table id="allAddress-table" width="100%" height="100%" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="addrType" width="150px" lov="IS_ADDR_TYPE" editor="{type:'combobox',
																		options:{valueField:'val',
																		textField:'name',
																		method:'get',
																		data:getLovArray('IS_ADDR_TYPE'),
																		editable:false,
																		onSelect:selectAddrType,
																		required:true}}" >类型</th>		
						<th field="addrName" width="180px" defaultSearch="true" editor="text">名称</th>
						<th field="addrCode" width="120px" editor="text">编码</th>
						<th field="parentAddrId" width="100px" hidden="true">父名称ID</th>
				        <th field="parentRealName" width="150px" align="center"  editor="{type:'picklistbox',options:{title:'父名称列表',
				            initParam:parentNamePicklistParam,completeFun:parentNamePickListComplete,tableUrl:'${AppContext.ctxPath}/portal/addrpst/picklist/parentNamePickList.jsp'}}">父名称</th>
						
						<th field="parentCode" width="100px" >父编码</th>
						<th field="active" width="120px" lov="IS_EFFECTIVE" editor="{type:'combobox',
																			options:{valueField:'val',
																					textField:'name',
																					method:'get',
																					data:getLovArray('IS_EFFECTIVE'),
																					editable:false
																					}}">是否有效</th>
						
						
					</tr>
				</thead>
			</table>
		</div>
		
	</div>
   	
		
	<script type="text/javascript">
		
			$datagrid = $('#allAddress-table');
			getLovOfList("[IS_ADDR_TYPE,IS_EFFECTIVE]");
			$datagrid.hdatagrid({
					updateable:true,
					toolbarShow:true,
					buttonSearch:true,
					buttonNew:true,
					buttonDelete:true,
					buttonCopy:true,
					buttonExport:true,
					buttonImport:true,
					striped:true,
					title:'',
					border:false,
					url:'${AppContext.ctxPath}/action/portal/alladdress/queryByExamplePage',
				    onInsertAction:function(row,successFun,errFun,that){
				    	 $.post('${AppContext.ctxPath}/action/portal/alladdress/insert', 
								{
					    		    addrName     :row.addrName,
									addrType     :row.addrType,
									addrCode     :row.addrCode,
									active       :row.active,
									parentAddrId :row.parentAddrId
								},
								function(data){
							    	if (!data.success) {
										errFun(data.result,that);
									} else {
										successFun(that, data);
									}
								});
				    },
                    onUpdateAction:function(row,successFun,errFun,that){
                    	 $.post('${AppContext.ctxPath}/action/portal/alladdress/update', 
 								{
		                    		id           :row.id,
		     						addrName     :row.addrName,
		     						addrType     :row.addrType,
		     						addrCode     :row.addrCode,
		     						active       :row.active,
		     						addrType     :row.addrType,
		     						parentAddrId :row.parentAddrId
 								},
 								function(data){
 							    	if (!data.success) {
 										errFun(data.result,that);
 									} else {
 										successFun(that, data);
 									}
 								});
				    },
                    onDeleteAction:function(row,successFun,errFun,that){
                    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
        					if(data){
        						$.post('${AppContext.ctxPath}/action/portal/alladdress/deleteById', {
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
			});
			//选择类型
			function selectAddrType(selectRow){
				var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
				$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'parentRealName'}).target).picklist('clear');
			}
			
			//父名称PickList
			function parentNamePickListComplete(selectRow){
				$datagrid.hdatagrid('updateCurrentRow', {
					parentAddrId   : selectRow.id
				})
				/* //类型字段控件combobox不可编辑
			    var nindex = $datagrid.datagrid('getRowIndex');
				var cellEdit = $datagrid.datagrid('getEditor', { index: nindex, field: 'addrType' });
				$(cellEdit.target).combobox('disable'); */
				return selectRow.addrName;
			}
			
			function parentNamePicklistParam(){
				var rSelected = $datagrid.hdatagrid('getCurrentRow');
				var nIndex  = $datagrid.datagrid('getRowIndex',rSelected);
				var saddrType = "";
				var arr=$datagrid.datagrid('getEditor',{index:nIndex,field:'addrType'});
				saddrType = $(arr.target).combobox('getValue');
				if(saddrType == null || saddrType == ''){
					return {attr2:'noMatchId'};
				}else{
					
					return {attr2:saddrType};
				}
			}
			
			function allressDel(){
				var row = $datagrid.datagrid('getSelected');
				window.parent.operationconfirm($datagrid, '${AppContext.ctxPath}/action/portal/alladdress/deleteById', row.id, '是否确定删除信息？'); 
			}
			
	</script>
</body>
</html>