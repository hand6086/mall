package com.hand.base.audittrail.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import com.hand.base.audittrail.model.AuditTrail;
import com.hand.base.audittrail.service.AuditTrailService;
import com.hand.base.basic.service.LovService;
import com.hand.base.user.model.User;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import com.hand.core.util.Constants;
import com.hand.core.util.LOVUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;


/**
 * 
 * <p>审计追踪Controller</p>
 * <p>Description</p>
 * <p>Company</p>
 * @author hhx
 * @date 2016年10月8日
 */
@Controller
@RequestMapping("/action/portal/auditTrail")
public class PortalAuditTrailController extends BasicController<AuditTrail> {

	private static final Logger logger = LogManager.getLogger(PortalAuditTrailController.class); 
	@Autowired
	private AuditTrailService auditTrailService;
	@Autowired
	private LovService lovService;
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	
	@Override
	public BasicService<AuditTrail>  getBasicService() throws Exception{
		return auditTrailService;
	}

	@Override
	@RequestMapping(value = "/preDefaultValue", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Object> preDefaultValue(AuditTrail entity, HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			AuditTrail newEntity = new AuditTrail();
			User user = UserUtil.getUser(session);
			SimpleDateFormat dfFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date myDate = new Date();
			String sysdate = dfFormat.format(myDate);
			newEntity.setDateTime(sysdate);
			newEntity.setUserId(user.getId());
			newEntity.setUserName(user.getUsername());
			result.put("success", true);
			result.put("result", newEntity);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	/**
	 * 删除一条记录
	 */
	@RequestMapping(value = "/deleteByIdNew")
	@ResponseBody
	public Map<String, Object> deleteById(AuditTrail entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("删除一条列表信息...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			beforDelete(entity, request);
			checkData(entity, request);
			if(!checkExistDataCache("base", session, entity)){
				throw new BasicServiceException("非法删除数据！");
			}
			auditTrailService.deleteById(entity);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

}
