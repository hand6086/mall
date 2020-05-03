package com.hand.base.user.controller;



import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.user.model.LoginResult;
import com.hand.base.user.model.Token;
import com.hand.base.user.service.TokenService;
import com.hand.core.util.AppConstants;
import com.hand.core.util.EncryptUtil;
import com.hand.core.util.JsonUtil;
import com.hand.core.util.StringUtils;

@Controller
@RequestMapping("/action/portal/token")
public class TokenController extends BasicController<Token>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private TokenService tokenService;

	@Override
	public BasicService<Token> getBasicService() throws Exception {
		return tokenService;
	}	 
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST, headers="Referer=http://www.hand-china.com/")
	@ResponseBody
	public String outerLogin(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Token token = null;
		String username = request.getParameter("j_username");
		String password = request.getParameter("j_password");
		try {
			// 判断是否为空
			if(StringUtils.isNull(username) || StringUtils.isNull(password)){
				return errorHandle(AppConstants.INTERFACE_QUERY_PARAM_ERROR_CODE, AppConstants.INTERFACE_QUERY_ERROR_STATUS, "参数错误！");
			}
			// 校验用户名密码
			token = tokenService.login(username, password);
			if(token.isSuccess()) return successHandle(token);
			return errorHandle(token.getCode(), AppConstants.INTERFACE_QUERY_ERROR_STATUS, token.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return errorHandle(AppConstants.INTERFACE_QUERY_OTHER_ERROR_CODE, AppConstants.INTERFACE_QUERY_ERROR_STATUS, "未知错误！");
		}
	}
	
	private static String successHandle(Token token){
		LoginResult loginResult = new LoginResult();
		loginResult.setReturnCode(AppConstants.INTERFACE_QUERY_SUCCESS_CODE);
		loginResult.setReturnStatus(AppConstants.INTERFACE_QUERY_SUCCESS_STATUS);
		loginResult.setReturnMsg("");
		try {
			String result = EncryptUtil.encryptDES(token.getToken(), token.getMdKey());
			loginResult.setToken(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return JsonUtil.toJSON(loginResult);
		
	}
	
	public static void main(String[] args) {
		
	}
	
	private static String errorHandle(String code, String status, String message){
		String result = "";
		LoginResult loginResult = new LoginResult();
		loginResult.setReturnCode(code);
		loginResult.setReturnStatus(status);
		loginResult.setReturnMsg(message);
		try {
			result = JsonUtil.toJSON(loginResult);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
		
	}
}
