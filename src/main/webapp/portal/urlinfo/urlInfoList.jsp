<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" border="false" style="width:100%;" fit="true">
  
	
	<table id="urlInfo-table" style="height:100%;width:100%">
		<thead>
			<tr>
				<th field="id" width="100px" >编号</th>
				<th field="created" width="150px" >创建时间</th>
				<th field="url" noSearch="false" defaultSearch="true"   width="400px" editor="{type:'validatebox',options:{required:false}}"  >URL</th>
				<th field="name" noSearch="false" defaultSearch="false"   width="300px" editor="{type:'validatebox',options:{required:false}}"  >所属控制器</th>
				<th field="defaultAccessFlag" noSearch="false" defaultSearch="false"  width="100px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}"  >默认可访问</th>
				<th field="type" noSearch="false" defaultSearch="false"  width="100px" lov="URL_TYPE" editor="{type:'combobox',options:{
																		valueField:'val',
																		textField:'name',
																		data:getLovArray('URL_TYPE'),
																		editable:false}}"  >URL类型</th>
				<th field="insertFlag" noSearch="false" defaultSearch="false"  width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}"  >添加</th>
				<th field="delFlag" noSearch="false" defaultSearch="false"  width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}"  >删除</th>
				<th field="updateFlag" noSearch="false" defaultSearch="false"  width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}"  >修改</th>
				<th field="selectFlag" noSearch="false" defaultSearch="false"  width="60px" editor="{type:'checkbox',options:{on:'Y',off:'N'}}"  >查询</th>
				<th field="comments" noSearch="false" defaultSearch="false"   width="200px" editor="{type:'validatebox',options:{required:false}}"  >备注</th>

			</tr>
		</thead>
	</table>
	
	</div>
   	
	<script type="text/javascript">
		$datagrid = $('#urlInfo-table');
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 30,//每页显示的记录条数，默认为20 
		    pageList: [30,60,100],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : true,
			buttonDelete : true,
			buttonCopy : true,
			buttonExport : true,
			buttonImport : true,
			newDefaultValue : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/urlInfo/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : [], //当前表的子表的id，字符串列表
			buttonBatchEdit : true,//批量修改
			
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/urlInfo/batchUpdate",
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
				
				$.post('${AppContext.ctxPath}/action/portal/urlInfo/upsert', row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/urlInfo/deleteById', {
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{UrlInfoId:row.id});
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
					postnName : appCtx.postnName
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="updateCache()" iconCls="icon-reload" plain="true">更新缓存</a>',that);
				addButtonFun(90,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="updateAll()" iconCls="icon-reload" plain="true">重新扫描并更新</a>',that);
				
				//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);
			
			},
			/**
			 * 编辑一行前判断当前行是否可进行编辑, false为可编辑，改函数属性在updateable为true时有效
			 */
			//readOnlyCondition: function(row, that){
			//	return false;
			//},
		});

	   
		
		
		var editFormatter = function(value,row,index){
			return value;
		}
		
		function updateCache(){
			$.post('${AppContext.ctxPath}/action/portal/urlInfo/updateMapping', {}, function(data) {
				if (!data.success) {
					$.messager.alert("错误", data.result, "error");
				}else{
					$.messager.alert("成功", "更新成功", "info");
				}
			});
		}
		
		function updateAll(){
			$.messager.confirm("操作提示", '此操作需要几分钟时间处理，确定进行扫描更新？', function(flag) {
				if(flag){
					$datagrid.datagrid("loading_2");
					$.ajax({
						async:false,
						url: "${AppContext.ctxPath}/action/portal/urlInfo/getUrlMapping",
						type:"post",
						success: function(data){
							$.messager.alert("成功", "操作成功","info");
						},
						error: function(xhr, code, msg){
							alert(code+" "+msg);
						}
					});
					$datagrid.datagrid("reload");
					$datagrid.datagrid("loaded");
				}
			});
		}
	</script>
</body>
</html>
