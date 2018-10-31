package com.activity.common.model.oneMoneyShop.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 拼团中奖用户
 * @author ChenXb
 *
 * 2017年12月7日
 */
@SuppressWarnings("serial")
public class BaseOneMoneyWxUserWinning<M extends BaseOneMoneyWxUserWinning<M>> extends Model<M> implements IBean{

	public java.lang.String getId() {
		return get("ID");
	}
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	/**
	 * 参与记录ID
	 * @return
	 */
	public java.lang.String getOneMoneyWxUserId() {
		return get("ONEMONEY_WXUSER_ID");
	}
	public void setOneMoneyWxUserId(java.lang.String ONEMONEY_WXUSER_ID) {
		set("ONEMONEY_WXUSER_ID", ONEMONEY_WXUSER_ID);
	}

	/**
	 * 奖品类型
	 * @return
	 */
	public java.lang.String getPrizeType() {
		return get("PRIZE_TYPE");
	}
	public void setPrizeType(java.lang.String PRIZE_TYPE) {
		set("PRIZE_TYPE", PRIZE_TYPE);
	}

	/**
	 * 所属中奖ID
	 * @return
	 */
	public java.lang.String getBelongWinningPrizeId() {
		return get("BELONG_WINNING_PRIZE_ID");
	}
	public void setBelongWinningPrizeId(java.lang.String BELONG_WINNING_PRIZE_ID) {
		set("BELONG_WINNING_PRIZE_ID", BELONG_WINNING_PRIZE_ID);
	}

	/**
	 * 奖品名称
	 * @return
	 */
	public java.lang.String getPrizeProject() {
		return get("PRIZE_PROJECT");
	}
	public void setPrizeProject(java.lang.String PRIZE_PROJECT) {
		set("PRIZE_PROJECT", PRIZE_PROJECT);
	}
	
	/**
	 * 奖品图片
	 * @return
	 */
	public java.lang.String getPrizeProjectImg() {
		return get("PRIZE_PROJECT_IMG");
	}
	public void setPrizeProjectImg(java.lang.String PRIZE_PROJECT_IMG) {
		set("PRIZE_PROJECT_IMG", PRIZE_PROJECT_IMG);
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
	 * 实物中奖记录ID
	 * @param DELIVER_TIME
	 */
	public void setProductWinningInfoId(java.lang.String PRODUCT_WINNING_INFO_ID) {
		set("PRODUCT_WINNING_INFO_ID", PRODUCT_WINNING_INFO_ID);
	}

	public java.lang.String getProductWinningInfoId() {
		return get("PRODUCT_WINNING_INFO_ID");
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
