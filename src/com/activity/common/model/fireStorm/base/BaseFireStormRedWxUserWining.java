package com.activity.common.model.fireStorm.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 火爆小酒红包活动 
 * @author ChenXb
 *
 * 2018年7月3日      FIRE_STORM_RED_WXUSER_WINNING
 */
@SuppressWarnings("serial")
public class BaseFireStormRedWxUserWining<M extends BaseFireStormRedWxUserWining<M>> extends Model<M> implements IBean{

	
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}
	
	/**
	 * 抢红包参与记录ID
	 * @param RED_WXUSER_ID
	 */
	public void setRedWxuserId(java.lang.String RED_WXUSER_ID) {
		set("RED_WXUSER_ID", RED_WXUSER_ID);
	}

	public java.lang.String getRedWxuserId() {
		return get("RED_WXUSER_ID");
	}
	
	/**
	 * 所属中奖ID
	 * @param BELONG_ROB_RED_PRIZE_ID
	 */
	public void setBelongRobRedPrizeId(java.lang.String BELONG_ROB_RED_PRIZE_ID) {
		set("BELONG_ROB_RED_PRIZE_ID", BELONG_ROB_RED_PRIZE_ID);
	}

	public java.lang.String getBelongRobRedPrizeId() {
		return get("BELONG_ROB_RED_PRIZE_ID");
	}
	
	/**
	 * 中奖金额/积分
	 * @param RED_WXUSER_ID
	 */
	public void setWinningMoney(java.lang.String WINNING_MONEY) {
		set("WINNING_MONEY", WINNING_MONEY);
	}

	public java.lang.String getWinningMoney() {
		return get("WINNING_MONEY");
	}
	
	/**
	 * 奖项
	 * @param RED_WXUSER_ID
	 */
	public void setPrizeProject(java.lang.String PRIZE_PROJECT) {
		set("PRIZE_PROJECT", PRIZE_PROJECT);
	}

	public java.lang.String getPrizeProject() {
		return get("PRIZE_PROJECT");
	}
	
	/**
	 * 创建时间
	 * @param RED_WXUSER_ID
	 */
	public void setCreateTime(java.lang.String CREATE_TIME) {
		set("CREATE_TIME", CREATE_TIME);
	}

	public java.lang.String getCreateTime() {
		return get("CREATE_TIME");
	}
	
	/**
	 * 微信指定ID
	 * @param RED_WXUSER_ID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
	}
	
}
