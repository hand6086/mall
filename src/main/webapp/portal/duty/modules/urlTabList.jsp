<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<table id="urlDutyLink-table" style="height:100%;width:100%" >
		<thead>
			<tr>
<!-- 				<th field="id" width="100px" >编号</th>
				<th field="created" width="100px" >创建时间</th>
				<th field="urlId" noSearch="false" defaultSearch="false"   width="100px"  >urlId</th>
				<th field="dutyId" noSearch="false" defaultSearch="false"   width="100px"  >dutyId</th> -->
				<!-- <th field="dutyComments" noSearch="false" defaultSearch="false"   width="100px"  >职责备注</th>
				<th field="dutyName" noSearch="false" defaultSearch="false"   width="100px"  >职责</th> -->
				<th field="url" noSearch="false" defaultSearch="false"   width="300px" >url</th>
				<th field="urlComments" noSearch="false" defaultSearch="false"   width="200px" >url 备注</th>
				<th field="accessFlag" noSearch="false" defaultSearch="false"  width="100px"  editor="{type:'checkbox',options:{on:'Y',off:'N'}}">可访问</th>
				<th field="defaultAccessFlag" noSearch="false" defaultSearch="false"  width="100px"  >默认可访问</th>
				<th field="insertFlag" noSearch="false" defaultSearch="false"  width="60px"  >插入</th>
				<th field="delFlag" noSearch="false" defaultSearch="false"  width="60px" >删除</th>
				<th field="updateFlag" noSearch="false" defaultSearch="false"  width="60px"  >修改</th>
				<th field="selectFlag" noSearch="false" defaultSearch="false"  width="60px" >查询</th>
				

			</tr>
		</thead>
	</table>
   	
	<script type="text/javascript">
		$datagridUrlDutyLink = $('#urlDutyLink-table');
		$datagridUrlDutyLink.hdatagrid({
			title: "可访问URL列表",
		    pageSize: 15,//每页显示的记录条数，默认为20 
		    pageList: [15,30,50],//可以设置每页记录条数的列表 
		    updateable:true,
			toolbarShow : true,
			buttonSearch : true,
			buttonDelete : true,
			buttonExport : true,
			striped : true,
			border : false,
			url:'${AppContext.ctxPath}/action/portal/urlDutyLink/queryByExamplePage',
			
			parentGridId : 'duty-table',
		    parentGridField : 'id',
		    linkGridField : 'dutyId',
			subGridIds : [], //当前表的子表的id，字符串列表
			
			buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/urlDutyLink/batchUpdate",
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
			
			onUpdateAction:function(row,successFun,errFun,that){
				$.post('${AppContext.ctxPath}/action/portal/urlDutyLink/update', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that);
					}
				});
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/urlDutyLink/deleteById', {
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
				//$datagrid.hdatagrid("changeParentItemAndParams",{UrlDutyLinkId:row.id});
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
				addButtonFun(10,'<a href="javascript:void(0)" id="selectUrl" class="easyui-linkbutton" onClick="addURL()" iconCls="icon-add" plain="true">新建</a>',that);
				//addToolbarTag(9999, '<div iconCls="icon-detail" class="">更多菜单按钮</div>', this,true);
			
			},
		});
		
		function addURL(){
			var dutyRecord = $datagrid.hdatagrid('getSelected');
			$('#selectUrl').multiSelect({
				title:'添加链接',
				initParam:function(){
					return {attr1:dutyRecord.id};
				},
				tableUrl:'${AppContext.ctxPath}/portal/duty/dialog/urlMultiSelect.jsp',
				completeFun:function(selectedRow){
					var dutyRow = $datagrid.hdatagrid('getSelected');
					var records = [];
					for(var i =0; selectedRow != null && i<selectedRow.length;i++){
						records.push({
							urlId:selectedRow[i].id,
							dutyId:dutyRow.id
						});
					}
					$.ajax({	
							type: "POST",
				            url: "${AppContext.ctxPath}/action/portal/urlDutyLink/batchInsert",
				            data: JSON.stringify(records),
				            dataType: "json",	
				            contentType: 'application/json', 
				            success:function(data){
								if(data.success){
									$datagridUrlDutyLink.hdatagrid("reload");
								}else{
									$.messager.alert("警告",data.result);
								}
							},
							error: function(obj, code, msg){
								alert(msg);
							},
					});
				}
			});
		}
	</script>
</body>
</html>