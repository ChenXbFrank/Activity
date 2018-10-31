package com.activity.common.controller.moblie.robRed;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.openWine.OpenWineWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.robRed.RobRed;
import com.activity.common.model.robRed.RobRedWxUserWining;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.openWine.OpenWineService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.robRed.RobRedPrizeService;
import com.activity.common.service.robRed.RobRedService;
import com.activity.common.service.robRed.RobRedWxUserService;
import com.activity.common.service.robRed.RobRedWxUserWiningService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerOutInfoService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.activity.common.utils.wxInterface.WxRedPackageUitils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 抢红包活动
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/robRed")
public class RobRedController extends BaseController {
	private final Logger log = LoggerFactory.getLogger(RobRedController.class);
	// 工具类
	DateUitils uitils = DateUitils.getUitils();
	EmojiUtils emojiUtils = EmojiUtils.getEmojiUtils();
	WxService wxService = WxService.getService();
	SellerOutInfoService sellerOutInfoService = SellerOutInfoService.getService();
	RobRedPrizeService robRedPrizeService = RobRedPrizeService.getService();
	RobRedWxUserService robRedWxUserService = RobRedWxUserService.getService();
	RobRedWxUserWiningService robRedWxUserWiningService = RobRedWxUserWiningService.getService();
	IndexService indexService = IndexService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IntegralService integralService = IntegralService.getService();
	OpenWineService openWineService = OpenWineService.getService();
	private static RobRedService robRedService = new RobRedService();
	/**
	 * 进入抢红包首页
	 */
	public void robRedIndex(){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				String robRedActivityId = getPara("robRedActivityId");
				//公众号ID
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(getPara("SPNId"));
				//用户所扫二维码
				String qrcode = getPara("qrcode");
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				map.putAll(robRedService.robRed(sellerPublicNumber, qrcode, openid, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()), robRedActivityId));
				ApiConfigKit.removeThreadLocalAppId();
				if(map.get("rest").toString().equals("true")){
					return true;
				}else{
					return false;
				}
			}
		});
		if(map.get("url").toString().equals("0")){
			RobRed robRed = (RobRed) map.get("robRed");
			SellerPublicNumber sellerPublicNumber = (SellerPublicNumber)map.get("sellerPublicNumber");
			WxUserInfo wxuser = (WxUserInfo) map.get("wxUserInfo");
			setAttr("scanWinningNumber", map.get("scanWinningNumber")); 
			setAttr("qrcode", map.get("qrcode"));
			setAttr("robRed", robRed);
			setAttr("openid", map.get("openid"));
			setAttr("mch_billno", map.get("mch_billno"));
			setAttr("redWxUserId", map.get("redWxUserId"));
			setAttr("sellerPublicNumber", sellerPublicNumber);
			setAttr("wxUserInfo", wxuser);
			log.error("---抢红包--扫码进入---code---"+map.get("qrcode")+"---活动活动ID---"+robRed.getRedId()+"---openid---"+map.get("openid"));
			render("/robRed/robRed-homepage.html");
		}else{
			render("/index/QRCodeInvalid.html");
		}
	}
	
	/**
	 * 马上抢
	 */
	public void nowRobRed(){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//抢红包活动ID
				String robRedActivityId = getPara("robRedActivityId");
				//公众号ID
				String sellerPublicNumberId = getPara("SPNId");
				String openid = getPara("openid");
				String redWxUserId = getPara("redWxUserId");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(getPara("SPNId"));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				map.putAll(robRedService.nowRobRed(robRedActivityId, sellerPublicNumberId, openid, redWxUserId, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret())));
				ApiConfigKit.removeThreadLocalAppId();
				if(map.get("rest").toString().equals("true")){
					return true;
				}else{
					return false;
				}
		   }
		});
		renderJson(map);
	}
	
	/**
	 * 进入零钱罐中
	 * 展示本次扫码所中奖品
	 */
	public void intoSmallChange(){
		String openid = getPara("openid");
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(getPara("SPNId"));
		String redId = getPara("redId");
		String follow = getPara("follow");
		//微信用户参与记录ID
		String redWxUserId = getPara("redWxUserId");
		//查询当前用参与记录的中奖
		List<RobRedWxUserWining> rrwuwList = robRedWxUserWiningService.queryRobRedWxUserWiningByWxUserId(redWxUserId);
		RobRed rr = RobRed.dao.findById(redId);
		setAttr("robRed", rr);
		setAttr("SPNId", sellerPublicNumber.getId());
		setAttr("sellerPublicNumber", sellerPublicNumber);
		setAttr("openid", openid);
		setAttr("follow", follow);
		setAttr("rrwuwList", rrwuwList);
		render("/robRed/robRed-record.html");
	}
	
	
	/**
	 * 发送红包
	 */
	public void sendRedPackage(){
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				Boolean rest = false;
				String openid = getPara("openid");
				//公众号ID
				String SPNId = getPara("SPNId");
				String mch_billno = getPara("mch_billno");
				//提现金额
				String extractMoney = getPara("extractMoney");
				Map<String, String> map = new HashMap<String, String>();
				float a =  (float)Float.parseFloat(extractMoney)*100;
				int sup = (int)a;
				if(sup >= Integer.parseInt(PropKit.use("system.properties").get("weixintixian"))){
				SellerPublicNumber spn = SellerPublicNumber.dao.findById(SPNId);
				ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(),spn.getAppId(), spn.getAppSecret()));
				//补全用户信息
				ApiConfigKit.setThreadLocalAppId(spn.getAppId());
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				//保存或修改微信用户
				wxService.saveWxUser(wxuser,openid,spn,newId());
				//修改记录中的微信名称和头像地址
				String sql = PropKit.use("database.properties").get("updateNameByOpenid"); 
				Db.update(sql,wxuser.getNickname(),wxuser.getHeadimgurl(),openid);
				//判断剩余总金额是否大于或等于提现金额
				float num = Float.parseFloat(awu.getSurplusTotalMoney())- Float.parseFloat(extractMoney);
				if(num < 0.00 || num < 0 || num <0.0){
					map.put("state", "NoMoney");
					rest = true;
				}else{
					//修改当前用户剩余余额
					int suprlus = indexService.updateUserByOpenidAndAppId(openid,spn.getId());
					if(suprlus > 0){
						//修改所有红包中奖记录未提现的提现   修改提现状态为0的记录，更改为1已经提现，条件是完成状态是1=已完成的
						int state = redWinningInfoService.updateRedInfoByWithdrawals("1","1",openid,spn.getId());
						if(state>0){
							//TODO  这里将开酒瓶的活动的中奖纪录信息的状态修改为已经提现
							List<OpenWineWxUserWinning> openWinByOpenIdList = openWineService.getOpenWinByOpenId(openid.toString());
							for (OpenWineWxUserWinning openWineWxUserWinning : openWinByOpenIdList) {
								/**
								 * 提现成功 将提现状态修改为已提现
								 */
								openWineService.updateOpenWinState(openWineWxUserWinning.getId());
								openWineService.updateOpenWineState(openWineWxUserWinning.getOpenWineWxuserId());
							}
							//将该用户的头像昵称更新
							openWineService.updateOpenWxInfoByOpenWxUserId(wxuser.getNickname(), wxuser.getHeadimgurl(),openid);
						}
						if(state > 0){
							/**
							 * 发送普通红包
							 * @param mchId  微信支付分配的商户号
							 * @param appid  微信分配的公众账号ID（企业号corpid即为此appId）
							 * @param sendName  红包发送者名称
							 * @param openid   接受红包的用户,用户在wxappid下的openid
							 * @param totalAmount  付款金额，单位分
							 * @param totalNum  红包发放总人数total_num=1
							 * @param redWishing  红包祝福语
							 * @param activityName  活动名称
							 * @param redRemark  备注信息   猜越多得越多，快来抢！
							 * @param payKey  支付密钥
							 */
							Map<String, String> paymap = WxRedPackageUitils.getWxRedPackageUitils().enterprisePayment(mch_billno,spn.getShopNumber(), spn.getAppId(), spn.getSenderName(), openid, extractMoney, "1", 
									spn.getWish(), spn.getSenderName(), spn.getRemarks()+"--"+wxuser.getNickname(), spn.getPayKey(),spn.getCertPath());
							map.putAll(paymap);
							//修改开酒瓶的中奖提现记录
							if(paymap.get("state").equals("OK")){
								//查询开酒瓶的中奖记录状态
								List<RedWinningInfo> redWinList = openWineService.getRedWinList();
								for (RedWinningInfo redWinningInfo : redWinList) {
									openWineService.updateRedWinInfoState(redWinningInfo.getId());
								}
							}
						}else{
							map.put("state", "NoMoney");
						}
					}else{
						map.put("state", "NoMoney");
					}
					rest = true;
				  }
				}else{
					map.put("state", "NoMoney");
				}
				renderJson(map);
				return rest;
			}
		});
	}

	/**
	 * 算概率
	 * */
	public String algorithm(int SurplusNumber ,int number){
		Float nowprize = (float)SurplusNumber/ (float)number*100;
		DecimalFormat df = new DecimalFormat("##0.00");//格式化小数   
		String probability = df.format(nowprize);//返回的是String类型
		return probability;
	}
	
	/**
	 * 保存红包中奖信息
	 */
	public void saveRedWinningInfo(int one,String id,String robRedActivityId,RobRed robRed,String state,String redWinningInfoMoneyTotal,String openid,String redWxUserId,String publicNumber){
		if(one == 1){
			new RedWinningInfo().set("ID", id).set("BELONG_ACTIVITY_ID", robRedActivityId).set("ACTIVITY_NAME", robRed.getActivityName())
			.set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("RobRed")).set("WINNING_RED_TOTAL", redWinningInfoMoneyTotal).set("CREATE_TIME", uitils.newDate())
			.set("STATE", state).set("STARTTIME", robRed.getStartTime()).set("ENDTIME", robRed.getEndTime()).set("WITHDRAWALS", "0")
			.set("OPENID", openid).set("ACTIVITY_WXUSER_ID", redWxUserId).set("BELONG_PUBLICNUMBER_ID", publicNumber).save();
		}else{
			new RedWinningInfo().set("ID", id).set("BELONG_ACTIVITY_ID", robRedActivityId).set("ACTIVITY_NAME", robRed.getActivityName())
			.set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("RobRed")).set("WINNING_RED_TOTAL", redWinningInfoMoneyTotal).set("CREATE_TIME", uitils.newDate())
			.set("STATE", state).set("STARTTIME", robRed.getStartTime()).set("ENDTIME", robRed.getEndTime()).set("WITHDRAWALS", "0")
			.set("OPENID", openid).set("ACTIVITY_WXUSER_ID", redWxUserId).set("BELONG_PUBLICNUMBER_ID", publicNumber).update();
		}
	}
	
	
}
