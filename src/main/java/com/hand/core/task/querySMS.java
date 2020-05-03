package com.hand.core.task;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.hand.base.smscode.dao.mybatis.mapper.SystemConfigMapper;
import com.hand.base.workbench.model.SmsSend;
import com.hand.base.workbench.service.SmsLineService;
import com.hand.base.workbench.service.SmsLotService;
import com.hand.base.workbench.service.SmsSendService;
import com.hand.core.util.AppConstants;
import com.hand.core.util.SendTemplateSMS;

@Component
public class querySMS { 
	
	@Autowired
	private SmsSendService smsSendService;
	
	@Autowired
	private SmsLineService smsLineService;
	
	@Autowired
	private SystemConfigMapper configMapper;
	
	@Autowired
	private SmsLotService smsLotService;
	
	@Scheduled(fixedRate = 900000) 
	public void callBackSMS(){
		
		String flag = AppConstants.portalTaskDefaultRun;
		if("N".equals(flag)) return;
		
		SendTemplateSMS sendTemplateSMS = new SendTemplateSMS();
		
		String tmpId = configMapper.getByCode("TB_O2O_TMP_ID");
		try {
			List<SmsSend> lines = smsSendService.querySmsLineAll(null);
			for (SmsSend entity : lines) {
				// 发送时间
				String sendDate = entity.getDateCreated().substring(0, 8);
				// 发送MessageId
				String msgId = entity.getMessageSid();
				
				String phoneNumber = entity.getPhoneNumber();
				
				SmsSend smsSend = new SmsSend();
				
				smsSend.setId(entity.getHeadId());
				
				smsSend = smsSendService.queryById(smsSend);
				
				if(smsSend == null){
					continue;
				}
				
				if(smsSend.getSucceedNum()==null||smsSend.getSucceedNum().equals("")){
					smsSend.setSucceedNum("0");
				}
				if(smsSend.getFailedNum()==null||smsSend.getFailedNum().equals("")){
					smsSend.setFailedNum("0");
				}
				
				SmsSend lot = new SmsSend();
				
				lot.setId(entity.getSendLotId());
				lot = smsLotService.queryById(lot);//对应的批次记录对象，用于更新批次表
				if(lot == null){
					continue;
				}
				// 短信行表，关联批次表查询MessageId和发送时间调用接口查询 发送结果
				HashMap<String, Object> result = sendTemplateSMS.doInvokeMethod2(sendDate, msgId, tmpId);
				String statusCode = (String) result.get("statusCode");
				String statusMsg = (String) result.get("statusMsg");
				HashMap<String, Object> data = (HashMap)result.get("data");
				if(data == null){
					lot.setStatusCode(statusCode);
					lot.setStatusMsg(statusMsg);
					lot.setBackFlag("Y");
					smsLotService.update(lot);
					
					entity.setBackFlag("Y");
					smsLineService.update(entity);
					
					smsSend.setFailedNum(String.valueOf(Integer.parseInt(smsSend.getFailedNum())+1));
					smsSendService.update(smsSend);
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
					entity.setSendStatus(sendStatus);
					entity.setSendTime(sendTime);
					entity.setReceiveTime(receiveTime);
					entity.setReceiveStatus(receiveStatus);
					if(receiveTime!=null && receiveStatus!=null){
						entity.setBackFlag("Y");
						if(receiveStatus.equals("0")){
							smsSend.setSucceedNum(String.valueOf(Integer.parseInt(smsSend.getSucceedNum())+1));
						}else if(receiveStatus.equals("1")){
							smsSend.setFailedNum(String.valueOf(Integer.parseInt(smsSend.getFailedNum())+1));
						}
						
					}
					smsLineService.update(entity);
					
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
				smsSendService.update(smsSend);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	    
	} 
 }