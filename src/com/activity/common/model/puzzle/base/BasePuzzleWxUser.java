package com.activity.common.model.puzzle.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 *  拼图活动微信用户
 * @author ChenXb
 *
 * 2017年12月15日
 */
@SuppressWarnings("serial")
public class BasePuzzleWxUser<M extends BasePuzzleWxUser<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 活动ID
	 */
	public void setPuzzleId(java.lang.String PUZZLE_ID) {
		set("PUZZLE_ID", PUZZLE_ID);
	}

	public java.lang.String getPuzzleId() {
		return get("PUZZLE_ID");
	}

	/**
	 * 微信指定ID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
	}

	/**
	 * 微信昵称
	 */
	public void setNickName(java.lang.String NICKNAME) {
		set("NICKNAME", NICKNAME);
	}

	public java.lang.String getNickName() {
		return get("NICKNAME");
	}

	/**
	 * 微信头像
	 */
	public void setHeadImgUrl(java.lang.String HEADIMGURL) {
		set("HEADIMGURL", HEADIMGURL);
	}

	public java.lang.String getHeadImgUrl() {
		return get("HEADIMGURL");
	}

	/**
	 * 所属公众号
	 */
	public void setBelongPublicNumberId(java.lang.String BELONG_PUBLICNUMBER_ID) {
		set("BELONG_PUBLICNUMBER_ID", BELONG_PUBLICNUMBER_ID);
	}

	public java.lang.String getBelongPublicNumberId() {
		return get("BELONG_PUBLICNUMBER_ID");
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
	
	/**
	 * 状态0未成功 1成功
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
		return get("STATE");
	}
	
	/**
	 * 扫码CODE
	 */
	public void setScanCode(java.lang.String SCAN_CODE) {
		set("SCAN_CODE", SCAN_CODE);
	}

	public java.lang.String getScanCode() {
		return get("SCAN_CODE");
	}

	/**
	 * 活动名称
	 */
	public void setActivityName(java.lang.String ACTIVITYNAME) {
		set("ACTIVITYNAME", ACTIVITYNAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITYNAME");
	}
	
	/**
	 * 发货状态 0 未发货  1已发货
	 */
	public void setGoodState(java.lang.String GOODSTATE) {
		set("GOODSTATE", GOODSTATE);
	}

	public java.lang.String getGoodState() {
		return get("GOODSTATE");
	}
	
}
