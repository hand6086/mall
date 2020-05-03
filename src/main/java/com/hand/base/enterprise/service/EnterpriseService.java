package com.hand.base.enterprise.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.enterprise.model.Enterprise;
import com.hand.base.o2oaccnt.model.UserAudit;
import com.hand.base.user.model.User;

public interface EnterpriseService extends BasicService<Enterprise> {

	public void userAuditImageUpate(UserAudit record, List<Image> list) throws BasicServiceException;

	/**
	 * 企业入驻
	 * 
	 * @throws BasicServiceException
	 */
	public Enterprise enterPriseIn(Enterprise record) throws BasicServiceException;

	/**
	 * 初始化企业
	 * 
	 * @throws BasicServiceException
	 */
	public void initializeCompany(CallParam record) throws BasicServiceException;

	/**
	 * 删除企业
	 * 
	 * @throws BasicServiceException
	 */
	public void deleteCompany(CallParam record) throws Exception;

	/**
	 * 通过企业编号查询一个企业信息
	 * 
	 * @param code
	 *            企业编号
	 */
	public Enterprise queryByCode(String code) throws Exception;


	/**
	 * 更新二维码图片ID
	 * 
	 * @param record
	 * @param list
	 * @throws BasicServiceException
	 */
	public void qrCodeImageUpate(Enterprise record, List<Image> list) throws BasicServiceException;

	/**
	 * <p>
	 * 企点
	 * </p>
	 * 第三方授权信息更新
	 * 
	 * @param record
	 * @throws Exception
	 */
	public void qidianAuthUpdate(Enterprise record) throws Exception;

	/**
	 * <p>
	 * 企点
	 * </p>
	 * 更新授权方的接口调用凭证
	 * 
	 * @param record
	 * @throws Exception
	 */
	public void authAccessTokenUpdate(Enterprise record) throws Exception;

	/**
	 * 查询所有关联了企点的企业
	 * 
	 * @return
	 */
	public List<Enterprise> queryQidianEnt() throws Exception;

	/**
	 * 根据授权方appid查询企业
	 * 
	 * @param qps
	 * @return
	 */
	public List<Enterprise> queryByAuthAppidPage(String authAppid) throws Exception;

	/**
	 * 查询当前登录用户所属企业的企点token
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryQiDianToken() throws Exception;

	public void dutyInsert(Enterprise entity) throws Exception;

	public void dutyUpdate(Enterprise entity) throws Exception;

	public void defaultMenuInsert(Enterprise entity) throws Exception;

	/**
	 * 审批通过之后更新商户状态，审批通过
	 */
	public void storeStatusPassUpdate(Enterprise record) throws Exception;

	/**
	 * 押金支付之后更改商户状态，押金支付
	 */
	public void storeStatusPayUpdate(Enterprise record) throws Exception;
	
	/**
	 * 确认转账之后更改商户状态，确认转账
	 */
	public void storeStatuspassedNopaidUpdate(Enterprise record) throws Exception;

	/**
	 * 审批拒绝之后更改商户状态，审批拒绝
	 */
	public void storeStatusRejectUpdate(Enterprise record) throws Exception;

	/**
	 * 根据userID查询企业
	 */
	public Enterprise queryByUserId(Enterprise entity) throws Exception;
	
	/**
	 * 根据entpId查询企业
	 */
	public Enterprise queryByEntpID(Enterprise entity) throws Exception;

	/**
	 * 更据企业去查询押金明细
	 */
	public List<Enterprise> queryDepositDetailsPage(Enterprise entity) throws Exception;
	
	/**
	 * 押金记录新建
	 */
	public void depositDetailsInsert(Enterprise record) throws Exception;
	/**
	 * 客服信息查询
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Enterprise> queryCustomerServicePage(Enterprise entity) throws Exception;
	
	/**
	 * 新建客服
	 * @param record
	 * @throws Exception
	 */
	public void customerServiceInsert(Enterprise record) throws Exception;
	/**
	 * 审批意见更新
	 * @param record
	 * @throws Exception
	 */
	public void approvalOpinionUpdate(Enterprise record) throws Exception;
	
	/**
	 * 转账验证码
	 * @param record
	 * @throws Exception
	 */
	public void transferCodeUpdate(Enterprise record) throws Exception;
	
	/**
	 * 查询网店管理员信息
	 * @param entity
	 * @return
	 * @throws Exception
	 */
	public List<Enterprise> queryShopKeeperPage(Enterprise entity) throws Exception;
	
	/**
	 * 新建店铺管理员
	 * @param record
	 * @throws Exception
	 */
	public void shopKeeperInsert(Enterprise record,User user) throws Exception;
}
