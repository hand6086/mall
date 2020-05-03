package com.hand.base.common.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.common.model.Announce;
import com.hand.base.common.model.Attachment;

public interface AttachmentService extends BasicService<Attachment>{
	
	/**
	 * 单个附件上传
	 * @param 
	 * @throws BasicServiceException
	 */
	public void upload(MultipartFile myfile, Attachment record) throws BasicServiceException;
	
	/**
	 * 删除文件
	 * @param filePath 文件的服务器路径
	 * @throws BasicServiceException
	 */
	public void fileDelete(String filePath) throws BasicServiceException;
	
	/**
	 * 查询资源库列表
	 */
	public List<Attachment> queryAttachmentLibraryListPage(Attachment record) throws Exception;
	
	
	
	
	/* ---------------------------------------------------------------------------------- */
	
	/**
	 * 附件上传，其中方法的参数为MultipartFile[]
	 * @param MultipartFile[]
	 * @throws BasicServiceException
	 * @return 附件对象
	 */
	public List<Attachment> attachmentUpload(MultipartFile[] myfiles) throws BasicServiceException;
	
	/**
	 * 附件上传，其中方法的参数为List<MultipartFile>
	 * @param myfiles
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Attachment> attachmentListUpload(List<MultipartFile> myfiles) throws BasicServiceException;
	
	/**
	 * 上传附件并覆盖原有附件
	 * @param myfiles
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Attachment> attachmentUploadAndCover(MultipartFile[] myfiles) throws BasicServiceException;
	
	/**
	 * 查询公告下的附件列表
	 * @return
	 * @throws Exception
	 */
	public List<Attachment> queryAttachmentListByAnnounceId(Announce record) throws BasicServiceException;
	
	/**
	 * 编辑公告时，删除公告下的附件
	 * @param record
	 * @throws BasicServiceException
	 */
	public void deleteAttachmentInAnnounceId(Attachment record) throws BasicServiceException;
	
	/**
	 * 根据附件Id查询附件隶属的公告信息
	 * @param record
	 * @throws BasicServiceException
	 */
	public Announce queryAnnouceByAttachmentId(Attachment record) throws BasicServiceException;
	
	/**
	 * 
	 *<p>多文件打包下载</p>
	 * @author yrf
	 * @param ids 文件id字符串组
	 * @return 生成压缩包的url
	 */
	public String batchDownload(String[] ids);
	
	/**
	 * 邮件附件上传，其中方法的参数为List<MultipartFile>
	 * @param myfiles
	 * @return
	 * @throws BasicServiceException
	 */
	public List<Attachment> emailAttachmentUpload(List<MultipartFile> myfiles) throws BasicServiceException;
	
	/**
	 * 删除邮件附件
	 * @param fileName
	 * @throws BasicServiceException
	 */
	public void emailAttachmentDelete(String fileName) throws BasicServiceException;
	
	/**
	 * 下载邮件附件
	 * @param fileName
	 * @param response
	 * @throws BasicServiceException
	 */
	public void emailAttachmentDownload(String fileName, HttpServletResponse response) throws BasicServiceException;
}
