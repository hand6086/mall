<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<script src="${AppContext.ctxPath}/static/js/jquery.min.js"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.form.js"></script>
<style type="text/css">  
.align-center{  
    margin:0 auto;      /* 居中 这个是必须的，，其它的属性非必须 */  
    width:100%;        /* 给个宽度 顶到浏览器的两边就看不出居中效果了 */  
    text-align:center;  /* 文字等内容居中 */  
}  
</style> 
<body>
	<form id="form" method="post" enctype="multipart/form-data">
	    <input type='hidden' name='method' value='upload'/>
	    <input type='file' id='file' name='myExcel'/>
	    <input type='text' id='headId' name='headId' value =''  hidden />
    </form>
	<script type="text/javascript">
	function uploadExcel($dialog, obj, url, headId) {
		$('#headId').val(headId);
    	var options = {
   			url:url,
   			type:'post',
   			dataType:'json',
   			contentType:"application/vnd.ms-excel;charset=utf-8",
   			success : function(data) {
   					if(data.success){
   						window.parent.contentPage.window.$('#' + obj).datagrid('reload');
   				  	}
   					$dialog.dialog('close');
   			}
   		};
   		$('#form').ajaxSubmit(options);
    }
	</script>
</body>
</html>