package com.activity.common.model.fireStorm.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 火爆小酒红包活动 
 * @author ChenXb
 *
 * 2018年7月3日      FIRE_STORM_RED_WXUSER
 */
@SuppressWarnings("serial")
public class BaseFireStormRedWxUser<M extends BaseFireStormRedWxUser<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}
	
	/**
	 * 红包活动ID
	 * @param RED_ID
	 */
	public void setRedId(java.lang.String RED_ID) {
		set("RED_ID", RED_ID);
	}

	public java.lang.String getRedId() {
		return get("RED_ID");
	}
	
	/**
	 * 微信指定ID
	 * @param OPENID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
	}
	
	/**
	 * 微信昵称
	 * @param NICKNAME
	 */
	public void setNickName(java.lang.String NICKNAME) {
		set("NICKNAME", NICKNAME);
	}

	public java.lang.String getNickName() {
		return get("NICKNAME");
	}
	
	/**
	 * 微信头像
	 * @param HEADIMGURL
	 */
	public void setHeadImgUrl(java.lang.String HEADIMGURL) {
		set("HEADIMGURL", HEADIMGURL);
	}

	public java.lang.String getHeadImgUrl() {
		return get("HEADIMGURL");
	}
	
	/**
	 * 所属公众号
	 * @param BELONG_PUBLICNUMBER_ID
	 */
	public void setBelongPublicNumberId(java.lang.String BELONG_PUBLICNUMBER_ID) {
		set("BELONG_PUBLICNUMBER_ID", BELONG_PUBLICNUMBER_ID);
	}

	public java.lang.String getBelongPublicNumberId() {
		return get("BELONG_PUBLICNUMBER_ID");
	}
	
	
	/**
	 * 创建时间
	 * @param CREATE_TIME
	 */
	public void setCreateTime(java.lang.String CREATE_TIME) {
		set("CREATE_TIME", CREATE_TIME);
	}

	public java.lang.String getCreateTime() {
		return get("CREATE_TIME");
	}
	
	/**
	 * 状态
	 * @param STATE
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
		return get("STATE");
	}
	
	/**
	 * 扫码CODE
	 * @param SCAN_CODE
	 */
	public void setScanCode(java.lang.String SCAN_CODE) {
		set("SCAN_CODE", SCAN_CODE);
	}

	public java.lang.String getScanCode() {
		return get("SCAN_CODE");
	}

	/**
	 * 扫码红包次数
	 */
	public void setScanRedNumber(java.lang.String SCAN_RED_NUMBER) {
		set("SCAN_RED_NUMBER", SCAN_RED_NUMBER);
	}

	public java.lang.String getScanRedNumber() {
		return get("SCAN_RED_NUMBER");
	}
	
	/**
	 * 总金额
	 */
	public void setTotalMoney(java.lang.String TOTAL_MONEY) {
		set("TOTAL_MONEY", TOTAL_MONEY);
	}

	public java.lang.String getTotalMoney() {
		return get("TOTAL_MONEY");
	}
	
	/**
	 * 活动名称
	 */
	public void setActivityName(java.lang.String ACTIVITY_NAME) {
		set("ACTIVITY_NAME", ACTIVITY_NAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITY_NAME");
	}
	
	/**
	 * 活动开始时间
	 */
	public void setStartTime(java.lang.String STARTTIME) {
		set("STARTTIME", STARTTIME);
	}

	public java.lang.String getStartTime() {
		return get("STARTTIME");
	}

	/**
	 * 活动结束时间
	 */
	public void setEndTime(java.lang.String ENDTIME) {
		set("ENDTIME", ENDTIME);
	}

	public java.lang.String getEndTime() {
		return get("ENDTIME");
	}
	
	/**
	 * 参与方式  1=扫码进入  2=积分兑换
	 */
	public void setJoinMode(java.lang.String JOINMODE){
		set("JOINMODE", JOINMODE);
	}

	public java.lang.String getJoinMode() {
		return get("JOINMODE");
	}
}
