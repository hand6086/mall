<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />

<%@ include file="/portal/header.jsp" %>
<body>
   	<tr>                                                             
             <td class="left">省:</td>   
             <td><input name="province"  id="province" style="width: 174px;" ></td>         
             <td class="left">市:</td>                    
             <td><input   name="city" id="city" style="width: 174px;"></td>                                             
             <td class="left">县区:</td>   
             <td><input name="district"  id="district" style="width: 174px;" ></td>
        </tr>
        <span>完整地址：</span><input name="allAddress"  id="allAddress" style="width: 300px;" >

	<a href="javascript:void(0)" id="btn_examine_item" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="goBack()">我跳</a>
<script type="text/javascript">
//下拉框选择控件，下拉框的内容是动态查询数据库信息
var result = '';//完整地址结果
$.post('${AppContext.ctxPath}/action/portal/address/provinceList',{
},function(data){
 	$('#province').combobox({ 
		 		data : data,
				valueField:'id',
				textField:'addrName',
			    editable:false, //不可编辑状态
			    cache: false,
			    
			    onSelect: function(){

				    $("#city").combobox("setValue",'');
				    $("#district").combobox("setValue",'');
				    $("#allAddress").val('');
				    result = '';//清空完整地址结果
					var province = $('#province').combobox('getValue');		
					if(province!=''){
					$.ajax({
						type: "POST",
						url: "${AppContext.ctxPath}/action/portal/address/childList?id="+province,
						cache: false,
						dataType : "json",
						success: function(data){
						$("#city").combobox("loadData",data);
				                               }
			                               }); 	
		                           }
		                     } 
		                 }); 
	
	$('#city').combobox({ 

	    editable:false, //不可编辑状态
	    cache: false,
	    //panelHeight: 'auto',//自动高度适合
	    valueField:'id',   
	    textField:'addrName',
	    onSelect: function(){
	    	$("#allAddress").val('');
	    	result = '';//清空完整地址结果
		    $("#district").combobox("setValue",'');
			var city = $('#city').combobox('getValue');		
			if(city!=''){
			$.ajax({
				type: "POST",
				url: "${AppContext.ctxPath}/action/portal/address/childList?id="+city,
				cache: false,
				dataType : "json",
				success: function(data){
				$("#district").combobox("loadData",data);
		                               }
	                               }); 	
                           }
                     }
	   });  
	$('#district').combobox({ 
	    editable:false, //不可编辑状态
	    cache: false,
	   // panelHeight: 'auto',//自动高度适合
	    valueField:'id',   
	    textField:'addrName',
	    onSelect: function(){
	    	result = '';//清空完整地址结果
         	result = $('#province').combobox('getText')+$('#city').combobox('getText')+$('#district').combobox('getText');
		    $("#allAddress").val(result);	
                     }
	 });
   
});






function goBack(){
	window.location.href='${AppContext.ctxPath}/portal/address/AllAddress.jsp';
}
</script>

</body>
</html>