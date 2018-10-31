package com.activity.common.service.shareBargain;

import java.util.List;

import com.activity.common.model.shareBargain.ShareBargainPrize;
import com.jfinal.kit.PropKit;

/**
 * 分享砍价活动奖品配置
 * 
 * @author 唐
 *
 */
public class ShareBargainPrizeService {
	private static ShareBargainPrizeService shareBargainPrizeService = new ShareBargainPrizeService();

	private ShareBargainPrizeService() {
	}

	public static ShareBargainPrizeService getService() {
		return shareBargainPrizeService;
	}

	/**
	 * 根据活动ID查询出所有的奖品
	 * 
	 * @param ActvityId
	 * @return
	 */
	public List<ShareBargainPrize> getShareBargainPrizeByActvityId(String actvityId) {
		String sql = PropKit.use("database.properties").get("getShareBargainPrizeByActvityId");
		List<ShareBargainPrize> sbpList = ShareBargainPrize.dao.find(sql, actvityId);
		return sbpList;
	}

}
