package com.hand.core.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.hand.base.basic.model.UploadImgInfo;
import com.hand.base.user.model.User;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public final class ImageUtil {
	private static final Logger logger = LogManager.getLogger(ImageUtil.class);
	private static int currentImageIndex = 0;
	private static float quality = 0.1f;//图片质量，值越小，失真越高，占用内存越小
	private static float B_quality = 0.5f;//图片质量，值越小，失真越高，占用内存越小
	private static int MAX_SIZE = 300;//图片长宽不超过300
	private static int L_MAX_SIZE = 150;//图片长宽不超过150
	
	public static void main(String[] args) throws Exception {
    	//makeSmallImage("D:/QQ图片20150715192309.jpg","C:/Users/ZHENGHONGDA/Desktop/a.JPEG");
	}
	
	
	private static final String[] chars = { "0", "1", "2", "3", "4", "5", "6",
			"7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I"};
	private static final int SIZE = 4;
	private static final int LINES = 10;
	private static final int WIDTH = 150;
	private static final int HEIGHT = 70;
	private static final int FONT_SIZE = 40;
	
	static BASE64Encoder encoder = new sun.misc.BASE64Encoder();      
    static BASE64Decoder decoder = new sun.misc.BASE64Decoder();
    
    /**
     * 获取缩略图上传文件名称
     * @return
     */
    public static String getLessUploadFileName()
    {
    	return DateUtil.getYYYYMMDDHHMMSS() + "less.jpg";
    }
    
    /**
     * 获取上传文件名称
     * @return
     */
    public static String getUploadFileName()
    {
    	return DateUtil.getYYYYMMDDHHMMSS() + ".jpg";
    }
    
    /**
     * 获取缩略图上传路径
     * @return
     */
    public static String getLessUploadPath()
    {
    	return System.getProperty("user.dir") + File.separator + "lessUpload" + File.separator;
    }
    
    
    /**
     * 获取上传路径
     * @return
     */
    public static String getUploadPath()
    {
    	return System.getProperty("user.dir") + File.separator + "upload" + File.separator;
    }
    
	
    /**
     * 将二进制字符串生成图片
     * @param srcStr 源图片二进制字符串
     * @param dstImageFileName	待生成的图片完整路径名称 
     * @throws Exception
     */
	public static void makeImage(String srcStr, String dstImageFileName) throws Exception
	{
		try {      
            byte[] bytes1 = decoder.decodeBuffer(srcStr);      
                  
            ByteArrayInputStream bais = new ByteArrayInputStream(bytes1);      
            BufferedImage bi1 =ImageIO.read(bais);      
            File w2 = new File(dstImageFileName);//可以是jpg,png,gif格式      
            ImageIO.write(bi1, "jpg", w2);//不管输出什么格式图片，此处不需改动      
        } catch (IOException e) {      
            e.printStackTrace();      
        }
	}
    
    
	/**
     * 生成缩略图
     * @param srcImageName 图片完整路径名称   
     * @param dstImageFileName 待生成的缩略图片完整路径名称
     * @throws Exception
     */
    public static void makeSmallImage(String srcImageName,String dstImageFileName) throws Exception {
        FileOutputStream fileOutputStream = null;
        JPEGImageEncoder encoder = null;
        BufferedImage tagImage = null;
        Image srcImage = null;
        try{
            srcImage = ImageIO.read(new File(srcImageName));
            int srcWidth = srcImage.getWidth(null);//原图片宽度
            int srcHeight = srcImage.getHeight(null);//原图片高度
            int dstMaxSize = MAX_SIZE;//目标缩略图的最大宽度/高度，宽度与高度将按比例缩写
            int dstWidth = srcWidth;//缩略图宽度
            int dstHeight = srcHeight;//缩略图高度
            float scale = 0;
            //计算缩略图的宽和高
            if(srcWidth>dstMaxSize){
                dstWidth = dstMaxSize;
                scale = (float)srcWidth/(float)dstMaxSize;
                dstHeight = Math.round((float)srcHeight/scale);
            }
            srcHeight = dstHeight;
            if(srcHeight>dstMaxSize){
                dstHeight = dstMaxSize;
                scale = (float)srcHeight/(float)dstMaxSize;
                dstWidth = Math.round((float)dstWidth/scale);
            }
            //生成缩略图
            tagImage = new BufferedImage(dstWidth,dstHeight,BufferedImage.TYPE_INT_RGB);
            tagImage.getGraphics().drawImage(srcImage,0,0,dstWidth,dstHeight,null);
            fileOutputStream = new FileOutputStream(dstImageFileName);
            encoder = JPEGCodec.createJPEGEncoder(fileOutputStream);
//            encoder.encode(tagImage);
            
            JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tagImage);
            /* 压缩质量 */
            jep.setQuality(quality, true);
            encoder.encode(tagImage, jep);
            
            
            fileOutputStream.close();
            fileOutputStream = null;
        }finally{
            if(fileOutputStream!=null){
                try{
                    fileOutputStream.close();
                }catch(Exception e){
                }
                fileOutputStream = null;
            }
            encoder = null;
            tagImage = null;
            srcImage = null;
            System.gc();
        }
    }
    

    public static String  makeBigSmallImage(String srcFilePath,String fileName,String path,String root) throws Exception {
    	String endPath = "/"+ root +"/" + fileName;
		String filePath = path + endPath;
		String fileFolder = path + "/" + root; 
    	
		File file = new File(fileFolder);
		if(!file.exists()){
			logger.info("文件夹路径不存在，创建文件夹【"+fileFolder+"】");
			boolean isCreateSuccess = file.mkdirs();
			if(isCreateSuccess){
				logger.info("Create folder【"+fileFolder+"】 Success");
			}else{
				logger.error("Create folder 【"+fileFolder+"】 Failed");
			}
		}
		if(!file.isDirectory()){
    		//如果路径不是一个目录， 报错
    		logger.error(fileFolder + "is not a file directory!");
    	}else if(!file.canRead()){
    		//如果路径不可读，报错
    		logger.error("this folder can't be read " + fileFolder);
    	}else if(!file.canWrite()){
    		//如果路径不可写，报错
    		logger.error("this folder can't be write " + fileFolder);
    	}
		file = new File(filePath);
		if(file.exists()){
			throw new Exception("文件已经存在，保存文件失败！");
		}else{
			file.createNewFile();
			FileOutputStream fileOutputStream = null;
			BufferedImage tagImage = null;
			Image srcImage = null;
			try{
				srcImage = ImageIO.read(new File(srcFilePath));
				int srcWidth = srcImage.getWidth(null);//原图片宽度
				int srcHeight = srcImage.getHeight(null);//原图片高度
				int dstMaxSize = MAX_SIZE;//目标缩略图的最大宽度/高度，宽度与高度将按比例缩写
				int dstWidth = srcWidth;//缩略图宽度
				int dstHeight = srcHeight;//缩略图高度
				float scale = 0;
				//计算缩略图的宽和高
				if(srcWidth>dstMaxSize){
					dstWidth = dstMaxSize;
					scale = (float)srcWidth/(float)dstMaxSize;
					dstHeight = Math.round((float)srcHeight/scale);
				}
				srcHeight = dstHeight;
				if(srcHeight>dstMaxSize){
					dstHeight = dstMaxSize;
					scale = (float)srcHeight/(float)dstMaxSize;
					dstWidth = Math.round((float)dstWidth/scale);
				}
				//生成缩略图
				tagImage = new BufferedImage(dstWidth,dstHeight,BufferedImage.TYPE_INT_RGB);
				tagImage.getGraphics().drawImage(srcImage,0,0,dstWidth,dstHeight,null);
				fileOutputStream = new FileOutputStream(filePath);
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fileOutputStream);
				
				JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tagImage);
				/* 压缩质量 */
				jep.setQuality(B_quality, true);
				encoder.encode(tagImage, jep);
			
				fileOutputStream.close();
				fileOutputStream = null;
			}finally{
				if(fileOutputStream!=null){
					try{
						fileOutputStream.close();
					}catch(Exception e){
					}
					fileOutputStream = null;
				}
				encoder = null;
				tagImage = null;
				srcImage = null;
				System.gc();
			}
		}
        return endPath;
    }
	
	public static String  makeSmallImage(String srcFilePath,String fileName,String path,String root) throws Exception {
    	String endPath = "/"+ root +"/" + fileName;
		String filePath = path + endPath;
		String fileFolder = path + "/" + root; 
    	
		File file = new File(fileFolder);
		if(!file.exists()){
			logger.info("文件夹路径不存在，创建文件夹【"+fileFolder+"】");
			boolean isCreateSuccess = file.mkdirs();
			if(isCreateSuccess){
				logger.info("Create folder【"+fileFolder+"】 Success");
			}else{
				logger.error("Create folder 【"+fileFolder+"】 Failed");
			}
		}
		if(!file.isDirectory()){
    		//如果路径不是一个目录， 报错
    		logger.error(fileFolder + "is not a file directory!");
    	}else if(!file.canRead()){
    		//如果路径不可读，报错
    		logger.error("this folder can't be read " + fileFolder);
    	}else if(!file.canWrite()){
    		//如果路径不可写，报错
    		logger.error("this folder can't be write " + fileFolder);
    	}
		file = new File(filePath);
		if(file.exists()){
			throw new Exception("文件已经存在，保存文件失败！");
		}else{
			file.createNewFile();
			FileOutputStream fileOutputStream = null;
			BufferedImage tagImage = null;
			Image srcImage = null;
			try{
				logger.info(srcFilePath);
				srcImage = ImageIO.read(new File(srcFilePath));
				int srcWidth = srcImage.getWidth(null);//原图片宽度
				int srcHeight = srcImage.getHeight(null);//原图片高度
				int dstMaxSize = L_MAX_SIZE;//目标缩略图的最大宽度/高度，宽度与高度将按比例缩写
				int dstWidth = srcWidth;//缩略图宽度
				int dstHeight = srcHeight;//缩略图高度
				float scale = 0;
				//计算缩略图的宽和高
				if(srcWidth>dstMaxSize){
					dstWidth = dstMaxSize;
					scale = (float)srcWidth/(float)dstMaxSize;
					dstHeight = Math.round((float)srcHeight/scale);
				}
				srcHeight = dstHeight;
				if(srcHeight>dstMaxSize){
					dstHeight = dstMaxSize;
					scale = (float)srcHeight/(float)dstMaxSize;
					dstWidth = Math.round((float)dstWidth/scale);
				}
				//生成缩略图
				tagImage = new BufferedImage(dstWidth,dstHeight,BufferedImage.TYPE_INT_RGB);
				tagImage.getGraphics().drawImage(srcImage,0,0,dstWidth,dstHeight,null);
				fileOutputStream = new FileOutputStream(filePath);
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(fileOutputStream);
				
				JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tagImage);
				/* 压缩质量 */
				jep.setQuality(quality, true);
				encoder.encode(tagImage, jep);
			
				fileOutputStream.close();
				fileOutputStream = null;
			}finally{
				if(fileOutputStream!=null){
					try{
						fileOutputStream.close();
					}catch(Exception e){
					}
					fileOutputStream = null;
				}
				encoder = null;
				tagImage = null;
				srcImage = null;
				System.gc();
			}
		}
        return endPath;
    }
    
	  public static String getLessUploadFileName(String fileName)
	    {
	    	return fileName + "less.jpg";
	    }
	    
	    /**
	     * 获取上传文件名称
	     * @return
	     */
	    public static String getUploadFileName(String fileName)
	    {
	    	return fileName + ".jpg";
	    }
	    
	 public synchronized static UploadImgInfo saveImageAndLessImage(String strImg,String category,String parentId) throws Exception{
	    	String strImg1 = strImg.substring(strImg.lastIndexOf(",")+1);
	    	UploadImgInfo uploadImgInfo = new UploadImgInfo();
	    	String commonName = getLogin() + DateUtil.getHHMMSS_SSS()+"_"+getNextImageIndex();
	    	String fileName = getUploadFileName(commonName);
	    	String fileLessRelatePath = makeSmallImage(strImg,fileName,AppConstants.portalShareFileDir,"/web/"+category + "/imageless");
	    	String BigLessRelatePath = makeBigSmallImage(strImg,fileName,AppConstants.portalShareFileDir,"/web/"+category + "/bigimage");
			uploadImgInfo.setFileLessPath(AppConstants.portalShareFileDir + fileLessRelatePath);
			uploadImgInfo.setFileLessHtppPath( fileLessRelatePath);
			uploadImgInfo.setBigfilePath(AppConstants.portalShareFileDir + BigLessRelatePath);
			uploadImgInfo.setBigfileHtppPath( BigLessRelatePath);
				
	    	return uploadImgInfo;
	    }
	 public static synchronized int getNextImageIndex(){
	    	if(currentImageIndex > 10000){
	        	currentImageIndex = 0;
	    	}
			return currentImageIndex++;
	    }
	 public static String getLogin(){
			User user = UserUtil.getUser(null);
			return user.getId();
		}
}
