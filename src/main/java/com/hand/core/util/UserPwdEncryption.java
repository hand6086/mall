package com.hand.core.util;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
/**
 * 32位MD5用户密码加密
 * @author liujie
 */
public class UserPwdEncryption {
	/**
	 * 采用MD5为用户密码加密
	 * @param pwd 需要加密的字符串
	 * @return 加密后的字符串
	 */
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
	// 测试
	public static void main(String args[]) {
		String s = new String("123456");
		System.out.println("原始：" + s);
		System.out.println("MD5后：" + md5(s));
		if("ba56bab91016bcb37878e06c16e9e68f".equals(md5(s)))
		{
			System.out.println("true");
		}
	}
}
