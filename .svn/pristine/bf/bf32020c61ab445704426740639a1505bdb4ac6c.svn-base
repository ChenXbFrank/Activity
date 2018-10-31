package com.activity.common.utils.probability;

import java.text.DecimalFormat;

/**
 * 概率工具 tanghaobo
 */
public class ProbabilityUtils {
	private static ProbabilityUtils Service = new ProbabilityUtils();
	private ProbabilityUtils() {}
	public static ProbabilityUtils getService() {return Service;}
	
	/**
	 * 两个Int 算概率 保存小数点后两位
	 */
	public String algorithm(int SurplusNumber, int number) {
		Float nowprize = (float) SurplusNumber / (float) number * 100;
		DecimalFormat df = new DecimalFormat("##0.00");// 格式化小数
		String probability = df.format(nowprize);// 返回的是String类型
		return probability;
	}
}
