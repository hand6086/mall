package com.hand.base.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.CallParam;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.User;
import com.hand.base.user.service.UserImpService;
import com.hand.base.user.service.UserService;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.imports.ImportReader;
import com.hand.core.modules.imports.ImportsFactory;
import com.hand.core.util.PasswordUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Controller
@RequestMapping("/portal/userImp")
public class PortalUserImpController extends BasicController<User>{
	
	private static final Logger logger = LogManager.getLogger(PortalUserImpController.class);
	
	@Resource
	private UserImpService userImpService;
	
	@Resource
	private UserService userService;
	
	/*@Resource
	private LdapShaPasswordEncoder passwordEncoder;*/
	
	@Resource
	private KeyGenerateService keyGenerateService;
	
	public BasicService<User> getBasicService(){
		return userImpService;
	}
	
	@Override
	@RequestMapping(value = "/importData")
	@ResponseBody
	@Transactional
	public Map<String, Object> importData(User record, QueryParams qps, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		logger.info("导入用户列表...");
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			ImportReader importReader= ImportsFactory.newInstance(qps,request);
			List<User> list = importReader.readList(User.class);
			for(int i =0;list != null && i<list.size() ;i++){
				record = list.get(i);			
				User checkUser1 = userImpService.queryByUsername(record.getUsername());
				User checkUser2 = userService.getUserByUsername(record.getUsername());
				if(checkUser1 != null || checkUser2 != null){
					result.put("success", false);
					result.put("result", "导入失败！不能重复创建用户名：" + record.getUsername());
					return result;
				}
				String encodedNewPassword = PasswordUtil.generatePwd("111111");//passwordEncoder.encodePassword("111111",null);
				record.setPassword(encodedNewPassword);
				record.setId(keyGenerateService.keyGenerate());
				userImpService.insert(record);
			}
			result.put("success", true);
			result.put("total", list.size());
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@Override
	@RequestMapping(value = "/upsert")
	@ResponseBody
	public Map<String, Object> upsert(User record, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			User checkUser1 = userImpService.queryByUsername(record.getUsername());
		    User checkUser2 = userService.getUserByUsername(record.getUsername());
		    String selectId = record.getId();
		    if(checkUser1 != null){
				String recordId = checkUser1.getId();
				if(!selectId.equals(recordId)){
					result.put("success", false);
					result.put("result", "用户名：" + record.getUsername() + "已存在，不能重复创建！");
					return result;
				}
			}
		    if(checkUser2 != null){
				result.put("success", false);
				result.put("result", "用户名：" + record.getUsername() + "已存在，不能重复创建！");
				return result;
			}
		    
			if(!getBasicService().isInsertFlag(record) && !checkExistDataCache("base", session, record)){
				throw new BasicServiceException("非法更新数据！");
			}
			String encodedNewPassword = PasswordUtil.generatePwd("111111");//passwordEncoder.encodePassword("111111",null);
			if(StringUtils.equals(record.getRow_status(), "NEW")){
				record.setPassword(encodedNewPassword);
			}
			getBasicService().upsert(record);
			User newEntry = getBasicService().queryById(record);
			result.put("newRow", newEntry);
			result.put("success", true);
		}catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
		
	}
	
	@Override
	public void beforQueryAllOrExample(User entity, HttpServletRequest request) throws Exception{
		User user = UserUtil.getUser(null);
		if(entity.getConditionSql() == null){
			entity.setConditionSql("");
		}
		entity.setConditionSql(entity.getConditionSql()+" and createdBy="+"'"+user.getId()+"'");
	}
	
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> check(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			userImpService.runUserCheck(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
	
	@RequestMapping(value = "/userImpInsert", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> userImpInsert(CallParam callParam, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			userImpService.runNewUserForimp(callParam);
			result.put("success", true);
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
