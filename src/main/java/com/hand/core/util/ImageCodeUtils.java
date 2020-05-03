package com.hand.core.util;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

public class ImageCodeUtils {

	// 验证码字符集
	private static final char[] chars = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
			'X', 'Y', 'Z', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
	// 字符数量
	private static final int SIZE = 4;
	// 干扰线数量
	private static final int LINES = 5;
	// 宽度
	private static final int WIDTH = 120;
	// 高度
	private static final int HEIGHT = 40;
	// 字体大小
	private static final int FONT_SIZE = 30;

	/**
	 * 生成随机验证码及图片 Object[0]：验证码字符串； Object[1]：验证码图片。
	 */
	public static Object[] createImage() {
		StringBuffer sb = new StringBuffer();
		// 1.创建空白图片
		BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
		// 2.获取图片画笔
		Graphics2D graphic = image.createGraphics();
		// 增加下面代码使得背景透明
		image = graphic.getDeviceConfiguration().createCompatibleImage(WIDTH, HEIGHT, Transparency.TRANSLUCENT);
		graphic.dispose();
		graphic = image.createGraphics();
		// 背景透明代码结束
		// 3.设置画笔颜色
		graphic.setColor(new Color(255, 0, 0));
		// 4.绘制矩形背景
		graphic.fillRect(128, 128, WIDTH, HEIGHT);
		Random ran = new Random();
        // 5.画干扰线
        for (int i = 0; i < LINES; i++) {
            // 设置随机颜色
            graphic.setColor(getRandomColor());
            // 随机画线
            graphic.drawLine(ran.nextInt(WIDTH), ran.nextInt(HEIGHT),
                    ran.nextInt(WIDTH) + ran.nextInt(WIDTH / 8), ran.nextInt(HEIGHT) + ran.nextInt(HEIGHT / 8));
        }
		// 6.画随机字符
		for (int i = 0; i < SIZE; i++) {
			// 取随机字符索引
			int n = ran.nextInt(chars.length);
			// 设置随机颜色
			graphic.setColor(getRandomColor());
			// 设置字体大小
			graphic.setFont(new Font("微软雅黑", Font.BOLD + Font.PLAIN, FONT_SIZE));
			// 画字符
			graphic.drawString(chars[n] + "", i * WIDTH / SIZE, HEIGHT * 2 / 3);
			// 记录字符
			sb.append(chars[n]);
		}
		// 7.返回验证码和图片
		return new Object[] { sb.toString(), image };
	}

	/**
	 * 随机取色
	 */
	public static Color getRandomColor() {
		Random ran = new Random();
		Color color = new Color(ran.nextInt(255), ran.nextInt(255), ran.nextInt(255));
		return color;
	}
}
