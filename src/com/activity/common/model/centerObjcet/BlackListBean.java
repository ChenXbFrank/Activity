package com.activity.common.model.centerObjcet;

/** 
 * @author ChenXb
 *               扫码超过阀值的信息报表
 * 2018年6月4日
 */
public class BlackListBean {
	private String nickName;
	
	private String headImgUrl;
	
	private String activityName;
	
	private String activityType;
	
	private String prizeName;
	
	private String scanNum;
	
	private String openId;
	
	private String activityId;
	
	public String getOpenId() {
		return openId;
	}
	public void setOpenId(String openId) {
		this.openId = openId;
	}
	public String getActivityId() {
		return activityId;
	}
	public void setActivityId(String activityId) {
		this.activityId = activityId;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getHeadImgUrl() {
		return headImgUrl;
	}
	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getActivityType() {
		return activityType;
	}
	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}
	public String getPrizeName() {
		return prizeName;
	}
	public void setPrizeName(String prizeName) {
		this.prizeName = prizeName;
	}
	public String getScanNum() {
		return scanNum;
	}
	public void setScanNum(String scanNum) {
		this.scanNum = scanNum;
	}
	
}
