package com.hand.core.xstream;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

class DataTypeConverter implements Converter {

	public void marshal(Object source, HierarchicalStreamWriter writer, MarshallingContext context) {
		if (null == source) {
			return;
		}

		Class<?> cType = source.getClass();
		// 判断是否是List
		// 判断是否是Map
		// 判断是否是对象
		if (source instanceof List) {
			// 这里不需要自己指定list，因为在此构造函数中，已经设置了别名。
			// writer.startNode("list");
			for (Object o : (List<?>) source) {
				boolean isBaseType = isBaseType(o.getClass());
				if (isBaseType) {
					writeData(o, o.getClass(), writer);
				} else {
					writer.startNode("data");
					// 递归组装xml.
					marshal(o, writer, context);
					writer.endNode();
				}
			}
			// writer.endNode();
		} else if (source instanceof Map) {
			// writer.startNode("map");
			for (Map.Entry<?, ?> entry : ((Map<?, ?>) source).entrySet()) {
				writer.startNode(entry.getKey().toString());
				Object o = entry.getValue();
				boolean isBaseType = isBaseType(o.getClass());
				if (isBaseType) {
					writeData(o, o.getClass(), writer);
				} else {
					marshal(o, writer, context);
				}
				// writer.startNode("list");
				// marshal(o, writer, context);
				// writer.endNode();
				writer.endNode();
			} // 递归组装xml.
				// writer.endNode();
		} else {
			try {
				List<Field> fieldList = new ArrayList<Field>();
				Class<?> clazz = cType;
				// fieldList.addAll(cType.getDeclaredFields());
				// fieldList.addAll(java.util.Arrays.asList(cType.getDeclaredFields()));
				while (clazz.getSuperclass() != Object.class) {
					fieldList.addAll(java.util.Arrays.asList(clazz.getDeclaredFields()));
					clazz = clazz.getSuperclass();
				}
				fieldList.addAll(java.util.Arrays.asList(clazz.getDeclaredFields()));

				// Field[] fields = cType.getDeclaredFields();
				for (Field field : fieldList) {
					// 获得get方法
					String temp1 = "get" + field.getName().substring(0, 1).toUpperCase() + field.getName().substring(1);
					Method m = null;
					try {
						m = cType.getMethod(temp1, null);
					} catch (Exception e) {
						continue;
					}

					String methodName = m.getName();
					if (methodName.startsWith("get") && methodName != "getClass") {
						boolean isBaseType = isBaseType(m.getReturnType());
						Object objGetValue = m.invoke(source, null);
						if (objGetValue == null) {
							continue;
						}
						if (isBaseType) {
							writer.startNode(field.getName());
							writeData(objGetValue, m.getReturnType(), writer);
							writer.endNode();
						} else if (m.getReturnType().equals(List.class)) {
							writer.startNode(field.getName());
							if (objGetValue != null) {
								for (Object o : (List<?>) objGetValue) {
									isBaseType = isBaseType(o.getClass());
									if (isBaseType) {
										writeData(o, o.getClass(), writer);
									} else {
										writer.startNode("data");
										// 递归组装xml.
										marshal(o, writer, context);
										writer.endNode();
									}
								} // 递归组装xml.
							}
							writer.endNode();
						} else if (m.getReturnType().equals(Map.class)) {
							writer.startNode(field.getName());
							if (objGetValue != null) {
								for (Map.Entry<?, ?> entry : ((Map<?, ?>) objGetValue).entrySet()) {
									Object o = entry.getValue();
									if (o == null) {
										continue;
									}
									isBaseType = isBaseType(o.getClass());
									if (isBaseType) {
										writer.startNode(entry.getKey().toString());
										writeData(o, o.getClass(), writer);
										writer.endNode();
									} else {
										writer.startNode(entry.getKey().toString());
										marshal(o, writer, context);
										writer.endNode();
									}
								} // 递归组装xml.
							}
							writer.endNode();
						}
					} // end if
				} // end for
			} catch (Exception e) {
				e.printStackTrace();
			} // end catch
		} // end if
	}

	/**
	 * 改写输出XML
	 * 
	 * @param o
	 * @param ReturnType
	 * @param writer
	 */
	private void writeData(Object o, Class<?> ReturnType, HierarchicalStreamWriter writer) {
		// 如果是数字类型的话就要预设为0而不能为空
		// 如果是日期，则做转换yyyy-MM-dd HH:mm:ss.
		if (isNumValueType(ReturnType)) {
			if (o == null) {
				writer.setValue("");
			} else if (ReturnType.equals(Double.class) || ReturnType.equals(double.class)
					|| ReturnType.equals(BigDecimal.class)) {
				DecimalFormat df = new DecimalFormat("#.##");
				writer.setValue(df.format(o));
			} else {
				writer.setValue(o.toString());
			}
		} else if (ReturnType.equals(Date.class)) {
			if (o == null) {
				writer.setValue("");
			} else {
				String result = "";
				try {
					result = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(o);
				} catch (Exception e) {
				} finally {
					writer.setValue(result);
				}
			} // end if (o == null)
		} else {
			writer.setValue(o == null ? "" : o.toString());
		}
	}

	public Object unmarshal(HierarchicalStreamReader reader, UnmarshallingContext context) {
		return null;
	}

	public boolean canConvert(Class type) {
		return true;
	}

	/**
	 * 判断是否为支持的数据类型
	 * 
	 * @param type
	 * @return boolean
	 */
	private boolean isBaseType(Class<?> type) {
		if (type.equals(Integer.class) || type.equals(Double.class) || type.equals(String.class)
				|| type.equals(Boolean.class) || type.equals(Long.class) || type.equals(Short.class)
				|| type.equals(Byte.class) || type.equals(Float.class) || type.equals(BigDecimal.class)
				|| type.equals(int.class) || type.equals(float.class) || type.equals(long.class)
				|| type.equals(double.class) || type.equals(short.class) || type.equals(boolean.class)
				|| type.equals(byte.class) || type.equals(Date.class)) {
			return true;
		}
		return false;
	}

	/**
	 * 判断是否为数字类型
	 * 
	 * @param type
	 * @return boolean
	 */
	public boolean isNumValueType(Class<?> type) {
		if (type.equals(Integer.class) || type.equals(Double.class) || type.equals(Long.class)
				|| type.equals(Short.class) || type.equals(Float.class) || type.equals(BigDecimal.class)
				|| type.equals(int.class) || type.equals(float.class) || type.equals(long.class)
				|| type.equals(double.class) || type.equals(short.class)) {
			return true;
		}
		return false;
	}

}