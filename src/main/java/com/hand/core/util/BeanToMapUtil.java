package com.hand.core.util;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import com.hand.base.basic.model.BasicModel;

/**
 * Map对象与JavaBean互转工具类
 * @author qiqian.he
 *
 */
public class BeanToMapUtil {

	/**
	 * 将一个 Map 对象转化为一个 JavaBean
	 * 
	 * @param type
	 *            要转化的类型
	 * @param map
	 *            包含属性值的 map
	 * @return 转化出来的 JavaBean 对象
	 * @throws IntrospectionException
	 *             如果分析类属性失败
	 * @throws IllegalAccessException
	 *             如果实例化 JavaBean 失败
	 * @throws InstantiationException
	 *             如果实例化 JavaBean 失败
	 * @throws InvocationTargetException
	 *             如果调用属性的 setter 方法失败
	 */
	public static Object convertMap(Class type, Map map)
			throws IntrospectionException, IllegalAccessException, InstantiationException, InvocationTargetException {
		BeanInfo beanInfo = Introspector.getBeanInfo(type); // 获取类属性
		Object obj = type.newInstance(); // 创建 JavaBean 对象
		// 给 JavaBean 对象的属性赋值
		PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
		for (int i = 0; i < propertyDescriptors.length; i++) {
			PropertyDescriptor descriptor = propertyDescriptors[i];
			String propertyName = descriptor.getName();
			if (map.containsKey(propertyName)) {
				// 下面一句可以 try 起来，这样当一个属性赋值失败的时候就不会影响其他属性赋值。
				Object value = map.get(propertyName);
				Object[] args = new Object[1];
				args[0] = value;
				try {
					descriptor.getWriteMethod().invoke(obj, args);
				} catch (Exception e) {
					System.out.println("Map转换为JavaBean操作： \"" + propertyName + "\"转换失败，可能缺少setter方法。");
				}
			}
		}
		return obj;
	}

	/**
	 * 将一个 JavaBean 对象转化为一个 Map
	 * 
	 * @param bean
	 *            要转化的JavaBean 对象
	 * @return 转化出来的 Map 对象
	 * @throws IntrospectionException
	 *             如果分析类属性失败
	 * @throws IllegalAccessException
	 *             如果实例化 JavaBean 失败
	 * @throws InvocationTargetException
	 *             如果调用属性的 setter 方法失败
	 */
	public static Map convertBean(Object bean)
			throws IntrospectionException, IllegalAccessException, InvocationTargetException {
		Class type = bean.getClass();
		Map returnMap = new HashMap();
		BeanInfo beanInfo = Introspector.getBeanInfo(type);
		PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
		for (int i = 0; i < propertyDescriptors.length; i++) {
			PropertyDescriptor descriptor = propertyDescriptors[i];
			String propertyName = descriptor.getName();
			if (!propertyName.equals("class")) {
				Method readMethod = descriptor.getReadMethod();
				Object result = null;
				try {
					result = readMethod.invoke(bean, new Object[0]);
				} catch (Exception e) {
					System.out.println("JavaBean转换为Map操作： \"" + propertyName + "\"转换失败，可能缺少getter方法。");
				}
				if (result != null) {
					returnMap.put(propertyName, result);
				} else {
					returnMap.put(propertyName, "");
				}
			}
		}
		return returnMap;
	}

	public static void main(String[] args) {
		Map<String, String> map = new HashMap<String, String>();
		// map.put("id", "111");
		// map.put("parentId", "1110");
		// map.put("usercorpid", "101");
		// map.put("page", "-1");
		// map.put("rows", "50");
		// map.put("total", "-1");
		// map.put("totalPage", "-1");
		// map.put("startRow", "1");
		// map.put("endRow", "19");
		// map.put("totalFlag", "true");
		// map.put("pageFlag", "true");
		// map.put("corpid", "101");
		// map.put("test1", "101");
		// map.put("test2", "101");
		// map.put("test3", "101");
		// map.put("test4", "101");
		// map.put("test5", "101");
		map.put("attr1", "101");
		try {
			BasicModel basicModel = (BasicModel) BeanToMapUtil.convertMap(BasicModel.class, map);
			System.out.println("------------------------------------------------");
			System.out.println(basicModel.getAttr1());
			System.out.println("------------------------------------------------");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return;

	}
}