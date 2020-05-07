package com.hand.base.basic.dao;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.hand.core.util.AppConstants;
import com.hand.core.util.StringUtils;

@Service
public class KeyGenerateDao {
	
	private static final Logger logger = LogManager.getLogger(KeyGenerateDao.class);
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public String keyGenerate(){
		String sql = "select s_sequence_pkg_get_next_rowid() as result";
		String id = (String)jdbcTemplate.queryForObject(sql,String.class);
		logger.debug("生成的Sequence = ["+id+"]");
		return id;
	}

	public String orderNoGenerate() {
		String sql = "";
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			sql = "select concat(date_format(now(), '%Y%m%d'), nextval('S_ORDER_SEQUENCE_S')) from dual";
		}else if(StringUtils.equals(AppConstants.key_applicationDatabase, "oracle")){
			sql = "select to_char(sysdate, 'yyyymmdd') || S_ORDER_SEQUENCE_S.NEXTVAL from dual";
		}
		String orderNo = (String)jdbcTemplate.queryForObject(sql,String.class);
		logger.debug("生成的订单编号 Sequence = ["+orderNo+"]");
		return orderNo;
	}

	public String memCardNoGenerate() {
		String sql = "";
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			sql = "select concat(date_format(now(), '%Y'), nextval('S_MEMCARD_SEQUENCE_S')) from dual";
		}else if(StringUtils.equals(AppConstants.key_applicationDatabase, "oracle")){
			sql = "select to_char(sysdate, 'yyyy') || S_MEMCARD_SEQUENCE_S.NEXTVAL from dual";
		}
		String memCardNo = (String)jdbcTemplate.queryForObject(sql,String.class);
		logger.debug("生成的订单编号 Sequence = ["+memCardNo+"]");
		return memCardNo;
	}
	public String keyo2oCode(){
		String code = null;
		String sql = "";
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			sql = "select TB_O2O_ACCTIVITYCODE() as result";
		}else if(StringUtils.equals(AppConstants.key_applicationDatabase, "oracle")){
			sql = "select s_sequence_pkg.get_next_rowid() as result from dual";
		}
		
		code = (String)jdbcTemplate.queryForObject(sql,String.class);
		logger.debug("生成的Sequence = ["+code+"]");
		return code;
	}
	
	/**
	 * 生成公司账套编号
	 * @return
	 */
	public String corpIdGenerate(){
		String id = null;
		String sql = "";
		if(StringUtils.equals(AppConstants.key_applicationDatabase, "mysql")){
			sql = "select nextval('S_CORP_ID') as result";
		}else if(StringUtils.equals(AppConstants.key_applicationDatabase, "oracle")){
			
		}
		id = (String)jdbcTemplate.queryForObject(sql,String.class);
		logger.info("生成的CorpId = ["+id+"]");
		return id;
	}

}
