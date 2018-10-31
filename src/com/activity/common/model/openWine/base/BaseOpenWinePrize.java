package com.activity.common.model.openWine.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 开酒瓶活动 奖品配置
 * @author ChenXb
 *
 * 2017年11月6日
 */
@SuppressWarnings("serial")
public class BaseOpenWinePrize<M extends BaseOpenWinePrize<M>> extends Model<M> implements IBean {
	
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 所属砸蛋活动ID
	 */
	public void setOpenwineId(java.lang.String OPENWINE_ID) {
		set("OPENWINE_ID", OPENWINE_ID);
	}

	public java.lang.String getOpenwineId() {
		return get("OPENWINE_ID");
	}

	/**
	 * 奖品名称(可以是实物名、红包名)
	 */
	public void setPrizeName(java.lang.String PRIZENAME) {
		set("PRIZENAME", PRIZENAME);
	}

	public java.lang.String getPrizeName() {
		return get("PRIZENAME");
	}

	/**
	 * 奖品图片
	 */
	public void setPrizeImg(java.lang.String PRIZEIMG) {
		set("PRIZEIMG", PRIZEIMG);
	}

	public java.lang.String getPrizeImg() {
		return get("PRIZEIMG");
	}

	/**
	 * 奖品类型 1实物 2积分 3红包
	 */
	public void setPrizeType(java.lang.String PRIZETYPE) {
		set("PRIZETYPE", PRIZETYPE);
	}

	public java.lang.String getPrizeType() {
		return get("PRIZETYPE");
	}
	
	/**
	 * 红包值
	 */
	public void setRedMoney(java.lang.String REDMONEY) {
		set("REDMONEY", REDMONEY);
	}

	public java.lang.String getRedMoney() {
		return get("REDMONEY");
	}

	/**
	 * 奖品数量
	 */
	public void setPrizeNumber(java.lang.String PRIZENUMBER) {
		set("PRIZENUMBER", PRIZENUMBER);
	}

	public java.lang.String getPrizeNumber() {
		return get("PRIZENUMBER");
	}
	
	/**
	 * 中奖概率
	 */
	public void setPrizeProbability(java.lang.String PRIZEPROBABILITY) {
		set("PRIZEPROBABILITY", PRIZEPROBABILITY);
	}

	public java.lang.String getPrizeProbability() {
		return get("PRIZEPROBABILITY");
	}
	
	/**
	 * 积分值
	 */
	public void setIntegral(java.lang.String INTEGRAL) {
		set("INTEGRAL", INTEGRAL);
	}

	public java.lang.String getIntegral() {
		return get("INTEGRAL");
	}

	/**
	 * 备用字段一
	 */
	public void setSpareOne(java.lang.String SPARE_ONE) {
		set("SPARE_ONE", SPARE_ONE);
	}

	public java.lang.String getSpareOne() {
		return get("SPARE_ONE");
	}

	/**
	 * 备用字段二
	 */
	public void setSpareTwo(java.lang.String SPARE_TWO) {
		set("SPARE_TWO", SPARE_TWO);
	}

	public java.lang.String getSpareTwo() {
		return get("SPARE_TWO");
	}

	/**
	 * 剩余数量
	 */
	public void setSurplusPrizeNumber(java.lang.String SURPLUS_PRIZE_NUMBER) {
		set("SURPLUS_PRIZE_NUMBER", SURPLUS_PRIZE_NUMBER);
	}

	public java.lang.String getSurplusPrizeNumber() {
		return get("SURPLUS_PRIZE_NUMBER");
	}
	
	/**
	 * 剩余奖品概率
	 */
	public void setSurplusPrizeProbability(java.lang.String SURPLUS_PRIZE_PROBABILITY) {
		set("SURPLUS_PRIZE_PROBABILITY", SURPLUS_PRIZE_PROBABILITY);
	}

	public java.lang.String getSurplusPrizeProbability() {
		return get("SURPLUS_PRIZE_PROBABILITY");
	}
}
