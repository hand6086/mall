package com.hand.base.enterprise.controller;


import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.service.BasicService;
import com.hand.base.common.model.Image;
import com.hand.base.enterprise.model.Enterprise;
import com.hand.base.enterprise.service.EnterpriseService;
import com.hand.base.o2oaccnt.model.UserAudit;
import com.hand.core.util.FileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("EnterpriseController")
@RequestMapping("/action/portal/enterprise")
public class EnterpriseController extends BasicController<Enterprise>{

	@Resource
	private EnterpriseService enterpriseService;
	

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
			List<Image> list = null;// myFileService.imgUpload(myfiles);
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
	
	

}
