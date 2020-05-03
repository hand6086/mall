package com.hand.base.tablemanage.service;
import java.util.List;
import com.hand.base.basic.service.BasicService;
import com.hand.base.platformfavorable.model.Platformfavorable;
import com.hand.base.tablemanage.model.tableManage;

public interface tableManageService extends BasicService<tableManage> {

	List<tableManage> queryFieldPage(tableManage t)throws Exception;

	public  void filedInsert(tableManage entity)throws Exception;

	public  void filedupdate(tableManage entity)throws Exception;

	public void deletefiledId(tableManage entity)throws Exception;
	


}
