package com.hand.base.servicemanage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.servicemanage.dao.mybatis.mapper.AfterSaleMapper;
import com.hand.base.servicemanage.model.AfterSale;
import com.hand.base.smscode.service.SmsService;
import com.hand.base.user.dao.mybatis.mapper.AppUserMapper;
import com.hand.base.user.model.AppUser;
import com.hand.base.workbench.service.MesPushService;
import com.hand.core.util.SmsUtil;

@Service
public class AfterSaleServiceImpl extends BasicServiceImpl<AfterSale>
		implements AfterSaleService {
	@Autowired
	private AfterSaleMapper afterSaleMapper;
	
	@Autowired
	private AppUserMapper userMapper;
	
	@Autowired
	private MesPushService pdService;
	
	@Autowired
	private SmsService smsService;

	public BasicMapper<AfterSale> getBasicMapper() throws Exception {
		if (afterSaleMapper != null) {
			return afterSaleMapper;
		}
		throw new BasicServiceException("获取Basic Mapper 失败，请确认程序是否正确！");
	}

	/**
	 * 查询该记录的所有申请照片的URL
	 * @param qps
	 * @return
	 */
	public List<AfterSale> queryApplyPicAll(AfterSale entity) throws Exception{
		checkId(entity);
		return afterSaleMapper.queryApplyPicAll(entity);
	}
	
	/**
	 * 查询该记录的所有退货照片的URL
	 * @param qps
	 * @return
	 */
	public List<AfterSale> queryReturnPicAll(AfterSale entity) throws Exception{
		checkId(entity);
		return afterSaleMapper.queryReturnPicAll(entity);
	}
	
	@Override
	public void afterUpdate(AfterSale entity) throws Exception{
		if("push".equals(entity.getAttr1())){
			String notifyType = entity.getAttr2();
			entity = afterSaleMapper.queryById(entity);
			AppUser user = new AppUser();
			user.setPageFlag(false);
			user.setAttr1("storeInfo");
			user.setAttr2(entity.getCustomerId());
			List<AppUser> userList = userMapper.queryByExamplePage(user);
			if(userList.size() != 0){
				user = userMapper.queryByExamplePage(user).get(0);
				SmsUtil.notifUser(user, "", pdService, smsService, notifyType, entity.getOrderId(),
						entity.getOrderNumber(), "", "", "", "", "");
			}
		}
	}
}
