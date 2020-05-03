package com.hand.core.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtils {
	
	public static final String UKEY_FLAG = "uKeyFlag";
	
	public static String urlEncoder(String str,String enc) throws UnsupportedEncodingException{
    	if(enc == null || enc.length() <= 0)enc = "UTF-8";
    	String keyWord = URLEncoder.encode(str, enc);
    	return keyWord;
    }
	
	public static String token(){
    	String currentDate = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
    	String str = getStringRandom(6);
    	
    	return md5(currentDate + str);
    }
	
	public static String md5(String pwd)
	{
		String md5 = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(pwd.getBytes());
			byte b[] = md.digest();
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			md5 = buf.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return md5;
	}
	
	 /**
     * 生成随机数字和字母
     * @param length
     * @return
     */
    public static String getStringRandom(int length) {  
          
        String val = "";  
        Random random = new Random();  
          
        //参数length，表示生成几位随机数  
        for(int i = 0; i < length; i++) {  
              
            String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";  
            //输出字母还是数字  
            if( "char".equalsIgnoreCase(charOrNum) ) {  
                //输出是大写字母还是小写字母  
                int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;  
                val += (char)(random.nextInt(26) + temp);  
            } else if( "num".equalsIgnoreCase(charOrNum) ) {  
                val += String.valueOf(random.nextInt(10));  
            }  
        }  
        return val;  
    }  
	
	/**
	 * 判断字符串是否为空，为空返回true；否则返回false
	 * @param str
	 * @return
	 */
	public static boolean isNull(String str)
	{
		if(null == str || "".equals(str))
		{
			return true;
		}
		return false;
	}
	/**
	 * 空转空串
	 * @param str
	 * @return
	 */
	public static String null2EmptyString(String str)
	{
		try {
			if(null == str || str.length() <= 0 || "null".equals(str))return "";
		} catch (Exception e) {
			return "";
		}
		return str;
	}
	/**
	 * 判断字符串是否为数字，为空返回true；否则返回false
	 * @param str
	 * @return
	 */
	public static boolean isNum(String str)
	{
		return  str.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
	}
	
	 // Delim style
    public static final String DELIM_DEFAULT = ".";
 
    private StringUtils() {
        // Cannot be instantiated
    }
 
    /**
     * 将指定对象转换成字符串
     * 
     * @param obj
     *            指定对象
     * @return 转换后的字符串
     */
    public static String toString(Object obj) {
        StringBuffer buffer = new StringBuffer();
        if (obj != null) {
            buffer.append(obj);
        }
        return buffer.toString();
    }
 
    /**
     * 判断指定字符串是否等于null或空字符串
     * 
     * @param str
     *            指定字符串
     * @return 如果等于null或空字符串则返回true，否则返回false
     */
    public static boolean isBlank(String str) {
        return str == null || "".equals(str.trim());
    }
 
    /**
     * 判断指定字符串是否不等于null和空字符串
     * 
     * @param str
     *            指定字符串
     * @return 如果不等于null和空字符串则返回true，否则返回false
     */
    public static boolean isNotBlank(String str) {
        return !isBlank(str);
    }
 
    /**
     * 根据默认分隔符获取字符串前缀
     * 
     * @param str
     *            指定字符串
     * @return 返回前缀字符串
     */
    public static String getPrefix(String str) {
        return getPrefix(str, DELIM_DEFAULT);
    }
 
    /**
     * 根据指定分隔符获取字符串前缀
     * 
     * @param str
     *            指定字符串
     * @param delim
     *            指定分隔符
     * @return 返回字符串前缀
     */
    public static String getPrefix(String str, String delim) {
        String prefix = "";
        if (isNotBlank(str) && isNotBlank(delim)) {
            int pos = str.indexOf(delim);
            if (pos > 0) {
                prefix = str.substring(0, pos);
            }
        }
        return prefix;
    }
 
    /**
     * 根据默认分隔符获取字符串后缀
     * 
     * @param str
     *            指定字符串
     * @return 返回字符串后缀
     */
    public static String getSuffix(String str) {
        return getSuffix(str, DELIM_DEFAULT);
    }
 
    /**
     * 根据指定分隔符获取字符串后缀
     * 
     * @param str
     *            指定字符串
     * @param delim
     *            指定分隔符
     * @return 返回字符串后缀
     */
    public static String getSuffix(String str, String delim) {
        String suffix = "";
        if (isNotBlank(str) && isNotBlank(delim)) {
            int pos = str.lastIndexOf(delim);
            if (pos > 0) {
                suffix = str.substring(pos + 1);
            }
        }
        return suffix;
    }
 
    /**
     * 根据指定字符串和重复次数生成新字符串
     * 
     * @param str
     *            指定字符串
     * @param repeatCount
     *            重复次数
     * @return 返回生成的新字符串
     */
    public static String newString(String str, int repeatCount) {
        StringBuffer buf = new StringBuffer();
        for (int i = 0; i < repeatCount; i++) {
            buf.append(str);
        }
        return buf.toString();
    }
 
    /**
     * 隐藏字符串指定位置的字符
     * 
     * @param str
     *            指定字符串
     * @param index
     *            起始位置
     * @param length
     *            字符长度
     * @return 返回隐藏字符后的字符串
     */
    public static String hideChars(String str, int index, int length) {
        return hideChars(str, index, length, true);
    }
 
    /**
     * 隐藏字符串指定位置的字符
     * 
     * @param str
     *            指定字符串
     * @param start
     *            起始位置
     * @param end
     *            结束位置
     * @param confusion
     *            是否混淆隐藏的字符个数
     * @return 返回隐藏字符后的字符串
     */
    public static String hideChars(String str, int start, int end,
            boolean confusion) {
        StringBuffer buf = new StringBuffer();
        if (isNotBlank(str)) {
            int startIndex = Math.min(start, end);
            int endIndex = Math.max(start, end);
            // 如果起始位置超出索引范围则默认置为0
            if (startIndex < 0 || startIndex > str.length()) {
                startIndex = 0;
            }
            // 如果结束位置超出索引范围则默认置为字符串长度
            if (endIndex < 0 || endIndex > str.length()) {
                endIndex = str.length();
            }
            String temp = newString("*", confusion ? 4 : endIndex - startIndex);
            buf.append(str).replace(startIndex, endIndex, temp);
 
        }
        return buf.toString();
    }
 
    /**
     * 将指定字符串转换成大写
     * 
     * @param str
     *            指定字符串
     * @return 返回转换后的大写字符串
     */
    public static String toLowerCase(String str) {
        StringBuffer buffer = new StringBuffer(str);
        for (int i = 0; i < buffer.length(); i++) {
            char c = buffer.charAt(i);
            buffer.setCharAt(i, Character.toLowerCase(c));
        }
        return buffer.toString();
    }
 
    /**
     * 将指定字符串转换成大写
     * 
     * @param str
     *            指定字符串
     * @return 返回转换后的大写字符串
     */
    public static String toUpperCase(String str) {
        StringBuffer buffer = new StringBuffer(str);
        for (int i = 0; i < buffer.length(); i++) {
            char c = buffer.charAt(i);
            buffer.setCharAt(i, Character.toUpperCase(c));
        }
        return buffer.toString();
    }
 
    /**
     * 将指定字符串转换成驼峰命名方式
     * 
     * @param str
     *            指定字符串
     * @return 返回驼峰命名方式
     */
    public static String toCalmelCase(String str) {
        StringBuffer buffer = new StringBuffer(str);
        if (buffer.length() > 0) {
            // 将首字母转换成小写
            char c = buffer.charAt(0);
            buffer.setCharAt(0, Character.toLowerCase(c));
            Pattern p = Pattern.compile("_\\w");
            Matcher m = p.matcher(buffer.toString());
            while (m.find()) {
                String temp = m.group(); // 匹配的字符串
                int index = buffer.indexOf(temp); // 匹配的位置
                // 去除匹配字符串中的下划线，并将剩余字符转换成大写
                buffer.replace(index, index + temp.length(),
                        temp.replace("_", "").toUpperCase());
            }
        }
        return buffer.toString();
    }
 
    /**
     * 将指定字符串转换成匈牙利命名方式
     * 
     * @param str
     *            指定字符串
     * @return 转换后的匈牙利命名方式
     */
    public static String toHungarianCase(String str) {
        StringBuffer buffer = new StringBuffer(str);
        if (buffer.length() > 0) {
            Pattern p = Pattern.compile("[A-Z]");
            Matcher m = p.matcher(buffer.toString());
            while (m.find()) {
                String temp = m.group(); // 匹配的字符串
                int index = buffer.indexOf(temp); // 匹配的位置
                // 在匹配的字符串前添加下划线，并将其余字符转换成大写
                buffer.replace(index, index + temp.length(), (index > 0
                        ? "_"
                        : "") + temp.toLowerCase());
            }
        }
        return buffer.toString();
    }
 
    /**
     * 将指定字符串首字母转换成大写字母
     * 
     * @param str
     *            指定字符串
     * @return 返回首字母大写的字符串
     */
    public static String firstCharUpperCase(String str) {
        StringBuffer buffer = new StringBuffer(str);
        if (buffer.length() > 0) {
            char c = buffer.charAt(0);
            buffer.setCharAt(0, Character.toUpperCase(c));
        }
        return buffer.toString();
    }
 
    /**
     * 将指定数组转换成字符串
     * 
     * @param objs
     *            指定数组
     * @return 返回转换后的字符串
     */
    public static String array2String(Object[] objs) {
        StringBuffer buffer = new StringBuffer();
        if (objs != null) {
            for (int i = 0; i < objs.length; i++) {
                buffer.append(objs[i]).append(",");
            }
        }
        buffer.deleteCharAt(buffer.length() - 1);
        return buffer.toString();
    }
    
    /**
     * 比较两个字符串是否相等
     * @param str1
     * @param str2
     * @return
     */
    public static boolean equals(String str1, String str2){
    	if(str1 == null || str2 == null){
    		return false;
    	}
    	return str1.equals(str2);
    }
    
    /**
	 * MD5 加密字符串
	 * @return 
	 */
	public static String encryptByMD5(String strSrc) {
		StringBuilder sb = new StringBuilder();
		MessageDigest md5;
		try {
			md5 = MessageDigest.getInstance("MD5");
			md5.update(strSrc.getBytes());
			for (byte b : md5.digest()) {
				sb.append(String.format("%02X", b)); // 10进制转16进制，X 表示以十六进制形式输出，02 表示不足两位前面补0输出
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
    
    /**
	 * SHA-1 加密字符串
	 * @return 
	 */
	public static String encryptBySHA1(String strSrc) {
		MessageDigest md = null;
		String strDes = null;
		byte[] bt = strSrc.getBytes();
		try {
			md = MessageDigest.getInstance("SHA-1");
			md.update(bt);
			strDes = bytes2Hex(md.digest()); // to HexString
		} catch (NoSuchAlgorithmException e) {
			return null;
		}
		return strDes;
	}

	/**
	 * to HexString
	 * 转换为hex编码
	 */
	public static String bytes2Hex(byte[] bts) {
		String des = "";
		String tmp = null;
		for (int i = 0; i < bts.length; i++) {
			tmp = (Integer.toHexString(bts[i] & 0xFF));
			if (tmp.length() == 1) {
				des += "0";
			}
			des += tmp;
		}
		return des;
	}
	
	/**
	 * 把null替换为""
	 * @param str
	 * @return
	 */
	public static String replaceNullString(String str){
		if(str == null ) return "";
	           else return str;
	}
	
	public static boolean checkPhoneNumFormat(String phoneNum) {
		Pattern p = Pattern.compile("^(1[3-8][0-9])\\d{8}$");
		Matcher m = p.matcher(phoneNum);
		return m.matches();
	}
 
    public static void main(String[] args) {
        String str = "log.text.txt";
        System.out.println(getPrefix(str));
        System.out.println(getSuffix(str));
        System.out.println(hideChars(str, 2, str.length() - 1));
        System.out.println(toString(null));
        System.out.println(toCalmelCase("rate_limit_exceeded"));
        System.out.println(toHungarianCase("rateLimitExceeded"));
        System.out.println(firstCharUpperCase(str));
        System.out.println(new StringBuffer().append(""));
        System.out.println(array2String(new String[]{"a", "b", "c"}));
    }

}
