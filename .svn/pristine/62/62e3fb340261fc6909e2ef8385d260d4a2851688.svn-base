package com.activity.common.model.groupPurchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.groupPurchase.base.BaseGroupPurchase;
import com.activity.common.model.system.SystemUser;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 拼团活动
 * @author ChenXb
 *
 * 2017年12月6日
 */
@SuppressWarnings("serial")
public class GroupPurchase extends BaseGroupPurchase<GroupPurchase> {
	public static final GroupPurchase dao = new GroupPurchase();
	
//  cord.getStr("STATE")
	public GroupPurchase mapping(Record cord, GroupPurchase info) {
		info.setId(cord.getStr("ID"));
		info.setActivityName(cord.getStr("ACTIVITYNAME"));
		info.setBackgroundImg(cord.getStr("BACKGROUND_IMG"));
		info.setBelongActivityId(cord.getStr("BELONG_ACTIVITY_ID"));
		info.setMobleBackgroundImg(cord.getStr("MOBLE_BACKGROUND_IMG"));
		info.setAcitivityLaunchUserId(cord.getStr("ACITIVITY_LAUNCH_USERID"));
		info.setAcitivityLaunchUserCode(cord.getStr("ACITIVITY_LAUNCH_USERCODE"));
		info.setJoinPropleNumber(cord.getStr("JOIN_PROPLE_NUMBER"));
		info.setWinningPropleNumber(cord.getStr("WINNING_PROPLE_NUMBER"));
		info.setState(cord.getStr("STATE"));
		info.setStartTime(cord.getStr("STARTTIME"));
		info.setEndTime(cord.getStr("ENDTIME"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		info.setComfirmuserId(cord.getStr("COMFIRMUSERID"));
		info.setComfirmuserName(cord.getStr("COMFIRMUSERNAME"));
		info.setComfirmTime(cord.getStr("COMFIRMTIME"));
		info.setComfirmAdvise(cord.getStr("COMFIRMADVISE"));
		info.setApplyUserName(cord.getStr("APPLYUSERNAME"));
		info.setApplyUserId(cord.getStr("APPLYUSERID"));
		info.setApplyPhone(cord.getStr("APPLYPHONE"));
		info.setOpenPrizeNumber(cord.getStr("OPENPRIZENUMBER"));
		info.setTotal(cord.getStr("TOTAL"));
		info.setGroupPrice(cord.getStr("GROUPPRICE"));
		info.setOutTotal(cord.getStr("OUTTOTAL"));
		info.setHandle(cord.getStr("HANDLE"));
		info.setJoined(cord.getStr("JOINED"));
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
		String sql=" from TB_GROUP_PURCHASE where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
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
		Page<GroupPurchase> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			GroupPurchase sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			model.put("applyusername", sb.getApplyUserName());
			model.put("applyphone", sb.getApplyPhone());
			model.put("create_time", sb.getCreateTime());
			model.put("create_time", sb.getCreateTime());
			model.put("starttime", sb.getStartTime());
			model.put("endtime", sb.getEndTime());
			model.put("comfirmtime", sb.getComfirmTime());
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
