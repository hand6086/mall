package com.hand.base.email.emailUtils;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;

/**
 * 
 * @author weixuan
 *
 */
public class UploadImgServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public UploadImgServlet() {
        super();
    }

    public void destroy() {
        super.destroy(); // Just puts "destroy" string in log
        // Put your code here
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String path = request.getRealPath("/image");
        File file = new File(path);
        if (!file.exists()){
        	file.mkdirs();
        }
        
        String fileName = "";// 文件名称
        /**上传文件处理内容**/
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        sfu.setHeaderEncoding("UTF-8"); // 处理中文问题
        sfu.setSizeMax(5*1024 * 1024);  // 限制文件大小
        try {
            List<FileItem> fileItems = sfu.parseRequest(request); // 解码请求
            for (FileItem fi : fileItems) {
            	String fileName123 = fi.getName();
            	
                fileName = UUID.randomUUID()+fi.getName().substring(fi.getName().lastIndexOf("."),fi.getName().length());
                fi.write(new File(path, fileName));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        /**********************/
        
        //获取图片url地址
        String imgUrl = "http://localhost:8080/image/"+fileName;
        response.setContentType("text/text;charset=utf-8");
        PrintWriter out = response.getWriter();
        out.print(imgUrl);  //返回url地址
        out.flush();
        out.close();
    }

    public void init() throws ServletException {
        // Put your code here
    }
}