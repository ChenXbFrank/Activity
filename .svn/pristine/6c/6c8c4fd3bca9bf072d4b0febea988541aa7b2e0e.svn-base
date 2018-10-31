package com.activity.common.model.groupPurchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.groupPurchase.base.BaseGroupPurchaseGroupWxUser;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 拼团活动
 * @author ChenXb
 *
 * 2017年12月6日
 */
@SuppressWarnings("serial")
public class GroupPurchaseGroupWxUser extends BaseGroupPurchaseGroupWxUser<GroupPurchaseGroupWxUser> {
	public static final GroupPurchaseGroupWxUser dao = new GroupPurchaseGroupWxUser();
	
//  cord.getStr("STATE")
	public GroupPurchaseGroupWxUser mapping(Record cord, GroupPurchaseGroupWxUser info) {
		info.setId(cord.getStr("ID"));
		info.setGroupPurchaseWxUserId(cord.getStr("GROUP_PURCHASE_WXUSER_ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setBelongPublicnumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setState(cord.getStr("STATE"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setCreater(cord.getStr("CREATER"));
		info.setPayState(cord.getStr("PAYSTATE"));
		info.setPayMoney(cord.getStr("PAYMONEY"));
		info.setPayOutNo(cord.getStr("PAYOUTNO"));
		info.setMchId(cord.getStr("MCHID"));
		info.setHandle(cord.getStr("HANDLE"));
		info.setFulled(cord.getStr("FULLED"));
		info.setGoodState(cord.getStr("GOODSTATE"));
		return info;
	}
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_GROUP_PURCHASE_GROUP_WXUSER where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName) &&activityName!=null) {
			sql += " and ACTIVITYNAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) &&state!=null) {
			sql += " and state = " + " '" + state + "' ";
		}
		if (!"".equals(startTime)&&startTime!=null && !"".equals(endTime)&&endTime!=null) {
			sql += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		Page<GroupPurchaseGroupWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			GroupPurchaseGroupWxUser sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			model.put("create_time", sb.getCreateTime());
			model.put("create_time", sb.getCreateTime());
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
