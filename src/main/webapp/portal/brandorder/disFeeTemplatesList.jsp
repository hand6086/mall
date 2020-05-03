<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp"%>
<body class="easyui-layout">
		<div data-options="region:'north',split:true" title="" border="false" style="width:100%;height:100%;padding:0px;">
			<table id="freght-table" style="width:100%;height:100%;" singleSelect="true" rownumbers="true" pagination="true">
				<thead>
					<tr>
						<th field="cityName" width="150px" editor="{type:'picklistbox',
															options:{title:'选择城市',
															completeFun:cityPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/Tbo2oDistrictPickList.jsp',
															required:true}}">城市</th>
						<th field="cityId" width="100px" hidden = "true" noSearch = "true">城市Id</th>
						<th field="name" width="100px" editor="{type:'textbox',options:{required:true}}">模板名称</th>
						<th field="firstFee" width="200px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">基础费用</th>
						<th field="firstNumber" width="200px" editor="{type:'numberbox',options:{min:0,required:true}}">基础件数</th>
						<th field="addFee" width="200px" editor="{type:'numberbox',options:{min:0,precision:2,required:true}}">累计费用</th>
						<th field="addNumber" width="200px" editor="{type:'numberbox',options:{min:0,required:true}}">累计配件数</th>
						<th field="commodityScope" width="120px" formatter="csFormatter">商品范围</th>
						<th field="notes" width="200px" editor="{type:'textarea',options:{required:true}}">说明</th>
					</tr>
				</thead>
			</table>
		</div>
	
    <!-- 弹出窗2 -->
    <div id="detailWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="detailWinFram" name="detailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
    <!-- 弹出窗3 -->
    <div id="csWin" class="easyui-dialog" title="商品范围" data-options="closed:true,buttons:[{text:'确定',handler:function(){$('#csWin').dialog('close');$csWinFram.attr('src','')}}]" style="width:50%;height:70%">
    <iframe src=""  id="csWinFram" name="csWinFram" width="100%" height="98%" frameborder="0">
    </iframe>
    </div>
    <!-- 弹出窗4 -->
    <div id="maWin" class="easyui-dialog" title="包邮区域" data-options="closed:true,buttons:[{text:'确定',handler:function(){$('#maWin').dialog('close');$maWinFram.attr('src','')}}]" style="width:50%;height:70%">
    <iframe src=""  id="maWinFram" name="maWinFram" width="100%" height="98%" frameborder="0">
    </iframe>
    </div>
    <!-- 弹出窗5 -->
    <div id="nmaWin" class="easyui-dialog" title="不包邮区域" data-options="closed:true,buttons:[{text:'确定',handler:function(){$('#nmaWin').dialog('close');$nmaWinFram.attr('src','')}}]" style="width:50%;height:70%">
    <iframe src=""  id="nmaWinFram" name="nmaWinFram" width="100%" height="98%" frameborder="0">
    </iframe>
    </div>
	<script type="text/javascript">
		$addWin = $("#addWin");
		$addWinFram = $("#addWinFram");
		$detailWin = $("#detailWin");
		$detailWinFram = $("#detailWinFram");
		$csWin = $("#csWin");
		$csWinFram = $("#csWinFram");
		$maWin = $("#maWin");
		$maWinFram = $("#maWinFram");
		$nmaWin = $("#nmaWin");
		$nmaWinFram = $("#nmaWinFram");
		$datagrid = $('#freght-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonNew:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			title : '运费模板',
			border : false,
			url : '${AppContext.ctxPath}/action/portal/freight/queryByExamplePage',
			
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
			}
		});
		
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
			$csWinFram.attr("src","");
			$csWinFram.attr("src","${AppContext.ctxPath}/portal/brandorder/dialog/commodityScope.jsp?freightId="+freightId);
			$csWin.dialog('open');
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
			$maWinFram.attr("src","");
			$maWinFram.attr("src","${AppContext.ctxPath}/portal/brandorder/dialog/mailArea.jsp?freightId="+freightId);
			$maWin.dialog('open');
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
			$nmaWinFram.attr("src","");
			$nmaWinFram.attr("src","${AppContext.ctxPath}/portal/brandorder/dialog/nMailArea.jsp?freightId="+freightId);
			$nmaWin.dialog('open');
		}
		
	   function openDetailWin(freightId){
			if(!freightId){
				$.messager.show("错误", "参数错误，无法获取id", "error");
				return;
			}
			$detailWinFram.attr("src","");
			if( !$detailWinFram.attr("src") ){
				$detailWinFram.attr("src", "${AppContext.ctxPath}/portal/brandorder/freightDetail.jsp?freightId="+freightId);
				$detailWinFram[0].onload = function() {
					$detailWinFram[0].contentWindow.freightInfoInit(freightId, "reload");//等待窗口加载完毕
				}
			}else{
				$detailWinFram[0].contentWindow.freightInfoInit(freightId, "reload");
			}
			$detailWin.css("display", "block");
		}
	   function closeDetailWin(operate){
			$detailWin.css("display", "none");
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
		}
	   
	   function cityPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').cityId = selectRow.id;
			return selectRow.name;
		}
	</script>
</body>
</html>