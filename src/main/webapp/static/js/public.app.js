/**
 * CRM和DMS共用的js
 * 每个方法都必须写下详细的注释
 * Created by heqq on 2017/10/20
 */

/**
 * 计算获取菜单标记, 返回各标记属性组成的新对象
 * @param menu 二级菜单
 * @param securityMenu 安全性菜单
 * @returns {___anonymous23816_23817}
 * @author yaorunfa
 */
function getMenuFlag(menu, securityMenu){
	var obj = {};
	if(!securityMenu){
		if (menu.readonlyFlag == "Y") {
			obj.readonlyFlag = "Y"
			obj.addFlag = "N";//只读，作用于子页面
			obj.editFlag = "N";
			obj.deleteFlag = "N";
		} else {
			obj.readonlyFlag = "N";
			obj.addFlag = menu.addFlag;
			obj.editFlag = menu.editFlag;
			obj.deleteFlag = menu.deleteFlag;
		}
		obj.oauth = "";
		obj.defaultNoQueryFlag = menu.defaultNoQueryFlag;
		obj.exportFlag = menu.exportFlag;
		obj.openNewpageFlag = menu.openNewpageFlag;
	}else if(securityMenu){
		//根据菜单配置，设置页面可见性
		if (menu.readonlyFlag == "Y") {//只读标记为Y,则增删改标记都设为N
			obj.readonlyFlag = "Y"
			obj.addFlag = "N";
			obj.editFlag = "N";
			obj.deleteFlag = "N";
		} else {
			if (securityMenu.readonlyFlag == "Y") {//安全性菜单只读标记为Y
				obj.readonlyFlag = "Y"
				obj.addFlag = "N";
				obj.editFlag = "N";
				obj.deleteFlag = "N";
			} else {
				obj.readonlyFlag = "N";
				obj.addFlag = securityMenu.addFlag;
				obj.editFlag = securityMenu.editFlag;
				obj.deleteFlag = securityMenu.deleteFlag;
			}
		}
		obj.oauth = securityMenu.oauthType;
		//obj.defaultNoQueryFlag = securityMenu.defaultNoQueryFlag;
		obj.exportFlag = securityMenu.exportFlag;
		//obj.openNewpageFlag = securityMenu.openNewpageFlag;
	}
	obj.defaultNoQueryFlag = menu.defaultNoQueryFlag;
	obj.openNewpageFlag = menu.openNewpageFlag;
	return obj;
}