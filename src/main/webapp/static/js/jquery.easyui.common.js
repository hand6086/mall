/**
 * 弹出导出筛选条件
 * @param exportTitle
 * @param paramsUrl
 * @param exportUrl
 * @param paramsObj
 */
function exportParams(exportTitle, paramsUrl, paramsObj)
{
	var diag = new Dialog();
	diag.Width = $(window).width() * 0.6;
	diag.Height = $(window).height() * 0.6;
	diag.Title = exportTitle;
	diag.URL = paramsUrl;
	diag.OKEvent = function(){
		diag.innerWin.exportExcute(diag);
	};
	diag.show();
}

function importParams()
{
	var diag = new Dialog();
	diag.Width = $(window).width() * 0.2;
	diag.Height = $(window).height() * 0.2;
	diag.Title = "选择导入文件";
	diag.URL = "/portal/exportParams/ImportParams.jsp";
	diag.OKEvent = function(){
		
	};
	diag.show();
}

function importImg(id, obj)
{
	var diag = new Dialog();
	diag.Width = $(window).width() * 0.2;
	diag.Height = $(window).height() * 0.2;
	diag.Title = "选择上传图片";
	diag.URL = "/portal/exportParams/ImportImg.jsp";
	diag.OKEvent = function(){
		diag.innerWin.$('#productId').val(id);
		diag.innerWin.uploadImg(obj, diag);
	};
	diag.show();
}

//上传图片
function importImgPicklist(id, obj){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: "选择上传图片",     
           width: $(window).width() * 0.2,     
           height: $(window).width() * 0.2, 
           href: '/portal/exportParams/ImportImg.jsp',     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	window.parent.$('#productId').val(id);
                	window.parent.uploadImg(obj, $dialog);
                }    
            }]  
      });    
}

//上传图片（多个图片）
function importThreeImgsPicklist(id, obj,prodImgId,imgNo,url){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: "选择上传图片",     
           width: $(window).width() * 0.2,     
           height: $(window).width() * 0.2, 
           href: '/portal/exportParams/ImportThreeImgs.jsp',     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	window.parent.$('#productId').val(id);
                	window.parent.$('#prodImgId').val(prodImgId);
                	window.parent.$('#imgNo').val(imgNo);
                	window.parent.uploadImg(obj, $dialog,url);
                }    
            }]  
      });    
}

//导出Excel
function exportParamsPicklist(exportTitle, paramsUrl, paramsObj){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: exportTitle,     
           width: $(window).width() * 0.2,     
           height: $(window).width() * 0.2, 
           href: paramsUrl,     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	window.parent.exportExcel();
                	$dialog.dialog('close');
                }    
            }]  
      });    
}

//导出Excel
function exportParamsPicklist(exportTitle, paramsUrl, paramsObj){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: exportTitle,     
           width: $(window).width() * 0.2,     
           height: $(window).width() * 0.2, 
           href: paramsUrl,     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	window.parent.exportExcel();
                	$dialog.dialog('close');
                }    
            }]  
      });    
}


//导入Excel
/*function importParamsPicklist(){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: "选择上传Excel文件",     
           width: $(window).width() * 0.2,     
           height: $(window).width() * 0.2, 
           href: '/portal/exportParams/ImportParams.jsp',     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	window.parent.uploadExcel($dialog);
                }    
            }]  
      });    
}*/

 
//导入Excel
function importParamsPicklist(obj, url, headId){
	var $dialog = parent.window.$('#picklistid');
	$dialog.dialog({     
           title: "选择上传Excel文件",     
           width: $(window).width() * 0.2,     
           height: $(window).width() * 0.2, 
           href: '/portal/exportParams/ImportParams.jsp',     
           modal: true,  
           buttons : [{    
                text : '确定',    
                iconCls : 'icon-ok',
                width: '100px',
                handler : function() {   
                	window.parent.uploadExcel($dialog, obj, url, headId);
                }    
            }]  
      });    
}

