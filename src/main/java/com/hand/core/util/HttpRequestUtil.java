package com.hand.core.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;


public class HttpRequestUtil {
	
	public static final String HTTP_POST = "POST";
	public static final String HTTP_GET = "GET";
	public static final String HTTP_PUT = "PUT";
	
	/**
	 * 向指定 URL 发送GET方法的请求
	 * 
	 * @param url
	 *            发送请求的 URL
	 * @param content
	 *            请求内容
	 * @param contentType
	 *            请求类型：默认为：text/html;charset=UTF-8
	 * @return 所代表远程资源的响应结果
	 */
	public static String sendGet(String url, String param) {
		String result = "";
		BufferedReader in = null;
		try {
			String urlNameString = url;
			if (param != null && !"".equals(param)) {
				urlNameString += "?" + param;
			}
			System.err.println("HttpRequestUtil.sendGet===>"+urlNameString);
			URL realUrl = new URL(urlNameString);
			// 打开和URL之间的连接
			URLConnection connection = realUrl.openConnection();
			// 设置通用的请求属性
			connection.setRequestProperty("accept", "*/*");
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
			connection.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3");
			connection.setRequestProperty("connection", "Keep-Alive");
			connection.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			connection.setConnectTimeout(30000);  //设置连接主机超时（单位：毫秒）  
			connection.setReadTimeout(30000); 	  //置从主机读取数据超时（单位：毫秒）
			// 建立实际的连接
			connection.connect();
			// 获取所有响应头字段
			Map<String, List<String>> map = connection.getHeaderFields();
			// 定义 BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输入流
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	
	/**
	 * 向指定 URL 发送POST方法的请求（使用字符流）
	 * 
	 * @param url 发送请求的 URL
	 * @param content 请求内容
	 * @param contentType 请求类型：默认为：text/html;charset=UTF-8
	 * @return 所代表远程资源的响应结果
	 */
	public static String sendPost(String url, String content, String contentType) {
		OutputStreamWriter out = null;
		BufferedReader in = null;
		String result = "";
		System.err.println("HttpRequestUtil.sendPost===>"+url);
		try {
			URL realUrl = new URL(url);
			HttpURLConnection conn = null;
			conn = (HttpURLConnection) realUrl.openConnection();
			// 打开和URL之间的连接
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestMethod("POST"); // POST方法\
			if (contentType == null || "".equals(contentType)) {
				conn.setRequestProperty("Content-Type", "text/html;charset=UTF-8");
			} else {
				conn.setRequestProperty("Content-Type", contentType);
			}
			conn.setConnectTimeout(30000);  //设置连接主机超时（单位：毫秒）  
			conn.setReadTimeout(30000); 	  //置从主机读取数据超时（单位：毫秒）
			// 设置通用的请求属性
			conn.connect();
			// 获取URLConnection对象对应的输出流
			out = new OutputStreamWriter(conn.getOutputStream(), "UTF-8");
			// 发送请求参数
			out.write(content);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	
	/**
	 * 发送HttpPost请求 
	 * @param strURL 服务地址
	 * @param params json字符串,例如: "{ \"id\":\"12345\" }" ;其中属性名必须带双引号<br/>
	 * @return 成功:返回json字符串<br/>
	 */
    public static String jsonPost(String strURL, String params) {   
        try {
        	return jsonRequest(strURL, params, "POST");
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return "error"; // 自定义错误信息  
    }
    
    /**
     * 发送Http请求
     * @param strURL 服务地址
     * @param params json字符串,例如: "{ \"id\":\"12345\" }" ;其中属性名必须带双引号<br/>
     * @param requestMethod http方法(POST GET PUT ...)
     * @return 成功:返回json字符串<br/>
     */
    public static String jsonRequest(String strURL, String params, String requestMethod) {   
        try {  
            URL url = new URL(strURL);// 创建连接  
            HttpURLConnection connection = (HttpURLConnection) url  
                    .openConnection();  
            connection.setDoOutput(true);  
            connection.setDoInput(true);  
            connection.setUseCaches(false);  
            connection.setInstanceFollowRedirects(true);  
            connection.setRequestMethod(requestMethod); // 设置请求方式  
            connection.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式  
            connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式  
            connection.setConnectTimeout(30000);  //设置连接主机超时（单位：毫秒）  
            connection.setReadTimeout(30000); 	  //置从主机读取数据超时（单位：毫秒）
            connection.connect();  
            OutputStreamWriter out = new OutputStreamWriter(  
                    connection.getOutputStream(), "UTF-8"); // utf-8编码  
            out.append(params);  
            out.flush();  
            out.close();  
            // 读取响应  
            int length = (int) connection.getContentLength();// 获取长度  
            InputStream is = connection.getInputStream();  
            if (length != -1) {  
                byte[] data = new byte[length];  
                byte[] temp = new byte[512];  
                int readLen = 0;  
                int destPos = 0;  
                while ((readLen = is.read(temp)) > 0) {  
                    System.arraycopy(temp, 0, data, destPos, readLen);  
                    destPos += readLen;  
                }  
                String result = new String(data, "UTF-8"); // utf-8编码  
                return result;  
            }  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return "error"; // 自定义错误信息  
    }
	
	/**
	 * 向指定 URL 发送POST方法的请求（使用字节流）
	 * 
	 * @param url 发送请求的 URL
	 * @param content 请求内容
	 * @param contentType 请求类型：默认为：text/html;charset=UTF-8
	 * @return 所代表远程资源的响应结果
	 */
	public static String sendPostByByte(String url, String content, String contentType,String savePath) {
		BufferedOutputStream bos = null;
		BufferedInputStream bis = null;
		FileOutputStream fos = null;
		String filePath = null;
		String result = "";
		System.err.println("HttpRequestUtil.sendPost===>"+url);
		try {
			URL realUrl = new URL(url);
			HttpURLConnection conn = null;
			conn = (HttpURLConnection) realUrl.openConnection();
			// 打开和URL之间的连接
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestMethod("POST"); // POST方法
			if (contentType == null || "".equals(contentType)) {
				conn.setRequestProperty("Content-Type", "text/html;charset=UTF-8");
			} else {
				conn.setRequestProperty("Content-Type", contentType);
			}
			conn.setConnectTimeout(30000);  //设置连接主机超时（单位：毫秒）  
			conn.setReadTimeout(30000); 	  //置从主机读取数据超时（单位：毫秒）
			// 设置通用的请求属性
			conn.connect();
			// 获取URLConnection对象对应的输出流
			bos = new BufferedOutputStream(conn.getOutputStream());
			// 发送请求参数
	        byte b[] = content.getBytes();  
			bos.write(b);
			// flush输出流的缓冲
			bos.flush();
			
			if (!savePath.endsWith("/")) {
				savePath += "/";
			}
			// 根据内容类型获取扩展名
			System.err.println(conn.getHeaderField("Content-Type"));
			String fileExt = getFileEndWitsh(conn.getHeaderField("Content-Type"));
			// 将mediaId作为文件名
			filePath = savePath + "ceshi" + fileExt;
			
			bis = new BufferedInputStream(conn.getInputStream());
			fos = new FileOutputStream(new File(filePath));
			byte[] buf = new byte[8096];
			int size = 0;
			while ((size = bis.read(buf)) != -1)
			fos.write(buf, 0, size);
			
			conn.disconnect();
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				bis.close();
				bos.close();
				fos.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	/**
	 * 根据内容类型判断文件扩展名
	 * 
	 * @param contentType
	 *            内容类型
	 * @return
	 */
	public static String getFileEndWitsh(String contentType) {
		String fileEndWitsh = "";
		if ("image/jpeg".equals(contentType))
			fileEndWitsh = ".jpg";
		else if ("audio/mpeg".equals(contentType))
			fileEndWitsh = ".mp3";
		else if ("audio/amr".equals(contentType))
			fileEndWitsh = ".amr";
		else if ("video/mp4".equals(contentType))
			fileEndWitsh = ".mp4";
		else if ("video/mpeg4".equals(contentType))
			fileEndWitsh = ".mp4";
		return fileEndWitsh;
	}
	
	public static void main(String args[]) {
		
	}
}
