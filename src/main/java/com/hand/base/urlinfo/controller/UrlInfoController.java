package com.hand.base.urlinfo.controller;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import com.hand.base.urlinfo.model.UrlInfo;
import com.hand.base.urlinfo.service.UrlInfoService;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.KeyGenerateService;

@Controller("UrlInfoController")
@RequestMapping("/action/portal/urlInfo")
public class UrlInfoController extends BasicController<UrlInfo>{
 
	@Resource
	private KeyGenerateService keyGenerateService;

	@Resource
	private UrlInfoService urlInfoService;

	@Override
	public BasicService<UrlInfo> getBasicService() throws Exception {
		return urlInfoService;
	}	 
	
	/**
	 * 
	 *<p>获取所有可访问url</p>
	 * @author yrf
	 * @param request
	 * @return
	 */
    @ResponseBody  
    @RequestMapping("getUrlMapping")  
    public List<Map<String, Object>> getUrlMapping(HttpServletRequest request) {  
    	
    	List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
    	
        WebApplicationContext wc = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());  
        RequestMappingHandlerMapping rmhp = wc.getBean(RequestMappingHandlerMapping.class);  
        Map<RequestMappingInfo, HandlerMethod> map = rmhp.getHandlerMethods();  
        for(RequestMappingInfo info : map.keySet()){  
        	String url = info.getPatternsCondition().toString();
        	String bean = map.get(info).getBean().toString();
            System.out.println(url  + ","  +bean);  
            UrlInfo urlInfo = new UrlInfo();
            urlInfo.setUrl(url.replace("[", "").replace("]", ""));
            urlInfo.setName(map.get(info).getBean().toString());
            urlInfo.setDefaultAccessFlag("Y");
            urlInfo.setType("CRM");
            try {
				urlInfoService.insert(urlInfo);
			} catch (DuplicateKeyException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				/*Map<String, Object> result = new HashMap<String, Object>();
				result.put("success", false);
				result.put("url", url);
				result.put("bean", bean);
				list.add(result);*/
			} catch(Exception e){
				e.printStackTrace();
				Map<String, Object> result = new HashMap<String, Object>();
				result.put("success", false);
				result.put("result", e.getMessage());
				result.put("result", e.getClass().toString());
				result.put("url", url);
				result.put("bean", bean);
				list.add(result);
			}
        }  
        return list;  
    }  
    
    /**
     * 
     *<p>更新redis中的URL信息</p>
     * @author yrf
     * @param request
     * @return
     */
    @ResponseBody  
    @RequestMapping("updateMapping")  
    public Map<String, Object> updateRedisCache(HttpServletRequest request) {  
    	Map<String, Object> result = new HashMap<String, Object>();
    	try {
			urlInfoService.loadUrlToRedis();
			result.put("success", true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
    	return result;
    }
}
