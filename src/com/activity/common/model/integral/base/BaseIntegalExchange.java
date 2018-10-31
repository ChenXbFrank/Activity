package com.activity.common.model.integral.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 积分兑换记录
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class BaseIntegalExchange<M extends BaseIntegalExchange<M>> extends Model<M> implements IBean{
	/**
	 * 主键ID
	 * @param INTEGRAL_EXCHANGE_ID
	 */
	public void setIntegralExchangeId(java.lang.String INTEGRAL_EXCHANGE_ID) {
		set("INTEGRAL_EXCHANGE_ID", INTEGRAL_EXCHANGE_ID);
	}

	public java.lang.String getIntegralExchangeId() {
		return get("INTEGRAL_EXCHANGE_ID");
	}
	
	/**
	 * 积分活动ID
	 * @param INTEGRAL_ID
	 */
	public void setIntegralId(java.lang.String INTEGRAL_ID) {
		set("INTEGRAL_ID", INTEGRAL_ID);
	}

	public java.lang.String getIntegralId() {
		return get("INTEGRAL_ID");
	}
	
	/**
	 * 1=兑换参与记录   2=兑换产品
	 * @param INTEGRAL_ID
	 */
	public void setExchangeType(java.lang.String EXCHANGE_TYPE) {
		set("EXCHANGE_TYPE", EXCHANGE_TYPE);
	}

	public java.lang.String getExchangeType() {
		return get("EXCHANGE_TYPE");
	}
	
	/**
	 * 兑换产品或兑换参与活动的ID
	 * @param EXCHANGE_PRIZE_ID
	 */
	public void setExchangePrizeId(java.lang.String EXCHANGE_PRIZE_ID) {
		set("EXCHANGE_PRIZE_ID", EXCHANGE_PRIZE_ID);
	}

	public java.lang.String getExchangePrizeId() {
		return get("EXCHANGE_PRIZE_ID");
	}

	/**
	 * 兑换使用积分
	 * @param EXCHANGE_USE_INTEGRAL
	 */
	public void setExchangeUseIntegral(java.lang.String EXCHANGE_USE_INTEGRAL) {
		set("EXCHANGE_USE_INTEGRAL", EXCHANGE_USE_INTEGRAL);
	}

	public java.lang.String getExchangeUseIntegral() {
		return get("EXCHANGE_USE_INTEGRAL");
	}
	
	/**
	 * 兑换产品或兑换参与活动的名称
	 * @param EXCHANGE_PRIZE_NAME
	 */
	public void setExchangePrizeName(java.lang.String EXCHANGE_PRIZE_NAME) {
		set("EXCHANGE_PRIZE_NAME", EXCHANGE_PRIZE_NAME);
	}

	public java.lang.String getExchangePrizeName() {
		return get("EXCHANGE_PRIZE_NAME");
	}
	
	/**
	 * 兑换产品或兑换参与活动的图片
	 * @param EXCHANGE_PRIZE_IMG
	 */
	public void setExchangePrizeImg(java.lang.String EXCHANGE_PRIZE_IMG) {
		set("EXCHANGE_PRIZE_IMG", EXCHANGE_PRIZE_IMG);
	}

	public java.lang.String getExchangePrizeImg() {
		return get("EXCHANGE_PRIZE_IMG");
	}
	
	/**
	 * 兑换产品或兑换参与活动的数量
	 * @param EXCHANGE_PRIZE_NUMBER
	 */
	public void setExchangePrizeNumber(java.lang.String EXCHANGE_PRIZE_NUMBER) {
		set("EXCHANGE_PRIZE_NUMBER", EXCHANGE_PRIZE_NUMBER);
	}

	public java.lang.String getExchangePrizeNumber() {
		return get("EXCHANGE_PRIZE_NUMBER");
	}
	
	/**
	 * 十个活动ID
	 * @param TEN_ACTIVITY_ID
	 */
	public void setTenActivityId(java.lang.String TEN_ACTIVITY_ID) {
		set("TEN_ACTIVITY_ID", TEN_ACTIVITY_ID);
	}

	public java.lang.String getTenActivityId() {
		return get("TEN_ACTIVITY_ID");
	}
	
	/**
	 * 十个活动名称
	 * @param TEN_ACTIVITY_NAME
	 */
	public void setTenActivityName(java.lang.String TEN_ACTIVITY_NAME) {
		set("TEN_ACTIVITY_NAME", TEN_ACTIVITY_NAME);
	}

	public java.lang.String getTenActivityName() {
		return get("TEN_ACTIVITY_NAME");
	}
	
	/**
	 * 微信用户唯一ID
	 * @param OPENID
	 */
	public void setOpenId(java.lang.String OPENID) {
		set("OPENID", OPENID);
	}

	public java.lang.String getOpenId() {
		return get("OPENID");
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
	 * @param ADDRESSEE_PHONE
	 */
	public void setAddresseePhone(java.lang.String ADDRESSEE_PHONE) {
		set("ADDRESSEE_PHONE", ADDRESSEE_PHONE);
	}

	public java.lang.String getAddresseePhone() {
		return get("ADDRESSEE_PHONE");
	}
	
	/**
	 * 发货状态  1=兑换成功  2未填写地址 3地址已填写  4已发货  5未发货
	 * @param STATE
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
		return get("STATE");
	}
	
	/**
	 * 发货人名称
	 * @param LSSUE_USER_NAME
	 */
	public void setLssueUserName(java.lang.String LSSUE_USER_NAME) {
		set("LSSUE_USER_NAME", LSSUE_USER_NAME);
	}

	public java.lang.String getLssueUserName() {
		return get("LSSUE_USER_NAME");
	}
	
	/**
	 *发货人USERID
	 * @param LSSUE_USER_USERID
	 */
	public void setLssueUserUserId(java.lang.String LSSUE_USER_USERID) {
		set("LSSUE_USER_USERID", LSSUE_USER_USERID);
	}

	public java.lang.String getLssueUserUserId() {
		return get("LSSUE_USER_USERID");
	}
	
	/**
	 * 发货人USERCODE
	 * @param LSSUE_USER_USERCODE
	 */
	public void setLssueUserUsercode(java.lang.String LSSUE_USER_USERCODE) {
		set("LSSUE_USER_USERCODE", LSSUE_USER_USERCODE);
	}

	public java.lang.String getLssueUserUsercode() {
		return get("LSSUE_USER_USERCODE");
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
	 * 兑换参与活动时保存的QRCODE，查询兑换所中奖品
	 * @param QRCODE
	 */
	public void setQrCode(java.lang.String QRCODE) {
		set("QRCODE", QRCODE);
	}

	public java.lang.String getQrCode() {
		return get("QRCODE");
	}
	
	/**
	 * 昵称
	 * @param NICKNAME
	 */
	public void setNickName(java.lang.String NICKNAME) {
		set("NICKNAME", NICKNAME);
	}

	public java.lang.String getNickName() {
		return get("NICKNAME");
	}
	
	/**
	 * 头像
	 * @param HEADIMGURL
	 */
	public void setHeadimgUrl(java.lang.String HEADIMGURL) {
		set("HEADIMGURL", HEADIMGURL);
	}

	public java.lang.String getHeadimgUrl() {
		return get("HEADIMGURL");
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
	 * 实物中奖记录ID
	 * @param PRODUCT_WINNING_INFO_ID
	 */
	public void setProductWinningInfoId(java.lang.String PRODUCT_WINNING_INFO_ID) {
		set("PRODUCT_WINNING_INFO_ID", PRODUCT_WINNING_INFO_ID);
	}

	public java.lang.String getProductWinningInfoId() {
		return get("PRODUCT_WINNING_INFO_ID");
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
	
	public void setSpareOne(java.lang.String SPAREONE) {
		set("SPAREONE", SPAREONE);
	}

	public java.lang.String getSpareOne() {
		return get("SPAREONE");
	}
	public void setSpareTwo(java.lang.String SPARETWO) {
		set("SPARETWO", SPARETWO);
	}

	public java.lang.String getSpareTwo() {
		return get("SPARETWO");
	}
}
