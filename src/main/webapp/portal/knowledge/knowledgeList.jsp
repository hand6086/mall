<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css">
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

.tree-folder {
	width:3px;
}
.tree-folder-open {
	width:3px;
}
.tree-file {
	width:3px;
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
  height: 13px;
  white-space: nowrap;
  cursor: pointer;
  margin:2px;
  padding-bottom:10px;
  white-space: nowrap;
  /* border:1px solid #0f0; */
}

#knowledge-tree>li>div>.tree-expanded{
	background: url('/static/images/spinner1.png')no-repeat -8px -60px; 
 	
}
#knowledge-tree>li>div>.tree-title{
	font-size: 24px;
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
	font-size: 17px;
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
	font-size: 15px;
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

<body class="easyui-layout" data-options="fit:true" border="false">
		<div data-options="region:'east',split:true" title="" border="false" style="width:300px;height:100%;padding:0px;padding-bottom:55px;max-width:400px;min-width:250px;">
				<div style="padding-left:35%;border-bottom:1px solid #DFDFE0;margin:auto 10px;margin-top:27px;font-size:24px;font-weight:500;color:#333;">知识库</div>
				<div class="easyui-panel" style="height:100%;padding:0px;padding:30px;padding-top:0px;" border="false" data-options="fit:true" fit="true">
					<div style="margin-left:70%;position:relative;padding-top:10px;">
						<span class="expandedAll" onclick="expandedAll()"></span>
						<span class="collapsedAll" onclick="collapsedAll()"></span>
					</div>
					<ul id="knowledge-tree" style="margin-top:-20px;"></ul>
				</div>
		</div>
   	<div data-options="region:'center'" border="false">
		<table id="knowledge-table" fit="true" >
			<thead>
				<tr>
					<th field="title" width="20%" formatter="captionFormatter">标题</th>
					<th field="author" width="13%">作者</th>
					<th field="lastUpdated" width="18%">更新时间</th>
					<th field="fstName" width="15%">更新人</th>
					<th field="type" width="15%" lov="KNOWLEDGE_TYPE">一级分类</th>
					<th field="secondaryType" width="15%" lov="KNOWLEDGE_SECONDARY_TYPE">二级分类</th>
				</tr>
			</thead>
		</table>
	</div>
   	
	<script type="text/javascript">
		getLovOfList("[KNOWLEDGE_TYPE]");
		$datagrid = $('#knowledge-table');
		$datatree = $('#knowledge-tree');
		
		treeInit();
		$datagrid.hdatagrid({
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			oauthFlag:true,
			url:'${AppContext.ctxPath}/action/portal/knowledge/queryByExamplePage',
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(21,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addKnowledge()">新建</a>',that);
				addButtonFun(22,'<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editKnowledge()">编辑</a>',that);
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				 $.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/knowledge/deleteById', {
								id : row.id
						}, function(data) {
								if (!data.success) {
									errFun(data.result,that);
								} else {
									successFun(that, data);
								}
						});
					}
				});		 
			}
		});
		
		$('#typeKeyfilter').keyFilter({
			remoteData:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/KNOWLEDGE_TYPE'
		});
		function addKnowledge(){

			//gotoContentPage('${AppContext.ctxPath}/portal/knowledge/knowledgeEdit.jsp?id=noMatchId');
			window.open('${AppContext.ctxPath}/portal/knowledge/knowledgeEdit.jsp?id=noMatchId');

		}
		function editKnowledge(){
			var row = $datagrid.datagrid("getSelected");

			//gotoContentPage('${AppContext.ctxPath}/portal/knowledge/knowledgeEdit.jsp?id='+ row.id);
			//window.location.href='${AppContext.ctxPath}/portal/knowledge/knowledgeEdit.jsp?id='+ row.id;
			window.open('${AppContext.ctxPath}/portal/knowledge/knowledgeEdit.jsp?id='+ row.id);
		}
		
		function captionFormatter(val,row){
		     if(val != null){
		     	return "<a href='###' onclick='window.open(\"${AppContext.ctxPath}/portal/knowledge/dialog/knowledgeReadOnly.jsp?id=" + row.id +"&openOrgin=true\")'>" + val + "</a>";
		     }
		}
		function contentFormatter(val,row){
		     if(val != null){
		     	return "<div style='height:20px;'>" + val + "</div>";
		     }
		}
		
		var array =[];
		/**
		 * 初始化树形表格
		 */
		 var flag = false;
		function treeInit(){
			//知识树内容加载完成前遮盖
			$("#knowledge-tree").html("<div id='cover' style='margin-left:30%;margin-top:80%;'><img src='/static/images/loading1.gif' width='15px' height='15px'><span style='margin-left:10px;'>数据正在加载中……</span></div>");
			/* 树形表格 */
			 $datatree.tree({
			    onClick: function(node){
			    	var secondaryType = node.value;
			    	if(!secondaryType){
			    		if(node.title){
			    			openShow(node.id);//弹出显示页面内容
			    		}else{
			    			secondaryType = 'noMatchId';
			    		}
			    	}
			    	expandTree(node);
			    	$datagrid.hdatagrid("changeParentItemAndParams",{secondaryType:secondaryType});
			    },
			    onBeforeExpand:function(node){
			    	if("closed"==node.state){
						if(!node.children || node.children.length<=0){
							if(node.content==null){//判断是否为最底层结点,非最底层结点无内容
								$.post('${AppContext.ctxPath}/action/portal/knowledge/queryByNode',{secondaryType:node.value,serial:node.serial}, 
										function (data){
									//console.info("+++++++++++++++++++++++++++++++");
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
			    formatter:function(node){
			    	if(node.type=='KNOWLEDGE_TYPE'||node.text=="root"){
		    			if(node.text=="root"){
		    				return "";//node.text;
		    			}else{
			    			return node.serial+node.text;
		    			}
			    	}else if(node.type=='KNOWLEDGE_SECONDARY_TYPE'){
			    		return node.serial+node.text;
			    	}else{
			    		return node.serial+node.text;
			    		//return node.text;
		    	}
			    }
			}); 
			
			$.post('${AppContext.ctxPath}/action/portal/knowledge/treelist',{}, function (data){
				  if(data.success){
					  array = new Array();
					  array.push(data.list);
					  $datatree.tree('loadData', array);
					  //知识树内容加载完成后清除遮盖
					  //$(".tree-hit.tree-expanded").remove();
					  $("#knowledge-tree").find("#cover").remove();
				  }
			    });
			    
		}
		//新窗口打开
		 function openShow(id){
			if(!id){
				var row = $datagrid.datagrid('getSelected');
				id=row.id;
			}
			window.open("./dialog/knowledgeReadOnly.jsp?id="+id);
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
		
		 function expandTree(node){
				if("closed"==node.state){
					if(!node.children || node.children.length<=0){
						if(node.content==null){//判断是否为最底层结点,非最底层结点无内容
							$.post('${AppContext.ctxPath}/action/portal/knowledge/queryByNode',{secondaryType:node.value,serial:node.serial}, 
									function (data){
									  if(data.success){
										  console.info("+++++++++++++++++++++++++++++expandTree");
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
		
	</script>
</body>
</html>