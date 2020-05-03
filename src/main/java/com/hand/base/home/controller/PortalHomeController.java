package com.hand.base.home.controller;

import com.hand.base.home.service.HomeService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/action/portal/home")
public class PortalHomeController {
	
	private static final Logger logger = LogManager.getLogger(PortalHomeController.class);
	
		@Resource
		private HomeService homeService;
		
		@RequestMapping(value = "/mainjsp")
		public @ResponseBody ModelAndView main( HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mav = new ModelAndView();
			try{
				mav.setViewName("main/home");
			}catch(Exception e){
				e.printStackTrace();
			}
			return mav;
		}

}
