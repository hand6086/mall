<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>
<style type="text/css" >
.file {
    position: relative;
    display: inline-block;
    overflow: hidden;
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
</style>
<body>
	<div class="easyui-layout" data-options="fit:true" border="false">
  	<div data-options="region:'north',split:true" border="false" fit=true style="width:100%;height:100%;border-collapse: true">
  
	<div class="panel-header panel-header-noborder">
		<div class="panel-title">企业信息
		</div>
	</div>
	<table id="enterprise-table" fit="true">
		<thead>
			<tr>
				<!-- <th field="id" width="100px"  noSearch="true" defaultSearch="false" >id</th> -->
				<th field="created" width="100px" noSearch="true"  defaultSearch="false" hidden>创建时间</th>
				<th field="code" defaultSearch="false" width="100px">编号</th>
				<th field="name" width="200px" formatter="detailFormatter" editor="{type:'validatebox',options:{required:true}}"  >名称</th>
				<th field="userName" width="130px" editor="{type:'validatebox',options:{required:true}}">用户名</th>
				<th field="appDutyName" defaultSearch="false"  width="120px" editor="{type:'textbox',options:{required:false}}"  >APP职责</th>
				<th field="smallClass"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >小类</th>
				<th field="inClass"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >中类</th>
				<th field="bigClass"   width="100px" editor="{type:'validatebox',options:{required:false}}"  >大类</th>
				<th field="comments"   width="200px" editor="{type:'validatebox',options:{required:false}}"  >说明</th>
				
			</tr>
		</thead>
	</table>
	</div>
	</div>
   	<!-- 弹出窗 -->
    <div id="addEnterpriseWin" class="crmWin" style="width:100%;height:100%">
	    <iframe src=""  id="addEnterpriseWinFram" name="addEnterpriseWinFram" width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>
    <!-- 弹出窗 -->
    <div id="readOnlyWin" class="crmWin" style="width:100%; height:100%">
	    <iframe src=""  id="readOnlyWinFram" name=readOnlyWinFram width="100%" height="100%" frameborder="0">
	    </iframe>
    </div>

	<script type="text/javascript">
		$addEnterpriseWinFram = $("#addEnterpriseWinFram");
		$addEnterpriseWin = $("#addEnterpriseWin");
		$readOnlyWin = $("#readOnlyWin");
		$readOnlyWinFram = $("#readOnlyWinFram");
		
		$datagrid = $('#enterprise-table');
		//$wxcpadatagrid = $('#wxchartpubaccnt-table');
		//$wxcpafansdatagrid = $('#wxchartpubaccntfans-table');
		
		var initId = getUrlParams("id");
		
		$datagrid.hdatagrid({
			title:'',
		    pageSize: 20,//每页显示的记录条数，默认为20 
		    pageList: [20,50,100],//可以设置每页记录条数的列表 
			updateable : true,
			toolbarShow : true,
			buttonSearch : true,
			buttonNew : false,
			buttonDelete : false,
			//buttonCopy : true,
			buttonExport : true,
			newDefaultValue : true,
			//buttonImport:true,
			striped : true,
			border : false,
			sortName:'code',			//默认列表排序
			sortOrder:'asc',			//默认排列顺序为倒序
			url:'${AppContext.ctxPath}/action/portal/enterprise/queryByExamplePage',
			
			parentGridId: null,	//当前表的父表id
			parentGridField:null, //当前表关联的父表字段名称
			linkGridField:null, //当前表与父表关联的的字段名称
			subGridIds : ['wxchartpubaccnt-table'], //当前表的子表的id，字符串列表
			
			onBeforeLoad:function(param){
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					param.id = initId;
				}
			},
			
			onLoadSuccess: function (data) {
				if(initId != '' && initId != null && typeof(initId) != 'undefined'){
					initId = '';
				}
	        },
	        
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/enterprise/batchUpdate",
							type:"post",
							data:JSON.stringify(rows),
							dataType:"json",
							contentType: "application/json",
							success: function(data){
								if(data.success){
									successFun(that, data);
								}else{
									errFun(that, data);
								}
							},
							error: function(xhr, code, msg){
								errFun(that, "msg");
							}
						});
					},				
					onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				
				$.post('${AppContext.ctxPath}/action/portal/enterprise/upsert', row, function(data) {
					if (!data.success) {
						
						errFun(data.result,that);
					}else{
						
						successFun(that,data);
					}
				});
				
				
			},
			onDeleteAction:function(row,successFun,errFun,that) {
				$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
					if(data){
						$.post('${AppContext.ctxPath}/action/portal/enterprise/deleteCompany', {
								id : row.id,
								code : row.code
						}, function(data) {
							if (!data.success) {
								errFun(data.result,that);
							}else{
								successFun(that);
							}
						});
					}
				});
			},
			onChangeSelectedItem:function(row){
				if(row.code=='101' ||row.code=='102' ||row.code=='000'|| row.code==appCtx.corpId){
					$('#initializeCompany',$datagrid.datagrid('getPanel')).linkbutton('disable');
					$('.easyui-linkbutton-delete-list-table',$datagrid.datagrid('getPanel')).linkbutton('disable');
				}else{
					$('#initializeCompany',$datagrid.datagrid('getPanel')).linkbutton('enable');
					$('.easyui-linkbutton-delete-list-table',$datagrid.datagrid('getPanel')).linkbutton('enable');
				}
			}, 
			onInitNewData:function(that){
				return {
					created : appCtx.sysdate(),
					orgId : appCtx.orgId,
					orgName : appCtx.orgName,
					postnId : appCtx.postnId,
					postnName : appCtx.postnName
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				/* addButtonFun(21,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openAddEnterpriseWin()">新建</a>',that); */
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" id="initializeCompany" iconCls="icon-page-white-excel" plain="true" onclick="initializeCompany()">初始化企业</a>',that);
			}
		});
		
	
		function readOnlyCol(val, row, index){ //当行列（单元格）可否编辑判断；true为只读
			if(val){
				// return true;
			}else{
				//return false;
			}
		}
		function detailFormatter(val, row) {
			if (val != null) {
				var content = "";
			    return "<a class='easyui-tooltip' title='"
			    		+content+
			    		"' href='javascript:void(0)' onclick='windowShow(\"" + row.id + "\",\"" + row.userId + "\")'>" + val + "</a>";
			}
		}
		
		function initializeCompany(){
			var row = $datagrid.datagrid('getSelected');
			$.messager.confirm("操作提示", '是否确定初始化企业？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/enterprise/initializeCompany', row,
						function(data){
					    	if(data.success){
					    		window.parent.operationtip('初始化成功！<br>'+data.message, 'success');
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		//选择价格表
		function priceListPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').defaultPrice = selectRow.id;
			return selectRow.priceListName;
		}
		
		function openAddEnterpriseWin(){
			$.post("${AppContext.ctxPath}/action/portal/enterprise/initNew", {}, function(data){
				if(data.success){
					if(!data.result.row_status){
						data.result.row_status = "NEW";
					}
					if( !$addEnterpriseWinFram.attr("src") ){//弹出窗口
						$addEnterpriseWinFram.attr("src", "${AppContext.ctxPath}/portal/enterprise/AddEnterprise.jsp");
						$addEnterpriseWinFram[0].onload = function() {
							$addEnterpriseWinFram[0].contentWindow.initInfo("",data.result);//等待窗口加载完毕
						}
					}else{
						$addEnterpriseWinFram[0].contentWindow.initInfo("", data.result);
					}
					$addEnterpriseWin.css("display", "block");
				}else{
					$.messager.alert("错误", data.result, "error");
				}
			});
		}
	
		function closeAddEnterpriseWin(){
			$addEnterpriseWin.css("display", "none");
		}
		function closeEnterpriseReadOnlyWin(){
			$readOnlyWin.css("display", "none");
		}
		function defaultFlagWxpp(){
			var row = $wxcpadatagrid.hdatagrid('getSelected');
			$.messager.confirm("操作提示", '是否确定设为默认公众号？', function(data) {
				if(data){
					if(row){
						if(row.primary_flag=='Y'){
							window.parent.operationtip('默认公众号不能重复设置', 'error');
						}else{
							$.post('${AppContext.ctxPath}/action/portal/wxPublicPlatform/defaultFlagWxpp',{
								id : row.id,
								head_row_id:row.head_row_id,
								primary_flag : 'Y'
							},function(data){
								if(data.success){
									var index = $wxcpadatagrid.hdatagrid('getRowIndex', row);
									row.primary_flag = 'Y';
									$wxcpadatagrid.hdatagrid("reload");
									refreshAddrToolBar();
								}else{
									window.parent.operationtip(data.result, 'error');
								}
							});
						}
					}
				}
			})
		}
		function activeWxpp(){
			var row = $wxcpadatagrid.hdatagrid('getSelected');
			if(row){
				$.post('${AppContext.ctxPath}/action/portal/wxPublicPlatform/activeWxpp',{
					id : row.id,
					valid_flag : 'Y'
				},function(data){
					if(data.success){
						var index = $wxcpadatagrid.hdatagrid('getRowIndex', row);
						row.valid_flag = 'Y';
						$wxcpadatagrid.hdatagrid("refreshRow", index);
						refreshAddrToolBar();
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				});
			}
		}
		function inactiveWxpp(){
			var row = $wxcpadatagrid.hdatagrid('getSelected');
			if(row){
				if(row.primary_flag == 'Y'){
					window.parent.operationtip('默认公众号不能失效，请先设置为非默认公众号再操作。', 'error');
					return false;
				}
				$.post('${AppContext.ctxPath}/action/portal/wxPublicPlatform/inactiveWxpp',{
					id : row.id,
					valid_flag : 'N'
				},function(data){
					if(data.success){
						var index = $wxcpadatagrid.hdatagrid('getRowIndex', row);
						row.valid_flag = 'N';
						$wxcpadatagrid.hdatagrid("refreshRow", index);
						refreshAddrToolBar();
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				});
			}
		}
		//打开编辑窗口
		function windowShow(enterId,userId){
			if(!enterId){
				$.messager.show("错误", "参数错误，无法获取线索id", "error");
				return;
			}
			$addEnterpriseWinFram.attr("src","");
			if( !$addEnterpriseWinFram.attr("src") ){
				$addEnterpriseWinFram.attr("src", "${AppContext.ctxPath}/portal/enterprise/enterpriseDetail.jsp?"+"enterId=" + enterId+"&"+"userId="+userId);
				$addEnterpriseWinFram[0].onload = function() {
					$addEnterpriseWinFram[0].contentWindow.enterInfoInit(enterId, "reload");//等待窗口加载完毕
				}
			}else{
				$addEnterpriseWinFram[0].contentWindow.enterInfoInit(enterId, "reload");
			}
			//$accntDetailWin.window("open");
			$addEnterpriseWin.css("display", "block");
		}
		function collapsefirstFun(){
			$(".easyui-layout").layout('collapse','north');
			$(".easyui-layout").layout('expand','south');
		}
		function collapsesecondFun(){
			$(".easyui-layout").layout('collapse','center');
		}
		function collapsethirdFun(){
			$(".easyui-layout").layout('collapse','south');
			$(".easyui-layout").layout('expand','north');
		}
		/* if($(".easyui-layout").layout("panel", "north")[0].clientWidth>0){
			$(".easyui-layout").layout('collapse','south');
		}
		if($(".easyui-layout").layout("panel", "south")[0].clientWidth>0){
			$(".easyui-layout").layout('collapse','north');
		} */
		function clearWxppCatch(){
			var row = $wxcpadatagrid.hdatagrid('getSelected');
			$.messager.confirm("操作提示", '是否确定清楚缓存？', function(data) {
				if(data){
					if(row){
						$.post('${AppContext.ctxPath}/action/portal/wxPublicPlatform/clearWxppCatch',{
							id : row.id,
							head_row_id:row.head_row_id,
						},function(data){
							if(data.success){
								var index = $wxcpadatagrid.hdatagrid('getRowIndex', row);
								row.primary_flag = 'Y';
								$wxcpadatagrid.hdatagrid("reload");
								refreshAddrToolBar();
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
					}
				}
			})
		}
	</script>
</body>
</html>
