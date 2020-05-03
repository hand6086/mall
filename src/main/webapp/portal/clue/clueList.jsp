<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/portal/header.jsp" %>

<body class="easyui-layout" data-options="fit:true" border="false">
   <div data-options="region:'north',split:true" fit="true" border="false">
   
   <fieldset class="x-fieldset" id="clueKeyFilter">
		<legend class="x-fieldset-header"
			style="width: 95px; margin-bottom: 0px; border: none;">
			<span class="x-fieldset-title">线索筛选条件</span>
		</legend>

		<div class="row keyfilter-border">
			<ul id="clue-status-keyfilter" data-toggle="keyfilter"
				data-title="跟进状态" data-filter-filed="followStatus"
				data-table-Id="clue-table">
			</ul>
		</div>
	</fieldset>
	
	<taBLE id="clue-table"
			singleSelect="true" rownumbers="true"  pagination="true" fit="true" keyFilterDiv="clueKeyFilter">
		<thead>
			<tr>
				<th field="id" hidden="true">线索ID</th>
				<th field="code" width="100px" editor="{type:'textbox',options:{required:true}}">线索编号</th>
				<th field="name" width="100px" defaultSearch="true" formatter="clueNameFormatter" editor="{type:'textbox',options:{required:true}}">线索名称</th>
				<th field="province" width="80px" editor="{type:'combobox',options:{valueField:'addrName',
																		textField:'addrName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/provinceList',
																		editable:false,
																		onSelect:selectedProvince,
																		required:true}}">省</th>
				<th field="city" width="80px"  editor="{type:'combobox',options:{valueField:'addrName',
																		textField:'addrName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/queryAddressListSelect',
																		onBeforeLoad:beforeSelectCity,
																		onSelect:selectedCity,
																		editable:false,
																		required:true}}">市</th>
				<th field="district" width="80px" editor="{type:'combobox',options:{valueField:'addrName',
																		textField:'addrName',
																		method:'get',
																		url:'${AppContext.ctxPath}/action/portal/address/queryAddressListSelect',
																		onBeforeLoad:beforeSelectDistrict,
																		editable:false,
																		required:true
																		}}">区/县</th>
				<th field="address" width="130px" editor="{type:'validatebox',options:{required:true}}">地址</th>
				<th field="contactName" width="130px" editor="{type:'validatebox',options:{required:true}}">联系人</th>
				<th field="mobilePhone" width="130px" editor="{type:'validatebox',options:{required:true}}">电话</th>
				<th field="followStatus" width="130px" lov="CLUE_FOLLOW_STATUS">跟进状态</th>
				<th field="source" lov="CLUE_SOURCE" width="130px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('CLUE_SOURCE'),
																		editable:false,
																		required:true}}">线索来源</th>
				<th field="sex" lov="GENDER" width="130px" editor="{type:'combobox',options:{valueField:'val',
																		textField:'name',
																		data : getLovArray('GENDER'),
																		editable:false}}">性别</th>
				<th field="companyName" width="130px" editor="{type:'validatebox'}">公司名字</th>
				<th field="orgId" width="130px" hidden="true">组织Id</th>
				<th field="orgName" width="130px" editor="{type:'picklistbox',options:{title:'选择组织',
															completeFun:orgPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/orgPickList.jsp'}}">组织</th>
				<th field="postnId" width="130px" hidden="true">职位Id</th>
				<th field="postnName" width="130px" editor="{type:'picklistbox',options:{title:'选择职位',
															completeFun:postnPicklistComplete,
															tableUrl:'${AppContext.ctxPath}/portal/picklist/positionPickList.jsp'}}">职位</th>
				<th field="qqNum" width="130px" editor="{type:'validatebox'}">qq号码</th>
				
				<th field="price" width="130px" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">价格</th>
				<th field="income" width="130px" currency="CNY" editor="{type:'numberbox',options:{
																				min:0,
																				precision:2}}">收入</th>
				<th field="created" width="130px" mark="DATE">创建时间</th>
			</tr>
		</thead>
	</table>
	</div>
   	
   	<!-- 弹出窗1 -->
    <div id="clueDetailWin" class="crmWin" style="width:100%;height:100%">
    <iframe src=""  id="clueDetailWinFram" name="clueDetailWinFram" width="100%" height="100%" frameborder="0">
    </iframe>
    </div>
	<script type="text/javascript">
		getLovOfList("[CLUE_FOLLOW_STATUS,GENDER,CLUE_SOURCE]");
		$clueDetailWin = $("#clueDetailWin");
		$clueDetailWinFram = $("#clueDetailWinFram");
		
	    $datagrid = $('#clue-table');
		$datagrid.hdatagrid({
			updateable:true,
			toolbarShow:true,
			buttonSearch:true,
			buttonNew:true,
			buttonDelete:true,
			buttonCopy:true,
			buttonExport:true,
			buttonImport:true,
			buttonMenu:true,
			menuButtonCount : true,
			newDefaultValue:true,
			oauthFlag:true,
			striped:true,
			border:false,
			url:'${AppContext.ctxPath}/action/portal/clue/queryByExamplePage',
			
			buttonCombineSearch:true,
			/* buttonBatchEdit : true,
			onBatchUpdateAction : function(rows, successFun, errFun, that){
				$.ajax({
					url: "${AppContext.ctxPath}/action/portal/clue/batchUpdate",
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
			}, */				
			onInsertOrUpdateAction:function(row,successFun,errFun,that) {
				$.post('${AppContext.ctxPath}/action/portal/clue/upsert',row, function(data) {
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
						$.post('${AppContext.ctxPath}/action/portal/clue/deleteById', {
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
			},onInitNewData:function(that){
				var orgNameValue = appCtx.orgName != null ? '' : appCtx.orgName;
				var postnNameValue = appCtx.postnName != null ? '' : appCtx.postnName;
				return {
					created: appCtx.sysdate(),
					followStatus : getLovShowName('CLUE_FOLLOW_STATUS','New'),
					orgId : appCtx.orgId,
					orgName : orgNameValue,
					postnId : appCtx.postnId,
					postnName : postnNameValue
				};
			},
			onAddMoreButton:function(that,addButtonFun){
				addButtonFun(91,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFollow()" iconCls="icon-followUp" plain="true">跟进</a>',that);
				addButtonFun(92,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueRecall()" iconCls="icon-undo" plain="true">撤回</a>',that);
				addButtonFun(93,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueFinish()" iconCls="icon-ok" plain="true">完成</a>',that);
				addButtonFun(94,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="clueCancel()" iconCls="icon-no" plain="true">取消</a>',that);
				addButtonFun(95,'<a href="javascript:void(0)" class="easyui-linkbutton" onClick="generateAccount()" iconCls="icon-generate" plain="true">生成客户</a>',that);

			},
            buttonBatchEdit : true,
            onBatchUpdateAction : function(rows, successFun, errFun, that){
                $.ajax({
                    url: "${AppContext.ctxPath}/action/portal/clue/batchUpdate",
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
            }
		});
		
		//跟进
		function clueFollow(){
			var row = $datagrid.datagrid('getSelected');
			$.post('${AppContext.ctxPath}/action/portal/clue/clueFollow', 
			{
				id	: row.id,
				followStatus : getLovShowName('CLUE_FOLLOW_STATUS','running')
		    },
			function(data){
		    	if(!data.success){
					window.parent.operationtip(data.result, 'error');
				}else{
					$datagrid.datagrid('reload');
				}
			});
		}
		//撤回
		function clueRecall(){
			var row = $datagrid.datagrid('getSelected');
			if(row.followStatus == 'running'){
				$.post('${AppContext.ctxPath}/action/portal/clue/clueRecall', 
				{
					id	: row.id,
					followStatus : getLovShowName('CLUE_FOLLOW_STATUS','UNTREATED')
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName('CLUE_FOLLOW_STATUS',row.followStatus)+'，无法撤回！', 'error');
			}
		}
		//完成
		function clueFinish(){
			var row = $datagrid.datagrid('getSelected');
			$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,followStatus:'success'});
			/* var row = $datagrid.datagrid('getSelected');
			if(row.followStatus == 'running'){
				$.post('${AppContext.ctxPath}/action/portal/clue/clueFinish', 
				{
					id	: row.id,
					followStatus : getLovShowName('CLUE_FOLLOW_STATUS','success')
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName('CLUE_FOLLOW_STATUS',row.followStatus)+'，无法完成！', 'error');
			} */
		}
		//取消
		function clueCancel(){
			var row = $datagrid.datagrid('getSelected');
			//$datagrid.hdatagrid('changeRowValue',{row.id,followStatus:'cancel'});
			$datagrid.hdatagrid('changeAndSaveRowValue',{id:row.id,followStatus:'cancel'});
			/* if(row.followStatus != 'success'){
				$.post('${AppContext.ctxPath}/action/portal/clue/clueCancel', 
				{
					id	: row.id,
					followStatus : getLovShowName('CLUE_FOLLOW_STATUS','cancel')
			    },
				function(data){
			    	if(!data.success){
						window.parent.operationtip(data.result, 'error');
					}else{
						$datagrid.datagrid('reload');
					}
				});
			}else{
				window.parent.operationtip('该线索状态为'+getLovShowName('CLUE_FOLLOW_STATUS',row.followStatus)+'，无法取消！', 'error');
			} */
		}
		//线索转订单
	    /* function optyGenerateOrder(){
	    	var row = $datagrid.datagrid('getSelected');
			if(row.stage == '成交'){
				delete row.prodList;
				$.post('${AppContext.ctxPath}/action/portal/opty/optyGenerateOrder',row,
				function(data){
					if(!data.success){
						$.messager.alert("操作提示", data.result,"error");
					}else{
						$.messager.alert("操作提示", "订单生成成功!");
					}
				});
			}else{
				$.messager.alert('提示','该报价单未成交，不能转换为订单！');
			}
	    }; */
	    //线索转成客户
	    function generateAccount(){
	        var row = $datagrid.datagrid('getSelected');
			if(row.followStatus == 'success'){
				//delete row.prodList;
				$.post('${AppContext.ctxPath}/action/portal/clue/clueToAccount',row,
				function(data){
					if(!data.success){
						$.messager.alert("操作提示", data.result,"error");
					}else{
						$.messager.alert("操作提示", "客户生成成功!");
					}
				});
			}else{
				$.messager.alert('提示','该线索跟进状态未完成，不能转换为客户！');
			}
	    }
		//初始化选择城市
		function beforeSelectCity(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			
			if(province == null || province == ''){
				param.parentAddrName='noMatchId';
			}else{
				param.parentAddrName=province;
			}
		}

		//初始化选择城市
		function beforeSelectDistrict(param){
			var province = $datagrid.hdatagrid('getCurrentRow').province;
			var city = $datagrid.hdatagrid('getCurrentRow').city;
			if(province == null || province == ''){
				param.parentAddr2Name='noMatchId';
			}else{
				param.parentAddr2Name=province;
			}
			if(city == null || city == ''){
				param.parentAddrName='noMatchId';
			}else{
				param.parentAddrName=city;
			}
		}
		
		//选择省份
		function selectedProvince(selectRow){
			$datagrid.hdatagrid('getCurrentRow').province = selectRow.addrName;
			$datagrid.hdatagrid('getCurrentRow').city = '';
			$datagrid.hdatagrid('getCurrentRow').district = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'city'}).target).combobox('setValue','');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.hdatagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
			
		}
		
		//城市
		function selectedCity(selectRow){
			$datagrid.hdatagrid('getCurrentRow').city = selectRow.addrName;
			$datagrid.hdatagrid('getCurrentRow').district = '';
			var editIndex = $datagrid.hdatagrid('getCurrentRowIndex');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('reload');
			$($datagrid.datagrid('getEditor',{index:editIndex,field:'district'}).target).combobox('setValue','');
		}
		
		function orgPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').orgId = selectRow.id;
			return selectRow.text;
		}

		function postnPicklistComplete(selectRow){
			$datagrid.hdatagrid('getCurrentRow').postnId = selectRow.id;
			return selectRow.text;
		}
		

		
	   $('.fixed-keyfilter-ul').keyFilter();
	   $('#clue-status-keyfilter').keyFilter({
			remoteData:true,
			filterByValue:true,
			remoteUrl:'${AppContext.ctxPath}/action/portal/basic/list/CLUE_FOLLOW_STATUS'
	   });
	   
	   function clueNameFormatter(val,row){
		     if(val != null){
					return "<a href='###' onClick='openClueDetailWin(\""+row.id+"\")'>"+val+"</a>";
		     }
		}
	   function openClueDetailWin(clueId){
			if(!clueId){
				$.messager.show("错误", "参数错误，无法获取线索id", "error");
				return;
			}
			if( !$clueDetailWinFram.attr("src") ){
				$clueDetailWinFram.attr("src", "${AppContext.ctxPath}/portal/clue/ClueDetail.jsp?clueId="+clueId);
				$clueDetailWinFram[0].onload = function() {
					$clueDetailWinFram[0].contentWindow.clueInfoInit(clueId, "reload");//等待窗口加载完毕
				}
			}else{
				$clueDetailWinFram[0].contentWindow.clueInfoInit(clueId, "reload");
			}
			//$accntDetailWin.window("open");
			$clueDetailWin.css("display", "block");
		}
	   function closeClueDetailWin(){
			//$accntDetailWin.window("close");
			$clueDetailWin.css("display", "none");
			var row = $datagrid.datagrid('getSelected');
			var index = $datagrid.datagrid('getRowIndex', row);

			$.post("${AppContext.ctxPath}/action/portal/clue/queryById", {id: row.id}, function(data){
				if(data.success){
					$datagrid.datagrid('updateRow', {index : index, row:data.result})
					$datagrid.datagrid('acceptChanges');
				}else{
					$.messager.show("错误", "更新数据错误: "+data.result, "error");
				}
			});
		}
	</script>
</body>
</html>