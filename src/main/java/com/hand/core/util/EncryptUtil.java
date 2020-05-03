package com.hand.core.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class EncryptUtil {
	
	private static byte[] iv = { 1, 2, 3, 4, 5, 6, 7, 8 };
	
	public static String getKey(){
		return "F6a9f50C";
	}
	
	

    public static String encryptDES(String encryptString, String encryptKey)
            throws Exception {
        IvParameterSpec zeroIv = new IvParameterSpec(iv);
        SecretKeySpec key = new SecretKeySpec(encryptKey.getBytes("UTF-8"), "DES");
        Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
        cipher.init(Cipher.ENCRYPT_MODE, key, zeroIv);
        byte[] encryptedData = cipher.doFinal(encryptString.getBytes("UTF-8"));
        return Base64.encode(encryptedData);
    }
    
    public static String decryptDES(String decryptString, String decryptKey)
              throws Exception {
          byte[] byteMi = Base64.decode(decryptString);
          IvParameterSpec zeroIv = new IvParameterSpec(iv);
          SecretKeySpec key = new SecretKeySpec(decryptKey.getBytes("UTF-8"), "DES");
          Cipher cipher = Cipher.getInstance("DES/CBC/PKCS5Padding");
          cipher.init(Cipher.DECRYPT_MODE, key, zeroIv);
          byte decryptedData[] = cipher.doFinal(byteMi);

          return new String(decryptedData);
      }
    
    public static void main(String[] args) {
    	String plaintext = "QdVZliILBh9g/+LqapZOIUVS8XfQy6LPOH1v24uO/HcwR6u2QNRFSg==";
		try {
	    	System.out.println("解密后：" + EncryptUtil.encryptDES(plaintext, "F6a9f50C"));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("F6a9f50C".getBytes().length);
		
		//System.out.println(getKey());
    	
	}
    
   
}
