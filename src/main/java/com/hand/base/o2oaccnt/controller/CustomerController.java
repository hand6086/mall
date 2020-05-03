package com.hand.base.o2oaccnt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hand.base.basic.service.BasicServiceException;
import com.hand.base.user.model.User;
import com.hand.core.modules.export.ExportFactory;
import com.hand.core.modules.export.ExportWriter;
import com.hand.core.util.UserUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hand.base.basic.controller.BasicController;
import com.hand.base.basic.model.BasicModel;
import com.hand.base.basic.service.BasicService;
import com.hand.base.coupon.model.Coupon;
import com.hand.base.o2oaccnt.model.Customer;
import com.hand.base.o2oaccnt.service.CustomerService;
import com.hand.core.basic.query.QueryParams;

@Controller()
@RequestMapping("/action/portal/customer")
public class CustomerController extends BasicController<Customer> {
	@Resource
	private CustomerService custmService;

	@Override
	public BasicService<Customer> getBasicService() {
		return custmService;
	}

//	public void beforUpsert(Customer entity, HttpServletRequest request) throws Exception {
//
//		if (custmService.isInsertFlag(entity)) {
//			custmService.orgExtInsert(entity);
//			custmService.orgExtXInsert(entity);
//		} else {
//			custmService.update(entity);
//		}

//	}
	
	/**
	 * 根据条件查询记录,默认分页(若将'pageFlag'设置为'false'，则不分页)
	 */
	@RequestMapping(value = "/queryByExamplePage")
	@ResponseBody
	public Map<String, Object> queryByExamplePage(QueryParams qps, Customer entity, HttpSession session, 
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			qps.preDealSecurity(request);
			Customer t = (Customer)BasicModel.transformClass(entity, qps);
			beforQueryAllOrExample(t,request);
			beforQueryExample(t,request);
			//t.setCorpid(UserUtil.getUser(session).getUsercorpid());
			//t.setUsercorpid(UserUtil.getUser(session).getUsercorpid());
			List<Customer> list = new ArrayList<Customer>();
			
			if(qps.getOnlyCountFlag()){
				result.put("success", true);
				int count = custmService.queryCustomerCount(t);
				Customer customer = new Customer();
				customer.setTotal(count);
				list.add(customer);
				result.put("rows", list);
			}else{
				
				list = getBasicService().queryByExamplePage(t);
				result.put("success", true);
				result.put("rows", list);
				this.pushCurrentDataCache(list, session.getId(), "base", false);
				result.put("total", getCount((BasicModel)t, list.size()));
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Customer>());
			result.put("result", e.getMessage());
		}
		return result;
	}

	/**
	 * 根据所选的行查询消费者的邀请关系
	 */
	@RequestMapping(value = "/inviteeQuery", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> inviteeQuery(QueryParams qps, Customer cs, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			
			qps.preDealSecurity(request);
			cs = (Customer) BasicModel.transformClass(Customer.class, qps);
			List<Customer> list = custmService.inviteeQueryPage(cs);

			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) cs), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("result", e.getMessage());
		}
		return result;
	}

	@RequestMapping(value = "/registerCityPickListPage", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> registerCityPickList(QueryParams qps, Customer record, HttpSession session,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Customer t = (Customer) BasicModel.transformClass(record, qps);
			List<Customer> list = custmService.registerCityPickListPage(t);
			result.put("success", true);
			result.put("rows", list);
			result.put("total", getCount(((BasicModel) t), list.size()));
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("rows", new ArrayList<Customer>());
			result.put("result", e.getMessage());
		}
		return result;
	}

    public void beforExportExample(Customer entity, HttpServletRequest request) throws Exception{
        int count = custmService.queryCustomerCount(entity);
        if(count > 20000 ){
            throw new BasicServiceException("检测到需要导出的数据数量过大，请输入筛选条件后再尝试导出！");
        }
    }
}
