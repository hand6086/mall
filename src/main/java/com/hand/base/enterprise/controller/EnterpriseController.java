package com.hand.base.enterprise.controller;



import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Image;
import com.hand.base.common.service.MenuService;
import com.hand.base.common.service.MyFileService;
import com.hand.base.duty.service.DutyService;
import com.hand.base.enterprise.model.Enterprise;
import com.hand.base.enterprise.service.EnterpriseService;
import com.hand.base.o2oaccnt.model.UserAudit;
//import com.hand.base.product.model.PriceList;
//import com.hand.base.product.service.PriceListService;
import com.hand.base.user.model.User;
import com.hand.base.user.service.UserService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.FileUtil;
import com.hand.core.util.UserUtil;

@Controller("EnterpriseController")
@RequestMapping("/action/portal/enterprise")
public class EnterpriseController extends BasicController<Enterprise>{
	@Resource
	private MenuService menuService;
	
	@Resource
	private DutyService dutyService;
 
	@Resource
	private MyFileService myFileService;
	
	@Resource
	private EnterpriseService enterpriseService;
	
	@Resource
	private UserService userService;
	
	@Override
	public BasicService<Enterprise> getBasicService() throws Exception {
		return enterpriseService;
	}
	
	@RequestMapping(value = "/uploadImg", method = RequestMethod.POST)
	@ResponseBody
	public void uploadImg(UserAudit record, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String url="";
		Map<String, Object> result = new HashMap<String, Object>();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request; 
		List<MultipartFile> myfiles=multipartRequest.getFiles("myfiles");
		if(!FileUtil.validateIsAllImage(myfiles)){
			throw new BasicControllerException("上上传图片格式错误！");
		}
		try{
			// 上传图片到服务器
			List<Image> list = myFileService.imgUpload(myfiles);
			for(int i=0;i<list.size();i++){
				Image image=list.get(i);
				//url=image.getId();
				result.put("result",image);
			}
			result.put("success", true);
			//result.put("result", list.get(list.size()-1));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		
		try {
			ObjectMapper objectMapper = new ObjectMapper(); 
			OutputStream os;
    		response.setContentType("text/html;charset=UTF-8");  
			os = response.getOutputStream();
			JsonGenerator jsonGenerator = objectMapper.getFactory().createGenerator(os);
			jsonGenerator.writeObject(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	@RequestMapping(value = "/upsert")
	@ResponseBody
	public Map<String, Object> upsert(Enterprise entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforUpsert(entity, request);
			checkData(entity, request);
			
			Enterprise newEntry = enterpriseService.enterPriseIn(entity);
			auditTrailInsert(entity, request, session, "US"); // 审计追踪新建记录
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	
	@RequestMapping(value = "/deleteCompany")
	@ResponseBody
	public Map<String, Object> deleteCompany(Enterprise entity, CallParam callParam, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		//logger.info("删除一条列表信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User user=UserUtil.getUser(null);
			if( "000".equals(entity.getCode()) || "101".equals(entity.getCode()) || "102".equals(entity.getCode()) || user.getCorpid().equals(entity.getCode()) ){
				result.put("success", false);
				result.put("result", "安全性限制，您不能删除该条记录！");
				return result;
			}
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法删除数据！");
			}
			auditTrailInsert(entity,request,session,"D");    //审计追踪新建记录
			callParam.setParam1(entity.getId());
			callParam.setParam2(entity.getCode());
			enterpriseService.deleteCompany(callParam);
			if("OK".equals(callParam.getReturnStatus())){
				result.put("success", true);
				//throw new Exception(callParam.getMsgData());
			}else{
				throw new Exception(callParam.getMsgData());
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/initNew")
	@ResponseBody
	public Map<String, Object> initNew(QueryParams qps, HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Enterprise enterprise = new Enterprise();
			//enterprise.setId(keyGenerateService.keyGenerate());
			enterprise.setRow_status("NEW");//标记
			result.put("success", true);
			result.put("result", enterprise);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/storeStatusPassUpdate")
	@ResponseBody
	public Map<String, Object> storeStatusPassUpdate(QueryParams qps,Enterprise entity ,HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.storeStatusPassUpdate(entity);
			result.put("success", true);
			result.put("result", entity);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/storeStatuspassedNopaidUpdate")
	@ResponseBody
	public Map<String, Object> storeStatuspassedNopaidUpdate(QueryParams qps,Enterprise entity ,HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.storeStatuspassedNopaidUpdate(entity);
			result.put("success", true);
			result.put("result", entity);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value="/storeStatusPayUpdate")
	@ResponseBody
	public Map<String, Object> storeStatusPayUpdate(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Enterprise newEntity = enterpriseService.queryByEntpID(entity);
			enterpriseService.storeStatusPayUpdate(newEntity);
			result.put("success", true);
			result.put("result", entity);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value="/storeStatusRejectUpdate")
	@ResponseBody
	public Map<String, Object> storeStatusRejectUpdate(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.storeStatusRejectUpdate(entity);
			result.put("success", true);
			result.put("result", entity);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	@RequestMapping(value="/queryByUserId")
	@ResponseBody
	public Map<String, Object> queryByUserId(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			Enterprise enterprise= enterpriseService.queryByUserId(entity);
			result.put("success", true);
			result.put("result",enterprise);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询一条记录
	 */
	@RequestMapping(value = "/queryById")
	@ResponseBody
	public Map<String, Object> queryById(Enterprise entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = UserUtil.getUser(session);
		try{
			Enterprise record = null;
			if("101".equals(user.getUsercorpid()) && "0".equals(entity.getBrandQuery())){
				record = getBasicService().queryById(entity);
			}else{
				record = getBasicService().brandQueryById(entity);
			}
			if(record !=null){
				String realPath = AppConstants.portalSharePicHttpDir;
				record.setpIdentifiCard(realPath+record.getpIdentifiCard());
				record.setnIdtifiCard(realPath+record.getnIdtifiCard());
				record.setBusinessLicense(realPath+record.getBusinessLicense());
				record.setOpenAccountLicense(realPath +record.getOpenAccountLicense());
				record.setQualityReport(realPath+ record.getQualityReport());
				record.setCertificateRegistration(realPath + record.getCertificateRegistration());
				record.setAuthorizationCertificate(realPath + record.getAuthorizationCertificate());
				record.setStoreLogo(realPath +record.getStoreLogo());
			}
			List<Enterprise> list = new ArrayList<Enterprise>();
			list.add(record);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("result", record);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 押金管理界面查询行信息
	 */
	@RequestMapping(value="/queryDepositDetailsPage",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryDepositDetailsPage(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			entity = (Enterprise) BasicModel.transformClass(Enterprise.class, qps);
			List<Enterprise> list= enterpriseService.queryDepositDetailsPage(entity);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) entity), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查询网店管理人员信息
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/queryShopKeeperPage",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryShopKeeperPage(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			entity = (Enterprise) BasicModel.transformClass(Enterprise.class, qps);
			List<Enterprise> list= enterpriseService.queryShopKeeperPage(entity);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) entity), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建客户
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/customerServiceInsert")
	@ResponseBody
	public Map<String, Object> customerServiceInsert(Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.customerServiceInsert(entity);
			
			auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
			
			Enterprise newEntry = getBasicService().queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	/**
	 * 客服信息查询
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/queryCustomerServicePage",method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryCustomerServicePage(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			entity = (Enterprise) BasicModel.transformClass(Enterprise.class, qps);
			List<Enterprise> list= enterpriseService.queryCustomerServicePage(entity);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) entity), list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 押金明细插入
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/depositDetailsInsert")
	@ResponseBody
	public Map<String, Object> depositDetailsInsert(Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.depositDetailsInsert(entity);
			
			auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
			
			Enterprise newEntry = getBasicService().queryById(entity);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 更新审批意见
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/approvalOpinionUpdate")
	@ResponseBody
	public Map<String, Object> approvalOpinionUpdate(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.approvalOpinionUpdate(entity);
			result.put("success", true);
			result.put("result", entity);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 转账验证码
	 * @param qps
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/transferCodeUpdate")
	@ResponseBody
	public Map<String, Object> transferCodeUpdate(QueryParams qps,Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			enterpriseService.transferCodeUpdate(entity);
			result.put("success", true);
			result.put("result", entity);
			return result;
		}catch(Exception e){
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 新建店铺管理员
	 * @param entity
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/shopKeeperInsert")
	@ResponseBody
	public Map<String, Object> shopKeeperInsert(Enterprise entity , HttpSession session, HttpServletRequest request,HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User user = UserUtil.getUser(null);
			entity.setCrmDutyId(user.getDutyId());
			User checkUser = userService.getUserByUsername(entity.getApplicantPhone());
			if(checkUser != null){
				throw new BasicControllerException("用户名：" + entity.getApplicantPhone() + "已存在，不能重复创建！");
			}
			enterpriseService.shopKeeperInsert(entity,user);
			
			auditTrailInsert(entity,request,session,"N");    //审计追踪新建记录
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
