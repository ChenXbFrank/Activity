package com.activity.common.model.oneMoneyShop.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 一元购微信参与用户 参与拼团的用户
 * @author ChenXb
 *
 * 2017年12月7日
 */
@SuppressWarnings("serial")
public class BaseOneMoneyGroupWxUser <M extends BaseOneMoneyGroupWxUser<M>> extends Model<M> implements IBean{
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
	}
	
	/**
	 * 活动ID
	 * @return
	 */
	public void setOneMoneyWxUserId(java.lang.String ONEMONEY_WXUSER_ID) {
		set("ONEMONEY_WXUSER_ID", ONEMONEY_WXUSER_ID);
	}

	public java.lang.String getOneMoneyWxUserId() {
		return get("ONEMONEY_WXUSER_ID");
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
	 * 活动名称
	 */
	public void setActivityName(java.lang.String ACTIVITY_NAME) {
		set("ACTIVITY_NAME", ACTIVITY_NAME);
	}

	public java.lang.String getActivityName() {
		return get("ACTIVITY_NAME");
	}
	
	/**
	 * 创建者1 参与者0
	 */
	public void setCreater(java.lang.String CREATER) {
		set("CREATER", CREATER);
	}

	public java.lang.String getCreater() {
		return get("CREATER");
	}
	
	/**
	 * 支付状态 0未支付 1支付
	 */
	public void setPayState(java.lang.String PAYSTATE) {
		set("PAYSTATE", PAYSTATE);
	}

	public java.lang.String getPayState() {
		return get("PAYSTATE");
	}
	
	/**
	 * 支付金额一元购 默认一元
	 */
	public void setPayMoney(java.lang.String PAYMONEY) {
		set("PAYMONEY", PAYMONEY);
	}

	public java.lang.String getPayMoney() {
		return get("PAYMONEY");
	}
	
	/**
	 * 支付订单号
	 */
	public void setPayOutNo(java.lang.String PAYOUTNO) {
		set("PAYOUTNO", PAYOUTNO);
	}

	public java.lang.String getPayOutNo() {
		return get("PAYOUTNO");
	}
	
	/**
	 * 商户号
	 */
	public void setMchId(java.lang.String MCHID) {
		set("MCHID", MCHID);
	}

	public java.lang.String getMchId() {
		return get("MCHID");
	}
	
	/**
	 * 退款状态0没有退款 1已经退款
	 */
	public void setReturnState(java.lang.String RETURNSTATE) {
		set("RETURNSTATE", RETURNSTATE);
	}

	public java.lang.String getReturnState() {
		return get("RETURNSTATE");
	}
}
