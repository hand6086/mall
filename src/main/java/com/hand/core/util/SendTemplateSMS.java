package com.hand.core.util;

import com.hand.base.workbench.model.SmsSend;
import com.hand.cloopen.rest.sdk.CCPRestSDK;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class SendTemplateSMS
{
  public void doInvokeMethod(String PhoneNumber,String MsgContext,String tmpId,SmsSend output)
    throws Exception
  {
	  ArrayList objectArray;
	  
	  String ACCOUNTSID = "aaf98f895147cd2a01515622bcc4217c";
	  String AUTHTOKEN = "7ca00fd632f44ac6a841e24f2d8c4877";
	  String APPID = "aaf98f895147cd2a01515c5af81d3534";
	  String BASEURL = "app.cloopen.com";
	  String Port = "8883";
	  String TEMPLATEID = tmpId;
      
      HashMap<String, Object> result = null;
      String returnMsg = null;
      
      CCPRestSDK restAPI = new CCPRestSDK();
      
      restAPI.init(BASEURL, Port);
      restAPI.setAccount(ACCOUNTSID, AUTHTOKEN);
      restAPI.setAppId(APPID);
      result = restAPI.sendTemplateSMS(PhoneNumber, TEMPLATEID, new String[] { MsgContext });
      if ("000000".equals(result.get("statusCode")))
      {
    	output.setStatusCode((String)result.get("statusCode"));
    	output.setStatusMsg("调用成功！");
        String smsMessageSid = "";
        String dateCreated = "";
        
        HashMap<String, Object> data = (HashMap)result.get("data");
        Set<String> keySet = data.keySet();
        for (String key : keySet)
        {
	      	ArrayList object = (ArrayList)data.get(key);
	      	for(int i=0;i<object.size();i++){
	  	    	HashMap<String, Object> data1 = (HashMap)object.get(i);
	  	    	 Set<String> keySet1 = data1.keySet();
	  	    	 for (String key1 : keySet1)
	  	         {
	  	           if (key1 == "smsMessageSid")
	  	           {
	  	             smsMessageSid = ((String)data1.get(key1)).toString();
	  	           }
	  	           if (key1 == "dateCreated")
	  	           {
	  	             dateCreated = ((String)data1.get(key1)).toString();
	  	           }
	  	         }
	      	}
        }
        output.setMessageSid(smsMessageSid);
        output.setDateCreated(dateCreated);
      }
      else
      {
        output.setStatusCode((String)result.get("statusCode"));
        output.setStatusMsg((String)result.get("statusMsg"));
      }
  }
  
  public HashMap<String, Object> doInvokeMethod2(String sendDate,String msgId,String tmpId)
		    throws Exception
		  {
			  ArrayList objectArray;
			  
			  String ACCOUNTSID = "aaf98f895147cd2a01515622bcc4217c";
			  String AUTHTOKEN = "7ca00fd632f44ac6a841e24f2d8c4877";
			  String APPID = "aaf98f895147cd2a01515c5af81d3534";
			  String BASEURL = "app.cloopen.com";
			  String Port = "8883";
			  String TEMPLATEID = tmpId;
		      
		      HashMap<String, Object> result = null;
		      String returnMsg = null;
		      
		      CCPRestSDK restAPI = new CCPRestSDK();
		      
		      restAPI.init(BASEURL, Port);
		      restAPI.setAccount(ACCOUNTSID, AUTHTOKEN);
		      restAPI.setAppId(APPID);
		      result = restAPI.querySMS(sendDate,msgId);
		      return result;
		      
		  }
}
