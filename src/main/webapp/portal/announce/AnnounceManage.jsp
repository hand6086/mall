<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" /> 
<%@ include file="/portal/header.jsp" %>
<body>
		<div class="easyui-layout" data-options="fit:true" border="false">
			<div data-options="region:'center'" border="false" style="padding:0px;">
				
				<table id="announce-table" fit="true">
				<thead>
					<tr>
						<th field="captions" width="150px"  formatter="nameFormatter" editor="{type:'textbox'}" sortable="true">标题</th>
						<!-- <th field="orgName" width="150px" formatter="orgMvgFormatter" >营销渠道</th> -->
						<th field="anneType" width="150px" sortable="true" lov="ANNE_TYPE">类型</th>
						<th field="anneReader" width="150px" sortable="true" lov="ANNE_OBJECT">发布对象</th>
						<th field="publishDate" width="150px" sortable="true">发布时间</th>
						<th field="anneStatus" width="150px" sortable="true" lov="ANNE_STATUS">状态</th>
						<th field="startDate" width="150px" sortable="true">有效开始时间</th>
						<th field="endDate" width="150px" sortable="true">有效结束时间</th>
						<!-- <th field="isLimited" lov="IS_LIMITED" width="150px" sortable="true">限制营销渠道</th> -->
					</tr>
				</thead>
			</table>
			</div>
		</div>
<!-- 弹出窗1 -->
<div id="brandAnnounceWin" class="crmWin" style="width:100%;height:100%">
	<iframe src="" id="brandAnnounceWinFram" name="brandAnnounceWinFram" width="100%" height="100%" frameborder="0"></iframe>
</div>
	<script type="text/javascript">
		$brandAnnounceWin = $("#brandAnnounceWin");
		$brandAnnounceWinFram = $("#brandAnnounceWinFram");

		$datagrid = $('#announce-table');
		$datagrid.hdatagrid({
			updateable:false,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:false,
			buttonDelete:false,
			buttonExport:true,
			url:'${AppContext.ctxPath}/action/portal/announce/manageList',
			oauthFlag:true,
			striped:true,
			title: '',
			onAddMoreButton:function(that,addButtonFun){
				if(appCtx.systemRole == 'super_administrator'){
					addButtonFun(91,'<a href="javascript:void(0)" id="btn_add" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="announceAdd()">新建</a>',that);
					addButtonFun(92,'<a href="javascript:void(0)" id="btn_remove" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="announceDel()">删除</a>',that);
					addButtonFun(93,'<a href="javascript:void(0)" id="btn_submit" class="easyui-linkbutton" iconCls="icon-ok" plain="true" onclick="announceSubmit()">发布</a>',that);
				}
			},
		});
		
		//新建公告的跳转
		function announceAdd(){
			$brandAnnounceWinFram.attr("src","");
			$brandAnnounceWinFram.attr("src", "${AppContext.ctxPath}/portal/announce/AnnouceEdit.jsp?id=noMatchId");
			$brandAnnounceWinFram[0].onload = function() {
				$brandAnnounceWinFram[0].contentWindow.brandAnnounceInit("reload");//等待窗口加载完毕
			}
			$brandAnnounceWin.css("display", "block");
		}
		
	   function closeAnnounceWin(){
            $brandAnnounceWinFram.attr("src","");
			$brandAnnounceWin.css("display", "none");
			$datagrid.datagrid('reload');
		}
		
		//删除记录
		function announceDel(){
				var row = $datagrid.datagrid('getSelected');
				window.parent.operationconfirm($datagrid, '${AppContext.ctxPath}/action/portal/announce/announceDelete/' + row.id, row.id, '是否确定删除信息？');
		}
		
		// 发布
		function announceSubmit(){
			var row = $datagrid.datagrid('getSelected');
			if(!row){
				return;
			}
			if(row.anneStatus == 'PUBLISHED'){
				$.messager.alert("提示", "已发布的公告不能重复操作", "info");
				return;
			}
			$.messager.confirm("操作提示",'是否确定发布公告?', function(data){
				if(data){
					$.post("${AppContext.ctxPath}/action/portal/announce/brandPublish", {
						id: row.id,
					}, function(data){
						if(data.success){
							$.messager.alert("提示", "发布成功", "info");
							$datagrid.datagrid('reload');
						}else{
							$.messager.alert("错误", data.result, "error");
						}
					});
				}
			});
		}
        //公告标题跳转编辑界面
        function nameFormatter(val,row,index){
            if(val != null){
                return "<a href='###' onClick='openDetailWin("+index+")'>"+val+"</a>";
            }
        }

        function openDetailWin(index){
		    var row = $datagrid.hdatagrid('getData').rows[index];
            if(!row){
                $.messager.show("错误", "参数错误，无法获取id", "error");
                return;
            }
            if( !$brandAnnounceWinFram.attr("src") ){
                $brandAnnounceWinFram.attr("src", "${AppContext.ctxPath}/portal/announce/AnnouceEdit.jsp?id="+row.id+"&anneStatus="+row.anneStatus);
                $brandAnnounceWinFram[0].onload = function(){
                    $brandAnnounceWinFram[0].contentWindow.init(row);
				};
            }
            $brandAnnounceWin.css("display", "block");
        }

	</script>
</body>
</html>