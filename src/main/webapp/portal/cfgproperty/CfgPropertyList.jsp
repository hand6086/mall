<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/portal/header.jsp" %>

</head>
<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" title="" border="false" fit="true">
<table id="cfg-table" width="100%" height="100%"  rownumbers="true" pagination="true">
<thead>
<tr>
<th field="id" hidden="true"></th>
<th field="propName" width="150px" editor="{type:'validatebox',options:{required:true}}">参数名称</th>
<th field="key" width="150px" editor="{type:'validatebox',options:{required:true}}">参数键</th>
<th field="value" width="150px" editor="{type:'validatebox',options:{required:true}}">参数值</th>
<th field="type" width="150px" editor="{type:'checkbox',options:{on:'Y', off:'N'}}" align="center">公共参数</th>
<th field="isReadOnly" width="150px" editor="{type:'checkbox',options:{on:'Y', off:'N'}}" align="center">只读</th>
<th field="comments" width="300px" editor="{type:'textarea'}" readOnlyCol="readOnlyCol">参数说明</th>
<th field="corpid" width="150px">公司账套</th>
</tr>
</thead>
</table>
</div>
</body>
<script type="text/javascript">
var $datagrid = $("#cfg-table");

$datagrid.hdatagrid({
	updateable:true,
	toolbarShow:true,
	buttonSearch:true,
	selectFirstRow:false,
	buttonNew:true,
	buttonDelete:true,
	striped : true,
	border : false,
	pagination : true,
	pageSize : 20,//每页显示的记录条数，默认为20 
	pageList : [ 20, 30, 50 ],//可以设置每页记录条数的列表
	url : '${AppContext.ctxPath}/action/portal/cfgProperty/queryByExamplePage',
	
	onAddMoreButton: function(that, addButtonFun){
		addButtonFun(90,'<a href="javascript:void(0)" id="btn_reply" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="loadCfg()">立即生效</a>',that);
	},
	
	buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/cfgProperty/batchUpdate",
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
					onInsertOrUpdateAction:function(row, successFunc, errorFunc, that){
		$.post("${AppContext.ctxPath}/action/portal/cfgProperty/upsert", row, function(data){
			if(data){
				if(data.success){
					successFunc(that, data);
				}else{
					errorFunc(data.result, that);
				}
			}
		});
	},
	onDeleteAction:function(row, successFunc, errorFunc, that){
		if(row.isReadOnly == 'Y'){
			$.messager.alert("操作提示", "该记录只读，不能删除!", "warning");
			return;
		}
		$.messager.confirm("操作提示", '是否确定删除信息？', function(confirm) {
			if(confirm){
				$.post("${AppContext.ctxPath}/action/portal/cfgProperty/deleteById", {id: row.id}, function(data){
					if(data){
						if(data.success){
							successFunc(that);
						}else{
							errorFunc(data.result, that);
						}
					}
				});
			}
		});
	},
	readOnlyCondition: function(row, that){//行不可编辑判断，true为只读
		if(row.isReadOnly == 'Y'){
    		return true;
    	}else{
    		return false;
    	}
	}
});

function checkboxFormatter(val, row, index){
	if(val == 'Y'){
		return "<input type='checkbox' checked='true' onclick='return false'></>";
	}
	return "<input type='checkbox' onclick='return false' />";;
}
function readOnlyCol(val, row, index){ //当行列（单元格）可否编辑判断；true为只读
	if(val){
		// return true;
	}else{
		//return false;
	}
}
function loadCfg(){
	$.post("${AppContext.ctxPath}/action/portal/cfgProperty/loadCfg", {}, function(data){
		if(data){
			if(data.success){
				$.messager.alert("操作提示", "刷新配置成功！", "info");
			}else{
				$.messager.alert("错误", data.result, "error");
			}
		}
		else{
			$.messager.alert("错误", "操作出错", "error");
		}
	});
}
</script>
</html>