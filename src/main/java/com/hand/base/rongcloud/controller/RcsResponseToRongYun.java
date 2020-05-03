package com.hand.base.rongcloud.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/action/portal/rongyun")
public class RcsResponseToRongYun {
	private static final Logger logger = 
			LogManager.getLogger(RcsResponseToRongYun.class);
	
	@RequestMapping("/response")
	public String resPonseRongYun() {
		return "200";
	}
}
