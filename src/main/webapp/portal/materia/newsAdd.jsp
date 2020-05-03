<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>新增图文消息界面</title>
	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<%-- <%@ include file="/portal/header.jsp" %> --%>
	<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/weixin/css/all.css">
	<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/weixin/css/editor.css">
	<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/weixin/css/desktop_bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/partner/static/css/style.css">
	
	<script src="${AppContext.ctxPath}/static/weixin/js/jquery-1.7.1.min.js"></script>
	<script src="${AppContext.ctxPath}/static/weixin/js/bootstrap.min.js"></script>
	<script src="${AppContext.ctxPath}/static/weixin/js/ajaxfileupload.js"></script>
	<script src="${AppContext.ctxPath}/static/js/main.js"></script>
	<script src="${AppContext.ctxPath}/static/js/jquery-validate.js"></script>
	<script src="${AppContext.ctxPath}/static/js/jquery.form.js"></script>
	<script src="${AppContext.ctxPath}/static/easyui/js/jquery.easyui.min.js"></script>
	<script src="${AppContext.ctxPath}/static/easyui/js/locale/easyui-lang-zh_CN.js"></script>
	<script src="${AppContext.ctxPath}/static/js/jquery.easyui.common.js"></script>
	<script src="${AppContext.ctxPath}/static/js/jquery.easyui.multiselect.js"></script>
	<script src="${AppContext.ctxPath}/static/js/jquery.menu.js"></script>
	<script src="${AppContext.ctxPath}/static/weixin/js/ueditor/ueditor.config.js"></script>
	<script src="${AppContext.ctxPath}/static/weixin/js/ueditor/ueditor.all.js"></script>
	<script src="${AppContext.ctxPath}/partner/static/js/pager.js"></script>
	<style type="text/css">
	.layout-panel-north, .layout-panel-south {
    z-index: auto;
	}
	.modal-middle {
    min-height: 16.428571429px;
    padding: 15px;
    border-bottom: 1px solid #e5e5e5;
    color: #8d8d8d;
	}
	.qty-text {
	    display: block;
	    padding: 5px 9px;
	    height: 32px;
	    line-height: 32px;
	    text-align: left;
	    overflow: hidden;
	    white-space: nowrap;
	    text-overflow: ellipsis;
	}
	ul, ol {
    list-style-type: none;
	}
	.sel{
    border:solid 1px red;
	}
	.img_item_bd {
    margin: 0;
    border: 1px solid #e7e7eb;
    width: 117px;
	}
	.frm_checkbox_label {
    display: inline-block;
    text-align: left;
    cursor: pointer;
    margin-right: 1em;
	}
	.selected_mask {
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
	}
	.selected_mask.selected .selected_mask_inner {
    width: 118px;
    height: 118px;
    -moz-opacity: .6;
    -khtml-opacity: .6;
    opacity: .6;
    background-color: #000;
    filter: alpha(opacity=60);
	}
	.selected_mask.selected .selected_mask_icon {
    position: absolute;
    top: 0;
    //left: 0;
    background: transparent url(${AppContext.ctxPath}/static/weixin/img/icon_card_selected.png) no-repeat 0 0;
    width: 117px;
    height: 117px;
    vertical-align: middle;
    display: inline-block;
    background-position: 50% 50%;
	}
	.img-responsive {
    margin: 5px 3px;
	}
	.cover-img {
    width: 108px;
    height: 100px;
	}
	</style>
</head>
<body class="easyui-layout" data-options="fit:true" border="false">
<div data-options="region:'north',split:true" border="false"
		style="width: 100%;" fit="true">
<div id="wrap">
    <div id="sidebar">
        <div class="previewBox">
            <!-- <p style="margin:10px 14px 0 14px;"><span class="msg-date">2013-08-14</span></p>-->

            <div class="cover" onmouseout="removeCover(this);" onmouseover="showCover(this);">
                <h4 class="msg-t" style="width: 320px;" id="title2div0">
                <span class="i-title">标题</span>
                </h4>
                <img id="img2div0" src="${AppContext.ctxPath}/static/weixin/img/2.png" style="width: 320px;" />
                <ul class="abs tc sub-msg-opr" style="margin: 0px 10px; height: 160px; width: 320px;">
                    <a class="th" href="javascript:void(0)" onclick="editDiv('div0')">
                        <div style="width: 320px; height: 120px; font-size: 16px;">编辑</div>
                    </a>
                </ul>
            </div>

        </div>
        <div class="sub-add">
            <a class="block tc sub-add-btn" href="###" id="addone"> 
            <span class="vm dib sub-add-icon">增加一条</span>
            </a>
        </div>
    </div>
    <div id="main">

        <div class="msg-editer" id="div0">
            <form id="form0" method="POST" enctype="multipart/form-data" action="">
                <label class="block" for="">标题</label> 
                <input type="text" name="title" placeholder="请在这里输入标题" id="titlediv0" onchange="setTitle('div0')" class="msg-input" /> 
                <label class="block" for="">作者<em class="mp_desc">（选填）</em></label> 
                <input type="text" name="author" value="" id="author" class="msg-input" />
                
                <!--  <label class="block" for="">图文链接</label>
            	<input type="text" name="Message_URL" value="" id="url" class="msg-input"> -->
                <label class="block" for="">正文</label>

                <textarea name="content" id="myEditor"></textarea>

                <div class="none" id="url-block" style="margin-top: 14px;">

                    <label class="block" for="">原文链接<em class='mp_desc'>（选填）</em></label>
                    <input type="text" name="content_source_url" value="" id="surl" class="msg-input" /> <br />

                </div>
                
                <label class="block" for="">摘要<em class='mp_desc'>（选填，该摘要只在发送图文消息为单条时显示）</em></label> 
                <textarea rows="3" name="digest" class="msg-input"></textarea>
                
                <label class="block" for="">封面<span class="upload-tip r" id="upload-tip"><em class='mp_desc'>(大图片建议尺寸：900像素 * 500像素)</span></label>
                <div class="" style="vertical-align: bottom; margin-bottom: 10px;">
                	<button type="button" class="btn btn-default" onclick="openPictureDialog('div0')">从图片库选择</button>
                	<div id="imgdiv0"><input name="thumb_media_id" type="hidden" value="" ></div>
                    <!-- <input type="file" name="file" id="filediv0" /> 
                    <input type="button" value="上传" onclick="ajaxFileUpload('div0')" /> 
                    <img src="" id="imgdiv0" style="width: 100px; vertical-align: bottom; border: 1px solid gray" />
                    <a id="rmdiv0" href="###" onclick="removeImage('div0')" style="vertical-align: bottom;">删除</a> -->
                </div>
                
                
                <input type="checkbox" onclick="a.value=this.checked?1:0"/>封面显示在正文中
                <input name="show_cover_pic" type="hidden" id="a" value="0" >
            </form>
        </div>
    </div>

    <div style="clear: both; padding-top: 20px;">
        <div style="clear: both; text-align: center; padding-top: 20px; border-top: 1px solid #dddddd;">
            <input type="button" onclick='publishTemplate()' class="btn span2 btn-success" value="保存" /> 
            <input type="button" onclick="removeTemplate()" class="btn span2 btn-danger" value="删除" />
        </div>
    </div>
	

</div>
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" name="" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">选择图片</h4>
            </div>
           	<div class="modal-middle" >建议尺寸：900像素 * 500像素，已开启图片水印
           		<button type="button" class="btn btn-success">本地上传</button>
           	</div>
            <div class="modal-body">
            	<div class="picture-list" id="picture-list"></div>
            	
            	<div class="south-body" id="south-body">
				</div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="selectPic()">确定</button>
                <button type="button" class="btn btn-primary">取消</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!-- end -->
</div>

<script>
    var arr = [ 'div1', 'div2', 'div3', 'div4', 'div5', 'div6', 'div7' ];
    var arr2 = new Array();
    var showDiv = "div0";
    var option = {
        //initialContent : '在编辑器中默认显示的内容',//初始化编辑器的内容
        initialFrameHeight : 340
    };
    var editor = new UE.ui.Editor(option);
    editor.render("myEditor");
    editor.ready(function(){
        editor.setContent("欢迎使用UEditor！");
    })

    function removeImage(id) {
        $("#img" + id).hide();
        $("#rm" + id).hide();
    }

    function showCover(obj) {
        $(obj).addClass("sub-msg-opr-show");
    }
    function removeCover(obj) {
        $(obj).removeClass("sub-msg-opr-show");
    }

    function editDiv(obj) {
        if (showDiv != obj) {
            $("#" + showDiv).hide();
            $("#" + obj).show();
            showDiv = obj;
        }
    }

    function removeDiv(obj) {
        $("#s" + obj).remove();
        $("#" + obj).remove();
        $("#rich" + obj).remove();
        arr.push(obj);
        arr2.splice($.inArray(obj, arr2), 1);
        if (arr2.length == 0) {
            showDiv = "div0";
            $("#" + showDiv).show();
        } else {
            if (obj == showDiv) {
                showDiv = arr2.pop();
                arr2.push(showDiv);
                $("#" + showDiv).show();
            } else {
                $("#" + showDiv).show();
                showDiv = arr2.pop();
                arr2.push(showDiv);
            }
        }
    }

    function setTitle(obj) {
        $("#title2" + obj).text($("#title" + obj).val());
    }
    
    //设置封面图片
    function setCoverImg(obj){
    	var url = $("#img"+obj).children('img').attr("src");
    	$("#img2"+obj).attr('src',url);
    }

    $("#addone").click(
            function() {
                var msgDiv;
                //var msgDiv2;
                if (arr.length == 7) {
                    $("#" + showDiv).hide();
                    msgDiv = arr.pop();//表单div ID
                    arr2.push(msgDiv);
                    showDiv = msgDiv;
                } else if (arr.length == 0) {
                    alert('最多添加8个图文信息');
                    return;
                } else {
                    msgDiv = arr.pop();
                    //msgDiv2=arr2.pop();
                    $("#" + showDiv).hide();
                    //arr2.push(msgDiv2);
                    arr2.push(msgDiv);
                    showDiv = msgDiv;
                }
                $(".previewBox")
                        .append(
                        "<div class='cover' id='s"
                        + msgDiv
                        + "' style='border-top:1px solid #C6C6C6;height: 120px;' onmouseout='removeCover(this);'"
                        + " onmouseover='showCover(this);'><div> <div style='float:left;width: 250px; word-break:break-all;' id='title2"+msgDiv+"'>标题</div> <div style='float:right;'> "
                        + "<img id='img2"+msgDiv+"' src='${AppContext.ctxPath}/static/weixin/img/1.png' style='width: 80px;height: 80px;'/> </div> </div> <ul class='abs tc sub-msg-opr' style='margin-left: 0;'> <li><div style='width: 150px;"+
                        " height: 120px; font-size: 16px;'><a style='line-height:100px;' href='javascript:void(0)' onclick='editDiv(\""
                        + msgDiv
                        + "\");return false;'> 编辑</a> "
                        + "<a style='line-height:100px;' href='javascript:void(0)'"
                        + " onclick='removeDiv(\""
                        + msgDiv
                        + "\");return false;'> 删除 </a></div>  </li></ul> </div>");
                $("#main")
                        .append(
                        " <div class='msg-editer' id='"+msgDiv+"'> "
                        + "<form method='POST' enctype='multipart/form-data' action=''> <label class='block' for=''>标题</label>"
                        + " <input type='text' name='title' id='title"
                        + msgDiv
                        + "' onchange='setTitle(\""
                        + msgDiv
                        + "\")' class='msg-input'>"
                        + "<label class='block' for=''>作者<em class='mp_desc'>（选填）</em></label> <input type='text' name='author' value='' id='author' class='msg-input' />"
                        +
                            /* " <label class='block' for=''>图文链接</label>"+
                             "<input type='text' name='Message_URL' value='' id='url' class='msg-input'>"+*/
                        "<label class='block' for=''>正文</label><textarea name='content' id='rich"+msgDiv+"'></textarea>"
                        + "<div class='none' id='url-block' style='margin-top: 14px;'>"
                        + "<label class='block' for=''>原文链接<em class='mp_desc'>（选填）</em></label> <input type='text' name='content_source_urlUrl' value='' id='surl' class='msg-input' />"
                        +"<label class='block' for=''>摘要<em class='mp_desc'>（选填，该摘要只在发送图文消息为单条时显示）</em></label><textarea rows='3' name='digest' class='msg-input'></textarea>"
                        + "<label class='block' for=''>封面<span class='upload-tip r'id='upload-tip'><em class='mp_desc'>(大图片建议尺寸：900像素 * 500像素)</span></label>"
                        + "<div class='' style='vertical-align: bottom;margin-bottom: 10px;'>"
                        + "<button type='button' class='btn btn-default' onclick='openPictureDialog(\""+msgDiv+"\")'>从图片库选择</button>"
                    	+ "<div id='img"+msgDiv+"'><input name='thumb_media_id' type='hidden' value='' ></div>"
                    	+ "</div>"
                        + "<input type='checkbox' onclick='check"+msgDiv+".value=this.checked?1:0' />封面显示在正文中"
                        + "<input name='show_cover_pic' type='hidden' id='check"+msgDiv+"' value='0' >"
                        + "</form> </div>");
                editor.render("rich" + msgDiv);
            });
    function ajaxFileUpload(id) {
        var filename = $("#file" + id).val();
        var suffix;
        if (filename != "") {
            suffix = filename.substr(filename.indexOf(".") + 1,
                    filename.length);
        }
        if (filename == "") {
            alert("请选择要上传的图片");
        } else if (suffix != "jpg" && suffix != "png") {
            alert("文件格式有误！");
        } else {
            $.ajaxFileUpload({
                url : 'fileUpload', //用于文件上传的服务器端请求地址
                type: 'post',
                fileElementId : 'file' + id, //文件上传域的ID
                dataType : 'json', //返回值类型 一般设置为json
                success : function(data, status) //服务器成功响应处理函数
                {
                    alert("成功");
                },
                error : function(data, status, e)//服务器响应失败处理函数
                {
                    alert(e);
                }
            })
        }
    }
    function publishTemplate() {
    	//方法1：form表数据转json
    	/* $("form").each(function(){//循环每一个表
           var arr=$("form").serializeArray();
    	   console.log(arr);
           console.log(arrayToJson(arr));
           var o = {};
           $.each(arr, function() {    
           if (o[this.name]) {    
               if (!o[this.name].push) {    
                   o[this.name] = [o[this.name]];    
               }    
               o[this.name].push(this.value || '');    
           } else {    
               o[this.name] = this.value || '';    
           }    
          });  
          var sons = JSON.stringify(o);

          alert(sons);
    	}) */
    	
        /* if ("@ViewBag.Template.Row_ID") {
            var result = window.confirm("确定发布这条图文？");
            if (result) {
                window.location = "@PublishUrl";
            }
        } */
        
        /* 方法2：form表数据转json */
        var formArray = new Array();
        var arr0 = [ 'div1', 'div2', 'div3', 'div4', 'div5', 'div6', 'div7' ];
        var arr1 = new Array();//图文包含form的div块
        for(var i=0; i < arr0.length; i++){   
	        var flag = true;   
	        for(var j=0; j < arr.length; j++){   
	            if(arr0[i] == arr[j])   
	            flag = false;   
	        }   
	        if(flag)   
	        arr1.push(arr0[i]);   
	    } 
        var formArr = new Array();
        var formArray0 = $("#div0 form").serializeArray();
        formArr.push(arrayToJson(formArray0));
        for(var i = 0; i < arr1.length; i++){
        	formArray = $("#"+arr1[i]+" form").serializeArray();
        	formArr.push(arrayToJson(formArray));
        }
        var data = "["+formArr.toString()+"]";
        //var data = JSON.stringify(formArr);
        $.ajax({ 
            type: "post", 
            url:   "${AppContext.ctxPath}/action/portal/news/newsInsert", 
            contentType: "application/json",
            data:  data,
            dataType: "json",
            success: function(data){
            	if(data.success){
            		alert('保存成功！');
            		window.parent.quickEnter('微信管理', '图文素材', 'WECHAT_MANAGE', '${AppContext.ctxPath}/portal/materia/newsList.jsp');
            	}else{
            		alert(data.result);
            	}
            }
        });
        //alert(8-arr.length);//提交的form个数
        return
        
        var options = {
				url : '${AppContext.ctxPath}/action/portal/news/newsInsert',
				type : 'post',
				dataType :'json',
				success : function(data) {
					if(data.success){
						alert('保存成功！');
						//window.parent.operationtip('保存成功！',"info");
				  	} else {
				  		alert('保存失败！');
						//window.parent.operationtip(data.result,"error");
					}
				}
			};
		//getInputValue();
		var result = window.confirm("确定发布这条图文？");
		if (result) {
			$('#form0').ajaxSubmit(options);
        }
    }
    function removeTemplate() {
        if ("@ViewBag.Template.Row_ID") {
            var result = window.confirm("确定删除这条图文？");
            if (result) {
                window.location = "@RemoveUrl";
            }
        }
    }
    
    /*----------------------------------------加载选择封面dialog开始----------------------------------------*/
    var dialogOptions = {
			url:'${AppContext.ctxPath}/action/portal/materia/queryByExamplePage',
			pagerTagId:'south-body',
			dateTagId:'picture-list',
			pageList: [12,24,60],
			param:{filtersRaw:'[{"id":"type","property":"type","value":"image"}]'},
			onLoadSuccess:loadSuccess
	};
	$picPager=getDmsPager();
	$picPager.init(dialogOptions);
	
    function openPictureDialog(value) {
    	//alert(value)
    	$("#myModal").attr('name',value);
		$("#myModal").modal('show');
		
	}
    function loadSuccess(data){
		if (data.success) {
			initPicList(data);
			
			if($(".selected_mask.selected").length == 0){
				$(".selected_mask").click(function(){
					if($(".selected_mask.selected").length == 0){
						//console.log($(".selected_mask.selected"));
			        	$(this).addClass("selected");
					}else{
						//console.log("2"+$(".selected_mask.selected"));
						$(this).removeClass("selected");
					}
			    });
			}
		} else {
			modalAlert(data.result);
		}
	}
	
	/**
	 * 初始化图片列表信息
	 */
	function initPicList(data){
		var rows = data.rows;
		/* if(rows == null || rows.length < 1){
			modalAlert('产品行为空。');
		} */
		var picRowsHl = '<div class="row">';
		for(var i = 1; i<= rows.length; i++){
			var row = rows[i-1];
			picRowsHl += createPicCol(row);
		}
		$(".picture-list").append(picRowsHl);
	}
	
	/**
	 * 构造一个图片列信息
	 * @param 图片信息
	 */
	function createPicCol(row){
		//row = changeNullToEmptyStr(row);
		var prodColHl = '<div class="col-md-3" style="margin-top:15px;">'
				+ '<label class="frm_checkbox_label img_item_bd">'
				+ '<div class="cover-img"><img id="'+row.mediaId+'" src="' + row.url + '" alt="" class="img-responsive"></div>'
				+ '<div class="qty-text">'+row.name+'</div>'
				+ '<div class="col-md-3 selected_mask"><div class="selected_mask_inner"></div><div class="selected_mask_icon"></div></div>'
				+ '</lable></div>';
			return prodColHl;
	}
	/*----------------------------------------加载选择封面dialog结束----------------------------------------*/
	function selectPic(){
		
		var id = $('.selected_mask.selected').siblings('.cover-img').children().attr('id');//获取图片永久素材ID
		var url = $('.selected_mask.selected').siblings('.cover-img').children().attr('src');//获取图片url
		
		//点击确定后清除modal图片选中状态（重置）
		if($(".selected_mask.selected").length != 0){
			//alert('1')
			$('.selected_mask.selected').removeClass("selected");
		}
		//判断是否有图片，有则更换图片链接
		console.log($('#img'+div).children());
		var div = $("#myModal").attr('name');
		//alert(div)
		if($('#img'+div).children('img').length != 0){
			$('#img'+div).children('img').attr("src",url);
			$('#img'+div).children('input').attr("value",id);
			
		}else{
			var imgHtml= ''
			if(url != ''){
				imgHtml='<img src="' + url + '" alt="" class="img-responsive" heigth="120px" width="120px">'
						//+'<input name="thumb_media_id" type="hidden" value="' + id + '" /> ';
				$('#img'+div+' input').attr("value",id);
				$('#img'+div).append(imgHtml);
			}
		console.log(imgHtml);
		}
		//设置封面
		setCoverImg(div);
		console.log(id);
		console.log(url);
	}
	
    function arrayToJson(formArray){
      var dataArray = {};
      $.each(formArray,function(){
        if(dataArray[this.name]){
          if(!dataArray[this.name].push){
            dataArray[this.name] = [dataArray[this.name]];
          }
          dataArray[this.name].push(this.value || '');
        }else{
          dataArray[this.name] = this.value || '';
        }
      });
      return JSON.stringify(dataArray);
    }
    
    
    
</script>
</body>
</html>