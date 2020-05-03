<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<meta name="Author" contect="http://www.webqin.net">
<title>忘记密码</title>
<link rel="shortcut icon" href="images/favicon.ico" />
<link type="text/css" href="${AppContext.ctxPath}/static/css/forgetPass.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/css/common.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/icon.css?version=<%=version%>"> 
<script src="${AppContext.ctxPath}/static/js/jquery.min.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/jquery-validate.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js?version=<%=version%>"></script>
<script src="${AppContext.ctxPath}/static/js/jquery.easyui.datagrid.js?version=<%=version%>"></script>
</head>

<style type="text/css">
.widget-header{
	margin-top:0px;
	width:100%;
	padding:3px;
	font-weight:bold;
	background-color: #E0ECFF;
}
.widget-header span{
	margin-left:5px;
	font-size: 12px;
	color:#0E2D5F;
	
}
.divInput {
    width: 300px;
    position: relative;
    margin: 20px 0;
    padding: 5px 10px;
    left:10px;
  }

  .form_control {
    border: 1px #ccc solid;
  }

  input[type="text"],
  input[type="password"] {
    border: none;
    width: 100%;
  }

  .form_control.active {
    border: 1px #32BC61 solid;
    background-color: #fff;
  }

  .form_control.error {
    border: 1px #f00 solid;
    background-color: #FBF9BB;
  }

  .form_control.error input[type="text"],
  .form_control.error input[type="password"] {
    background-color: #FBF9BB;
    color: #f00;
  }

  input[type="text"]:focus,
  input[type="password"]:focus {
    border: none;
    outline: none;
  }

  .form_control .valid_message {
    color: #32BC61;
    position: absolute;
    left: 325px;
    top: 5px;
    width: 200px;
  }

  .form_control.error .valid_message {
    color: #f00;
  }

  .form_control.success .valid_message {
    background: url(${AppContext.ctxPath}/static/images/sucess.png) no-repeat;
    left: auto;
    right: 5px;
    top: 4px;
    width: 16px;
    height: 16px;
  }

  .none {
    display: none;
  }
</style>
<body>
  <div class="content">
   <div class="web-width">
     <div class="for-liucheng">
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist for-cur"></div>
      <div class="liulist"></div>
      <div class="liutextbox">
       <div class="liutext for-cur"><em>1</em><br /><strong>填写账户名</strong></div>
       <div class="liutext for-cur"><em>2</em><br /><strong>验证身份</strong></div>
       <div class="liutext for-cur"><em>3</em><br /><strong>设置新密码</strong></div>
       <div class="liutext"><em>4</em><br /><strong>完成</strong></div>
      </div>
     </div><!--for-liucheng/-->
    	<form class="form-horizontal" method="post" role="form" >
						<table width="100%">
							<tr>
								<td width="33%" style="text-align:right;">新密码:</td>
								<td>
									<div class="divInput form_control">
								     	<input class="required" type="password" id="newPassword" name="newPassword" data-tip="请输入您的新密码" data-valid="isNonEmpty||between:6-16" data-error="新密码不能为空||新密码长度6-16位">
								    </div>
								</td>
								<td width="33%"></td>
							</tr>
							<tr>
								<td width="33%" style="text-align:right;">确认密码:</td>
								<td>
									<div class="divInput form_control">
								     	<input class="required" type="password" id="confirmPassword" name="confirmPassword" data-tip="请再次输入您的新密码" data-valid="isNonEmpty||between:6-16" data-error="新密码不能为空||新密码长度6-16位">
								    </div>
								</td>
								<td width="33%"></td>
							</tr>
							
							<tr>
							    <td></td>
								<td align="center">
								<a class="easyui-linkbutton" style="margin-right:50px;width: 80px;"  onclick="formclear()">取消</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" style="margin-right:50px;width: 80px;" onclick="JavaScript:$('form').submit()">确定</a>
								</td>
							</tr>
						</table>
					</form>
   </div><!--web-width/-->
  </div><!--content/-->
  
  <script type="text/javascript">
  $(document).ready(function () {
		$('form').validate({
		    onFocus: function() {
		      this.parent().addClass('active');
		      return false;
		    },
		    onBlur: function() {
		      var $parent = this.parent();
		      var _status = parseInt(this.attr('data-status'));
		      $parent.removeClass('active');
		      if (!_status) {
		        $parent.addClass('error');
		      }
		      return false;
		    }
		  });
 	
		  $('form').on('submit', function(event) {
		    event.preventDefault();
		    var flag = $(this).validate('submitValidate'); 
			if(flag)
			{
			      $.post('${AppContext.ctxPath}/action/security/forword/resetPassword',
			      {
					newPassword:$('#newPassword').val(),
					confirmPassword:$('#confirmPassword').val()
			      },function (data){
			    	  if(!data.success){   
			    		  formclear();
			    		  $.messager.alert("错误提示", data.result,"warning");
			    	  }
			    	  else{
			    		  formclear();
			    		  window.location.href='${AppContext.ctxPath}/action/security/forword/forgetPass/step4';
			    	  }
			      }
				);
			}
		  });
  });
	function formclear() {
		$('#newPassword').val('');
		$('#confirmPassword').val('');
	}
  </script>
</body>
</html>
