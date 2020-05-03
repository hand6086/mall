package com.hand.core.util;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.formula.functions.T;

/** 
 *  
 * @Description: 该类用于各种表格的导出Excel 
 */  
public class ExcelCommonUtils {  
  
	/**
     * 新的EXCEL输出工具类
     * 
     * @param fileName
     * @param columnNameStr
     *            指定输出的字段名,逗号分开
     * @param columnFieldStr
     *            指定输出的字段,逗号分开
     * @param dataList
     * @param response
     * @throws IOException
     * @throws ClassNotFoundException
     * @throws NoSuchFieldException
     */
    public void exportExcelNew(String fileName, String columnNameStr,String columnFieldStr, List dataList,HttpServletResponse response) 
        throws Exception {

        String[] columnNames = URLDecoder.decode(columnNameStr, "UTF-8").split(",");
        String[] columnFields = columnFieldStr.split(",");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
        String pattern = sdf.format(new Date());

        // 声明一个工作薄
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 生成一个表格
        HSSFSheet sheet = workbook.createSheet(fileName + pattern);
        // 设置表格默认列宽度为15个字节
        sheet.setDefaultColumnWidth((short) 15);
        // 生成一个样式
        HSSFCellStyle style = workbook.createCellStyle();
        // 设置这些样式
        // style.setFillForegroundColor(HSSFColor.SKY_BLUE.index); //设置前景色
        // style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

        style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        // 生成一个字体
        HSSFFont font = workbook.createFont();
        // font.setColor(HSSFColor.VIOLET.index);
        font.setFontHeightInPoints((short) 10);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        // 把字体应用到当前的样式
        style.setFont(font);
        // 生成并设置另一个样式
        HSSFCellStyle style2 = workbook.createCellStyle();
        // style2.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index); //生成前景色
        // style2.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN);
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);
        style2.setAlignment(HSSFCellStyle.ALIGN_LEFT);
        style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
        // 生成另一个字体
        HSSFFont font2 = workbook.createFont();
        font2.setBoldweight(HSSFFont.BOLDWEIGHT_NORMAL);
        font2.setFontName("宋体"); // 设置字体
        font2.setFontHeightInPoints((short) 10); // 设置字体大小
        // 把字体应用到当前的样式
        style2.setFont(font2);

        // 声明一个画图的顶级管理器
        HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
        // 定义注释的大小和位置,详见文档
        // HSSFComment comment = patriarch.createComment(new
        // HSSFClientAnchor(0,0, 0, 0, (short) 4, 2, (short) 6, 5));
        // 设置注释内容
        // comment.setString(new HSSFRichTextString("可以在POI中添加注释！"));
        // 设置注释作者，当鼠标移动到单元格上是可以在状态栏中看到该内容.
        // comment.setAuthor("leno");

        // 产生表格标题行
        HSSFRow row = sheet.createRow(0);
        for (short i = 0; i < columnNames.length; i++) {
            HSSFCell cell = row.createCell(i);
            cell.setCellStyle(style);
            HSSFRichTextString text = new HSSFRichTextString(columnNames[i]);
            cell.setCellValue(text);
        }

        // 遍历集合数据，产生数据行
        int index = 0;
        // HSSFFont font3 = workbook.createFont();
        for(Object o : dataList){
        	 index++;
             row = sheet.createRow(index);

             for (short i = 0; i < columnFields.length; i++) {
                 HSSFCell cell = row.createCell(i);
                 cell.setCellStyle(style2);

                 String fieldName = columnFields[i];

                 try {

                     Object value = getValue(o, fieldName);

                     // 判断值的类型后进行强制类型转换
                     String textValue = null;

                     if (value instanceof String) {
                         textValue = value.toString();
                     } else if (value instanceof Integer) {
                         textValue = value.toString();
                     } else if (value instanceof BigInteger) {
                         textValue = value.toString();
                     } else if (value instanceof Float) {
                         textValue = value.toString();
                     } else if (value instanceof Double) {
                         textValue = value.toString();
                     } else if (value instanceof Long) {
                         textValue = value.toString();
                     } else if (value instanceof BigDecimal) {
                         textValue = value.toString();
                     } else if (value instanceof Boolean) {
                         boolean bValue = (Boolean) value;
                         textValue = "是";
                         if (!bValue) {
                             textValue = "否";
                         }
                     } else if (value instanceof Date) {
                         Date date = (Date) value;
                         SimpleDateFormat sdf2 = new SimpleDateFormat(
                                 "yyyy-MM-dd HH:mm:ss");
                         textValue = sdf2.format(date);
                     } else if (value instanceof byte[]) {
                         // 有图片时，设置行高为60px;
                         row.setHeightInPoints(60);
                         // 设置图片所在列宽度为80px,注意这里单位的一个换算
                         sheet.setColumnWidth(i, (short) (35.7 * 80));
                         // sheet.autoSizeColumn(i);
                         byte[] bsValue = (byte[]) value;
                         HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0,
                                 1023, 255, (short) 6, index, (short) 6, index);
                         anchor.setAnchorType(2);
                         patriarch.createPicture(anchor, workbook.addPicture(
                                 bsValue, HSSFWorkbook.PICTURE_TYPE_JPEG));
                     } else {
                         // 其它数据类型都当作字符串简单处理
                         if (value != null) {
                             textValue = value.toString();
                         }
                     }
                     // 如果不是图片数据，就利用正则表达式判断textValue是否全部由数字组成
                     if (textValue != null) {
                         Pattern p = Pattern.compile("^//d+(//.//d+)?{1}quot");
                         Matcher matcher = p.matcher(textValue);
                         if (matcher.matches()) {
                             // 是数字当作double处理
                             cell.setCellValue(Double.parseDouble(textValue));
                         } else {
                             HSSFRichTextString richString = new HSSFRichTextString(textValue);
                             // font3.setColor(HSSFColor.BLUE.index);
                             // richString.applyFont(font3);
                             cell.setCellValue(richString);
                         }
                     }
                 } catch (SecurityException e) {
                     e.printStackTrace();
                 } catch (IllegalArgumentException e) {
                     e.printStackTrace();
                 } catch (IllegalAccessException e) {
                     e.printStackTrace();
                 } finally {
                     // 清理资源
                 }
             }
        }

        // 输出流
        OutputStream out = null;
        try {
            response.setContentType("application/vnd.ms-excel; charset=utf-8");
            response.setHeader("Content-Disposition", "attachment;filename="+ java.net.URLEncoder.encode(fileName + ".xls", "UTF-8"));
            response.setCharacterEncoding("utf-8");
            out = response.getOutputStream();
            workbook.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }

    }

    // 递归调用，获取多层包装类中的值
    private Object getValue(Object obj, String colField)
            throws NoSuchFieldException, SecurityException,
            IllegalArgumentException, IllegalAccessException,
            ClassNotFoundException {
        Object value = null;
        if (colField.indexOf(".") > 0) {
            String fieldName = colField.substring(0, colField.indexOf("."));
            Field field = obj.getClass().getDeclaredField(fieldName);
            Class<?> clazz = Class.forName(field.getType().getName());
            field.setAccessible(true);
            Object fieldObj = field.get(obj);
            String nextField = colField.substring(colField.indexOf(".") + 1);
            value = getValue(fieldObj, nextField);
        } else {
            Field field = obj.getClass().getDeclaredField(colField);
            field.setAccessible(true);
            value = field.get(obj);
        }
        return value;
    }
}  