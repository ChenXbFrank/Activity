package com.activity.common.model.groupPurchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.model.groupPurchase.base.BaseGroupPurchaseWxUser;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 拼团活动
 * @author ChenXb
 *
 * 2017年12月6日
 */
@SuppressWarnings("serial")
public class GroupPurchaseWxUser extends BaseGroupPurchaseWxUser<GroupPurchaseWxUser> {
	public static final GroupPurchaseWxUser dao = new GroupPurchaseWxUser();
	
//  cord.getStr("STATE")
	public GroupPurchaseWxUser mapping(Record cord, GroupPurchaseWxUser info) {
		info.setId(cord.getStr("ID"));
		info.setGroupPurchaseId(cord.getStr("GROUP_PURCHASE_ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setState(cord.getStr("STATE"));
		info.setScanCode(cord.getStr("SCAN_CODE"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
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
	public Map<String, Object> paginate1(int pageNumber, int pageSize,String activityId,String nickName) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_GROUP_PURCHASE_WXUSER where 1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityId) &&activityId!=null) {
			sql += " and GROUP_PURCHASE_ID like '%" + activityId + "%'";
		}
		if (!"".equals(nickName) &&nickName!=null) {
			sql += " and nickName like '%" + nickName + "%'";
		}
		Page<GroupPurchaseWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by CREATE_TIME desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			GroupPurchaseWxUser sb = page.getList().get(i);
			model.put("fulled", sb.getFulled());
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			model.put("nickName", sb.getNickName());
			model.put("headimgurl", sb.getHeadImgUrl());
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
