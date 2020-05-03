package com.hand.core.util;


import java.util.Random;


/**
 * 后台生成随机验证码
 * @author liujie
 */
public class GetCode {
	private static final Random RAND = new Random();
	private static int RAND_MAX_10_THOUSAND = 10000;
	private static int RAND_MAX_10 = 10;
	private static String[] NUMS = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
	public static String getcode1() {
		int result = RAND.nextInt(RAND_MAX_10_THOUSAND);
		return String.format("%04d", result);
			
	}
	public static String getcode() {
		int num1 = RAND.nextInt(RAND_MAX_10);
		int num2 = RAND.nextInt(RAND_MAX_10);
		int num3 = RAND.nextInt(RAND_MAX_10);
		int num4 = RAND.nextInt(RAND_MAX_10);
		return NUMS[num1] + NUMS[num2] + NUMS[num3] + NUMS[num4]; 
			
	}
	
	public static void main(String[] args) {
		System.out.println(getcode());
		long startTime = System.currentTimeMillis();
		for(int i = 0; i < RAND_MAX_10_THOUSAND; i++) {
			getcode();
		}
		
		System.out.println("the algorithm 1 cost "  + (System.currentTimeMillis() - startTime));
		
		startTime = System.currentTimeMillis();
		for(int i = 0; i < RAND_MAX_10_THOUSAND; i++) {
			getcode1();
		}
		
		System.out.println("the algorithm 2 cost "  + (System.currentTimeMillis() - startTime));
	}
}
