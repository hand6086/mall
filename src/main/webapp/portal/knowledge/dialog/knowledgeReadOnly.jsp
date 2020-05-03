<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/portal/header.jsp" %>
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/partner/static/css/dmsCommon.css?version=<%=version%>">
<link rel="stylesheet" type="text/css" href="${AppContext.ctxPath}/static/bootstrap/css/bootstrap.min.css">
<title>知识库</title>
<style type="text/css">
a{text-decoration:none!important;}
/*  *{
	overflow: auto;
} */ 
p {
white-space: pre-wrap!important;
}
span {
white-space: pre-wrap!important;
}
.lh30 {
    line-height: 20px !important;
}
.collup{
	padding-left:1%;
}
.collup span{
	margin-left:10px;
	color:#999999;
}
.collup .marleft{
	margin-left:45%;
	margin-bottom:0;
}
.collup .ml{
	margin-left:5%;
}

.panel-bgColor{
	background-color:#ffffff;
}

/* **************easyui tree*************8 */

.expandedAll,
.collapsedAll{
  display: inline-block;
  width: 8px;
  height: 8px;
  vertical-align: middle;
  overflow: hidden;
} 


.collapsedAll{
  margin-left:20px;
  background: url('/static/images/spinner.png')no-repeat -8px -59px; 
}
.expandedAll {
  background: url('/static/images/spinner.png')no-repeat -8px -9px;
}


/* .tree-indent{
	width:8px;
} */
.tree-node-hover {
  background: #fff;
  color:#333;
}
.tree-node-selected {
  background: #ffe48d;
  color:#222;
}
.tree-node-hidden {
  display: none;
}

.tree-node span{
 	margin-left:3px;
}
.tree-hit {
  cursor: pointer;
  width:12px;
}

.tree-folder,.tree-folder-open {
	width:2px;
}
.tree-file {
	width:8px;
}

.tree-node-selected {
  background: #fff;
  color: #55B972;
}

.tree-title {
  font-size: 14px;
  font-family: "Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
  display: inline-block;
  text-decoration: none;
  vertical-align: top;
  white-space: nowrap;
  padding: 0 2px;
  height: 18px;
  line-height: 18px;
  font-weight:500;
  /*  border:1px solid #00f; */
}

.tree-node {
  height: 16px;
  white-space: nowrap;
  cursor: pointer;
  margin:2px;
  padding-bottom:10px;
  white-space: nowrap;
  /* border:1px solid #0f0; */
}

#knowledge-tree>li>div>.tree-expanded{
	background: url(''); 
}
#knowledge-tree>li>div>.tree-title{
	font-size: 20px;
	font-family: "Hiragino Sans GB","Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
  	display: inline-block;
  	text-decoration: none;
  	vertical-align: middle;
  	white-space: nowrap;
  	padding: 0 2px;
  	height: 24px;
  	line-height: 24px;
  	font-weight:500;
}

#knowledge-tree>li>ul>li>div>.tree-title{
	font-size: 18px;
	font-family: "Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
  	display: inline-block;
  	text-decoration: none;
  	vertical-align: middle;
  	white-space: nowrap;
  	padding: 0 2px;
  	height: 20px;
  	line-height: 20px;
  	font-weight:500;
}

#knowledge-tree>li>ul>li>ul>li>div>.tree-title{
	font-size: 16px;
	font-family: "Microsoft YaHei","\9ED1\4F53",Arial,sans-serif;
  	display: inline-block;
  	text-decoration: none;
  	vertical-align: middle;
  	white-space: nowrap;
  	padding: 0 2px;
  	height: 18px;
  	line-height: 18px;
  	font-weight:500;
}


#knowledge-tree>li>.tree-node {
  height: 36px;
  white-space: nowrap;
  cursor: pointer;
  margin-left:2px;
}
#knowledge-tree>li>ul>li>.tree-node {
  height: 45px;
  white-space: nowrap;
  cursor: pointer;
  margin-left:2px;
}
#knowledge-tree>li>ul>li>ul>li>.tree-node {
  height: 30px;
  white-space: nowrap;
  cursor: pointer;
  margin-left:2px;
}

</style>

<body>
	<div style="font-size:28px;color:#29303F;border-bottom:1px solid #DFDFE0;padding-left:9%;margin:auto 20px;margin-top:27px;margin-bottom:10px;font-weight:500;color:#333;">知识库</div>
	<div class="easyui-layout" data-options="fit:true" border="false" style="padding-bottom:90px;">
		<div data-options="region:'west',split:true" title="" border="false" style="width:300px;max-width:450px;min-width:360px;height:100%;padding:0px;margin-left:30px;margin-top:10px;padding-right:17px;">
				<div class="easyui-panel" style="height:100%;width:100%;padding:0px;border-right:1px solid #DFDFE0;" border="false" data-options="fit:true">
					<div style="margin-left:70%;position:relative;">
						<span class="expandedAll" onclick="expandedAll()"></span>
						<span class="collapsedAll" onclick="collapsedAll()"></span>
					</div>
					<ul id="knowledge-tree" style="margin-top:-20px;"></ul>
				</div>
		</div>
	<!-- <div id="bigImg" >
		<img id="popUpImg"/>
 	</div> -->
 	<div data-options="region:'center'" border="false">
 			<div class="easyui-panel" title="" border="false" fit="true">
				<div id="myTabContent" class="tab-content">
					<div class="main-t" style="height: 100%;width: 950px;margin: 20px auto;padding: 0px;">
						<div class="notifiCon">
						<div class="box-blue noticedes">
							<span class="title" id="title" style="font-size: 20px"></span>
							<!-- <span class="f12 lh30 db lite-gray" id="author"></span>
							<span class="f12 lh30 db lite-gray" id="type"></span> -->
							<div class="collup">
								<span class="f12 lh30 lite-gray" id="author"></span>
								<span class="f12 lh30 lite-gray" id="type"></span>
								<span class="f12 lh30 marleft glyphicon glyphicon-heart"  id="collectIcon" onclick="collect()"></span>
								<span class="f12 lh30 lite-gray glyphicon" id="collectNum"></span>
								<span class="f12 lh30 glyphicon glyphicon-thumbs-up" id="thumbUpIcon" style="margin-left:20px;position:re;" onclick="thumbUp()"></span>
								<span class="f12 lh30 lite-gray glyphicon"  id="thumbUpNum"></span>
							</div>
						</div>
						<div class="main clearfix">
							<div class="p10">
								<p id="contentp">
								
								</p>
							</div>	
						</div>
						<div id="attachment"></div>
						</div>
						<div class="control-box btn-submit">
<!-- 					          <a class="ui-btn ui-btn-default cancel" href="../knowledgeList.jsp">返回</a> -->
                                <!--  <span class="ui-btn ui-btn-default cancel" onclick="copyUrl()">复制地址</span> -->
                                <span id="shareUrl"></span>
					    </div>
					    <div id="value" hidden><%=request.getParameter("id")%></div>
					</div>
				</div>
			</div>
	</div>
	</div>
	
	<script type="text/javascript">
	var id = document.getElementById("value").innerText;
	var collNum=0;
	var upNum=0;
	var knowId='';
	var isColl,isUp;
	var serialNum=0;
	$datatree = $('#knowledge-tree');
	//var items = [];//消息行信息
	$(function () {
		initData();
		treeInit();
    });
	function initData(){
		$.post('${AppContext.ctxPath}/action/portal/knowledge/queryById',
				{id : id},
				function(data){
					if(data.success){
						//modalAlert(data.success);
						//modalAlert(data.result.id);
						//window.location.reload();
						isColl=data.result.isColl;//判断当前用户是否收藏
						isUp = data.result.isThumbUp;//判断当前用户是否点赞
						knowId=data.result.id;
						upNum=data.result.thumbUpNum;
						collNum=data.result.collNum
						//console.info(data);
						
						if (data.result.content == null){
							data.result.content = ''
						 }
						 if (data.result.title == null){
							 data.result.title = ''
						 }
						 if (data.result.author == null){
							 data.result.author = ''
						 }
						 if (data.result.type == null){
							 data.result.type = ''
						 }
						 if (collNum == null){
							 collNum = 0;
						 }
						 if (upNum == null){
							 upNum = 0;
						 }
						 
						 
						 if(isColl && isColl=="Y"){
							 $("#collectIcon").css("color","#ff0000");
						 }else{
							 $("#collectIcon").css("color","#999999");
						 }		
						 if(isUp && isUp=="Y"){
							 $("#thumbUpIcon").css("color","#ff0000");
						 }else{
							 $("#thumbUpIcon").css("color","#999999");
						 }						 
						var a = getLovArray('KNOWLEDGE_TYPE');
						var knowledgeType = '';
						for(var i=0;i<a.length;i++){
							if(a[i].val == data.result.type){
								knowledgeType=a[i].name;
							}
						}
						
						document.getElementById("contentp").innerHTML=data.result.content;
						document.getElementById("title").innerHTML="<a href='./knowledgeReadOnly2.jsp?id="+id+"'target='_blank'>"+data.result.title+"</a>";
						document.getElementById("author").innerHTML="作者："+data.result.author;
						document.getElementById("type").innerHTML="类型："+knowledgeType
										+ (data.result.secondaryType ? " - " + getLovShowName('KNOWLEDGE_SECONDARY_TYPE',data.result.secondaryType) : "");
						document.getElementById("collectNum").innerHTML=collNum;
						document.getElementById("thumbUpNum").innerHTML=upNum;
						getAttachments(id);
						//$("#shareUrl").text("分享地址："+window.location.href);
					}
					else{
						//modalAlert(data.result);
						$.messager.alert("错误", data.result, "error");
					}
		});
	}
	
	/**
	 * 根据记录ID获取附件信息
	 */
	function getAttachments(headId){
		$.post('${AppContext.ctxPath}/action/portal/attachment/queryByExamplePage', {
			headId : headId,
			pageFlag : false
		}, function(data) {
				if (data.success) {
					showAttachmentList(data.rows);
				} else {
					$.messager.alert("警告",data.result,"warning");
				}
		});
	}

	/**
	 * 附件数据拼接H5标签在前台页面展示
	 */
	function showAttachmentList(rows){
		if(rows != null && rows.length > 0){
			var temp = '';
			for(var i = 0; i < rows.length; i++){
				temp = temp +
						'<tr><td class="td-label">附件：&nbsp;</td><td class="td-content"><div>' +
						'<a href="###" onclick="window.open(\'' + rows[i].attachmentPath + '\')">' + rows[i].attachmentOriginal + '</a>' +
						'&nbsp;&nbsp;&nbsp;&nbsp;' +
						'</div></td></tr>';
			}
			$trs = $(temp);
			$table = $("#attachment");  
		    $table.html($trs);
		}
	}
	
	function collect(){
		if(isColl && isColl=="Y"){
			$.post("${AppContext.ctxPath}/action/portal/knowledgeColl/delete",{knowId:knowId},
					function(data){
				initData();
			});
		}else{
			$.post("${AppContext.ctxPath}/action/portal/knowledgeColl/insert",{knowId:knowId},
					function(data){
				//console.info(data);
				initData();
			});
		}
		//initData();
		//window.location.reload(false);
	}
	
	function thumbUp(){
		$.post("${AppContext.ctxPath}/action/portal/knowledgeColl/addOrDelThumbUp",{knowId:knowId},
			function(data){
				initData();
		});
	}
	//document.getElementById('contentp').innerHTML=contents;
	
	/**
		 * 初始化树形表格
		 */
		 var flag = false;
		function treeInit(){
			//知识树内容加载完成前遮盖
			$("#knowledge-tree").html("<div id='cover' style='margin-left:30%;margin-top:50%;'><img src='/static/images/loading1.gif' width='15px' height='15px'><span style='margin-left:10px;'>数据正在加载中……</span></div>");
			/* 树形表格 */
			 $datatree.tree({
			    onClick: function(node){
			    	
			    	if(node.text=="root"){
	    				return false;
	    			}
			    	
			    	var secondaryType = node.value;
			    	if(!secondaryType){
			    		if(node.title){
			    			//openShow(node.id);
			    			id=node.id;
			    			initData();
			    		}else{
			    			secondaryType = 'noMatchId';
			    		}
			    	}
			    	expandTree(node);
			    	//$(node.target).css("color","#0f0");
			    },
			    formatter:function(node){
			    	if(node.type=='KNOWLEDGE_TYPE'||node.text=="root"){
		    			if(node.text=="root"){
		    				return "";//node.text;
		    			}else{
			    			return node.serial+" "+node.text;
		    			}
			    	}else if(node.type=='KNOWLEDGE_SECONDARY_TYPE'){
			    		return node.serial+" "+node.text;
			    	}else{
			    		return node.serial+" "+node.text;
			    		//return node.text;
		    	}
			    },
			    onBeforeExpand:function(node){
			    	if("closed"==node.state){
						if(!node.children || node.children.length<=0){
							if(node.content==null){//判断是否为最底层结点,非最底层结点无内容
								$.post('${AppContext.ctxPath}/action/portal/knowledge/queryByNode',{secondaryType:node.value,serial:node.serial}, 
										function (data){
									console.info("+++++++++++++++++++++++++++++++");
										  if(data.success){
											  	if(data.list.children.length<=0){
											  		return false;
											  	}
											  	if (node&&node.children.length<=0){
											  		flag = true;
											  		$datatree.tree('append',{
											  			parent: node.target,
											  			data:data.list.children
											  		});
												}
											  	if(flag){
											  		$datatree.tree("collapse",node.target);
													$datatree.tree("expand",node.target);
													flag = false;
											  	}
											  	
										  }else{
											  return false;
										  }
								});
							}
						}
					}
			    },
			    onExpand:function(node){
			    	
			    }
			}); 
			$.post('${AppContext.ctxPath}/action/portal/knowledge/treelist',{}, function (data){
				  if(data.success){
					  var array = new Array();
					  array.push(data.list);
					  $datatree.tree('loadData', array);
						//知识树内容加载完成后清除遮盖
					  $("#knowledge-tree").find("#cover").remove();
				  }
			    });
			    
		}
	
		function expandTree(node){
			if("closed"==node.state){
				if(!node.children || node.children.length<=0){
					if(node.content==null){//判断是否为最底层结点,非最底层结点无内容
						$.post('${AppContext.ctxPath}/action/portal/knowledge/queryByNode',{secondaryType:node.value,serial:node.serial}, 
								function (data){
								  if(data.success){
									  	if (node&&node.children.length<=0){
									  		$datatree.tree('append',{
									  			parent: node.target,
									  			data:data.list.children
									  		});
									  		$datatree.tree("expand",node.target);
										}
								  }
							    });
					}
				}else{
					$datatree.tree("expand",node.target);
				}
			}else{
				$datatree.tree("collapse",node.target);
			}			    	
		}
	
		function collapsedAll(){
			var root= $datatree.tree("getRoot");
			if(root&&root.children){
				for(var i=0;i<root.children.length;i++){
					var node= root.children[i];
					$datatree.tree("collapseAll",node.target);
				}
			}			
		}
		function expandedAll(){
			var root= $datatree.tree("getRoot");
			$datatree.tree("expandAll",root.target);
		}
	
		function copyUrl()
		{	
			console.info(window.location.href);
			 window.document.clipboardswf.SetVariable('str', window.location.href)
		}
	</script>
</body>
</html>