package com.hand.base.goods.controller;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.goods.model.GoodsSeriesCity;
import com.hand.base.goods.service.GoodsCityService;
import com.hand.base.o2oaccnt.service.AreaManagerService;
import com.hand.core.basic.query.QueryParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/action/portal/goodsCity")
public class PortalGoodsCityController extends BasicController<GoodsSeriesCity> {
	@Autowired
	private GoodsCityService goodsCityService;
    
	@Resource
	private AreaManagerService areaManagerService;
	
	@Override
	public BasicService<GoodsSeriesCity> getBasicService() throws Exception {
			return goodsCityService;
	}
	
	/**
	 * 更新新建之前判断该城市是否已存在
	 */
	@Override
	public void beforUpsert(GoodsSeriesCity entity, HttpServletRequest request) throws Exception {
		//先根据新建或更新后传过来的cityId查询城市是否存在
		//直接使用了queryByExamplePage(其where下有一个cityId条件),所以limit的startRow(BasicModel类)需要设置为1
		entity.setStartRow(1);
		List<GoodsSeriesCity> goodsSeriesCityList= goodsCityService.queryByExamplePage(entity);
		if(goodsSeriesCityList.size() > 0 ){
			throw new BasicServiceException("该城市已存在，请勿重复创建。");
		}
		
	}
	
	@RequestMapping(value = "/queryCityPicklist")
	@ResponseBody
	public Map<String, Object> queryCityPicklist(QueryParams qps,GoodsSeriesCity entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			GoodsSeriesCity t = (GoodsSeriesCity)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			List<GoodsSeriesCity> list = goodsCityService.queryCity(t);
			result.put("success", true);
			result.put("rows", list);
			this.pushCurrentDataCache(list, session.getId(), "base", false);
			result.put("total", getCount((BasicModel)t, list.size()));
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<GoodsSeriesCity>());
			result.put("result", e.getMessage());
		}
		return result;
	}
}
