package com.activity.common.service.shareBargain;

import java.util.List;

import com.activity.common.model.shareBargain.ShareBargainHelp;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 用户发起的活动
 * 
 * @author 唐
 *
 */
public class ShareBargainWxuserService {

	private static ShareBargainWxuserService shareBargainWxuserService = new ShareBargainWxuserService();

	private ShareBargainWxuserService() {

	}

	/**
	 * 懒汉式 就是申明的时候不new 在下边的时候判断是否为空的时候 才new出来 这样线程不安全
	 * 
	 * @return
	 */
	public static ShareBargainWxuserService getService() {
		return shareBargainWxuserService;
	}

	/**
	 * 根据openId查询出未支付 活动
	 * 
	 * @param openid
	 * @return
	 */
	public List<ShareBargainWxuser> getSbwByOpenid(String openid, String activityId,String qrcode) {
		String sql = PropKit.use("database.properties").get("getSbwByOpenid");
		List<ShareBargainWxuser> sbwList = ShareBargainWxuser.dao.find(sql, openid, activityId,qrcode);
		return sbwList;
	}

	/**
	 * 根据openid和需要朋友砍价的ID查询出帮忙砍价的朋友
	 * 
	 * @param openid
	 * @param friendBargainId
	 * @return
	 */
	public List<ShareBargainHelp> getSbhByOpenidAndFriendBargainId(String openid, String friendBargainId) {
		String sql = PropKit.use("database.properties").get("getSbhByOpenidAndFriendBargainId");
		List<ShareBargainHelp> sbhList = ShareBargainHelp.dao.find(sql, openid, friendBargainId);
		return sbhList;
	}

	public ShareBargainWxuser getShareBargainHelpById(String id) {
		String sql = PropKit.use("database.properties").get("getShareBargainHelpById");
		ShareBargainWxuser rest = new ShareBargainWxuser();
		List<Record> rec = Db.find(sql,id);
		for(Record re : rec){
			ShareBargainWxuser wxUser = new ShareBargainWxuser();
			rest=wxUser.mapping(re, rest);
		}
		return rest;
	}
	
	/**
	 * 根据活动id查询ShareBargainWxuser的记录
	 */
	public List<ShareBargainWxuser> getShareBargainWxuserByActivityId(String activityId) {
		String sql = PropKit.use("database.properties").get("getShareBargainWxuserByActivityId");
		return ShareBargainWxuser.dao.find(sql, activityId);
	}

	/**
	 * 根据商户号和订单号查询出分享砍价
	 * 
	 * @param mchId
	 * @param outTradeNo
	 * @return
	 */
	public List<ShareBargainWxuser> getSbwByMchIdAndoutTradeNo(String mchId, String outTradeNo) {
		String sql = PropKit.use("database.properties").get("getSbwByMchIdAndoutTradeNo");
		List<ShareBargainWxuser> sbwList = ShareBargainWxuser.dao.find(sql, mchId, outTradeNo);
		return sbwList;
	}

	/**
	 * 根据openid和公众号ID查询记录
	 * 
	 * @param openid
	 * @param BelongPublicNumberId
	 * @return
	 */
	public List<ShareBargainWxuser> getSbwByOpenidAndBelongPublicNumberId(String openid, String BelongPublicNumberId,
			String activeName, String state) {
		String neirong = " ";
		// 这里是模糊查询名字
		if (activeName != null && !activeName.equals("")) {
			neirong += "and b.Activity_Name like '%" + activeName + "%'";
		}
		if (state != null && !state.equals("")) {
			if ("4".equals(state)) {
				neirong += " and a.GOODS_STATE = '1'";
			} else if ("0".equals(state)) {
				neirong += "";
			} else {
				neirong += " and a.STATE = " + state;
			}
		}
		String sql = PropKit.use("database.properties").get("getSbwByOpenidAndBelongPublicNumberId") + neirong;
		List<ShareBargainWxuser> sbwList = ShareBargainWxuser.dao.find(sql, openid, BelongPublicNumberId);
		return sbwList;
	}

	/**
	 * 查询参加该条分享砍价活动的记录 昵称 砍价情况 支付情况 发货情况
	 */
	public List<ShareBargainWxuser> searchShareBargainUserReportByCondition(String nickName, String state,
			String goodsState, String startTime, String endTime) {
		String neirong = "1=1 ";
		// 这里是模糊查询名字
		if (!"".equals(nickName)) {
			neirong += "and NICKNAME like '%" + nickName + "%'";
		}
		if (!"".equals(state)) {
			neirong += " and STATE = " + state;
		}
		if (!"".equals(goodsState)) {
			neirong += " and GOODS_STATE = " + goodsState;
		}
		if (!"".equals(startTime) && !"".equals(endTime)) {
			neirong += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		// 我记得下次模糊的时候 不用插入 用 拼接 是这样的
		String sql = "select * from TB_SHARE_BARGAIN_WXUSER where " + neirong;
		return ShareBargainWxuser.dao.find(sql);
	}

	/**
	 * 判断当前的价格和最低价是否一致 shareBargainHelp表里的friendId是WXUser表里的id
	 * WXUser表里的joinActivityId是shareBargain表里的Id 先判断WXUser表里当前价格和最低价是否一样
	 * 这里的activityId是shareBargainHelp表里的friendId
	 */
	public boolean isLowest(String activityId) {
		ShareBargainWxuser wxuser = ShareBargainWxuser.dao.findById(activityId);
		Float nowPrice = Float.parseFloat(wxuser.getNowPrice());
		Float lowPrice = Float.parseFloat(wxuser.getLowPrice());
		if ((int) (nowPrice * 100) == (int) (lowPrice * 100)) {
			return true;
		}
		return false;
	}

	/**
	 * 根据ID查询订单详细需要的数据
	 */
	public List<ShareBargainWxuser> getSbwById(String sbwId) {
		String sql = PropKit.use("database.properties").get("getSbwById");
		List<ShareBargainWxuser> wxuserList = ShareBargainWxuser.dao.find(sql, sbwId);
		return wxuserList;
	}

}
