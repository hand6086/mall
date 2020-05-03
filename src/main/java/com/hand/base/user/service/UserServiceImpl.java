package com.hand.base.user.service;

import javax.annotation.Resource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.basic.service.BasicServiceImpl;
import com.hand.base.basic.service.KeyGenerateService;
import com.hand.base.duty.service.DutyService;
import com.hand.base.position.service.PositionService;
import com.hand.base.user.dao.mybatis.mapper.LoginMapper;
import com.hand.base.user.dao.mybatis.mapper.UserMapper;
import com.hand.base.user.model.User;
import com.hand.core.basic.query.Filter;
import com.hand.core.basic.query.QueryParams;
import com.hand.core.util.AppConstants;
import com.hand.core.util.PasswordUtil;
import com.hand.core.util.StringUtils;
import com.hand.core.util.UserUtil;

@Service
public class UserServiceImpl extends BasicServiceImpl<User> implements UserService{
	
	private static final Logger logger = LogManager.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private LoginMapper loginMapper;
	/*@Resource
	private LdapShaPasswordEncoder passwordEncoder;*/
	@Autowired
	protected KeyGenerateService keyGenerateService;
	@Resource
	private PositionService positionService;
	@Resource
	private DutyService dutyService;
	
	
	@Override
	public BasicMapper<User> getBasicMapper() throws Exception {
		return userMapper;
	}
	
	
	/**
	 * 修改员工密码
	 * @param id 员工ID
	 * @param newPassword 新密码
	 * @param confirmPassword 确认密码
	 * @return
	 * @throws BasicServiceException
	 */
	public String modifyEmpLoyeePassword(String id,String empType, String newPassword, String confirmPassword) throws BasicServiceException {
		if(newPassword != null && !newPassword.trim().isEmpty()){
			if(confirmPassword != null && !confirmPassword.trim().isEmpty()){
				newPassword = newPassword.trim();
				confirmPassword = confirmPassword.trim();
				if(newPassword.equals(confirmPassword)){
					User sessionUser = UserUtil.getUser(null);
					if(!sessionUser.getId().equals(id))
					{
						//修改密码信息
						String encodedNewPassword = PasswordUtil.generatePwd(newPassword);//passwordEncoder.encodePassword(newPassword,null);
						User record = new User();
						record.setId(id);
						record.setPassword(encodedNewPassword);
						try {
							// 判断新密码是否与原密码一致
							User u = new User();
							u.setId(id);
							User rs = userMapper.queryById(u);
							if(rs.getPassword().equals(encodedNewPassword))
							{
								throw new BasicServiceException("新密码不能与旧密码一致");
							}
							if(empType.equals("INTER_EMP") || empType.equals("STORE_EMP")||empType.equals("BRAND_EMP")){
								userMapper.changeUserPasswordUpdate(record);
							}else{
								String AppNewPassword = PasswordUtil.getMD5StrJava(newPassword);
								record.setPassword(AppNewPassword);
								userMapper.changeAppUserPasswordUpdate(record);
							}
						} catch (Exception e) {
							e.printStackTrace();
							throw new BasicServiceException(e.getMessage());
						}
					}
					else
					{
						throw new BasicServiceException("不能修改自己的密码，请通过快捷栏修改自己的密码");
					}
					
				}else{
					throw new BasicServiceException("新密码与确认密码不一致");
				}
			}else{
				throw new BasicServiceException("确认密码为空");
			}
		}else{
			throw new BasicServiceException("新密码为空");
		}
		
		return null;
	}
	
	public String modifyPassword(User user, String oldPassword,
			String newPassword, String confirmPassword) throws BasicServiceException {
		if(oldPassword != null && !oldPassword.trim().isEmpty()){
			if(newPassword != null && !newPassword.trim().isEmpty()){
				if(confirmPassword != null && !confirmPassword.trim().isEmpty()){
					oldPassword = oldPassword.trim();
					newPassword = newPassword.trim();
					confirmPassword = confirmPassword.trim();
					
					String encodedOldPassword = PasswordUtil.generatePwd(oldPassword);//passwordEncoder.encodePassword(oldPassword,null);
					if(user.getPassword().equals(encodedOldPassword)){
						if(newPassword.equals(confirmPassword)){
							if(oldPassword.equals(newPassword))
							{
								throw new BasicServiceException("新密码不能与旧密码一致");
							}
							//修改密码信息
							String encodedNewPassword = PasswordUtil.generatePwd(newPassword);//passwordEncoder.encodePassword(newPassword,null);
							user.setPassword(encodedNewPassword);
							try {
								userMapper.changeUserPasswordUpdate(user);
							} catch (Exception e) {
								e.printStackTrace();
								throw new BasicServiceException(e.getMessage());
							}
						}else{
							throw new BasicServiceException("新密码与确认密码不一致");
						}
					}else{
						throw new BasicServiceException("原密码错误");
					}
				}else{
					throw new BasicServiceException("确认密码为空");
				}
			}else{
				throw new BasicServiceException("新密码为空");
			}
		}else{
			throw new BasicServiceException("原密码为空");
		}
		
		return null;
	}

	/**
	 * 重置密码
	 * @param user
	 * @param newPassword
	 * @param confirmPassword
	 * @return
	 * @throws BasicServiceException
	 */
	public String resetPassword(User user, String newPassword, 
			String confirmPassword) throws BasicServiceException {
			if(newPassword != null && !newPassword.trim().isEmpty()){
				if(confirmPassword != null && !confirmPassword.trim().isEmpty()){
					newPassword = newPassword.trim();
					confirmPassword = confirmPassword.trim();
						if(newPassword.equals(confirmPassword)){
							if(newPassword.length() >= 6){
								//修改密码信息
								String encodedNewPassword = PasswordUtil.generatePwd(newPassword);//passwordEncoder.encodePassword(newPassword,null);
								user.setPassword(encodedNewPassword);
								try {
									userMapper.resetUserPassword(user.getPassword(),user.getId());
								} catch (Exception e) {
									e.printStackTrace();
									throw new BasicServiceException(e.getMessage());
								}
							}else{
								throw new BasicServiceException("密码长度不足6位");
							}
						}else{
							throw new BasicServiceException("新密码与确认密码不一致");
						}
				}else{
					throw new BasicServiceException("确认密码为空");
				}
			}else{
				throw new BasicServiceException("新密码为空");
			}
		
		
		return null;
	}	
	/**
	 * 根据用户名查找用户
	 * @param username 用户名
	 * @return 用户信息
	 */
	public User getUserByUsername(String username) throws BasicServiceException{
		//忽略大小写,自动转换成大写
		String usernameUpperCase = username.toUpperCase();
		User record = new User();
		record.setUsername(usernameUpperCase);
		try {
			return loginMapper.queryByUsername(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}

	/**
	 * 根据手机号查询用户信息
	 * @param phone 手机号
	 * @return 用户信息
	 * @author anxiaobo
	 * @date 2019/04/22 11:05
	 * @throws BasicServiceException
	 */
	@Override
	public User getUserByPhone(String phone) throws BasicServiceException{
		User record = new User();
		record.setContactPhone(phone);
		try {
			return loginMapper.queryByPhone(record);
		} catch (Exception e) {
			e.printStackTrace();
			throw new BasicServiceException(e.getMessage());
		}
	}
	/*public User postDefaultValue(User record){
		String encodedNewPassword = "";
		String pwd = record.getPassword();
		if("OUTER_EMP".equals(record.getEmpType())){
			if(StringUtils.isBlank(pwd)){
				String phone = record.getContactPhone();
				pwd = phone.substring(phone.length()-6, phone.length());
			}
			encodedNewPassword = passwordEncoder.encodePassword(pwd,null);
		}else if("INTER_EMP".equals(record.getEmpType())){
			encodedNewPassword = passwordEncoder.encodePassword("111111",null);
		}else{
			throw new BasicServiceException("无法区分用户类型");
		}
		record.setPassword(encodedNewPassword);
		return record;
	}*/

	@Override
	public User querySampleUserById(User record) throws Exception {
		return userMapper.querySampleUserById(record);
	}

	@Override
	public void updateDmsProfile(User record) throws Exception {
		userMapper.updateDmsProfile(record);
	}
	
	@Override
	@Transactional
	public void upsert(User entity) throws Exception {
		super.upsert(entity);
		//同时修改职位的主要负责人
		String postnId = entity.getPostnId();
		String userId = entity.getId();
		if(StringUtils.isNotBlank(postnId)){
			QueryParams qps = new QueryParams();
			qps.setPageFlag(false);
			qps.addFilter(new Filter("id", postnId));
			
		}
	}
	
	public User outerPreDefaultValue() throws Exception {
		User outerUser = new User();
		String outerUserId = keyGenerateService.keyGenerate();
		String defaultDutyId = AppConstants.outerUserDefaultDuty;
		String defaultPostnId = AppConstants.outerUserDefaultPostn;
		String defaultRole = AppConstants.outerUserDefaultRole;
		outerUser.setId(outerUserId);
		outerUser.setRole(defaultRole);
		outerUser.setDutyId(defaultDutyId);
		outerUser.setPostnId(defaultPostnId);
		
		return outerUser;
	}

	@Override
	public void qidianInfoUpdate(User record) throws Exception {
		if(StringUtils.isBlank(record.getQdAssStatus())){
			throw new Exception("【企点分配状态】不能为空");
		}
		userMapper.qidianInfoUpdate(record);
	}
	
	@Override
	public void mainPostnUpdate(String userId, String postnId) throws Exception {
		User entity = new User();
		entity.setId(userId);
		entity.setPostnId(postnId);
		userMapper.mainPostnUpdate(entity);
	}
	
	@Override
	public int queryUserCount(User entity) throws Exception {
		return userMapper.queryUserCount(entity);
	}
}
