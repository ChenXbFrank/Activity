package com.activity.common.service.oneMoney;

import java.util.Date;
import java.util.List;

import com.activity.common.model.oneMoneyShop.OneMoneyGroupWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUser;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;

/**
 * @author ChenXb
 *
 * 2017年12月7日
 */
public class OneMoneyService {
	private static OneMoneyService oneMoneyService = new OneMoneyService();

	private OneMoneyService() {
	}

	public static OneMoneyService getService() {
		return oneMoneyService;
	}
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public String oneMoneyActivity(String oneMoneyActivityID, String qrcode) {
		OneMoneyShop sb = OneMoneyShop.dao.findById(oneMoneyActivityID);
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
							+ JFinal.me().getContextPath() + "%2foneMoneyShop%2foneMoney%3fActivity%3d"
							+ sb.getId() + "%26qrcode%3d" + qrcode + "%26sellerPublicNumber%3d" + spn.getId() 
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
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public OneMoneyWxUser getOneMoneyByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getOneMoneyByOpenidAndQrCode");
		return OneMoneyWxUser.dao.findFirst(sql,openid,scanCode);
	}
	
	/**
	 * 保存一元购微信活动记录
	 */
	public int saveOneMoneyWxUser(String id,String oneMoneyId,String openId,String nickName,String headImg,
			String createTime,String publicNumber,String scanCode,String activityName,String state){
		String saveSql = PropKit.use("database.properties").get("saveOneMoneyWxUser");
		return Db.update(saveSql,id,oneMoneyId,openId,nickName,headImg,createTime,publicNumber,scanCode,activityName,state);
	}
	
	/**
	 * 保存一元购微信活动记录group
	 */
	public int saveOneMoneyGroupWxUser(String id,String oneMoneyWxUserId,String openId,String nickName,String headImg,
			String createTime,String activityName,String state,String creater){
		String saveSql = PropKit.use("database.properties").get("saveOneMoneyGroupWxUser");
		return Db.update(saveSql,id,oneMoneyWxUserId,openId,nickName,headImg,createTime,activityName,state,creater);
	}
	
	/**
	 * 根据mchid 和订单号查询  支付的用户信息
	 */
	public OneMoneyGroupWxUser getOneMoneyGroupWxUser(String mchId,String outNo){
		String sql="select * from TB_ONE_MONEY_GROUP_WXUSER where MCHID = ? and PAYOUTNO = ? ";
		return OneMoneyGroupWxUser.dao.findFirst(sql,mchId,outNo);
	}
}
