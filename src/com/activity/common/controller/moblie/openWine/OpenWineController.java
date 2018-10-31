package com.activity.common.controller.moblie.openWine;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.openWine.OpenWine;
import com.activity.common.model.openWine.OpenWineWxUser;
import com.activity.common.model.openWine.OpenWineWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.service.openWine.OpenWineService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.probability.ProbabilityUtils;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.activity.common.utils.wxInterface.WxRedPackageUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * @author ChenXb
 *
 * 2018年6月21日
 */
@ControllerPath(controllerKey = "/openWine")
public class OpenWineController extends BaseController{
	
	private final Logger log = LoggerFactory.getLogger(OpenWineController.class);
	
	IndexService indexService = IndexService.getService();
	
	WxService wxService = WxService.getService();
	
	DateUitils uitils = DateUitils.getUitils();
	
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	
	OpenWineService openWineService = OpenWineService.getService();
	
	/**
	 * 开酒活动首页
	 * index
	 * @author 81046
	 * @date 2018年6月21日下午3:11:28
	 */
	public void index(){
		log.error("***开酒活动首页***");
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				//该活动的ID
				String activityId = getPara("activityId");
				//二维码
				String qrcode = getPara("qrcode");
				//公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumberId");
				SellerPublicNumber sellerPublicNumber = openWineService.getSellerPublicNumberById(sellerPublicNumberId);
				//绑定线程
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),
						sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				//获取到的openid
				String openid = getOpenid(sellerPublicNumber);
				/**
				 * 进入活动判断该用户该码的扫码情况
				 */
				map.putAll(openWineService.openWineInfo(sellerPublicNumber, qrcode, openid, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()), activityId));
				//使用完后释放，不释放可能存在内存溢出
				ApiConfigKit.removeThreadLocalAppId();
				log.error("---开酒瓶活动---"+activityId+"---Openid---"+openid+"---公众号---"+sellerPublicNumber.getId());
				if(map.get("rest").toString().equals("true")){
					return true;
				}else{
					return false;
				}
			}
		});
		//这是第一次进来
		if(map.get("result").toString().equals("3")){
			OpenWine openWine = (OpenWine) map.get("openWine");
			SellerPublicNumber sellerPublicNumber = (SellerPublicNumber)map.get("sellerPublicNumber");
			String openWineWxUserId = (String) map.get("openWineWxUserId");
			OpenWineWxUser openWineWxUser = OpenWineWxUser.dao.findById(openWineWxUserId);
			setAttr("sellerPublicNumber",sellerPublicNumber);
			setAttr("openWineWxUser", openWineWxUser);
			setAttr("openWine", openWine);
			setAttr("openid",map.get("openid"));
			setAttr("wxUserInfo",map.get("wxUserInfo"));
			setAttr("openWineWxUserId",map.get("openWineWxUserId"));
			setAttr("follow",map.get("follow"));
			setAttr("shareUrl",map.get("shareUrl"));
			// 判断是否属于活动时间内
			Date endDate = DateUitils.strToDateYMD(openWine.getEndTime());
			// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
			boolean isEnd = DateUitils.isDateBefore(endDate);
			setAttr("isEnd", isEnd);
		}
		//出错页面
		if(map.get("url").equals("404")){
			renderError(404);
		}
		//跳转对应的链接
		else{
			render(map.get("url").toString());
		}
	}
	
	
	/**
	 * 点击开瓶生成奖品(扫码奖品)
	 */
	public void openLuckDraw(){
		Map<String, Object> map = new HashMap<String, Object>();
		// 所参加活动ID
		String openWineId = getPara("openWineId");
		String openid = getPara("openid");
		String openWineWxUserId = getPara("openWineWxUserId");
		// 公众号ID
		String sellerPublicNumberId = getPara("sellerPublicNumberId");
		SellerPublicNumber sellerPublicNumber = openWineService.getSellerPublicNumberById(sellerPublicNumberId);
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		map.putAll(openWineService.openLuckDraw(openWineWxUserId, openWineId, openid, sellerPublicNumberId, sellerPublicNumber, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret())));
		//使用完后释放，不释放可能存在内存溢出
		ApiConfigKit.removeThreadLocalAppId();
		renderJson(map);
	}
	
	/**
	 * 点击开瓶生成奖品(分享奖品)
	 */
	public void openShareLuckDraw(){
		Map<String, Object> map = new HashMap<String, Object>();
		// 所参加活动ID
		String openWineId = getPara("openWineId");
		String openid = getPara("openid");
		String openWineWxUserId = getPara("openWineWxUserId");
		// 公众号ID
		String sellerPublicNumberId = getPara("sellerPublicNumberId");
		SellerPublicNumber sellerPublicNumber = openWineService.getSellerPublicNumberById(sellerPublicNumberId);
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		map.putAll(openWineService.openShareLuckDraw(openWineWxUserId, openWineId, openid, sellerPublicNumberId, sellerPublicNumber, getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret())));
		//使用完后释放，不释放可能存在内存溢出
		ApiConfigKit.removeThreadLocalAppId();
		renderJson(map);
	}
	
	/**
	 * 查看我的奖品
	 */
	public void lookWinInfo(){
		String openId = getPara("openid");
		String openWineWxUserId = getPara("openWineWxUserId");
		List<OpenWineWxUserWinning> list = openWineService.getOpenWineWinListByIdOpenId(openId, openWineWxUserId);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		renderJson(map);
	}
	
	/**
	 * 分享砍价微信配置
	 */
	public void wxShareConfig() {
		String locationUrl = getPara("locationUrl");
		Map<String, String> wxConfigApi = WxConfigUitils.getWxConfigUitils().WxConfigApi(locationUrl);
		renderJson(wxConfigApi);
	}
	
	/**
	 * 分享 重定向 /openWine/toShare
	 */
	public void toShare(){
		String sellerPublicNumberId = getPara("sellerPublicNumberId");
		SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
		+ "&redirect_uri=http%3a%2f%2f" + PropKit.use("system.properties").get("http")
		+ JFinal.me().getContextPath() + "%2fopenWine%2fshare%3fopenWineWxUserId%3d" + getPara("openWineWxUserId")
		+ "%26openWineId%3d" + getPara("openWineId") + "%26appid%3d" + spn.getAppId() + "%26qrcode%3d" + getPara("qrcode")
		+ "%26sellerPublicNumberId%3d" + sellerPublicNumberId
		+ "&response_type=code&scope=snsapi_userinfo&state=wx&connect_redirect=1#wechat_redirect";
		redirect(url);
	}	
	
	/**
	 * 分享直接跳转外部链接（客户提供的链接）
	 * share
	 * @author 81046
	 * @date 2018年6月28日上午10:35:10
	 */
	public void share(){
		redirect("https://i.eqxiu.com/s/LB6gFPbB?eqrcode=1&share_level=1&from_user=35557d54-2836-480e-9aa5-3a52dc3fd3ca&from_id=f9198458-3dd6-41da-85ad-7b2953b5c3c0&share_time=1531734440583&from=groupmessage&isappinstalled=0");
	}
	
	
	/**
	 * 分享成功之后的链接
	 */
	public void sharedSuccess(){
		String openWineWxUserId = getPara("openWineWxUserId");
		OpenWineWxUser openWineWxUser = OpenWineWxUser.dao.findById(openWineWxUserId);
		String openWineId = openWineWxUser.getOpenWineId();
		OpenWine openWine = OpenWine.dao.findById(openWineId);
		// 判断是否属于活动时间内
		Date endDate = DateUitils.strToDateYMD(openWine.getEndTime());
		// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
		boolean isEnd = DateUitils.isDateBefore(endDate);
		if(isEnd){
			//这里需要判断该用户是不是已经分享过来
			//是否分享过了 0 未分享  1 分享过了
			String isShare = openWineWxUser.getIsShare();
			if(isShare.equals("0")){
				//分享成功之后将该用户的分享抽奖次数+1
				int updateJoinTypeShareToOne = openWineService.updateJoinTypeShareToOne(openWineWxUserId);
				//将该条分享信息变为已经分享了
				updateJoinTypeShareToOne = openWineService.updateIsShare(openWineWxUserId);
				if(updateJoinTypeShareToOne > 0){
					renderJson("result","true");
				}else{
					renderJson("result","false");
				}
			}else{
				renderJson("result","isShared");
			}
			
		}else{
			renderJson("result","end");
		}
	}
	
	
	int isOK = 0; 
	
	private boolean isReceived() {
		String mch_billno = getPara("mch_billno");
		OpenWineWxUserWinning wineWxUserWinning = OpenWineWxUserWinning.dao.findById(mch_billno);
		return wineWxUserWinning == null ? false : wineWxUserWinning.getState().equals("9");
	}
	/**
	 * 活动内立即提现 发送红包
	 */
	public void nowSendRedPackage(){
		isOK= 0 ;
		if(isReceived()) {
			return ;
		}
		synchronized (this) {
			if(!isReceived()) {
				Db.tx(new IAtom() {
					@Override
					public boolean run() throws SQLException {
						log.error("***活动内立即提现 发送红包***");
						Boolean rest = false;
						//第一步 获取openid 公众号id
						String sellerPublicNumberId = getPara("sellerPublicNumberId");
						SellerPublicNumber spn = SellerPublicNumber.dao.findById(sellerPublicNumberId);
						ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(spn.getToKen(), spn.getAppId(), spn.getAppSecret()));
						ApiConfigKit.setThreadLocalAppId(spn.getAppId());
						String openid = getPara("openid");
						//商户订单号  这里就是中奖的id
						String mch_billno = getPara("mch_billno"); 
						log.error("***mch_billno***"+mch_billno);
						OpenWineWxUserWinning wineWxUserWinning = OpenWineWxUserWinning.dao.findById(mch_billno);
						log.error("***wineWxUserWinning***"+wineWxUserWinning);
						//当前人员剩余金额
						ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,spn.getId());
						//补全用户信息
						WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, spn.getAppId(), spn.getAppSecret());
						ApiConfigKit.removeThreadLocalAppId();
						//保存或修改微信用户
						wxService.saveWxUser(wxuser,openid,spn,newId());
						//修改记录中的微信名称和头像地址
						String sql = PropKit.use("database.properties").get("updateNameByOpenid");
						Db.update(sql,wxuser.getNickname(),wxuser.getHeadimgurl(),openid);
						//判断当前人员的中奖金额是否大于微信限制金额
						float a =  (float)Float.parseFloat(wineWxUserWinning.getWinningMoney())*100;
						int sup = (int)a;
						log.error("***当前人员的中奖金额(提现金额)***"+sup);
						log.error("***微信提现要求金额***"+Integer.parseInt(PropKit.use("system.properties").get("weixintixian")));
						if(sup >= Integer.parseInt(PropKit.use("system.properties").get("weixintixian"))){
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
							DecimalFormat df = new DecimalFormat("##0.00");
							if(wineWxUserWinning!=null&&(!wineWxUserWinning.getState().equals("9"))){
								log.error("***当前人员的中奖金额(提现金额)wineWxUserWinning.getWinningMoney()***"+wineWxUserWinning.getWinningMoney());
								Map<String, String> paymap = WxRedPackageUitils.getWxRedPackageUitils().enterprisePayment(mch_billno,spn.getShopNumber(), spn.getAppId(), spn.getSenderName(), openid, wineWxUserWinning.getWinningMoney(), "1", 
										spn.getWish(), spn.getSenderName()+"的活动", spn.getRemarks(), spn.getPayKey(),spn.getCertPath());
								if(paymap.get("state").equals("OK")){
									//这是剩余的金额-提现的金额 就是提现后剩下的金额了
									float surMoney= Float.parseFloat(awu.getSurplusTotalMoney())-Float.parseFloat(wineWxUserWinning.getWinningMoney());
									log.error("***剩余的金额surMoney***"+surMoney);
									//修改当前用户剩余余额
									int suprlus = indexService.updateUserMoneyByOpenidAndAppId(df.format(surMoney),openid,spn.getId());
									log.error("***剩余suprlus***"+suprlus);
									/**
									 * 提现成功 将提现状态修改为已提现
									 */
									int updateOpenWinState = openWineService.updateOpenWinState(wineWxUserWinning.getId());
									log.error("***提现成功***"+wineWxUserWinning.getId()+"***修改updateOpenWinState***"+updateOpenWinState);
									
									int updateOpenWineState = openWineService.updateOpenWineState(wineWxUserWinning.getOpenWineWxuserId());
									log.error("***修改updateOpenWineState***"+updateOpenWineState);
									//红包中奖总记录那里提现状态修改一下
									int updateRedWinInfoState = openWineService.updateRedWinInfoState(wineWxUserWinning.getId());
									log.error("***提现成功updateRedWinInfoState***"+updateRedWinInfoState);
									//将该用户的头像昵称更新
									openWineService.updateOpenWxInfoByOpenWxUserId(wxuser.getNickname(), wxuser.getHeadimgurl(),openid);
									isOK=1;
								}else{
									isOK=0;
								}
							}
						}
						rest = true;
						return rest;
					}
				});
			
			}
		}
		renderJson(isOK);
	}
	
}
