<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<body>
	<div id="menu_layout" class="easyui-layout" fit="true" border="false">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<table id="freght-table" style="width:100%;height:100%;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<c:if test="${UserContext.systemRole == 'super_administrator'}">
						<th field="corpName" width="80px">商户名称</th>
						</c:if>
						<th field="id" width="80px">模板ID</th>
						<th field="name" width="100px" formatter="nameFormatter" editor="{type:'textbox',options:{required:true}}">模板名称</th>
						<th field="way" width="100px" lov="BILLING_METHODS">计费方式</th>
						<th field="notes" width="200px" editor="{type:'textarea',options:{required:true}}">模板说明</th>
						<th field="commodityScope" width="120px" formatter="csFormatter">商品范围</th>
						<th field="mailArea" width="120px" formatter="maFormatter">包邮区域</th>
						<th field="noMailArea" width="120px" formatter="nmaFormatter">不包邮区域</th> 
						<th field="created" width="120px">创建时间</th>
						<th field="createdBy" width="120px">创建人</th>
						<th field="lastUpdated" width="180px">最后更新时间</th>
						<th field="lastUpdatedBy" width="120px">最后更新人</th>
					</tr>
				</thead>
			</table>
		</div>
	</div>
    <!-- 弹出窗1 -->
    <div id="freightWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="freightWinFram" name="freightWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
    <!-- 弹出窗2 -->
    <div id="dialogWin" class="easyui-dialog" title="商品范围" data-options="closed:true,buttons:[{text:'确定',handler:function(){$('#dialogWin').dialog('close');$dialogWinFram.attr('src','')}}]" style="width:50%;height:70%">
    <iframe src=""  id="dialogWinFram" name="dialogWinFram" width="100%" height="98%" frameborder="0">
    </iframe>
    </div>
    <!-- 弹出窗 3-->
    <div id="addNextWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="addNextWinFram" name="addNextWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
	<script type="text/javascript">
		$freightWin 	= $("#freightWin");
		$freightWinFram = $("#freightWinFram");
		$dialogWin 		= $("#dialogWin");
		$dialogWinFram  = $("#dialogWinFram");
		$addNextWin 	= $("#addNextWin");
		$addNextWinFram = $("#addNextWinFram");
		$datagrid 		= $('#freght-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			title : '',
			border : false,
			url : '${AppContext.ctxPath}/action/portal/freight/queryByExamplePage',
			onBeforeLoad : function(param){
				param.brandQuery = '1';
			},
			onInsertOrUpdateAction:function(row,successFun,errFun,that){
				$.post("${AppContext.ctxPath}/action/portal/freight/upsert",row, 
				function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that, data);
					}
				});
			},
			
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/freight/deleteById', {
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
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddWin()">新建</a>',that);
			}
		});
		function openAddWin(){
			$freightWinFram.attr("src","");
			$freightWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/freightDetail.jsp");
			$freightWinFram[0].onload = function() {
				$freightWinFram[0].contentWindow.addInfoInit("reload");//等待窗口加载完毕
			}
			$freightWin.css("display", "block");
		}
		
		 function openDetailWin(freightId){
				if(!freightId){
					$.messager.show("错误", "参数错误，无法获取id", "error");
					return;
				}
				$freightWinFram.attr("src","");
				$freightWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/freightDetail.jsp?freightId="+freightId);
				$freightWinFram[0].onload = function() {
					$freightWinFram[0].contentWindow.detailInfoInit(freightId, "reload");//等待窗口加载完毕
				}
				$freightWin.css("display", "block");
			}
		 
		   function closeDetailWin(freightId,operate){
			   	$freightWinFram.attr("src","");
				$freightWin.css("display", "none");
				var row = $datagrid.datagrid('getSelected');
				var index = $datagrid.datagrid('getRowIndex', row);

				if(operate == "ok"){
					$.post("${AppContext.ctxPath}/action/portal/freight/queryById", {id: row.id}, function(data){
						if(data.success){
							$datagrid.datagrid('updateRow', {index : index, row:data.result})
							$datagrid.datagrid('acceptChanges');
						}else{
							$.messager.show("错误", "更新数据错误: "+data.result, "error");
						}
					});
				}
				
				if(operate == "NEW"){
					openDetailWin(freightId);
				}
			}
		
		function openAddNextWin(freightId , type){
			$freightWinFram.attr("src","");
			$freightWin.css("display", "none");
			
			if(!freightId && !type){
				$.messager.show("错误", "参数错误，无法获取参数", "error");
				return;
			}
			$addNextWinFram.attr("src","");
			$addNextWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/addfreightNext.jsp?freightId="+freightId+"&type="+type);
			$addNextWinFram[0].onload = function() {
				$addNextWinFram[0].contentWindow.addInfoInit("reload");//等待窗口加载完毕
			}
			$addNextWin.css("display", "block");
		}
		
		function openUpdateNextWin(freightId , rowId ,type){
			$freightWinFram.attr("src","");
			$freightWin.css("display", "none");
			
			if(!freightId && !type && !rowId){
				$.messager.show("错误", "参数错误，无法获取参数", "error");
				return;
			}
			$addNextWinFram.attr("src","");
			$addNextWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/addfreightNext.jsp?freightId="+freightId+"&type="+type+"&rowId="+rowId);
			$addNextWinFram[0].onload = function() {
				$addNextWinFram[0].contentWindow.updateInfoInit("reload");//等待窗口加载完毕
			}
			$addNextWin.css("display", "block");
		}
		
	   function closeAddNextWin(freightId){
		    $addNextWin.css("display", "none");
			$addNextWinFram.attr("src","");
			
			$freightWinFram.attr("src","");
			$freightWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/freightDetail.jsp?freightId="+freightId);
			$freightWinFram[0].onload = function() {
				$freightWinFram[0].contentWindow.detailInfoInit(freightId, "reload");//等待窗口加载完毕
			}
			$freightWin.css("display", "block");
		}
	   
		function nameFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openDetailWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
		
		function csFormatter(val,row){
			val = "商品范围";
		     if(val != null){
					return "<a href='###' onClick='openCsWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
		
		function openCsWin(freightId){
			if(!freightId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			$dialogWinFram.attr("src","");
			$dialogWinFram.attr("src","${AppContext.ctxPath}/portal/brandorder/dialog/commodityScope.jsp?freightId="+freightId);
			$dialogWin.dialog('open');
		}
		
		function maFormatter(val,row){
			val = "包邮区域";
		     if(val != null){
					return "<a href='###' onClick='openMaWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
		
		function openMaWin(freightId){
			if(!freightId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			$dialogWinFram.attr("src","");
			$dialogWinFram.attr("src","${AppContext.ctxPath}/portal/brandorder/dialog/mailArea.jsp?freightId="+freightId);
			$dialogWin.dialog('open');
		}
		
		function nmaFormatter(val,row){
			val = "不包邮区域";
		     if(val != null){
					return "<a href='###' onClick='openNmaWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
		
		function openNmaWin(freightId){
			if(!freightId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			$dialogWinFram.attr("src","");
			$dialogWinFram.attr("src","${AppContext.ctxPath}/portal/brandorder/dialog/nMailArea.jsp?freightId="+freightId);
			$dialogWin.dialog('open');
		}
		
	  
	</script>
</body>
</html>