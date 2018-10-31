package com.activity.common.model.centerObjcet;

/**
 * @author ChenXb
 *
 * 2018年3月15日
 */
public class ScanReportObj {
	//活动名称
	private String activityName;
	//所属的活动类型
	private String typeName;
	//参与时间
	private String createTime;
	//中奖名称
	private String prizeName;
	//中奖类型 奖品类型1=实物 2=积分  3=红包   4=谢谢惠顾
	private String winType;
	//中奖金额/积分
	private String winInfo;
	//中奖时间
	private String winTime;
	//收货人名字
	private String recvierName;
	//收货人电话
	private String recvierPhone;
	//收货人地址
	private String recvierAddress;
	//发货人 
	private String sender;
	//物流公司
	private String company;
	//订单号
	private String order;
	//状态
	private String state;
	
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getActivityName() {
		return activityName;
	}
	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getPrizeName() {
		return prizeName;
	}
	public void setPrizeName(String prizeName) {
		this.prizeName = prizeName;
	}
	public String getWinType() {
		return winType;
	}
	public void setWinType(String winType) {
		this.winType = winType;
	}
	public String getWinInfo() {
		return winInfo;
	}
	public void setWinInfo(String winInfo) {
		this.winInfo = winInfo;
	}
	public String getWinTime() {
		return winTime;
	}
	public void setWinTime(String winTime) {
		this.winTime = winTime;
	}
	public String getRecvierName() {
		return recvierName;
	}
	public void setRecvierName(String recvierName) {
		this.recvierName = recvierName;
	}
	public String getRecvierPhone() {
		return recvierPhone;
	}
	public void setRecvierPhone(String recvierPhone) {
		this.recvierPhone = recvierPhone;
	}
	public String getRecvierAddress() {
		return recvierAddress;
	}
	public void setRecvierAddress(String recvierAddress) {
		this.recvierAddress = recvierAddress;
	}
	
}
