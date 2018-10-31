package com.activity.common.model.shareBargain;

import com.activity.common.model.shareBargain.base.BaseShareBargainHelp;
import com.jfinal.plugin.activerecord.Record;

/**
 * 分享砍价帮助砍价
 * 
 * @author 唐
 *
 */
@SuppressWarnings("serial")
public class ShareBargainHelp extends BaseShareBargainHelp<ShareBargainHelp> {
	public static final ShareBargainHelp dao = new ShareBargainHelp();

	/**
	 * 映射 数据库查询后映射对象
	 * 
	 * @param cord
	 * @param info
	 * @return
	 */
	public ShareBargainHelp mapping(Record cord, ShareBargainHelp info) {
		info.setId(cord.getStr("ID"));
		info.setOpenId(cord.getStr("OPENID"));
		info.setNickName(cord.getStr("NICKNAME"));
		info.setHeadImgUrl(cord.getStr("HEADIMGURL"));
		info.setFriendActivityId(cord.getStr("FRIEND_ACTIVITY_ID"));
		info.setBargainMoney(cord.getStr("BARGAIN_MONEY"));
		info.setSpareOne(cord.getStr("SPARE_ONE"));
		info.setSpareTwo(cord.getStr("SPARE_TWO"));
		return info;
	}
}
