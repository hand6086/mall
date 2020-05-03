package com.hand.base.user.authority;

import java.util.Map;

import javax.naming.directory.DirContext;

import org.springframework.security.authentication.encoding.PasswordEncoder;

import com.hand.base.user.login.HandTempPass;
import com.hand.base.user.model.User;
import com.hand.core.util.PasswordUtil;

@SuppressWarnings("deprecation")
public class UserPasswordEncoder implements PasswordEncoder{

	/*@Resource
	private LdapShaPasswordEncoder passwordEncoder;*/
	
	public static Map<String, HandTempPass> passwordMap;
	
	public String encodePassword(String rawPass, Object salt) {
		return null;
	}

	public boolean webserviceValid(String encPass,String rawPass,String corpId,String userName){
		User user = new User();
		user.setCorpid(corpId);
		user.setUsername(userName);
		return isPasswordValid(encPass, rawPass, user) ;
	}
	@SuppressWarnings("unchecked")
	public boolean isPasswordValid(String encPass, String rawPass, Object salt) {

		return PasswordUtil.isEquals(rawPass, encPass);
		//return passwordEncoder.isPasswordValid(encPass, rawPass, null);
		
//		User user = (User)salt;
//		if(passwordMap == null){
//			passwordMap = new HashMap<String,HandTempPass>();
//		}
//		if("102".equals(user.getCorpid())){
//			HandTempPass tempPass = passwordMap.get(user.getUsername());
//			if(tempPass != null){
//				if(tempPass.getPasswd() != null && tempPass.getPasswd().equals(rawPass)){
//					if((DateUtil.getCurrentTime() -tempPass.getRemenberedTime()) < 24*60*60*1000L){
//						return true;
//					}else{
//						//如果缓存超过1天，缓存失效
//						passwordMap.remove(user.getUsername());
//					}
//				}
//			}
//			try{
//				JSONObject obj = new JSONObject();
//				JSONObject params = new JSONObject();
//				params.put("p_user_name", user.getUsername());
//				params.put("p_password", rawPass);
//				obj.put("params", params);
//				String content = obj.toJSONString();
//				String result = HttpRequestUtil.sendPost("http://mobile-app.hand-china.com/hmbms_hand/api/appLogin/user_login/login",content,null);
//				Gson gson = new Gson();
//				HandResult loginResult = gson.fromJson(result, HandResult.class);
//				if(loginResult.getEmpno() != null){
//					HandTempPass newPass = new HandTempPass();
//					newPass.setPasswd(rawPass);
//					newPass.setRemenberedTime(DateUtil.getCurrentTime());
//					passwordMap.put(user.getUsername(), newPass);
//					return true;
//				}
//				return false;
//			}catch(Exception e){
//				e.printStackTrace();
//				throw new BadCredentialsException("登录认证网络异常，请稍后重试！");
//			}
//		}else{
//		}
	}
	
	/** 
	* 根据LDAP用户名密码验证 
	* @param userDn 
	* @param credentials 
	* @return 
	*/  
   public boolean ldapAuthenticate(String userDn, String credentials) { 
	   DirContext ctx = null;   
	   return true;
	 /*  try {
		   ctx = ldapTemplate.getContextSource().getContext("Manager",  
				   "secret");
		   return true;  
       } catch (Exception e) {
    	   e.printStackTrace();
           return false;  
       } finally {  
           LdapUtils.closeContext(ctx);  
       }  */
   }
   
   /*public static void checkPassword() {
		String UserName = "SADMIN";
		String Password = "huanganbang";
		String root = "ou=person,ou=utrust,dc=chinautrust,dc=com";
		Hashtable<String, String> env = new Hashtable<String, String>();
		env.put(Context.INITIAL_CONTEXT_FACTORY,
				"com.sun.jndi.ldap.LdapCtxFactory");
		env.put(Context.PROVIDER_URL, "ldap://58.213.132.83:389/" + root);
		env.put(Context.SECURITY_AUTHENTICATION, "simple");
		env.put(Context.SECURITY_PRINCIPAL, "uid=" + UserName
				+ ";ou=person,ou=utrust,dc=chinautrust,dc=com");
		env.put(Context.SECURITY_CREDENTIALS, Password);
		DirContext ctx = null;
		try {
			ctx = new InitialDirContext(env);
			System.out.println("认证成功！");
		} catch (Exception e) {
			System.out.println("认证出错：");
			e.printStackTrace();
		}
	}*/

}
