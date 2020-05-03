package com.hand.base.workbench.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.controller.BasicControllerException;
import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.service.BasicService;
import com.hand.base.params.dao.mybatis.mapper.SystemConfigurationMapper;
import com.hand.base.params.model.SystemConfiguration;
import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import com.hand.base.workbench.model.SmsSend;
import com.hand.base.workbench.service.SmsLineService;
import com.hand.base.workbench.service.SmsLotService;
import com.hand.base.workbench.service.SmsSendService;
import com.hand.core.util.SendTemplateSMS;

@Controller
@RequestMapping("/action/portal/smsSend")
public class PortalSmsSendController extends BasicController<SmsSend> {
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	
	@Autowired
	private SmsSendService smsSendService;
	
	@Autowired
	private SmsLotService smsLotService;
	
	@Autowired
	private SmsLineService smsLineService;
	
	@Autowired
	private SystemConfigMapper configMapper;
	
	@Autowired
	private SystemConfigurationMapper systemConfigurationMapper;
    
	@Override
	public BasicService<SmsSend> getBasicService() throws Exception {
		return smsSendService;
	}
	
	/**
	 * 发送短信
	 */
	@RequestMapping(value = "/send")
	@ResponseBody
	public Map<String, Object> send(SmsSend entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		int smsnum = Integer.parseInt(configMapper.getByCode("TB_O2O_SMS_NUM"));
	    try {
	    	
			// 群发短信，不能少于两条
			if(smsSendService.querySmsAll(entity).size() < smsnum){
				throw new BasicControllerException("当前发送短信条数少于"+smsnum+"条，不允许发送！");
			}
			// 短信行表，批次表关联
			List<SmsSend> listAll = smsSendService.queryDistinctSmsAll(entity);
			
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date time= sf.parse(entity.getSendTime());
			Timer timer = new Timer();
			   timer.schedule(new TimerTask() {
			     public void run() {
			    	 try {
			 			SendTemplateSMS sendTemplateSMS = new SendTemplateSMS();
			 			SmsSend output = new SmsSend();
			 			String MsgContext = entity.getTextContent();
			 			StringBuilder phoneNumber = new StringBuilder();
			 			String tmpId = configMapper.getByCode("TB_O2O_TMP_ID");
			 			
			 			// 拼接手机号码，用逗号隔开
			 			for(int i = 0;i<listAll.size();i+=smsnum){
			 				List<SmsSend>  list;
			 				if(i+smsnum<listAll.size()){
			 					list = listAll.subList(i,i+smsnum);
			 				}else{
			 					list = listAll.subList(i,listAll.size());
			 				}
			 				for(SmsSend smsSend : list){
			 					phoneNumber.append(",").append(smsSend.getPhoneNumber());
			 				}
			 				String phoneNumbers = phoneNumber.substring(i*12+1);
			 				// 发送短信
			 				sendTemplateSMS.doInvokeMethod(phoneNumbers, MsgContext, tmpId, output);
			 				
			 				if("000000".equals(output.getStatusCode())){
			 					
			 					// 插入批次表 CX_O_SMS_SE_LOT
			 					String id = keyGenerateDao.keyGenerate();
			 					output.setId(id);
			 					output.setHeadId(entity.getId());
			 					output.setBackFlag("N");
			 					output.setSendStatus("N");
			 					smsLotService.insert(output);
			 					
			 					// 循环更新短信行表 CX_O_SMS_SE_LN
			 					for(SmsSend smsLot : list){
			 						smsLot.setSendLotId(output.getId());
			 						smsLot.setStatusCode(output.getStatusCode());
			 						smsLot.setMessageSid(output.getMessageSid());
			 						smsLot.setDateCreated(output.getDateCreated());
			 						smsLot.setStatusMessage(output.getStatusMsg());
			 						smsLineService.update(smsLot);
			 					}
			 				}
			 			}
					 			// 更新短信头信息 CX_O_SMS_SEND
					 			entity.setDetermineFlag("Y");
					 			entity.setSendFlag("N");
					 			entity.setTemplateId(tmpId);
					 			smsSendService.update(entity);
					     } catch (Exception e) {
								e.printStackTrace();
						}
			    	 }
			   }, time);
			
			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
	    return result;
	}
	
	/**
	 * 发送短信
	 */
	@RequestMapping(value = "/sendReturn")
	@ResponseBody
	public Map<String, Object> sendReturn(SmsSend entity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		SendTemplateSMS sendTemplateSMS = new SendTemplateSMS();
		
		String tmpId = configMapper.getByCode("TB_O2O_TMP_ID");
		
		if(entity.getSucceedNum()==null||"".equals(entity.getSucceedNum())){
			entity.setSucceedNum("0");
		}
		if(entity.getFailedNum()==null||"".equals(entity.getFailedNum())){
			entity.setFailedNum("0");
		}
		
		try {
			
			SystemConfiguration systemConfiguration = new SystemConfiguration();
			systemConfiguration.setPageFlag(false);
			systemConfiguration.setCode("TB_O2O_SMS_RETURN");
			systemConfiguration = systemConfigurationMapper.queryByExamplePage(systemConfiguration).get(0);
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			int minute = Integer.parseInt(systemConfiguration.getValue());
			Date date =format.parse(systemConfiguration.getLastUpdated(0));
			Date now = new Date();
			date.setTime(date.getTime() + minute*60*1000); 
			if(date.after(now)){
				result.put("success", true);
				result.put("result", "系统正在向容联云查询短信发送结果，请稍后再点击。");
				return result;
			}else{
				systemConfigurationMapper.update(systemConfiguration);
			}
			
			entity.setAttr1("smsReturn");
			entity.setHeadId(entity.getId());
			entity.setPageFlag(false);
			List<SmsSend> lines = smsLineService.queryByExamplePage(entity);
			if(lines.size() == 0){
				entity.setSendFlag("Y");
				smsSendService.update(entity);
				result.put("success", true);
				result.put("result", "暂无可回调短信");
				return result;
			}
			for (SmsSend line : lines) {
				// 发送时间
				String sendDate = line.getDateCreated().substring(0, 8);

				String phoneNumber = line.getPhoneNumber();
				
				SmsSend lot = new SmsSend();
				lot.setId(line.getSendLotId());
				lot = smsLotService.queryById(lot);//对应的批次记录对象，用于更新批次表
				// 发送MessageId
				String msgId = lot.getMessageSid();
				
				// 短信行表，关联批次表查询MessageId和发送时间调用接口查询 发送结果
				HashMap<String, Object> sendReturn = sendTemplateSMS.doInvokeMethod2(sendDate, msgId, tmpId);
				String statusCode = (String) sendReturn.get("statusCode");
				String statusMsg = (String) sendReturn.get("statusMsg");
				HashMap<String, Object> data = (HashMap)sendReturn.get("data");
				if(data == null){
					lot.setStatusCode(statusCode);
					lot.setStatusMsg(statusMsg);
					lot.setBackFlag("Y");
					smsLotService.update(lot);
					
					line.setBackFlag("Y");
					smsLineService.update(line);
					
					entity.setFailedNum(String.valueOf(Integer.parseInt(entity.getFailedNum())+1));
					continue;
				}
				HashMap object;
				String receiveTime=null;
				String receiveStatus=null;
				for(int i=0;i<((ArrayList)data.get("receiveInfo")).size();i++){
					object = (HashMap)((ArrayList)data.get("receiveInfo")).get(i);
					if(phoneNumber.equals((String) object.get("receiver"))){
						receiveTime=(String) object.get("receiveTime");
						receiveStatus=(String) object.get("deliverStatus");
					}
				}
				
				
				String sendStatus = (String) data.get("sendStatus");
				String sendTime = (String)data.get("sendTime");
				// 根据发送结果表，更新批次表，更新短信发送记录表
				if ("000000".equals(statusCode)) {
					// 更新短信发送电话号码表
					line.setSendStatus(sendStatus);
					line.setSendTime(sendTime);
					line.setReceiveTime(receiveTime);
					line.setReceiveStatus(receiveStatus);
					if(receiveTime!=null && receiveStatus!=null){
						line.setBackFlag("Y");
						if(receiveStatus.equals("0")){
							entity.setSucceedNum(String.valueOf(Integer.parseInt(entity.getSucceedNum())+1));
						}else if(receiveStatus.equals("1")){
							entity.setFailedNum(String.valueOf(Integer.parseInt(entity.getFailedNum())+1));
						}
						
					}
					smsLineService.update(line);
					
					// 更新批次表 sendLotId
					lot.setStatusCode(statusCode);
					lot.setStatusMsg("调用成功！");
					lot.setSendStatus(sendStatus);
					lot.setSendTime(sendTime);
					lot.setBackFlag("Y");
					smsLotService.update(lot);
					
				}
				else{
					lot.setStatusCode(statusCode);
					lot.setStatusMsg(statusMsg);
					smsLotService.update(lot);
				}
			}
			smsSendService.update(entity);
			result.put("success", true);
			result.put("result", "短信回调完成！");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}
}
