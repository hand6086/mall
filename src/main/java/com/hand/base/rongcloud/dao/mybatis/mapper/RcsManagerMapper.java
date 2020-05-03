package com.hand.base.rongcloud.dao.mybatis.mapper;

import com.hand.base.basic.dao.mapper.BasicMapper;
import com.hand.base.rongcloud.model.RcsEmail;
import com.hand.base.rongcloud.model.RcsManager;

import java.util.List;
import java.util.Map;

public interface RcsManagerMapper extends BasicMapper<RcsManager> {

    /**
     * 新建一条智齿邮箱在线消息数据
     * @param
     */
    public void insertZc(RcsEmail rcsEmail) throws Exception;

    /**
     * 查询消息列表
     * @param
     */
    public List<RcsEmail> queryMsgList(RcsEmail entity) throws Exception;

    /**
     * 查询最后一条消息
     * @param
     */
    public RcsEmail queryLastMsg(RcsEmail entity) throws Exception;

    /**
     * 新建一条消息列表数据
     * @param
     */
    public void insertZcList(RcsEmail rcsEmail) throws Exception;

    /**
     * 修改一条消息列表数据
     * @param
     */
    public void updateZcList(RcsEmail rcsEmail) throws Exception;

    /**
     * 通过CID修改一条消息列表数据
     * @param
     */
    public void updateZcByCid(RcsEmail rcsEmail) throws Exception;

}