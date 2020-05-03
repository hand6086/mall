package com.hand.core.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.hand.base.common.model.Attachment;
public class FileUtil {
	
	
	public static boolean validateIsAllImage(List<MultipartFile> myfiles){
		
		for(MultipartFile myfile : myfiles){
			
			if(StringUtils.isBlank(myfile.getContentType())){
				return false;
			}
			
			if(!("image/jpg".equals(myfile.getContentType()) ||
					"image/jpeg".equals(myfile.getContentType()) ||
					"image/png".equals(myfile.getContentType()) ||
					"image/pjpeg".equals(myfile.getContentType()) ||
					"image/gif".equals(myfile.getContentType()) ||
					"image/bmp".equals(myfile.getContentType()) ||
					"image/x-png".equals(myfile.getContentType()) ||
					"image/x-icon".equals(myfile.getContentType()))){
				return false;
			}
		}
		return true;
	}

	/**
	 * 下载文件
	 * @param record
	 * @param response
	 */
	public static void downloadFile(Attachment record, HttpServletResponse response)
	{
		int status = 0;
		byte b[] = new byte[1024];
		FileInputStream in = null;
		ServletOutputStream out2 = null;
		try {
			response.setContentType("application/x-download");
			response.setHeader("content-disposition", "attachment; filename=" + record.getAttachmentName());
			/*String fileUrl = AppConstants.portalShareFileDir + record.getAttachmentPath() + "/" + record.getAttachmentName();*/
			String attachmentFilePath = record.getAttachmentFilePath().replace('/', '\\');
			String fileUrl = AppConstants.portalShareFileDir + attachmentFilePath + "\\" + record.getAttachmentName();
			in = new FileInputStream(fileUrl);
			out2 = response.getOutputStream();
			while (status != -1) {
				status = in.read(b);
				out2.write(b);
			}
			out2.flush();
		} catch (Exception e) {
			
		} finally {
			if (in != null)
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			if (out2 != null)
				try {
					out2.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}



	

}
