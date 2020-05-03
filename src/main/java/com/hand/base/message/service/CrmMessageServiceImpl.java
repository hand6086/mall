package com.hand.base.message.service;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hand.base.message.dao.mybatis.mapper.CrmMessageMapper;
import com.hand.base.message.dao.mybatis.mapper.UserMessageMapper;
import com.hand.base.message.model.CrmMessage;
import com.hand.base.message.model.UserMessage;
import com.hand.base.user.model.User;
import com.hand.base.basic.dao.KeyGenerateDao;
import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;
//import com.hand.mobile.push.model.PushInsert;
//import com.hand.mobile.push.service.PushService;

/**
 * 
 * <p>消息列表Service</p>
 * <p>Description</p>
 * <p>Company</p>
 * @author yrf
 * @date 2016年7月6日  上午10:41:56
 */
@Service
public class CrmMessageServiceImpl extends BasicServiceImpl<CrmMessage> implements CrmMessageService{

	private static final Logger logger = LogManager.getLogger(CrmMessageServiceImpl.class);
	@Resource
	private CrmMessageMapper crmMessageMapper;
	@Resource
	private UserMessageMapper userMessageMapper;
	@Resource
	private UserMessageService userMessageService;
	@Autowired
	private KeyGenerateDao keyGenerateDao;
	@Autowired
//	private PushService pushService;
	
	@Override
	public BasicMapper<CrmMessage> getBasicMapper() {
		return crmMessageMapper;
	}

	@Override
	public void upsert(CrmMessage msg) {
		//修改判断 插入or更新 逻辑：由于该方法在多处共用，考虑到兼容之前的代码，做出以下处理（跟通用模块方法略有不同） by qiqian.he,2016-7-19
		if(StringUtils.equals(msg.getRow_status(), "NEW")){
			try {
				String rowId = keyGenerateDao.keyGenerate();
				User user = UserUtil.getUser(null);
				msg.setSendBy(user.getFirstName());
				msg.setId(rowId);
				msg.setSendById(user.getId());
				crmMessageMapper.insert(msg);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(StringUtils.equals(msg.getRow_status(), "UPDATE")){
			try {
				crmMessageMapper.update(msg);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			if(msg.getId() == null || msg.getId().equals("")){
				try {
					msg.setId(keyGenerateDao.keyGenerate());
					User user = UserUtil.getUser(null);
					msg.setSendBy(user.getFirstName());
					msg.setSendById(user.getId());
					crmMessageMapper.insert(msg);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			else
			{
				try {
					crmMessageMapper.update(msg);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	@Override
	public void messageReplyInsert(CrmMessage msg) {
		msg.setId(keyGenerateDao.keyGenerate());
		User user = UserUtil.getUser(null);
		msg.setSendBy(user.getFirstName());
		msg.setSendById(user.getId());
		
		UserMessage usg = new UserMessage();
		usg.setId(keyGenerateDao.keyGenerate());
		usg.setUserId(msg.getUserId());		
		usg.setMsgId(msg.getId());
		try {
			crmMessageMapper.insert(msg);
			userMessageMapper.insert(usg);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public List<User> queryUnSelectUserListPage(UserMessage userMsg) {
		// TODO Auto-generated method stub
		return crmMessageMapper.queryUnSelectUserListPage(userMsg);
	}

	@Override
	public void atUserMsg(CrmMessage msg) {
//		msg.setIsSend("Y");
//		msg.setImportance("高");
//		msg.setAtOriginal(msg.getMsgContent());
//		String str = msg.getMsgContent().replaceAll("(@[^(]{1,20}\\([^)]{1,9}\\))[\\s]*", "");//去掉@消息中的用户id
//		msg.setMsgContent(str);
//		upsert(msg);
//		String msgOriginal = msg.getAtOriginal();
//		//解析文本，获取被@到的用户
//		Pattern pattern = Pattern.compile("(?<=@*\\()([^\\(^\\)]+?)(?=\\)\\s)");
//		Matcher match = pattern.matcher(msgOriginal);
//		List<String> userList=new ArrayList<String>();
////		List<PushInsert> pushList = new ArrayList<PushInsert>();
//		while(match.find()){
//			String userId = match.group();
//			if(!userList.contains(userId)){
//				try {
//					UserMessage userMsg = new UserMessage();
//					userMsg.setUserId(userId);
//					userMsg.setMsgId(msg.getId());//新建消息接收用户记录
//					userMessageService.upsert(userMsg);
//				} catch (Exception e1) {
//					e1.printStackTrace();
//				};
//				userList.add(userId);
//				
//				/*userMsg.setId(keyGenerateDao.keyGenerate());//插入数据到app端数据库表
//				userMsg.setMsgContent(msg.getMsgContent());
//				crmMessageMapper.mobileMsgInsert(userMsg);
//				*/
//				PushInsert pushInsert = new PushInsert();//调用app端推送
//				pushInsert.setLogin(userId);
//				pushInsert.setPushNote(msg.getMsgContent());
//				pushList.add(pushInsert);
//				try{
//					pushService.messageInsert(pushList);
//				}catch(Exception e){
//					//其实原方法就catch住了异常
//					e.printStackTrace();
//					logger.warn("插入推送消息失败：" + e.toString());
//				}
//			}
//		}
//		
	}

	
	public static void main(String args[]){
		String msg = "@张晓军(2-247484) @销售主管(2_105840) @销售主管(2_105840) 12341234";
		//Pattern pattern = Pattern.compile("(?<=@*\\()([^\\(^\\)]+?)(?=\\)\\s)");
		Pattern pattern = Pattern.compile("(@[^(]{1,20}\\([^)]{1,9}\\))[\\s]*");
		Matcher match = pattern.matcher(msg);
		System.out.println(match.replaceAll(""));
		while(match.find()){
			String str = match.group();
			System.out.println(str);
		}
		
		while(match.find()){
			String userId = match.group();
			System.out.println(userId);
		}
				
	}
}
