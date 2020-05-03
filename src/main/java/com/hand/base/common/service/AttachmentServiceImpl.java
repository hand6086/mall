package com.hand.base.common.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.model.UploadImgInfo;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.common.dao.mybatis.mapper.AttachmentMapper;
import com.hand.base.common.dao.mybatis.mapper.InterObjectMapper;
import com.hand.base.common.model.Announce;
import com.hand.base.common.model.Attachment;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.modules.export.FileIndexGenarate;
import com.hand.core.util.AppConstants;
import com.hand.core.util.Constants;
import com.hand.core.util.DateUtil;
import com.hand.core.util.ImageUtil;
import com.hand.core.util.UserUtil;

@Service
@Transactional
public class AttachmentServiceImpl extends BasicServiceImpl<Attachment> implements AttachmentService{
	
	private static final Logger logger = LogManager.getLogger(AttachmentServiceImpl.class);
	
	@Autowired
	private AttachmentMapper attachmentMapper;
	
	
	@Autowired
	private InterObjectMapper interObjectMapper;
	
	@Override
	public BasicMapper<Attachment> getBasicMapper(){
		return attachmentMapper;
	}
	
	public void upload(MultipartFile myfile, Attachment record) throws BasicServiceException {
		User user = UserUtil.getUser(null);
		String realativPath = "/web/file/" + user.getId() + "/" + DateUtil.getYYYYMMDDHHMMSS();
		String realPath = AppConstants.portalShareFileDir + realativPath;
		String originalFilename = null;

		originalFilename = myfile.getOriginalFilename();
        if(myfile.isEmpty()){
        	throw new BasicServiceException("请选择文件后上传");
        }else{
            SimpleDateFormat datetimeFormatter = new SimpleDateFormat("yyyyMMddHHmmsss");
			String newfileName = datetimeFormatter.format(new Date()) + "_" + FileIndexGenarate.getFileIndex(new Date())
					+ originalFilename.substring(originalFilename.lastIndexOf('.'));
            record.setAttachmentName(newfileName);
            record.setAttachmentPath(realativPath + "/" + newfileName);
            record.setAttachmentOriginal(originalFilename);
            record.setAttachmentSize(String.valueOf(myfile.getSize()));
            //record.setAttachmentType(myfile.getContentType());
            String fileType = "";//文件类型(后缀)
            try{
            	fileType = originalFilename.substring(originalFilename.lastIndexOf('.') + 1).toLowerCase();
            } catch (Exception e){
            	fileType = "";
            }
            record.setAttachmentType(fileType == null ? "" : fileType);
            try {
                FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, newfileName));
            } catch (IOException e) {
            	 throw new BasicServiceException(e.getMessage());
            }
            
            if(fileType.equals("jpg") || fileType.equals("png") || fileType.equals("bmp") || fileType.equals("jpeg") )
            {
            	 try {
     				UploadImgInfo ui = ImageUtil.saveImageAndLessImage(realPath +"/"+ newfileName, user.getId(), record.getId());
     				 record.setSmallurl(ui.getFileLessHtppPath());
     		            record.setBigurl(ui.getBigfileHtppPath());
     			} catch (Exception e) {
     				// TODO Auto-generated catch block
     				e.printStackTrace();
     			}
            }
        }
	}
	
	public List<Attachment> queryAttachmentLibraryListPage(Attachment record) throws Exception {
		return attachmentMapper.queryAttachmentLibraryListPage(record);
	}
	
	/*@Override
	@Transactional
	public void deleteById(Attachment entity) throws Exception {
		logger.info("删除一条列表信息...");
		Attachment attachment =  attachmentMapper.queryById(entity);
		super.deleteById(entity);
		if(attachment !=null){
			fileDelete(attachment.getAttachmentRelativePath());
		}
	}*/

	public void fileDelete(String filePath) throws BasicServiceException{
		try{
			File file = new File(filePath);
			if(file.exists() && file.isFile())
			{
				file.delete();
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	
	public List<Attachment> queryAttachmentListByAnnounceId(Announce record) throws BasicServiceException {
		List<Attachment> list = null;
		try {
			list = attachmentMapper.queryAttachmentListByAnnounceId(record);
			for(int i=0;i<list.size();i++){
				//获取附件的相对路径并拼成绝对路径
				String realPath=AppConstants.portalShareUrlDir+list.get(i).getAttachmentPath()
						+"/"+list.get(i).getAttachmentName();
				
					list.get(i).setAttachmentRealPath(realPath);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return list;
	}

	public List<Attachment> attachmentUpload(MultipartFile[] myfiles) throws BasicServiceException {
		List<Attachment> list = new ArrayList<Attachment>();
		User user = UserUtil.getUser(null);
		String realativPath = "/file/" + user.getId() + "/" + DateUtil.getYYYYMMDDHHMMSS();
		String realPath = AppConstants.portalShareFileDir + realativPath;
		String originalFilename = null;
		for(MultipartFile myfile : myfiles){
			Attachment result = new Attachment();
			originalFilename = myfile.getOriginalFilename();
            if(myfile.isEmpty()){
            	logger.debug(Constants.LOG_DIVISION_LINE + "请选择文件后上传");
            	throw new BasicServiceException("请选择文件后上传");
            }else{
              
            	
                String newfileName=user.getId()+DateUtil.getYYYYMMDDHHMMSS()+(int)(Math.random()*100)+originalFilename.substring(originalFilename.lastIndexOf('.'));
                logger.debug(Constants.LOG_DIVISION_LINE + "生成文件名称: " + newfileName);
                result.setAttachmentName(newfileName);
                logger.debug(Constants.LOG_DIVISION_LINE + "原始文件名称: " + originalFilename);
                result.setAttachmentOriginal(originalFilename);
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件大小: " + myfile.getSize());
                result.setAttachmentSize(String.valueOf(myfile.getSize()));
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件类型: " + myfile.getContentType());
                result.setAttachmentType(myfile.getContentType());
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件路径: " + realativPath);
                result.setAttachmentPath(realativPath);
                try {
                    FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, newfileName));
                } catch (IOException e) {
                	 logger.debug(Constants.LOG_DIVISION_LINE + e.getMessage());
                	 throw new BasicServiceException(e.getMessage());
                }
            }
            list.add(result);
		}
		return list;
	}

	public List<Attachment> attachmentListUpload(List<MultipartFile> myfiles) throws BasicServiceException {
		List<Attachment> list = new ArrayList<Attachment>();
		User user = UserUtil.getUser(null);
		String realativPath = "/file/" + user.getId() + "/" + DateUtil.getYYYYMMDDHHMMSS();
		String realPath = AppConstants.portalShareFileDir + realativPath;
		String originalFilename = null;
		for(MultipartFile myfile : myfiles){
			Attachment result = new Attachment();
			originalFilename = myfile.getOriginalFilename();
            if(myfile.isEmpty()){
            	logger.debug(Constants.LOG_DIVISION_LINE + "请选择文件后上传");
            	throw new BasicServiceException("请选择文件后上传");
            }else{
                String newfileName=user.getId()+DateUtil.getYYYYMMDDHHMMSS()+(int)(Math.random()*100)+originalFilename.substring(originalFilename.lastIndexOf('.'));
                logger.debug(Constants.LOG_DIVISION_LINE + "生成文件名称: " + newfileName);
                result.setAttachmentName(newfileName);
                logger.debug(Constants.LOG_DIVISION_LINE + "原始文件名称: " + originalFilename);
                result.setAttachmentOriginal(originalFilename);
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件大小: " + myfile.getSize());
                result.setAttachmentSize(String.valueOf(myfile.getSize()));
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件类型: " + myfile.getContentType());
                result.setAttachmentType(myfile.getContentType());
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件路径: " + realativPath);
                result.setAttachmentPath(realativPath);
                try {
                    FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, newfileName));
                }catch (IOException e) {
                	 logger.debug(Constants.LOG_DIVISION_LINE + e.getMessage());
                	 throw new BasicServiceException(e.getMessage());
                }
            }
            list.add(result);
		}
		return list;
	}
	
	
	public List<Attachment> attachmentUploadAndCover(MultipartFile[] myfiles) throws BasicServiceException{
		List<Attachment> list = new ArrayList<Attachment>();
		User user = UserUtil.getUser(null);
		String realativPath = "/file/onlyOne" + user.getId();//同一个用户上传的附件都会放在同一个文件夹下
		String realPath = AppConstants.portalShareFileDir + realativPath;
		File oldPath=new File(realPath);
		deleteFile(oldPath);//删除完该路径下的文件
		String originalFilename = null;
		for(MultipartFile myfile : myfiles){
			Attachment result = new Attachment();
			originalFilename = myfile.getOriginalFilename();
			
            if(myfile.isEmpty()){
            	logger.debug(Constants.LOG_DIVISION_LINE + "请选择文件后上传");
            	throw new BasicServiceException("请选择文件后上传");
            }else{
            	String newfileName=user.getId()+DateUtil.getYYYYMMDDHHMMSS()+(int)(Math.random()*100)+originalFilename.substring(originalFilename.lastIndexOf('.'));
                logger.debug(Constants.LOG_DIVISION_LINE + "生成文件名称: " + newfileName);
                result.setAttachmentName(newfileName);
                logger.debug(Constants.LOG_DIVISION_LINE + "原始文件名称: " + originalFilename);
                result.setAttachmentOriginal(originalFilename);
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件大小: " + myfile.getSize());
                result.setAttachmentSize(String.valueOf(myfile.getSize()));
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件类型: " + myfile.getContentType());
                result.setAttachmentType(myfile.getContentType());
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件路径: " + realativPath);
                result.setAttachmentPath(realativPath);
                try {
                    FileUtils.copyInputStreamToFile(myfile.getInputStream(), new File(realPath, newfileName));
                } catch (IOException e) {
                	 logger.debug(Constants.LOG_DIVISION_LINE + e.getMessage());
                	 throw new BasicServiceException(e.getMessage());
                }
            }
            list.add(result);
		}
		return list;
	}
	
	/**
	 * 此方法系工具方法，作用：删除文件
	 * @param oldPath
	 */
	public void deleteFile(File oldPath) {
        if (oldPath.isDirectory()) {
         System.out.println(oldPath + "是文件夹--");
         File[] files = oldPath.listFiles();
         for (File file : files) {
           deleteFile(file);
         }
        }else{
          oldPath.delete();
        }
      }
	
	@Transactional
	public void deleteAttachmentInAnnounceId(Attachment record) throws BasicServiceException {
		try {
			Attachment attachment = attachmentMapper.queryById(record);
			if(null == attachment){
				throw new BasicServiceException("找不到附件");
			}
			attachmentMapper.deleteById(record.getId());
			interObjectMapper.deleteAnnounceAttachByAttachId(record);
			String fileUrl = attachment.getAttachmentRelativePath();
			File file = new File(fileUrl);
			if(file.exists() && file.isFile())
			{
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		
	}

	public Announce queryAnnouceByAttachmentId(Attachment record) throws BasicServiceException {
		Announce announce;
		try {
			announce = attachmentMapper.queryAnnouceByAttachmentId(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
		return announce;
	}

	@Override
	public String batchDownload(String[] ids) {
		ZipOutputStream out = null;
		try{
				byte[] buffer = new byte[1024];
				User user = UserUtil.getUser(null);
				//if(user == null)
				String zipFileName = DateUtil.getYYYYMMDDHHMMSS()+"_"+(int)(Math.random()*100)+".zip";
				String relativePath = "/download/" + user.getId() + "/";
				String absolutePath = AppConstants.portalShareFileDir + relativePath;//文件在服务器上的绝对路径
				File file = new File(absolutePath);
				if(!file.exists() && !file.isDirectory()){
					System.out.println("file: '"+absolutePath+"' is not exists!");
					file.mkdirs();
				}
				out = new ZipOutputStream(new FileOutputStream(absolutePath+zipFileName));
				File[] files = new File[ids.length];
				Attachment entity = new Attachment();
				String warning = "";
				for(int i=0; i<ids.length; i++)
				{   
					entity.setId(ids[i]);
					Attachment attachment = attachmentMapper.queryById(entity);
					if(attachment != null){
						files[i] = new File(AppConstants.portalShareFileDir+attachment.getAttachmentFilePath());
						if(!files[i].exists() || files[i].isDirectory()){
							warning += attachment.getAttachmentOriginal()+ "; "+System.getProperty("line.separator");
							continue;
						}
						FileInputStream in = new FileInputStream(files[i]);
						out.putNextEntry(new ZipEntry(files[i].getName()));
						int len;  
		                // 读入需要下载的文件的内容，打包到zip文件  
		                while ((len = in.read(buffer)) > 0) { 
		                    out.write(buffer, 0, len);  
		                }
		                out.closeEntry(); 
		                in.close();
		                files[i] = null;
					}
				}
				if(!warning.equals("")){
					warning += System.getProperty("line.separator")+"===========以上文件不存在或已删除";
					File warningTxt= new File("warning.txt");
					if(!warningTxt.exists()){
						warningTxt.createNewFile();
					}
					FileOutputStream fos = new FileOutputStream(warningTxt);
					OutputStreamWriter osw = new OutputStreamWriter(fos);
					osw.write(warning);
					osw.flush();
					osw.close();
					osw = null;
					fos.close();
					fos = null;
					FileInputStream in = new FileInputStream(warningTxt);
					out.putNextEntry(new ZipEntry(warningTxt.getName()));
					int len;  
	                // 读入需要下载的文件的内容，打包到zip文件  
	                while ((len = in.read(buffer)) > 0) { 
	                    out.write(buffer, 0, len);  
	                }
	                out.closeEntry(); 
	                in.close();
	                warningTxt.delete();
	                warningTxt = null;
				}
				return AppConstants.portalShareUrlDir+relativePath+zipFileName;
			}catch(Exception e){
				e.printStackTrace();
				throw new BasicServiceException(e.getMessage());
			}finally{
				try {
					if(out != null){
						out.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
					throw new BasicServiceException(e.getMessage());
				}
			}
	}
	
	/**
	 * 邮件附件上传
	 */
	public List<Attachment> emailAttachmentUpload(List<MultipartFile> myfiles) throws BasicServiceException {
		List<Attachment> list = new ArrayList<Attachment>();
		User user = UserUtil.getUser(null);
		String realativPath = "/file/" + user.getId() + "/" + "emailTemp";
		String realPath = AppConstants.portalShareFileDir + realativPath;
		String originalFilename = null;
		for(MultipartFile myfile : myfiles){
			Attachment result = new Attachment();
			originalFilename = myfile.getOriginalFilename();
			if(originalFilename.lastIndexOf('.') == -1){
				throw new BasicServiceException("文件无后缀名,请校验文件是否合法性");
			}
            if(myfile.isEmpty()){
            	logger.debug(Constants.LOG_DIVISION_LINE + "请选择文件后上传");
            	throw new BasicServiceException("请选择文件后上传");
            }else{
                String newfileName=myfile.getOriginalFilename();
                newfileName=user.getId()+DateUtil.getYYYYMMDDHHMMSS()+(int)(Math.random()*100)+originalFilename.substring(originalFilename.lastIndexOf('.'));
                logger.debug(Constants.LOG_DIVISION_LINE + "生成文件名称: " + newfileName);
                result.setAttachmentName(newfileName);
                logger.debug(Constants.LOG_DIVISION_LINE + "原始文件名称: " + originalFilename);
                result.setAttachmentOriginal(originalFilename);
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件大小: " + myfile.getSize());
                result.setAttachmentSize(String.valueOf(myfile.getSize()));
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件类型: " + myfile.getContentType());
                result.setAttachmentType(myfile.getContentType());
                
                logger.debug(Constants.LOG_DIVISION_LINE + "文件路径: " + realativPath);
                result.setAttachmentPath(realativPath);
                try {
                	/*
                	File listFiles = new File(realPath);
                	if(listFiles.isDirectory()){
                		File[] fileslist = listFiles.listFiles();
                		if(fileslist != null){
                			for(File file : fileslist){
                    			file.delete();
                    		}
                		}
                	}
                	*/
                	File file =  new File(realPath, newfileName);
                	if(!file.exists()){
                		FileUtils.copyInputStreamToFile(myfile.getInputStream(), file);
                	}
                }catch (IOException e) {
                	 logger.debug(Constants.LOG_DIVISION_LINE + e.getMessage());
                	 throw new BasicServiceException(e.getMessage());
                }
            }
            list.add(result);
		}
		return list;
	}
	
	/*
	 * 删除邮件附件
	 */
	public void emailAttachmentDelete(String fileName) throws BasicServiceException {
			if("".equals(fileName)||fileName == null){
				throw new BasicServiceException("附件不存在！");
			}else{
				User user = UserUtil.getUser(null);
				String realativPath = "/file/" + user.getId() + "/" + "emailTemp";
				String realPath = AppConstants.portalShareFileDir + realativPath;
				File file =  new File(realPath, fileName);
				if(file.exists()){
					file.delete();
				}
			}
	}
	
	/**
	 * 下载邮件附件
	 * @param record
	 * @param response
	 */
	public void emailAttachmentDownload(String fileName, HttpServletResponse response)
	{
		int status = 0;
		byte b[] = new byte[1024];
		FileInputStream in = null;
		ServletOutputStream out2 = null;
		try {
			response.setContentType("application/x-download");
			response.setHeader("content-disposition", "attachment; filename=" + fileName);
			User user = UserUtil.getUser(null);
			String realativPath = "/file/" + user.getId() + "/" + "emailTemp";
			String fileUrl = AppConstants.portalShareFileDir + realativPath+"/"+fileName;
			File file = new File(fileUrl);
			if(!file.exists()){
				throw new BasicServiceException("附件不存在！");
			}
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
