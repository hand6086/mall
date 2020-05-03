$(function(){
    $(".caidan > li > a").click(function(){
    	$(".caidan > li > a").each(function(){
	    	 var menuClass = $(this).attr("class");
	    	 if(menuClass.length >2){
    	    	$(this).removeClass(menuClass);
	    		$(this).addClass(menuClass.substring(0,2));
	    	 }
	     });
    	
    	var menuClass = $(this).attr("class");
    	$(this).removeClass(menuClass);
    	$(this).addClass(menuClass+'_selected');
	});
	
    $(".sub-menu > li > a").click(function(){
        $(this).parent().parent().parent().parent().find("a").removeClass("active");
        $(this).addClass("active");
	});
	
    
	$.fn.changeMenuShow = function(menu1,menu2){
		if(menu1 == null || menu1 == '')
			return;
		var menu1List = $(".accordion > li > a");
		menu1List.each(function(index,menu){
			if($(menu).data('menuName') == menu1){
				showMenu1(menu);
				if(menu2 != null && menu2 != ''){
					var menu2List = $(menu).parent().find('ul > li > a');
					menu2List.each(function(index,subMenu){
						if($(subMenu).data('menuName') == menu2){
							showMenu2(subMenu);
						}
					});
				}
			}
		});
    };
    
    /**
     * 激活1级菜单选中状态
     */
    var showMenu1 = function(menu1){
    	$(menu1).addClass("s1").parent().siblings().find("a").removeClass("s1");
    	$(".accordion > li > a > span.brightBlue").each(function(){
	    	 $(this).removeClass("brightBlue");
	     });
    	$(menu1).children("span").addClass("brightBlue");
    	$(menu1).parents().siblings().find(".sub-menu").hide(300);
    	$(menu1).siblings(".sub-menu").toggle(300);
    }

    /**
     * 激活2级菜单选中状态
     */
    var showMenu2 = function(menu2){
        $(menu2).parent().parent().parent().parent().find("a").removeClass("active");
        $(menu2).addClass("active");
    }
})

function changMenuSeleted(menuText){
	var caidanList = $('.caidan > li');
 	 for(var i=0; caidanList != null && i<caidanList.length;i++){
 		 var item = caidanList[i];
 		if($('a > font',item).html() == menuText){
 			var times = Math.floor(i/6);
 			moveMainMenuLeft(times * 600);
 			$(".caidan > li > a").each(function(){
 		    	 var menuClass = $(this).attr("class");
 		    	 if(menuClass.length >2){
 	    	    	$(this).removeClass(menuClass);
 		    		$(this).addClass(menuClass.substring(0,2));
 		    	 }
 		     });
 	    	
 	    	var menuClass = $('a',item).attr("class");
 	    	$('a',item).removeClass(menuClass);
 	    	$('a',item).addClass(menuClass+'_selected');
 		}
 	 }
}

var moveMainMenuRight = function(length){
	var obj=document.getElementById('caidan');
	if(length != null){
		obj.scrollLeft = length;
		return ;
	}
	obj.scrollLeft += 600;
}

var moveMainMenuLeft = function(length){
	var obj=document.getElementById('caidan');
	if(length != null){
		obj.scrollLeft = length;
		return ;
	}
	obj.scrollLeft -= 600;
	if(obj.scrollLeft < 0){
		obj.scrollLeft = 0;
	}
}
