package com.activity.common.model.puzzle.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * 拼图
 * @author ChenXb
 *
 * 2017年11月29日
 */
@SuppressWarnings("serial")
public class BasePuzzle<M extends BasePuzzle<M>> extends Model<M> implements IBean {
	public void setId(java.lang.String ID) {
		set("ID", ID);
	}

	public java.lang.String getId() {
		return get("ID");
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
	 * 背景图
	 */
	public void setBackgroundImg(java.lang.String BACKGROUND_IMG) {
		set("BACKGROUND_IMG", BACKGROUND_IMG);
	}

	public java.lang.String getBackgroundImg() {
		return get("BACKGROUND_IMG");
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
	 * 手机页面背景图
	 */
	public void setMobleBackgroundImg(java.lang.String MOBLE_BACKGROUND_IMG) {
		set("MOBLE_BACKGROUND_IMG", MOBLE_BACKGROUND_IMG);
	}

	public java.lang.String getMobleBackgroundImg() {
		return get("MOBLE_BACKGROUND_IMG");
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
	 * 参与人数
	 */
	public void setJoinPropleNumber(java.lang.String JOIN_PROPLE_NUMBER) {
		set("JOIN_PROPLE_NUMBER", JOIN_PROPLE_NUMBER);
	}

	public java.lang.String getJoinPropleNumber() {
		return get("JOIN_PROPLE_NUMBER");
	}

	/**
	 * 获奖人数
	 */
	public void setWinningPropleNumber(java.lang.String WINNING_PROPLE_NUMBER) {
		set("WINNING_PROPLE_NUMBER", WINNING_PROPLE_NUMBER);
	}

	public java.lang.String getWinningPropleNumber() {
		return get("WINNING_PROPLE_NUMBER");
	}

	/**
	 * 活动状态：0申请中 1审批通过 2 已驳回
	 */
	public void setState(java.lang.String STATE) {
		set("STATE", STATE);
	}

	public java.lang.String getState() {
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
	 * 备用字段一
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
	 * 奖品总数
	 */
	public void setTotal(java.lang.String TOTAL) {
		set("TOTAL", TOTAL);
	}

	public java.lang.String getTotal() {
		return get("TOTAL");
	}
	
	/**
	 * 拼图用时
	 */
	public void setPalyTime(java.lang.String PALYTIME) {
		set("PALYTIME", PALYTIME);
	}

	public java.lang.String getPalyTime() {
		return get("PALYTIME");
	}
	
	/**
	 * 看图时间
	 */
	public void setLookTime(java.lang.String LOOKTIME) {
		set("LOOKTIME", LOOKTIME);
	}

	public java.lang.String getLookTime() {
		return get("LOOKTIME");
	}
	
	/**
	 * 拼图图片
	 */
	public void setPuzzleImg(java.lang.String PUZZLEIMG) {
		set("PUZZLEIMG", PUZZLEIMG);
	}

	public java.lang.String getPuzzleImg() {
		return get("PUZZLEIMG");
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
}
