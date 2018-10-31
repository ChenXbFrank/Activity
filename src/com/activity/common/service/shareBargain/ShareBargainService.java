package com.activity.common.service.shareBargain;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.shareBargain.ShareBargain;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;

/**
 * 分享砍价活动服务层
 * 
 * @author 唐 2017-8-15
 */
public class ShareBargainService {

	private static ShareBargainService shareBargainService = new ShareBargainService();

	private ShareBargainService() {
	}

	public static ShareBargainService getService() {
		return shareBargainService;
	}

	/**
	 * 根据运单查询出当前运单的所有已经审批通过活动
	 * 
	 * @param RecordId
	 * @return
	 */
	public List<ShareBargain> getShareBargainByRecordId(String RecordId) {
		String sql = PropKit.use("database.properties").get("getShareBargainByRecordId");
		List<ShareBargain> sb = ShareBargain.dao.find(sql, RecordId);
		return sb;
	}

	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param ShareBargainActivityID
	 * @return
	 */
	public String ShareBargainActivity(String ShareBargainActivityID, String qrcode) {
		ShareBargain sb = ShareBargain.dao.findById(ShareBargainActivityID);
		DateUitils.getUitils();
		// 判断是否属于活动时间内
		Date startDate = DateUitils.strToDateYMD(sb.getStartTime());
		Date endDate = DateUitils.strToDateYMD(sb.getEndTime());
		// 判断当前时间是否大于活动开始时间 返回fasle表示小于当前时间，代表活动已经开始
		boolean startTime = DateUitils.isDateBefore(startDate);
		// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
		boolean endTime = DateUitils.isDateBefore(endDate);
		String redirect = "";
		// 判断活动是否审批通过
		if (sb.getState().toString().equals("1")) {
			if (startTime) {
				// 活动未开始
				System.out.println("活动未开始");
			} else {
				// 活动已经开始
				System.out.println("活动已经开始");
				if (endTime) {
					System.out.println("活动活动未结束  ");
					// 活动未结束
					/**
					 * 1.进入这里代表当前人可参加当前活动 2.获取活动发起者经销商公众号配置
					 */
					// 活动发起人的userCode
					String userCode = sb.getAcitivityLaunchUserCode();
					// 活动发起人的公众号信息
					List<SellerPublicNumber> sellerPublicNumberList = SellerPublicNumberService.getService()
							.getPublicNumberByUsercode(userCode);
					SellerPublicNumber spn = new SellerPublicNumber();
					for (SellerPublicNumber spnErgodic : sellerPublicNumberList) {
						spn = spnErgodic;
					}
					System.out.println("重定项");
					// 重定向
					redirect = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
							+ "&redirect_uri=http%3a%2f%2f"+ PropKit.use("system.properties").get("http")
							+ JFinal.me().getContextPath() + "%2fShareBargain%2fshareBargainIndex%3fActivity%3d"
							+ sb.getId() + "%26qrcode%3d" + qrcode + "%26spn%3d" + spn.getId() 
							+ "&response_type=code&scope=snsapi_userinfo&state=wx"
							+ "&connect_redirect=1#wechat_redirect";
				} else {
					// 活动已经结束
				}
			}
		} else {
			// 活动未审批通过
		}
		return redirect;
	}

	/**
	 * 根据活动ID查询分享砍价的具体的活动信息
	 */
	public ShareBargain getShareBargainByActivityId(String activityId) {
		return ShareBargain.dao.findById(activityId);
	}

	/**
	 * 根据userCode查询分享砍价的活动记录
	 */
	public List<ShareBargain> getShareBargainByUserCode(String userCode) {
		String sql = PropKit.use("database.properties").get("getShareBargainByUserCode");
		return ShareBargain.dao.find(sql, userCode);
	}

	/**
	 * 根据userCode查询分享砍价的活动记录
	 */
	public List<ShareBargain> getShareBargainByUserCodeAndState(String userCode) {
		String sql = PropKit.use("database.properties").get("getShareBargainByUserCodeAndState");
		return ShareBargain.dao.find(sql, userCode);
	}
	
	/**
	 * 活动审批页面的查询 活动名称 状态
	 */
	public List<ShareBargain> searchApproveActivtyByCondition(String activityName, String state) {
		String neirong = "1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName)) {
			neirong += "and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state)) {
			neirong += " and STATE = " + state;
		}
		// 我记得下次模糊的时候 不用插入 用 拼接 是这样的
		String sql = "select * from TB_SHARE_BARGAIN where " + neirong;
		return ShareBargain.dao.find(sql);
	}

	/**
	 * 活动审批页面的查询 活动名称 状态 用户id
	 */
	public List<ShareBargain> searchApproveActivtyByCondition(String activityName, String state, String userCode) {
		String neirong = "1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName)) {
			neirong += "and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state)) {
			neirong += " and STATE = " + state;
		}
		if (!"".equals(userCode)) {
			neirong += " and APPLYUSERID = '" + userCode+"'";
		}
		// 我记得下次模糊的时候 不用插入 用 拼接 是这样的
		String sql = "select * from TB_SHARE_BARGAIN where " + neirong;
		return ShareBargain.dao.find(sql);
	}

	/**
	 * 活动审批页面的查询 活动名称 状态
	 */
	public List<ShareBargain> searchShareActivtyByCondition(String activityName, String state, String userCode,
			String startTime, String endTime) {
		String neirong = "1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(activityName)) {
			neirong += "and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state)) {
			neirong += " and STATE = " + state;
		}
		if (!"".equals(userCode)) {
			neirong += " and APPLYUSERID = " + userCode;
		}
		if (!"".equals(startTime) && !"".equals(endTime)) {
			neirong += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		String sql = "select * from TB_SHARE_BARGAIN where " + neirong;
		return ShareBargain.dao.find(sql);
	}
	
	
	/**
	 * 分页查询 查询所有的分享砍价的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		return ShareBargain.dao.paginate(pageNumber, pageSize,activityName,state,startTime,endTime,user);
	}

}
