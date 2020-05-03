<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%
	String version = "2.9.21" + application.getAttribute("contextInitTimeStamp");//版本号
%>
<html>
<head>
</head>
 <meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
 <script type="text/javascript" src="../../static/js/jquery.min.js?version=<%=version%>"></script>
 <script type="text/javascript" src="../../static/js/jquery.form.js?version=<%=version%>"></script>
 <script type="text/javascript" src="../../static/js/jquery-validate.js?version=<%=version%>"></script>  
 <script type="text/javascript" src="../../static/dist/js/wangEditor.js?version=<%=version%>"></script>
 <link rel="stylesheet" type="text/css" href="../../static/dist/css/wangEditor.min.css?version=<%=version%>">
 <style type="text/css">
    #editor-trigger {
           height: 400px;
           /*max-height: 500px;*/
    }
    .container {
           position: relative;
    } 
    
	.mainform {
		width: 800px;
		margin-left:auto;
 		margin-right:auto;
		/* margin: 30px auto; */
	}
	.lastform {
		width: 800px;
		margin-left:auto;
 		margin-right:auto;
	}
	.formrow{
		margin-left:auto;
 		margin-right:auto;
		width:90%;
		margin-top:5px;
		margin-bottom:5px;
		display: table;
	}
	.formeditor{
		margin-left:auto;
 		margin-right:auto;
		width:90%;
	 	/* margin-top:5px; */
		/* margin-bottom:5px; */
		display: table;
	}
	.new-main-topbar{
		margin-left:auto;
 		margin-right:auto;
		width:90%;
	/* 	background-color:#D3E7F9; */
		height:30px;
	}
	.emailhead{
		margin-left:auto;
 		margin-right:auto;
		width:90%;
		background-color:#E3E8ED;
		display: table;
	}
	.emailbottom{
		margin-left:auto;
 		margin-right:auto;
		width:90%;
		background-color:#E3E8ED;
		display: table;
	}
	.emailAttach{
		margin-left:auto;
 		margin-right:auto;
		width:720px;
		background-color:#E3E8ED;
		display: table;
	}
	.mr_6 {
		margin-left: 5px;
	    margin-right: 10px;
	}
	.icoBtn{
	    display: inline-block;
	    height: 30px;
	    width: 120px;
	    padding: 0;
	    font-size: 14px;
	    vertical-align: middle;
	    overflow: hidden;
	    zoom: 1;
	    cursor: pointer;
	    margin-top:5px;
		margin-bottom:5px;
		background-color:#AADFFD; 
		border-color: #78C3F3;
	}
	.file {
	    position: relative;
	    display: inline-block;
	    background: #D0EEFF;
	    border: 1px solid #99D3F5;
	    border-radius: 4px;
	    padding: 4px 12px;
	    overflow: hidden;
	    color: #1E88C7;
	    text-decoration: none;
	    text-indent: 0;
	    line-height: 20px; 
	}
	.file input {
	    position: absolute; 
	    font-size: 100px;
	    right: 0;
	    top: 0;
	    opacity: 0;
	}
	.file:hover {
	    background: #AADFFD;
	    border-color: #78C3F3;
	    color: #004974;
	    text-decoration: none;
	}
   </style>
   
<body>
    	<div id="p2" border="false" style="width:80%;height:100%;padding:0px;">
		    <form class="mainform" id="form" method="post" enctype="multipart/form-data">
		   		 <table id="editorTable" border="0">
			    	<div>
				    	<div class="emailhead">
				    		<div class="formrow">
								<span style="float:left;text-align:right;width:12%;">发送人&nbsp;&nbsp;</span>
								<input type="text" id="emailSendAddr" name="emailSendAddr" 
									   		 value="linkcrm@sina.com"
									   		 style="width:87%;margin-bottom:10px;border-width:1px;"/>
							</div>
							
							<div class="formrow">
								<span style="float:left;text-align:right;width:12%;">收件人&nbsp;&nbsp;</span>
								<input type="text" id="emailReceiveAddr" name="emailReceiveAddr" 
											value="18288748779@139.com" style="width:87%;margin-bottom:10px;border-width:1px;"/>
							</div>
							
							<div class="formrow">
								<span style="float:left;text-align:right;width:12%;">抄送人&nbsp;&nbsp;</span>
								<input type="text" id="emailCcAddr" name="emailCcAddr" 
											 style="width:87%;margin-bottom:10px;border-width:1px;"/>
							</div>
							
							<div class="formrow">
								<span style="float:left;text-align:right;width:12%;">密送人&nbsp;&nbsp;</span>
								<input type="text" id="emailBCcAddr" name="emailBCcAddr" 
											 style="width:87%;margin-bottom:10px;border-width:1px;"/>
							</div>
					        <div class="formrow" id="emailBody">
								<span style="float:left;text-align:right;width:12%;">主题&nbsp;&nbsp;</span>
								<input type="text" id="emailTitle" name="emailTitle" data-options="required:true" style="width:87%;margin-bottom:10px;border-width:1px;"/>
					    		<input type="text" id="emailMsg" name="emailMsg" style="display:none;"/>
						    </div>
				    	</div>
			    	</div>
					
			    	<div class="formeditor" id="editor-container">
				        <div id="editor-trigger">
				        </div>
					</div>
	            </table>
			</form>
			
			<form class="lastform" id="filesForm" method="post" enctype="multipart/form-data">
				 <table id="editorTable" border="0">
			    	<div class ="emailbottom">
		    			<a href="javascript:;" class="file" style="margin-top:5px;margin-left:10px">添加附件
		   					<input id="FileUpload" type="file"  name='myfiles' onchange="FileUpload_onselect(this)">
						</a>
		    			<a href="javascript:;" class="file" style="margin-top:2px;margin-left:520px">发送邮件
	   						<input class="file" type="submit" style="float:right;width:70px" onclick="sendEmail()">
						</a>
			    	</div>
			     </table>
            </form>
            
            <div id="filesList">
	            <!--<div class="emailbottom">
	            	  <a href="javascript:void(0)" style="color:blue" onclick="download()">添加附件(19k)</a>&nbsp;&nbsp;&nbsp; 
	            	 <a href="javascript:void(0)" style="color:blue" >删除</a> 
	         	</div> -->
	         	
	         	<div class="emailbottom">
		         	<!-- <a href="javascript:void(0)" style="text-decoration:none;color:#2D9DE0;cursor:pointer;margin-left:5px;" value='AA.jpg' onclick="download()">AA.jpg(19k)</a>&nbsp;&nbsp;&nbsp; 
				 	<a href="javascript:void(0)" style="text-decoration:none;color:#2D9DE0;cursor:pointer;" onclick="delFile()">删除</a>  -->
		 			<!-- <span style="text-decoration:none;color:#2D9DE0;cursor:pointer;margin-left:10px;" id="" title="AA.jpg">AA.jpg</span>&nbsp;&nbsp;
		 			<span style="color:gray">(9K)</span>
		 			<a style="text-decoration:none;color:#2D9DE0;cursor:pointer;margin-left:10px;" id=""  href="javascript:void(0)" onclick="delFile()">删除</a> -->
			 	</div>
		    </div>
		</div>
	
	<script type="text/javascript">
    	/*******富文本编辑器******/
        var editor = new wangEditor('editor-trigger');
        editor.config.menus = [
                               'fontfamily',
						       'fontsize',
						       'head',
						       'bold',
                               'underline',
                               'italic',
                               'forecolor',
                               'bgcolor',
						       '|', 
						        'unorderlist',
						        'orderlist',
						        'alignleft',
						        'aligncenter',
						        'alignright',
						        '|',
						        'link',
						        'unlink',
						        'table',
						      //'emotion',
						      //'|',
						        'img',
						      //'video',
						      //'location',
						      //'insertcode',
						        '|',
						        'eraser',
						        'undo',
						      //'redo',
						        'fullscreen',
						        '|',           // '|' 是菜单组的分割线
						        'source'
                            ];
        
        // 使用英语
        //editor.config.lang = wangEditor.langs['en'];
        
        // 取消粘贴过来
        // editor.config.pasteFilter = false;

        // 设置 z-index
        // editor.config.zindex = 20000;
        
        // 取消过滤js
        // editor.config.jsFilter = false;
         
        // 关闭菜单栏fixed
    	   editor.config.menuFixed = false;
        
       
		//上传图片
		editor.config.uploadImgUrl = '/upload';
		editor.config.uploadParams = {
			/* token1 : 'abcde',
			user : '12345' */
		};
		editor.config.uploadHeaders = {
			'Accept' : 'text/x-json'
		}
		//editor.config.uploadImgFileName = 'myFileName';
		
		// 隐藏网络图片
		editor.config.hideLinkImg = true;

		// 表情显示项
		//editor.config.emotionsShow = 'value';
		
		editor.config.emotions = {
			'default' : {
				title : '默认',
				data : './emotions.data'
			},
			'weibo' : {
				title : '微博表情',
				data : [
						{
							icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/7a/shenshou_thumb.gif',
							value : '[草泥马]'
						},
						{
							icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/60/horse2_thumb.gif',
							value : '[神马]'
						},
						{
							icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/bc/fuyun_thumb.gif',
							value : '[浮云]'
						},
						{
							icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/c9/geili_thumb.gif',
							value : '[给力]'
						},
						{
							icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/f2/wg_thumb.gif',
							value : '[围观]'
						},
						{
							icon : 'http://img.t.sinajs.cn/t35/style/images/common/face/ext/normal/70/vw_thumb.gif',
							value : '[威武]'
						} ]
			}
		};

		// onchange 事件
		editor.onchange = function() {
			console.log(this.$txt.html());
		};
		editor.create();
		/***************************************/

		//上传邮件附件
		var filesForm = $("#filesForm");
		function FileUpload_onselect(attach) {
			var obj = checkEmailAtt(attach);
			if(obj == null){
				return;
			}else{
				var options = {
					url : '${AppContext.ctxPath}/action/portal/emailInfo/uploadEmailAtt',
					type : 'post',
					dataType : 'json',
					success : function(data) {
						if (data.success) {
							var newFileName = data.imgFileName;
							var extName = obj.extName;
							var fileName = obj.fileName;
							var fileSize = obj.fileSize;
								//显示上传附件的信息
								/* 
								$("#filesList").append('<div class="emailbottom"><a href="javascript:void(0)" name="filesName"' 
										+'style="text-decoration:none;color:#2D9DE0;cursor:pointer;margin-left:5px;" value='+fileName+' onclick="download()">'+fileName+'('+fileSize+')</a>&nbsp;&nbsp;&nbsp;' 
									 +'<a href="javascript:void(0)" style="text-decoration:none;color:#2D9DE0;cursor:pointer;"onclick="delFile()">删除</a></div>');
								 */
								//form中添加隐藏的附件信息
								//$("#emailBody").append('<input type="text" name="filesName"  value='+fileName+' style="display:none;"/>');
								newExtNameArr = newFileName.split('.');
								var fileNamePart1;
								fileNamePart1 = newExtNameArr[0];
								$("#filesList").append(
												'<div id="'+fileNamePart1+'" class="emailAttach"><a href="${AppContext.ctxPath}/action/portal/emailInfo/downloadEmailAtt/'+newFileName+'?extName='+extName+'" name="filesName" '
												+'style="text-decoration:none;color:#2D9DE0;cursor:pointer;margin-left:10px;" title="'+newFileName+'" >'
														+ fileName
														+ '</a>&nbsp;&nbsp;'
														+ '<span style="color:gray">('
														+ fileSize
														+ ')</span>'
														+ '<a style="text-decoration:none;color:#2D9DE0;cursor:pointer;margin-left:10px;" href="javascript:void(0)" title="'+ newFileName+'"'
														+'onclick="delFile(this)">删除</a></div>');
								window.parent.operationtip("附件添加成功！","info"); 
								//alert("附件添加成功！");
						} else {
							alert("附件添加失败！");
						}
					}
				};
				filesForm.ajaxSubmit(options);
			}
		}

		//提交邮件表单
		var form = $("#form");
		function sendEmail() {
			if(!checkEmailSend()){
				return;
			}
			
			// 获取邮件内嵌的所有图片
			var index = 1;
	        var imgArr = [];
		    var imgs = editor.$txt.find('img').each(function(){
		    	var imgSrc = $(this).attr("src");
		    	imgArr.push(imgSrc);
		    	$(this).attr("src","cid:a0000000"+index);
		    	index++;
		    }); 
		    var imgStr = imgArr.join("|");
		    
		    var html = editor.$txt.html();
			$("#emailMsg").val(html);
			
			//获取上传附件的文件名,添加到form表单
			var filesNameArr = [];
			$("a[name='filesName']").each(function() {
				filesNameArr.push($(this).attr("title"));
			})
			var filesNameStr = filesNameArr.join("|");
			var options = {
				url : '${AppContext.ctxPath}/action/portal/emailInfo/sendEmail',
				type : 'post',
				data : formatRequest({
					emailAtt : filesNameStr,
					innerImgSrc : imgStr
				}),
				dataType : 'json',
				success : function(data) {
					if (data.success) {
						alert("邮件发送成功!");
						// window.parent.operationtip("邮件发送成功！","info"); 
					} else {
						alert("邮件发送失败!");
						// window.parent.operationtip("邮件发送失败","error");
					}
				}
			};
			 form.ajaxSubmit(options);
		}

		//删除邮件附件
		function delFile($this) {
			var fileName = $this.title;
			$.ajax({
				url : '${AppContext.ctxPath}/action/portal/emailInfo/delEmailAtt',
				type : "post",
				data : {
					"fileName" : fileName
				},
				async : false,
				success : function(data) {
					if (data.success) {
						var newExtNameArr = fileName.split('.');
						var fileNamePart1 = newExtNameArr[0];
						$("#" + fileNamePart1).remove();
					} else {
						alert("邮件删除失败！");
					}
				}
			});
		}
		
	 	//下载邮件附件
		function downloadFile($this) {
			var fileName = $this.title;
			$.ajax({
				url : '${AppContext.ctxPath}/action/portal/emailInfo/downloadEmailAtt/'+fileName,
				type : "post",
				data : {
					"extName" : 'jpg'
				}
			});
		} 
	 	
	 	//校验邮件上传附件,并获取附件名、附件后缀名、附件大小(kb)
		function checkEmailAtt(attach) {
			//获取加密后文件路径
			var path = attach.value;
			//获取文件格式后缀
			var extNameArr;
			extNameArr = path.split('.');
			if(extNameArr.length <= 1){
				alert("上传文件不完整,请检查数据合法性!");
				return null;
			}
			var extName;
			extName = extNameArr[extNameArr.length - 1];
			//获取文件名	
			var pathArr;
			pathArr = path.split('\\');
			var fileName = pathArr[pathArr.length - 1];
			
			//获取文件大小
			if (attach.files && attach.files[0]) {
				var fileSize = (attach.files[0].size / 1024).toFixed(2)+ "K";
		    }
			return {"fileName":fileName,"extName":extName,"fileSize":fileSize};
		}
	 	
	 	/*
	 	 * 邮件发送前对发送人、收件人、主题内容进行校验
	 	 */
		function checkEmailSend() {
			var emailSendAddr = document.getElementById("emailSendAddr");
			if(emailSendAddr.value == ""){
				alert("邮件发送人不能为空");
				return false;
			}else{
 				var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
 				var isok= reg.test(emailSendAddr.value);
				if(!isok){
					alert("邮件发送人邮件地址格式错误,请重新输入!");
					document.getElementById("emailSendAddr").val="";
					return false;
				}
			}
			var emailReceiveAddr = document.getElementById("emailReceiveAddr");
			if(emailReceiveAddr.value == ""){
				alert("邮件接受人不能为空");
				return false;
			}else{
				var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/; 
			    var isok= reg.test(emailReceiveAddr.value);
				if(!isok){
					alert("邮件接收人邮件地址格式错误,请重新输入!");
					document.getElementById("emailReceiveAddr").val="";
					return false;
				}
			}
			var emailTitle = document.getElementById("emailTitle");
			if(emailTitle.value == ""){
				alert("邮件主题不能为空");
				return false;
			}
			return true;
		}
	 	
		/**
		 * 格式化URL请求参数
		 */
		function formatRequest(data) {
			for ( var filed in data) {
				if (typeof (data[filed]) == "object") {
					data[filed] = JSON.stringify(data[filed]);
				} else if (typeof (data[filed]) == "Array") {
					data[filed] = JSON.stringify(data[filed]);
				}
			}
			return data;
		}
	</script>
</body>
</html>