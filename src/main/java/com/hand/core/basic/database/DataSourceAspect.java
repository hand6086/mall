package com.hand.core.basic.database;

import java.lang.reflect.Method;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.reflect.MethodSignature;

/**
 * 数据源切面类，动态选择数据源
 * @author qiqian.he
 *
 */
public class DataSourceAspect {

	/**
	 * 切换数据源
	 * @param point
	 * @return
	 */
	public Object changeDataSource(ProceedingJoinPoint point) throws Throwable {
		Object target = point.getTarget();
		String method = point.getSignature().getName();

		Class<?>[] parameterTypes = ((MethodSignature) point.getSignature()).getMethod().getParameterTypes();
		try {
			DynamicDataSourceHolder.clearDataSouce();//清空
			//获取实际调用的service实现类的方法
			Method targetMethod = target.getClass().getMethod(method, parameterTypes);
			//获取实际调用的service实现类对应的接口方法
			/*Method targetInterfaceMethod = target.getClass().getInterfaces()[0].getMethod(method, parameterTypes);*/
			//根据 ‘@DataSource’注解 动态选择数据源，优先取接口实现类的注解
			if(targetMethod != null && targetMethod.isAnnotationPresent(DataSource.class)){
				DataSource data = targetMethod.getAnnotation(DataSource.class);
				DynamicDataSourceHolder.putDataSource(data.value().getName());
			}
			/*else if(targetInterfaceMethod != null && targetInterfaceMethod.isAnnotationPresent(DataSource.class)) {
				DataSource data = targetInterfaceMethod.getAnnotation(DataSource.class);
				DynamicDataSourceHolder.putDataSource(data.value().getName());
			}*/
		} catch (Exception e) {
			// TODO: handle exception
		}
		try {  
			return point.proceed();  
        } finally {  
        	DynamicDataSourceHolder.clearDataSouce();//清空
        }
	}
}
