$.extend($.fn.hdatagrid.methods,{  
    columnMoving:function(jq){  
        return jq.each(function(){  
            var grid = this;  
              
            var $directionDiv = $("<div></div>");  
              
            $directionDiv.hide();  
              
            $("body").append($directionDiv);  
              
            $(grid).datagrid("getPanel")  
                    .find(".datagrid-header td[field]").draggable({  
                revert:true,  
                cursor:"move",  
                deltaX:10,  
                deltaY:10,  
                edge:10,  
                proxy:function(source){  
                    var $proxyEl = $("<div></div>");  
                      
                    $proxyEl.addClass("dg-proxy dg-proxy-error");  
                      
                    $proxyEl.text($(source).text());  
                      
                    $proxyEl.appendTo($("body"));  
                      
                    return $proxyEl;  
                }  
            }).droppable({  
                accept:".datagrid-header td[field]",  
                onDragOver:function(e,source){  
                    $(source).draggable("proxy").removeClass("dg-proxy-error").addClass("dg-proxy-right");  
                      
                    $(".dg-hide-div").hide();  
                      
                    var thisIndex = $(this).index();  
                    var sourceIndex = $(source).index();  
                      
                    var className = null;  
                      
                    var height = null;  
                      
                    var thisOffset = null;  
                      
                    var left = null;  
                    var top = null;  
                      
                    height = $(this).height();  
                      
                    if(sourceIndex > thisIndex){  
                        className = "dg-move-prev";  
  
                        thisOffset = $(this).offset();  
                          
                        left = thisOffset.left;  
                        top = thisOffset.top;  
                    }else{  
                        className = "dg-move-next";  
                          
                        if(thisIndex == $(this).parent().children(":last").index()){  
                            thisOffset = $(this).offset();  
                              
                            left = thisOffset.left + $(this).width() - $directionDiv.width();  
                            top = thisOffset.top;  
                        }else{  
                            thisOffset = $(this).next().offset();  
                              
                            left = thisOffset.left - $directionDiv.width();  
                            top = thisOffset.top;  
                        }  
                    }  
                      
                    $directionDiv.removeClass().addClass(className);  
                    $directionDiv.css({height:height, left:left, top:top});  
                    $directionDiv.show();  
                },  
                onDragLeave:function(e,source){  
                    $(source).draggable("proxy").removeClass("dg-proxy-right").addClass("dg-proxy-error");  
                      
                    $directionDiv.hide();  
                },  
                onDrop:function(e,source){  
                	//释放元素
                    $directionDiv.remove(); 
                    
                    //datagrid-view1是冻结模块，用来显示行号及冻结列，需要与datagrid-view2区分
                    var viewClass = "";
                    if($(this).closest(".datagrid-view1").length && $(source).closest(".datagrid-view1").length){
                    	viewClass = ".datagrid-view1";
                    }else if($(this).closest(".datagrid-view2").length && $(source).closest(".datagrid-view2").length){
                    	viewClass = ".datagrid-view2";
                    }else{
                    	//目前只允许在相同模块区域内进行列拖曳
                    	return ;
                    }
                    var thisIndex = $(this).index();  
                    var sourceIndex = $(source).index();  
                    swapField(source, this, viewClass);
                    
                    
                    var sourceCol = new Array();  
                      
                    $(source).detach(); //不移除绑定事件
                    $.each($(grid).datagrid("getPanel")  
                                    .find(viewClass+" .datagrid-body tr"),function(index,obj){  
                        var sourceTd = $(obj).children("td:eq(" + sourceIndex + ")");  
                          
                        sourceCol.push(sourceTd);  
                          
                        sourceTd.detach();  
                    });  
                      
                    var prev = sourceIndex > thisIndex;  
                    thisIndex = $(this).index();  
                    if(prev){  
                        $(this).before($(source));  
                    }else{  
                        $(this).after($(source));  
                    }  
                    
                    //列内容进行移动
                    $.each($(grid).datagrid("getPanel")
                                    .find(viewClass+" .datagrid-body tr"),function(index,obj){  
                        var thisTd = $(obj).children("td:eq(" + thisIndex + ")");  
                          
                        if(prev){  
                            thisTd.before(sourceCol[index]);  
                        }else{  
                            thisTd.after(sourceCol[index]);  
                        }  
                    });  
                    
                    //$(grid).datagrid("columnMoving");
                }  
            });
            
            function swapField(source, target, viewClass){
            	var sourceIndex = $(source).index();
            	var targetIndex = $(target).index();
            	//console.log("sourceIndex: "+sourceIndex+", targetIndex: "+targetIndex);
            	var columns = [];
            	if(viewClass == ".datagrid-view1"){
            		if($(grid).datagrid("options").rownumbers == true){
            			//如果显示行号，则options冻结列对应索引等于html元素索引减一
            			sourceIndex--;
            			targetIndex--;
            		}
            		columns = $(grid).datagrid('options').frozenColumns[0];
            	}else if(viewClass == ".datagrid-view2"){
            		columns = $(grid).datagrid('options').columns[0]; 
            	}
                var sourceField = columns[sourceIndex];
                var targetField = columns[targetIndex];
                
            	if(sourceIndex > targetIndex){
            		//列往前移
            		for(var i=sourceIndex; i > targetIndex; i--){
            			columns[i] = columns[i-1];
            		}
            		columns[targetIndex] = sourceField; 
            	}else if(sourceIndex < targetIndex){
            		//列往后移
            		for(var i=sourceIndex; i < targetIndex; i++){
            			columns[i] = columns[i+1];
            		}
            		columns[targetIndex] = sourceField; 
            	}
            }
        });  
        
       
    }  
});  