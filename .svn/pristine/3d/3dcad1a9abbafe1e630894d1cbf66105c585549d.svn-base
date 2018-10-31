package com.activity.common.model.turntable;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.system.SystemUser;
import com.activity.common.model.turntable.base.BaseTurnTable;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 转盘
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class TurnTable extends BaseTurnTable<TurnTable> {
	public static final TurnTable dao = new TurnTable();
	
	public TurnTable mapping(Record cord, TurnTable info) {
		info.setTurnTableId(cord.getStr("TURNTABLE_ID"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setBelongActivityId(cord.getStr("BELONG_ACTIVITY_ID"));
		info.setBackGroundImg(cord.getStr("BACKGROUND_IMG"));
		info.setMoblecBackGroundImg(cord.getStr("MOBLEC_BACKGROUND_IMG"));
		info.setAcitivityLaunchUserCode(cord.getStr("ACITIVITY_LAUNCH_USERCODE"));
		info.setAcitivityLaunchUserId(cord.getStr("ACITIVITY_LAUNCH_USERID"));
		info.setTurnTableNumber(cord.getStr("TURNTABLE_NUMBER"));
		info.setSpeed(cord.getStr("SPEED"));
		info.setJoinPropleNumber(cord.getStr("JOIN_PROPLE_NUMBER"));
		info.setWinningPropleNumber(cord.getStr("WINNING_PROPLE_NUMBER"));
		info.setState(cord.getStr("STATE"));
		info.setStartTime(cord.getStr("STARTTIME"));
		info.setEndTime(cord.getStr("ENDTIME"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setComfirmuserId(cord.getStr("COMFIRMUSERID"));
		info.setComfirmTime(cord.getStr("COMFIRMTIME"));
		info.setComfirmAdvise(cord.getStr("COMFIRMADVISE"));
		info.setComfirmuserName(cord.getStr("COMFIRMUSERNAME"));
		info.setApplyUserName(cord.getStr("APPLYUSERNAME"));
		info.setApplyPhone(cord.getStr("APPLYPHONE"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		info.setTotal(cord.getStr("TOTAL"));
		info.setScanTurnTableNumber(cord.getStr("SCAN_TURNTABLE_NUMBER"));
		info.setJoined(cord.getStr("JOINED"));
		info.setRuleImg(cord.getStr("RULE_IMG"));
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
		String sql=" from TB_TURNTABLE where 1=1 ";
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
		Page<TurnTable> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			TurnTable sb = page.getList().get(i);
			model.put("id", sb.getTurnTableId());
			model.put("activity_name", sb.getActivityName());
			model.put("applyusername", sb.getApplyUserName());
			model.put("applyphone", sb.getApplyPhone());
			model.put("create_time", sb.getCreateTime());
			model.put("starttime", sb.getStartTime());
			model.put("endtime", sb.getEndTime());
			model.put("comfirmusername", sb.getComfirmuserName());
			model.put("comfirmtime", sb.getComfirmTime());
			//扫码中奖次数
			model.put("scannumber", sb.getScanTurnTableNumber());
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
