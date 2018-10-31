package com.activity.common.model.shareBargain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.shareBargain.base.BaseShareBargain;
import com.activity.common.model.system.SystemUser;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 分享砍价奖品配置表
 * 
 * @author 小石潭记丶
 *
 *         2017年8月9日
 */
@SuppressWarnings("serial")
public class ShareBargain extends BaseShareBargain<ShareBargain> {
	public static final ShareBargain dao = new ShareBargain();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param user
	 * @return
	 */
	public ShareBargain mapping(Record cord, ShareBargain info) {
		info.setId(cord.getStr("ID"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setBelongActivityId(cord.getStr("BELONG_ACTIVITY_ID"));
		info.setBackGroundImg(cord.getStr("BACKGROUND_IMG"));
		info.setMoblecBackGroundImg(cord.getStr("MOBLEC_BACKGROUND_IMG"));
		info.setAcitivityLaunchUserCode(cord.getStr("ACITIVITY_LAUNCH_USERCODE"));
		info.setAcitivityLaunchUserId(cord.getNumber("ACITIVITY_LAUNCH_USERID"));
		info.setIntroduce(cord.getStr("INTRODUCE"));
		info.setJoinPropleNumber(cord.getNumber("JOIN_PROPLE_NUMBER"));
		info.setWinningPropleNumber(cord.getNumber("WINNING_PROPLE_NUMBER"));
		info.setState(cord.getNumber("STATE"));
		info.setStartTime(cord.getStr("STARTTIME"));
		info.setEndTime(cord.getStr("ENDTIME"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		info.setComfirmAdvise(cord.getStr("COMFIRMADVISE"));
		info.setComfirmTime(cord.getStr("COMFIRMTIME"));
		info.setComfirmuserName(cord.getStr("COMFIRMUSERNAME"));
		info.setApplyPhone(cord.getStr("APPLYPHONE"));
		info.setApplyUserName(cord.getStr("APPLYUSERNAME"));
		info.setApplyUserId(cord.getStr("APPLYUSERID"));
		info.setShareTitle(cord.getStr("SHARETITLE"));
		info.setShareDetail(cord.getStr("SHAREDETAIL"));
		info.setShareImg(cord.getStr("SHAREIMG"));
		return info;
	}
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_SHARE_BARGAIN where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		if (!"".equals(startTime)&&startTime!=null && !"".equals(endTime)&&endTime!=null) {
			sql += " and create_time >= '"+startTime+"' and create_time <= '"+endTime+"' ";
		}
		//= -1就是admin账号  否则就是普通经销商
		if(user.getUserId().intValue()!=-1){
			sql += " and ACITIVITY_LAUNCH_USERCODE = " + " '" + user.getUserCode() + "' ";
		}
		Page<ShareBargain> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			ShareBargain sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			model.put("applyusername", sb.getApplyUserName());
			model.put("applyphone", sb.getApplyPhone());
			model.put("create_time", sb.getCreateTime());
			model.put("comfirmtime", sb.getComfirmTime());
			model.put("starttime", sb.getStartTime());
			model.put("endtime", sb.getEndTime());
			model.put("comfirmusername", sb.getComfirmuserName());
			model.put("state", sb.getState());
			results.add(model);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", results);
		map.put("currentPage", page.getPageNumber());
		map.put("totalPages", page.getTotalPage());
		return map;
	}
}
