package com.activity.common.model.fireStorm.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 火爆小酒红包活动 
 * @author ChenXb
 *
 * 2018年7月3日      FIRE_STORM_RED_PRIZE
 */
@SuppressWarnings("serial")
public class BaseFireStormRedPrize<M extends BaseFireStormRedPrize<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}
	/**
	 * 抢红包活动ID
	 * @param RED_ID
	 */
	public void setRedId(java.lang.String RED_ID) {
		set("RED_ID", RED_ID);
	}

	public java.lang.String getRedId() {
		return get("RED_ID");
	}

	/**
	 * 奖项
	 */
	public void setPrizeProject(java.lang.String PRIZE_PROJECT) {
		set("PRIZE_PROJECT", PRIZE_PROJECT);
	}

	public java.lang.String getPrizeProject() {
		return get("PRIZE_PROJECT");
	}

	/**
	 * 扫码中奖次数
	 */
	public void setScanRodRedNum(java.lang.String SCANRODREDNUM) {
		set("SCANRODREDNUM", SCANRODREDNUM);
	}

	public java.lang.String getScanRodRedNum() {
		return get("SCANRODREDNUM");
	}
	
	/**
	 * 模式一:奖项金额(积分不填写)  模式二:红包金额
	 */
	public void setPrizeProjectMoney(java.lang.String PRIZE_PROJECT_MONEY) {
		set("PRIZE_PROJECT_MONEY", PRIZE_PROJECT_MONEY);
	}

	public java.lang.String getPrizeProjectMoney() {
		return get("PRIZE_PROJECT_MONEY");
	}

	/**
	 * 模式一:奖品人数  模式二:中奖人数
	 */
	public void setGetPrizeNumber(java.lang.String GET_PRIZE_NUMBER) {
		set("GET_PRIZE_NUMBER", GET_PRIZE_NUMBER);
	}

	public java.lang.String getGetPrizeNumber() {
		return get("GET_PRIZE_NUMBER");
	}

	/**
	 * 小计
	 */
	public void setSubTotal(java.lang.String SUBTOTAL) {
		set("SUBTOTAL", SUBTOTAL);
	}

	public java.lang.String getSubTotal() {
		return get("SUBTOTAL");
	}

	/**
	 * 中奖概率
	 */
	public void setRedWinningProbability(java.lang.String RED_WINNING_PROBABILITY) {
		set("RED_WINNING_PROBABILITY", RED_WINNING_PROBABILITY);
	}

	public java.lang.String getRedWinningProbability() {
		return get("RED_WINNING_PROBABILITY");
	}

	/**
	 * 中奖积分概率
	 */
	public void setIntegralWinningProbability(java.lang.String INTEGRAL_WINNING_PROBABILITY) {
		set("INTEGRAL_WINNING_PROBABILITY", INTEGRAL_WINNING_PROBABILITY);
	}

	public java.lang.String getIntegralWinningProbability() {
		return get("INTEGRAL_WINNING_PROBABILITY");
	}

	/**
	 * 中奖积分
	 */
	public void setWinningIntegral(java.lang.String WINNING_INTEGRAL) {
		set("WINNING_INTEGRAL", WINNING_INTEGRAL);
	}

	public java.lang.String getWinningIntegral() {
		return get("WINNING_INTEGRAL");
	}
	
	/**
	 * 积分中奖人数
	 */
	public void setWinningIntegralNumber(java.lang.String WINNING_INTEGRAL_NUMBER) {
		set("WINNING_INTEGRAL_NUMBER", WINNING_INTEGRAL_NUMBER);
	}

	public java.lang.String getWinningIntegralNumber() {
		return get("WINNING_INTEGRAL_NUMBER");
	}

	/**
	 * 红包概率合计
	 */
	public void setProbabilityTotal(java.lang.String RED_PROBABILITY_TOTAL) {
		set("RED_PROBABILITY_TOTAL", RED_PROBABILITY_TOTAL);
	}

	public java.lang.String getProbabilityTotal() {
		return get("RED_PROBABILITY_TOTAL");
	}
	
	/**
	 * 积分概率合计
	 */
	public void setIntegralProbabilityTotal(java.lang.String INTEGRAL_PROBABILITY_TOTAL) {
		set("INTEGRAL_PROBABILITY_TOTAL", INTEGRAL_PROBABILITY_TOTAL);
	}

	public java.lang.String getIntegralProbabilityTotal() {
		return get("INTEGRAL_PROBABILITY_TOTAL");
	}
	
	
	/**
	 * 奖项金额合计
	 */
	public void setPrizeProjectTotalMoney(java.lang.String PRIZE_PROJECT_TOTAL_MONEY) {
		set("PRIZE_PROJECT_TOTAL_MONEY", PRIZE_PROJECT_TOTAL_MONEY);
	}

	public java.lang.String getPrizeProjectTotalMoney() {
		return get("PRIZE_PROJECT_TOTAL_MONEY");
	}

	/**
	 * 剩余数量
	 */
	public void setSurplusNumber(java.lang.String SURPLUS_NUMBER) {
		set("SURPLUS_NUMBER", SURPLUS_NUMBER);
	}

	public java.lang.String getSurplusNumber() {
		return get("SURPLUS_NUMBER");
	}
	
	/**
	 * 剩余奖品中奖概率
	 */
	public void setSurplusPrizeProbability(java.lang.String SURPLUS_PRIZE_PROBABILITY) {
		set("SURPLUS_PRIZE_PROBABILITY", SURPLUS_PRIZE_PROBABILITY);
	}

	public java.lang.String getSurplusPrizeProbability() {
		return get("SURPLUS_PRIZE_PROBABILITY");
	}
	
	/**
	 * 剩余积分数量
	 */
	public void setSurplusIntegralNumber(java.lang.String SURPLUS_INTEGRAL_NUMBER) {
		set("SURPLUS_INTEGRAL_NUMBER", SURPLUS_INTEGRAL_NUMBER);
	}

	public java.lang.String getSurplusIntegralNumber() {
		return get("SURPLUS_INTEGRAL_NUMBER");
	}
	
	/**
	 * 剩余积分奖品中奖概率
	 */
	public void setSurplusIntegralProbability(java.lang.String SURPLUS_INTEGRAL_PROBABILITY) {
		set("SURPLUS_INTEGRAL_PROBABILITY", SURPLUS_INTEGRAL_PROBABILITY);
	}

	public java.lang.String getSurplusIntegralProbability() {
		return get("SURPLUS_INTEGRAL_PROBABILITY");
	}
	
	
	/**
	 * 剩余概率
	 */
	public void setSurplusProbability(java.lang.String SURPLUS_PROBABILITY) {
		set("SURPLUS_PROBABILITY", SURPLUS_PROBABILITY);
	}

	public java.lang.String getSurplusProbability() {
		return get("SURPLUS_PROBABILITY");
	}
	
	/**
	 * 剩余积分
	 */
	public void setSurplusIntegral(java.lang.String SURPLUS_INTEGRAL) {
		set("SURPLUS_INTEGRAL", SURPLUS_INTEGRAL);
	}

	public java.lang.String getSurplusIntegral() {
		return get("SURPLUS_INTEGRAL");
	}
	
	/**
	 * 剩余金额
	 */
	public void setSurplusMoney(java.lang.String SURPLUS_MONEY) {
		set("SURPLUS_MONEY", SURPLUS_MONEY);
	}

	public java.lang.String getSurplusMoney() {
		return get("SURPLUS_MONEY");
	}
	
	/**
	 * 活动创建时间
	 */
	public void setCreateTime(java.lang.String CREATE_TIME) {
		set("CREATE_TIME", CREATE_TIME);
	}

	public java.lang.String getCreateTime() {
		return get("CREATE_TIME");
	}
	
}
