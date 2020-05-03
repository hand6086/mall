<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'center',split:true" title="切换职位" border="false" fit="true">
		<form method="post" class="postnForm" style="text-align:center;margin-top: 30px;" enctype="multipart/form-data" >
			职位: &nbsp;
			<input id="postnName" name="postnName" class="easyui-combobox" data-options="valueField:'id',
																	textField:'text',
																	width:'200px',
							         							  	height:'30px',
																	method:'get',
																	url:'${AppContext.ctxPath}/action/portal/position/postnOfUser',
																	editable:false,
																	onLoadSuccess: function () {
																		$(this).combobox('select', appCtx.postnId);
																	}"/><br/><br/>
			<a href="javascript:void(0)" class="easyui-linkbutton" style="margin-right:50px;width: 80px;" iconCls="icon-no" onclick="toHome()">取消</a>
			<a href="javascript:void(0)" class="easyui-linkbutton" style="width: 80px;" iconCls="icon-ok" onclick="changePostn()">确定</a>
		</form>
	
	</div>
	
	
<script type="text/javascript">
function changePostn() {
	var postnId = $('#postnName').combobox('getValue');
	if(!postnId){
		$.messager.alert('警告', '职位不能为空!');
	}
	 $.messager.confirm("操作提示", '是否确定切换职位？', function(data) {
		if(data){
			$.post('${AppContext.ctxPath}/action/portal/position/changeLoginPostn', {
					id : postnId
			}, function(data) {
					if (data.success) {
						$.messager.alert('提示', '切换成功！');
						window.parent.location.reload();
					} else {
						$.messager.alert('警告', data.result);
					}
			});
		}
	});		 
}
function toHome(){
	window.location.href = '${AppContext.ctxPath}/action/portal/home/mainjsp';
}
</script>
</body>
</html>