package com.activity.common.model.activity.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 实物产品中奖记录
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class BaseProductWinningInfo<M extends BaseProductWinningInfo<M>> extends Model<M> implements IBean{
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}

	/**
	 * 所属活动ID
	 * @param ID
	 */
	public void setBelongActivityId(java.lang.String BELONG_ACTIVITY_ID) {
		set("BELONG_ACTIVITY_ID", BELONG_ACTIVITY_ID);
	}

	public java.lang.String getBelongActivityId() {
		return get("BELONG_ACTIVITY_ID");
	}
	
	/**
	 * 活动名称
	 * @param ACTIVITY_NAME
	 */
	public void setActivityName(java.lang.String ACTIVITY_NAME) {
		set("ACTIVITY_NAME", ACTIVITY_NAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITY_NAME");
	}
	
	/**
	 * 活动类型（疯狂砍价，抢红包...）
	 * @param ACTIVITY_NAME_TYPE
	 */
	public void setActivityNameType(java.lang.String ACTIVITY_NAME_TYPE) {
		set("ACTIVITY_NAME_TYPE", ACTIVITY_NAME_TYPE);
	}

	public java.lang.String getActivityNameType() {
		return get("ACTIVITY_NAME_TYPE");
	}
	
	/**
	 * 实物产品ID
	 */
	public void setProductId(java.lang.String PRODUCT_ID) {
		set("PRODUCT_ID", PRODUCT_ID);
	}

	public java.lang.String getProductId() {
		return get("PRODUCT_ID");
	}
	
	/**
	 * 实物产品名称
	 */
	public void setProductName(java.lang.String PRODUCT_NAME) {
		set("PRODUCT_NAME", PRODUCT_NAME);
	}

	public java.lang.String getProductName() {
		return get("PRODUCT_NAME");
	}
	
	/**
	 * 实物产品图片
	 */
	public void setProductImg(java.lang.String PRODUCT_IMG) {
		set("PRODUCT_IMG", PRODUCT_IMG);
	}

	public java.lang.String getProductImg() {
		return get("PRODUCT_IMG");
	}
	
	/**
	 * 活动奖品配置ID
	 */
	public void setActivityPrizeId(java.lang.String ACTIVITY_PRIZE_ID) {
		set("ACTIVITY_PRIZE_ID", ACTIVITY_PRIZE_ID);
	}

	public java.lang.String getActivityPrizeId() {
		return get("ACTIVITY_PRIZE_ID");
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
	 * 开始时间
	 * @param CREATE_TIME
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
	 * 微信唯一ID
	 * 
	 * @param OPENID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
	}  
	
	/**
	 * 活动微信参与记录ID
	 */
	public void setActivityWxUserId(java.lang.String ACTIVITY_WXUSER_ID) {
		set("ACTIVITY_WXUSER_ID", ACTIVITY_WXUSER_ID);
	}

	public java.lang.String getActivityWxUserId() {
		return get("ACTIVITY_WXUSER_ID");
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
	 * 状态 1=已经领取 2未填写地址 3地址已填写  4已发货  5未发货
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
		return get("STATE");
	}
	
	/**
	 * 中奖记录ID
	 */
	public void setWinningInfoId(java.lang.String WINNING_INFO_ID) {
		set("WINNING_INFO_ID", WINNING_INFO_ID);
	}

	public java.lang.String getWinningInfoId() {
		return get("WINNING_INFO_ID");
	}
	
	/**
	 * 快递单号
	 * @param DELIVER_NUMBER
	 */
	public void setDeliverNumber(java.lang.String DELIVER_NUMBER) {
		set("DELIVER_NUMBER", DELIVER_NUMBER);
	}

	public java.lang.String getDeliverNumber() {
		return get("DELIVER_NUMBER");
	}
	
	/**
	 * 快递公司
	 * @param DELIVER_COMPANY
	 */
	public void setDeliverCompany(java.lang.String DELIVER_COMPANY) {
		set("DELIVER_COMPANY", DELIVER_COMPANY);
	}

	public java.lang.String getDeliverCompany() {
		return get("DELIVER_COMPANY");
	}
	
	/**
	 * 发货时间
	 * @param DELIVER_TIME
	 */
	public void setDeliverTime(java.lang.String DELIVER_TIME) {
		set("DELIVER_TIME", DELIVER_TIME);
	}

	public java.lang.String getDeliverTime() {
		return get("DELIVER_TIME");
	}
	
	/**
	 * 收件人姓名
	 * @param ADDRESSEE_NAME
	 */
	public void setAddresseeName(java.lang.String ADDRESSEE_NAME) {
		set("ADDRESSEE_NAME", ADDRESSEE_NAME);
	}

	public java.lang.String getAddresseeName(){
		return get("ADDRESSEE_NAME");
	}
	
	/**
	 * 收件人地址
	 * @param ADDRESSEE_ADDRESS
	 */
	public void setAddresseeAddress(java.lang.String ADDRESSEE_ADDRESS) {
		set("ADDRESSEE_ADDRESS", ADDRESSEE_ADDRESS);
	}

	public java.lang.String getAddresseeAddress() {
		return get("ADDRESSEE_ADDRESS");
	}
	
	/**
	 * 收件人电话
	 * @param ADDRESSEE_ADDRESS
	 */
	public void setAddresseePhone(java.lang.String ADDRESSEE_PHONE) {
		set("ADDRESSEE_PHONE", ADDRESSEE_PHONE);
	}

	public java.lang.String getAddresseePhone() {
		return get("ADDRESSEE_PHONE");
	}
	
	/**
	 * 支付金额
	 * @param PAY_MONEY
	 */
	public void setPayMoney(java.lang.String PAY_MONEY) {
		set("PAY_MONEY", PAY_MONEY);
	}

	public java.lang.String getPayMoney() {
		return get("PAY_MONEY");
	}
	
	/**
	 * 原价
	 * 
	 * @param PRICE
	 */
	public void setPrice(java.lang.String PRICE) {
		set("PRICE", PRICE);
	}

	public java.lang.String getPrice() {
		return get("PRICE");
	}
	
	/**
	 * 最低价格
	 * 
	 * @param LOW_PRICE
	 */
	public void setLowPrice(java.lang.String LOW_PRICE) {
		set("LOW_PRICE", LOW_PRICE);
	}

	public java.lang.String getLowPrice() {
		return get("LOW_PRICE");
	}
}
