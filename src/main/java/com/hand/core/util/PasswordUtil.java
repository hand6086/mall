package com.hand.core.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordUtil {

	/**
     *  利用java原生的摘要实现SHA256加密
     * @param str 加密后的报文
     * @return
     */
    public static String getSHA256StrJava(String str){
        MessageDigest messageDigest;
        String encodeStr = "";
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(str.getBytes("UTF-8"));
            encodeStr = byte2Hex(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return encodeStr;
    }
    
    public static String getMD5StrJava(String str){
        MessageDigest messageDigest;
        String encodeStr = "";
        try {
            messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.update(str.getBytes("UTF-8"));
            encodeStr = byte2Hex(messageDigest.digest());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        return encodeStr;
    }

    /**
     * 将byte转为16进制
     * @param bytes
     * @return
     */
    private static String byte2Hex(byte[] bytes){
        StringBuffer stringBuffer = new StringBuffer();
        String temp = null;
        for (int i=0;i<bytes.length;i++){
            temp = Integer.toHexString(bytes[i] & 0xFF);
            if (temp.length()==1){
                //1得到一位的进行补0操作
                stringBuffer.append("0");
            }
            stringBuffer.append(temp);
        }
        return stringBuffer.toString();
    }
    
    /**
     * 
     *<p>本系统加密方法</p>
     * @author yrf
     * @param str
     * @return
     */
    public static String generatePwd(String str){
    	if(str == null || "".equals(str)){
    		return null;
    	}
    	str = "123@!LINK"+str+"CRM";
    	String shaStr = getSHA256StrJava(str);
    	String md5Str = getMD5StrJava(shaStr);
    	String result = "{LINKSHA}"+md5Str;
    	return result;
    }
    
    /**
     * 
     *<p>比较密码明文加密后是否等于该密文</p>
     * @author yrf
     * @param pwd 明文
     * @param encodeStr 密文
     * @return
     */
    public static boolean isEquals(String pwd, String encodeStr){
    	if(pwd == null || encodeStr == null){
    		return false;
    	}
    	if(!encodeStr.startsWith("{LINKSHA}")){
    		//throw new IllegalStateException("");
    		return false;
    	}
    	pwd = generatePwd(pwd);
    	return pwd.equals(encodeStr);
    }
    
    public static void main(String[] args) {
    	
    	System.out.println(generatePwd("123"));
		
	}
}
