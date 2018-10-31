package com.activity.common.model.shareBargain.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 分享砍价活动表
 * 
 * @author 小石潭记丶
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class BaseShareBargain<M extends BaseShareBargain<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
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
	 * 所属活动ID
	 */
	public void setBelongActivityId(java.lang.String BELONG_ACTIVITY_ID) {
		set("BELONG_ACTIVITY_ID", BELONG_ACTIVITY_ID);
	}

	public java.lang.String getBelongActivityId() {
		return get("BELONG_ACTIVITY_ID");
	}

	/**
	 * 背景图
	 */
	public void setBackGroundImg(java.lang.String BACKGROUND_IMG) {
		set("BACKGROUND_IMG", BACKGROUND_IMG);
	}

	public java.lang.String getBackGroundImg() {
		return get("BACKGROUND_IMG");
	}

	/**
	 * 手机页面背景图
	 */
	public void setMoblecBackGroundImg(java.lang.String MOBLEC_BACKGROUND_IMG) {
		set("MOBLEC_BACKGROUND_IMG", MOBLEC_BACKGROUND_IMG);
	}

	public java.lang.String getMoblecBackGroundImg() {
		return get("MOBLEC_BACKGROUND_IMG");
	}

	/**
	 * 活动发起人的USERCODE
	 */
	public void setAcitivityLaunchUserCode(java.lang.String ACITIVITY_LAUNCH_USERCODE) {
		set("ACITIVITY_LAUNCH_USERCODE", ACITIVITY_LAUNCH_USERCODE);
	}

	public java.lang.String getAcitivityLaunchUserCode() {
		return get("ACITIVITY_LAUNCH_USERCODE");
	}

	/**
	 * 活动发起人的USERID
	 */
	public void setAcitivityLaunchUserId(java.lang.Number ACITIVITY_LAUNCH_USERID) {
		set("ACITIVITY_LAUNCH_USERID", ACITIVITY_LAUNCH_USERID);
	}

	public java.lang.Number getAcitivityLaunchUserId() {
		return get("ACITIVITY_LAUNCH_USERID");
	}

	/**
	 * 介绍
	 */
	public void setIntroduce(java.lang.String INTRODUCE) {
		set("INTRODUCE", INTRODUCE);
	}

	public java.lang.String getIntroduce() {
		return get("INTRODUCE");
	}

	/**
	 * 参与人数
	 */
	public void setJoinPropleNumber(java.lang.Number JOIN_PROPLE_NUMBER) {
		set("JOIN_PROPLE_NUMBER", JOIN_PROPLE_NUMBER);
	}

	public java.lang.Number getJoinPropleNumber() {
		return get("JOIN_PROPLE_NUMBER");
	}

	/**
	 * 获奖人数
	 */
	public void setWinningPropleNumber(java.lang.Number WINNING_PROPLE_NUMBER) {
		set("WINNING_PROPLE_NUMBER", WINNING_PROPLE_NUMBER);
	}

	public java.lang.Number getWinningPropleNumber() {
		return get("WINNING_PROPLE_NUMBER");
	}

	/**
	 * 活动状态：0申请中 1审批通过 2 已驳回
	 */
	public void setState(java.lang.Number STATE) {
		set("STATE", STATE);
	}

	public java.lang.Number getState() {
		return get("STATE");
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
	 * 活动创建时间
	 */
	public void setCreateTime(java.lang.String CREATE_TIME) {
		set("CREATE_TIME", CREATE_TIME);
	}

	public java.lang.String getCreateTime() {
		return get("CREATE_TIME");
	}

	/**
	 * 备用字段一    用于导出时的状态显示
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
	 * 审核人的Id
	 */
	public void setComfirmuserId(java.lang.String COMFIRMUSERID) {
		set("COMFIRMUSERID", COMFIRMUSERID);
	}

	public java.lang.String getComfirmuserId() {
		return get("COMFIRMUSERID");
	}

	/**
	 * 审核人的名称
	 */
	public void setComfirmuserName(java.lang.String COMFIRMUSERNAME) {
		set("COMFIRMUSERNAME", COMFIRMUSERNAME);
	}

	public java.lang.String getComfirmuserName() {
		return get("COMFIRMUSERNAME");
	}

	/**
	 * 审核时间
	 */
	public void setComfirmTime(java.lang.String COMFIRMTIME) {
		set("COMFIRMTIME", COMFIRMTIME);
	}

	public java.lang.String getComfirmTime() {
		return get("COMFIRMTIME");
	}

	/**
	 * 审核建议
	 */
	public void setComfirmAdvise(java.lang.String COMFIRMADVISE) {
		set("COMFIRMADVISE", COMFIRMADVISE);
	}

	public java.lang.String getComfirmAdvise() {
		return get("COMFIRMADVISE");
	}

	/**
	 * 申请人名称
	 */
	public void setApplyUserName(java.lang.String APPLYUSERNAME) {
		set("APPLYUSERNAME", APPLYUSERNAME);
	}

	public java.lang.String getApplyUserName() {
		return get("APPLYUSERNAME");
	}

	/**
	 * 申请人ID
	 */
	public void setApplyUserId(java.lang.String APPLYUSERID) {
		set("APPLYUSERID", APPLYUSERID);
	}

	public java.lang.String getApplyUserId() {
		return get("APPLYUSERID");
	}

	/**
	 * 申请人电话
	 */
	public void setApplyPhone(java.lang.String APPLYPHONE) {
		set("APPLYPHONE", APPLYPHONE);
	}

	public java.lang.String getApplyPhone() {
		return get("APPLYPHONE");
	}

	/**
	 * 分享的标题
	 */
	public void setShareTitle(java.lang.String SHARETITLE) {
		set("SHARETITLE", SHARETITLE);
	}

	public java.lang.String getShareTitle() {
		return get("SHARETITLE");
	}

	/**
	 * 分享描述
	 */
	public void setShareDetail(java.lang.String SHAREDETAIL) {
		set("SHAREDETAIL", SHAREDETAIL);
	}

	public java.lang.String getShareDetail() {
		return get("SHAREDETAIL");
	}

	/**
	 * 分享时的图片
	 */
	public void setShareImg(java.lang.String SHAREIMG) {
		set("SHAREIMG", SHAREIMG);
	}

	public java.lang.String getShareImg() {
		return get("SHAREIMG");
	}
	
	/**
	 * 参加  0未参加1已参加
	 */
	public void setJoined(java.lang.String JOINED) {
		set("JOINED", JOINED);
	}

	public java.lang.String getJoined() {
		return get("JOINED");
	}
	
	/**
	 *  loginImg
	 */
	public void setLoginImg(java.lang.String LOGINIMG) {
		set("LOGINIMG", LOGINIMG);
	}

	public java.lang.String getLoginImg() {
		return get("LOGINIMG");
	}
	
	/**
	 * ruleImg
	 */
	public void setRuleImg(java.lang.String RULEIMG) {
		set("RULEIMG", RULEIMG);
	}

	public java.lang.String getRuleImg() {
		return get("RULEIMG");
	}
}
