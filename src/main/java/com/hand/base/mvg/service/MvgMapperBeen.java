package com.hand.base.mvg.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.hand.base.promotion.model.SalesPromotionSchema;
import com.hand.base.brandWorkbench.model.Classify;
import com.hand.base.duty.model.Duty;
import com.hand.base.goods.model.Goods;
import com.hand.base.mvg.dao.mybatis.classify.mapper.ClassifyBannerMvgMapper;
import com.hand.base.mvg.dao.mybatis.order.mapper.OrderAreaMvgMapper;
import com.hand.base.mvg.dao.mybatis.order.mapper.OrderNAreaMvgMapper;
import com.hand.base.mvg.dao.mybatis.order.mapper.OrderProdMvgMapper;
import com.hand.base.mvg.dao.mybatis.sale.mapper.SalesCityMvgMapper;
import com.hand.base.mvg.dao.mybatis.sale.mapper.SalesGoodsMvgMapper;
import com.hand.base.mvg.dao.mybatis.sale.mapper.SalesTypeMvgMapper;
//import com.hand.base.forum.model.People;
//import com.hand.base.mvg.dao.mybatis.accnt.mapper.AccntPostnMvgMapper;
//import com.hand.base.mvg.dao.mybatis.forum.mapper.ForumPeopleMvgMapper;
//import com.hand.base.mvg.dao.mybatis.loyalty.mapper.PromoOrgMvgMapper;
//import com.hand.base.mvg.dao.mybatis.policy.mapper.PcyCndprodMvgMapper;
//import com.hand.base.mvg.dao.mybatis.policy.mapper.PcyrltProdMvgMapper;
//import com.hand.base.mvg.dao.mybatis.postn.mapper.ApprovalPostnMvgMapper;
//import com.hand.base.mvg.dao.mybatis.postn.mapper.ApprovalPostnTypeMvgMapper;
//import com.hand.base.mvg.dao.mybatis.product.mapper.ProductTagMvgMapper;
//import com.hand.base.mvg.dao.mybatis.qdreception.mapper.QdReceptionUserMvgMapper;
import com.hand.base.mvg.dao.mybatis.user.mapper.ApprovalUserMvgMapper;
import com.hand.base.mvg.dao.mybatis.user.mapper.UserDutyMvgMapper;
import com.hand.base.mvg.dao.mybatis.user.mapper.UserMvgMapper;
import com.hand.base.mvg.dao.mybatis.user.mapper.UserPostnMvgMapper;
import com.hand.base.o2oaddress.model.O2OAddress;
//import com.hand.base.orgnization.model.Orgnization;
import com.hand.base.position.model.Position;
//import com.hand.base.product.model.Product;
//import com.hand.base.product.model.Tag;
import com.hand.base.user.model.User;

/**
 * MvgMapper的子类的配置
 * @author qiqian.he
 *
 */
public class MvgMapperBeen {
	
	/*
	 *规范格式 & 模板
	 
	 	@Autowired
		public *MvgMapper *MvgMapper;
		public Mapper方法的参数(JavaBean) *MvgBean;
		
	 */

	/**
	 * 促销方案 大区MVG
	 */
	@Autowired
	public SalesCityMvgMapper salesCityMvgMapper;
	public SalesPromotionSchema salesCityMvgBean;
	
	/**
	 * 促销方案 默认商品MVG
	 */
	@Autowired
	public SalesGoodsMvgMapper salesGoodsMvgMapper;
	public SalesPromotionSchema salesGoodsMvgBean;
	
	/**
	 * 促销方案 促销形式MVG
	 */
	@Autowired
	public SalesTypeMvgMapper salesTypeMvgMapper;
	public SalesPromotionSchema salesTypeMvgBean;
	
	@Autowired
	public UserPostnMvgMapper userPostnMvgMapper;
	public Position userPostnMvgBean;
	
	@Autowired
	public UserDutyMvgMapper userDutyMvgMapper;
	public Duty userDutyMvgBean;
	
	@Autowired
	public UserMvgMapper userMvgMapper;
	public User userMvgBean;
	
	/*@Autowired
	public ApprovalPostnMvgMapper approvalPostnMvgMapper;
	public Position approvalPostnMvgBean;
*/
	@Autowired
	public ApprovalUserMvgMapper approvalUserMvgMapper;
	public User approvalUserMvgBean;
	/*
	@Autowired
	public ApprovalPostnTypeMvgMapper approvalPostnTypeMvgMapper;
	public ListOfValue approvalPostnTypeMvgBean;
	
	@Autowired
	public ForumPeopleMvgMapper forumPeopleMvgMapper;//论坛，选择参与人
	public People forumPeopleMvgBean;
	
	@Autowired
	public ProductTagMvgMapper productTagMvgMapper;
	public Tag productTagMvgBean;
	
	@Autowired
	public PcyCndprodMvgMapper pcyCndprodMvgMapper;
	public Product pcyCndprodMvgBean;
	@Autowired
	public PcyrltProdMvgMapper pcyrltProdMvgMapper;
	public Product pcyrltProdMvgBean;
	
	@Autowired
	public PromoOrgMvgMapper promoOrgMvgMapper;
	public Orgnization promoOrgMvgBean;
	
	@Autowired
	public QdReceptionUserMvgMapper qdReceptionUserMvgMapper;//企点接待员工
	public User qdReceptionUserMvgBean;
	
	@Autowired
	public AccntPostnMvgMapper accntPostnMvgMapper;
	public Position accntPostnMvgBean;*/
	
	@Autowired
	public OrderProdMvgMapper orderProdMvgMapper;
	public Goods orderProdMvgBean;
	
	@Autowired
	public OrderAreaMvgMapper orderAreaMvgMapper;
	public O2OAddress orderAreaMvgBean;
	
	@Autowired
	public OrderNAreaMvgMapper orderNAreaMvgMapper;
	public O2OAddress orderNAreaMvgBean;
	
	@Autowired
	public ClassifyBannerMvgMapper classifyBannerMvgMapper;
	public Classify classifyBannerMvgBean;
}
