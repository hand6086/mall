<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<head>
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
	<div class="widget-header">
		<span class="widget-title">修改密码</span>
	</div>
	<div class="row-fluid">
		<div class="widget-box">
			<div class="widget-body">
				<div class="widget-main">
					<form class="form-horizontal" method="post" role="form" name="changeUserPasswordForm" id="changeUserPasswordForm">
						<table>
							<tr>
								<td width="50%" style="text-align:right;">原始密码:</td>
								<td>
									<div class="divInput form_control">
								     	<input class="required" type="password" id="oldPassword" name="oldPassword" data-tip="请输入您的密码" data-valid="isNonEmpty||between:6-16" data-error="密码不能为空||密码长度6-16位">
								    </div>
								</td>
							</tr>
							<tr>
								<td width="50%" style="text-align:right;">新密码:</td>
								<td>
									<div class="divInput form_control">
								     	<input class="required" type="password" id="newPassword" name="newPassword" data-tip="请输入您的新密码" data-valid="isNonEmpty||between:6-16" data-error="新密码不能为空||新密码长度6-16位">
								    </div>
								</td>
							</tr>
							<tr>
								<td width="50%" style="text-align:right;">确认密码:</td>
								<td>
									<div class="divInput form_control">
								     	<input class="required" type="password" id="confirmPassword" name="confirmPassword" data-tip="请再次输入您的新密码" data-valid="isNonEmpty||between:6-16" data-error="新密码不能为空||新密码长度6-16位">
								    </div>
								</td>
							</tr>
							
							<%--  <tr>
								<td width="50%" style="text-align:right;">验证码:</td>
								<td>
									<div class="divInput form_control">
								     	<input class="required" type="text" id="validateCode" name="validateCode" data-tip="暂未启用,请忽略" >
								    </div>
								</td>
							</tr>
							<tr>
								<td width="50%" style="text-align:right;"></td>
								<td>
									<img alt="验证码看不清，换一张" src="${AppContext.ctxPath}/action/portal/validatecode/code" name="ssss" id="validateCodeImg" onclick="changeImg()">
									<a href="javascript:void(0)" onclick="changeImg()">看不清，换一张</a>
								</td>
							</tr>  --%>
							
							<tr>
							    <td></td>
								<td align="center">
								<a href="${AppContext.ctxPath}/action/portal/home/mainjsp" class="easyui-linkbutton" style="margin-right:50px;width: 80px;">取消</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" style="margin-right:50px;width: 80px;"  data-options="iconCls:'icon-ok'" onclick="JavaScript:$('form').submit()">确定</a>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
		
	</div>
		
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
		    var flag = $(this).validate('submitValidate'); //return boolean;
			if(flag)
			{
				$.post('${AppContext.ctxPath}/action/portal/userUtil/changePassword',
			      {
					oldPassword:$('#oldPassword').val(),
					newPassword:$('#newPassword').val(),
					confirmPassword:$('#confirmPassword').val()
			      },
			      function (data) //回传函数
			      {
			    	  if(data.success)
			    	  {
			    		  window.parent.operationtip('修改密码成功');
			    		  //window.parent.location.href = "${AppContext.ctxPath}/action/portal/user/reload";
			    		  top.location.reload();
			    	  }
			    	  else{
			    		  formclear();
			    		  window.parent.operationtip(data.result,'warning');
			    	  }
			      }
				);
			}
		  });
	})
	

function formclear() {
	$('#oldPassword').val('');
	$('#newPassword').val('');
	$('#confirmPassword').val('');

}

//刷新验证码
function changeImg() {
	  //为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
	  document.getElementById("validateCodeImg").src= '${AppContext.ctxPath}/action/security/forword/code?tamp='+(new Date()).valueOf();
};

/* function changeCode() {
    var imgSrc = $("#imgObj");
    var src = imgSrc.attr("src");
    imgSrc.attr("src", changeImgUrl(src));
}
//时间戳   
//为了使每次生成图片不一致，即不让浏览器读缓存，所以需要加上时间戳   
function changeImgUrl(url) {
    var timestamp = (new Date()).valueOf();
    url = url.substring(0, 17);
    if ((url.indexOf("&") >= 0)) {
        url = url + "×tamp=" + timestamp;
    } else {
        url = url + "?timestamp=" + timestamp;
    }
    return url;
} */
	</script>
</body>
</html>