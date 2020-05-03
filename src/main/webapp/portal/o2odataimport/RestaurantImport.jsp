<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<script src="${AppContext.ctxPath}/static/easyui/js/validatebox-ext.js"></script>
<script src="${AppContext.ctxPath}/static/js/content_zoom.js"></script>

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
   <div data-options="region:'north',split:true" title="" border="false" fit="true">
   
	   <fieldset class="x-fieldset" id="keyFilter">
			<legend class="x-fieldset-header"
				style="width: 95px; margin-bottom: 0px; border: none;">
				<span class="x-fieldset-title">客户筛选条件</span>
			</legend>
	
			<div class="row keyfilter-border">
					<ul id="check-status-keyfilter" data-toggle="keyfilter"
					data-title="校验状态" data-filter-filed="checkStatus"
					data-table-Id="restaurant-imp-table">
					</ul>
			</div>
		</fieldset>
		
		<table id="restaurant-imp-table" keyFilterDiv="keyFilter"
				singleSelect="false" rownumbers="true"  pagination="true" fit="true">
			<thead>
				<tr>
					
					<th field="checkStatus" width="80px" lov="TB_CHECK_STATUS" defaultSearch="true" >校验状态</th>
					<th field="impStatus" width="80px" lov="TB_IMPORT_STATUS">导入状态</th>
					<th field="errMessage" width="400px" formatter="titleFormatter">错误信息</th>	
					<th field="name" width="100px" defaultSearch="true" editor="{type:'validatebox', options:{required:true}}">餐厅名称</th>
					<th field="logo" width="80px" hidden="true">Logo图片</th>
					<th field="logoUrl" width="80px" formatter="logoFormatter">Logo图片</th>
					<th field="province" width="100px" editor="{type:'validatebox',options:{required:true}}">省/直辖市</th>
					<th field="city" width="100px"  editor="{type:'validatebox',options:{required:true}}">市</th>
					<th field="district" width="100px" editor="{type:'validatebox',options:{required:true}}">区/县</th>
					<th field="street" width="200px" editor="{type:'validatebox'}">街道</th>
					<th field="address" width="80px" editor="{type:'validatebox',options:{required:true}}">详细地址</th>
					<th field="longtitude" width="80px">经度</th>
					<th field="latitude" width="80px">纬度</th>
					<th field="phone" width="100px" editor="{type:'validatebox',options:{required:true}}">餐厅电话</th>
					<th field="merchantsName" width="80px" editor="{type:'validatebox'}">配送商名称</th>
					<th field="merchantsContact" width="80px"editor="{type:'validatebox'}">配送商联系人</th>
					<th field="merchantsPhone" width="80px"editor="{type:'numberbox'}">配送商联系方式</th>
			</thead>
		</table>
		<div id="bigImg" style="display: none;">
			<img id="popUpImg"/>
		</div>
	</div>
 </div>  	
	<script type="text/javascript">
		$datagrid = $('#restaurant-imp-table');
		getLovOfList("[ACCT_TYPE,ACCT_STATUS,ACCT_LEVEL,IMP_STATUS]");
		$datagrid.hdatagrid({
			updateable : true,    
			toolbarShow:true,	//显示工具栏
			buttonSearch:true,	//搜索框功能
			buttonNew:true,
			buttonDelete:true,
			buttonExport:true,
			buttonCopy:true,
			buttonImport:true,
			oauthFlag:true,
			striped:true,
			title:'',
			border:false,
			url:'${AppContext.ctxPath}/action/portal/restaurantTemp/queryByExamplePage',
			onLoadSuccess: function (data) {
	            //调用图片展示组件
	            $('div.small_pic a').fancyZoom({scaleImg: true, closeOnClick: true});
	        },
	        readOnlyCondition: function(row, that){
				//先清除所有选择行,在选择当前编辑行
				if(row.checkStatus == 'Check Ok'){
		    		return true;
		    	}else{
		    		$datagrid.hdatagrid('clearSelections');
					var index = $datagrid.hdatagrid('getRowIndex', row);
					$datagrid.datagrid('selectRow',index)
		    		return false;
		    	}
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" id="btn_check" class="easyui-linkbutton" iconCls="icon-folder-page" plain="true" onclick="check()">校验数据</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="accntImpInsert()">提交数据</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="batchDeleteById()">批量删除</a>',that);
				addButtonFun(94,'<div style = "width:78px;display:inline-block"> <form id="form" method="post" enctype="multipart/form-data"> <a href="javascript:;" class="file easyui-linkbutton fileProdImg" iconCls="icon-uploadImg" plain="true">上传图片 <input type="hidden" id="goodsSeriesId" name="id"/>'+"<input type='hidden' name='method' value='upload'/><input type='file' id='file' name='myfiles'/></a></form></div>",that);
				addButtonFun(95,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="updateLatLng()">更新经纬度</a>',that);
			},
			buttonBatchEdit : true,
					onBatchUpdateAction : function(rows, successFun, errFun, that){
						for(var i=0; i< rows.length; i++){
							var row = rows[i];
							delete row.children;
						}
						$.ajax({
							url: "${AppContext.ctxPath}/action/portal/restaurantTemp/batchUpdate",
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
				$.post('${AppContext.ctxPath}/action/portal/restaurantTemp/upsert', row, function(data) {
					if (!data.success) {
						errFun(data.result,that);
					}else{
						successFun(that,data);
					}
				});
			},
			/**
			 * 初始化新建的数据
			 */
			onInitNewData:function(that){
				//var firstName = appCtx.firstName != null ? '' : appCtx.firstName;
				return {
					checkStatus : 'New',
					impStatus : 'New'
					
				};
			},
	
			onDeleteAction:function(row,successFun,errFun,that) {
		    	$.messager.confirm("操作提示", '是否确定删除信息？', function(data) {
		    		if(data){
		    			$.post('${AppContext.ctxPath}/action/portal/restaurantTemp/deleteById',{
		    				id : row.id
		    			},function(data){
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
		$('.fixed-keyfilter-ul').keyFilter();
		$('#check-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/TB_CHECK_STATUS'
	    });
		 
		function logoFormatter(val,row)
		{   
			var imgUrl_A = "<div class=\"small_pic\"><a href=\"#bigImg\"> <img height=\"50\" src=\"";
			var imgUrl_B = "\" /></a></div>";
			if(val)
			{
				return imgUrl_A +row.logoUrl +imgUrl_B;
			} 
			return imgUrl_A + "${AppContext.ctxPath}/static/images/404.jpg" + imgUrl_B;
		}
		
		function updateLatLng(){
			$.messager.confirm("操作提示", '是否确定更新经纬度信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/restaurantTemp/updateLatLng', { },
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		function check(){
			$.messager.confirm("操作提示", '是否确定校验信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/restaurantTemp/check', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
		
		function accntImpInsert(){
			$.messager.confirm("操作提示", '是否确定导入信息？', function(data) {
				if(data){
					$.post('${AppContext.ctxPath}/action/portal/restaurantTemp/restaurantImpInsert', {},
						function(data){
					    	if(data.success){
					    		$datagrid.datagrid('reload');
							}else{
								window.parent.operationtip(data.result, 'error');
							}
						});
				}
			});
		}
 		//批量删除
 
 		//错误信息title
		function titleFormatter(val,row){
		     if(val != null){
		        var content = '';
		        var content = val.replace(/\\n/g,'\n');
		        var val = val.replace(/\\n/g,'; ');
		     	return "<span class='easyui-tooltip' title='" + content +"'>" + val + "</span>";
		     }
		}
		
		function batchDeleteById(rows, successFun, errFun, that){
			var rows=$datagrid.hdatagrid('getSelections');
			 $.ajax({
				url: "${AppContext.ctxPath}/action/portal/restaurantTemp/batchDelete",
				type:"post",
				data:JSON.stringify(rows),
				dataType:"json",
				contentType: "application/json",
				
			 	function(data){					
			    	if(data.success){
			    		$datagrid.datagrid('reload');
					}else{
						window.parent.operationtip(data.result, 'error');
					}
				} 
			});
	    	$datagrid.datagrid('reload');

		}
 		
		$(".fileProdImg").change(function(){
			var row = $datagrid.datagrid('getSelected');
			if(row == null || row.id == null){
				$.messager.alter("没有选中任何产品信息！");
				return;
			};
			/* 判断产品上传图片大小
			var files = document.getElementById("file").files; 
			var size = files[0].size;
			if (size >= 2 * 1024 *1024){
				$.messager.alert('注意','上传图片大小不要超过2M');
				return;
			}
			 */
			$('#goodsSeriesId').val(row.id);
			var options = {
	   			url:'${AppContext.ctxPath}/action/portal/restaurantTemp/uploadImg',
	   			type:'post',
	   			dataType:'json',
	   			contentType:"application/x-www-form-urlencoded;charset=utf-8",
	   			success : function(data) {
	   					if(data.success){
	   						$datagrid.datagrid('reload');
	   						window.parent.operationtip('图片上传成功！', 'info');
	   				  	}
	   			}
	   		};
	   		$('#form').ajaxSubmit(options);
		});
	</script>
</body>
</html>