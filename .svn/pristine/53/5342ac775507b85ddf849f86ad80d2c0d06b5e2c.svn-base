package com.activity.common.model.accumulate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.activity.common.model.accumulate.base.BaseAccumulateCommentWxUser;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

/**
 * 集赞活动
 * @author ChenXb
 *
 * 2017年11月6日
 */
@SuppressWarnings("serial")
public class AccumulateCommentWxUser extends BaseAccumulateCommentWxUser<AccumulateCommentWxUser> {
	public static final AccumulateCommentWxUser dao = new AccumulateCommentWxUser();
	
	
//  cord.getStr("STATE")
	public AccumulateCommentWxUser mapping(Record cord, AccumulateCommentWxUser info) {
		info.setId(cord.getStr("ID"));
		info.setAccumulateId(cord.getStr("ACCUMULATE_ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setBelongPublicNumberId(cord.getStr("BELONG_PUBLICNUMBER_ID"));
		info.setCreateTime(cord.getStr("CREATE_TIME"));
		info.setComments(cord.getStr("COMMENTS"));
		info.setHelpNumber(cord.getNumber("HELP_NUMBER"));
		info.setState(cord.getStr("STATE"));
		info.setScanCode(cord.getStr("SCAN_CODE"));
		info.setActivityName(cord.getStr("ACTIVITY_NAME"));
		info.setAccumulatePrzieId(cord.getStr("ACCUMULATE_PRZIE_ID"));
		info.setCommentImg(cord.getStr("COMMENTIMG"));
		info.setWinState(cord.getStr("WINSTATE"));
		info.setNoticed(cord.getStr("NOTICED"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		return info;
	}
	
	
	/**
	 * 实现分页查询 这个方法要写在这个model里面的
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate1(int pageNumber, int pageSize,String nickName,String accumulateId) {
		List<Object> results = new ArrayList<Object>();
		String sql=" from TB_ACCUMULATE_COMMENT_WXUSER where 1=1 ";
		// 这里是模糊查询名字
		if (!StringUtils.isEmpty(nickName)) {
			sql += " and NICKNAME like '%" + nickName + "%'";
		}
		if (!StringUtils.isEmpty(accumulateId)) {
			sql += " and ACCUMULATE_ID = " + " '" + accumulateId + "' ";
		}
		Page<AccumulateCommentWxUser> page = paginate(pageNumber, pageSize, "select *", sql+" order by HELP_NUMBER desc");
		for (int i = 0; i < page.getList().size(); i++) {
			Map<String, Object> model = new HashMap<String, Object>();
			AccumulateCommentWxUser sb = page.getList().get(i);
			model.put("id", sb.getId());
			model.put("activity_name", sb.getActivityName());
			model.put("nickName", sb.getNickName());
			model.put("headimgurl", sb.getHeadImgUrl());
			model.put("create_time", sb.getCreateTime());
			model.put("helpNum", sb.getHelpNumber());
			model.put("winState", sb.getWinState());
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
