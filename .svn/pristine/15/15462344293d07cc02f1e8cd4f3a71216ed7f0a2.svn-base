package com.activity.common.service.openWine;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.openWine.OpenWine;
import com.activity.common.model.openWine.OpenWinePrize;
import com.activity.common.model.openWine.OpenWineSharePrize;
import com.activity.common.model.openWine.OpenWineWxUser;
import com.activity.common.model.openWine.OpenWineWxUserWinning;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.probability.ProbabilityUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.weixin.sdk.api.ApiConfigKit;

/**
 * 定制活动的service
 * 
 * @author ChenXb
 *
 * 2018年6月19日
 */
public class OpenWineService {
	
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	
	private final Logger log = LoggerFactory.getLogger(OpenWineService.class);
	
	WxService wxService = WxService.getService();
	
	DateUitils uitils = DateUitils.getUitils();
	
	IndexService indexService = IndexService.getService();
	
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	
	private static OpenWineService openWineService = new OpenWineService();
	
	private OpenWineService() {
		
	}

	public static OpenWineService getService() {
		return openWineService;
	}
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public String openWineActivity(String openWineActivityID, String qrcode) {
		OpenWine sb = OpenWine.dao.findById(openWineActivityID);
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
							+ JFinal.me().getContextPath() + "%2fopenWine%2findex%3factivityId%3d"
							+ sb.getId() + "%26qrcode%3d" + qrcode + "%26sellerPublicNumberId%3d" + spn.getId() 
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
	 * 查询开酒活动
	 */
	public OpenWine getActivityById(String activityId){
		return OpenWine.dao.findById(activityId);
	}
	
	/**
	 * 查询公众号 SellerPublicNumber 信息
	 */
	public SellerPublicNumber getSellerPublicNumberById(String sellerPublicNumberId){
		return SellerPublicNumber.dao.findById(sellerPublicNumberId);
	}
	
	/**
	 * 进入活动判断该用户该码的扫码情况
	 */
	public synchronized Map<String, Object> openWineInfo(SellerPublicNumber sellerPublicNumber,String qrcode,String openid,String accessToken,String activityId) {
		Map<String, Object> map = new HashMap<String, Object>();
		String queryOpenWine = PropKit.use("database.properties").get("queryOpenWine");
		Record recode = Db.findFirst(queryOpenWine,activityId);
		//这里查询开酒活动的
		OpenWine openWine = new OpenWine().mapping(recode, new OpenWine());
		//这里是查询该码是否有活动
		boolean rest = IndexService.getService().queryQrcodeState(qrcode, activityId, openid);
		// 第一次扫码进入
		ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		// 默认该用户未关注
		String follow = "0";
		if (wxuser.getSubscribe().equals("1")) {
			// 不为空的时候则是获取该用户的关注情况
			follow = wxuser.getSubscribe();
		}
		map.put("follow", follow);
		//微信参与活动的id
		String openWineWxUserId="";
		// 1=未保存成功 2=二维码已经使用 3=成功   
		int result = 1;
		if(rest){
			//根据openid和qrcode查询开酒活动参与的记录
			OpenWineWxUser wineWxUser = getOpenWineByOpenidAndQrCode(openid,qrcode);
			if(wineWxUser != null){
				//说明该码已经参加过活动了
				openWineWxUserId = wineWxUser.getId();
			}
			//该码第一次参加活动
			else{
				// 保存微信用户 现在的流程是不需要关注就可以参与抽奖，所以保存的信息就只有openid
				wxService.noSaveWxUser(wxuser, openid, sellerPublicNumber, newId());
				// 保存用户参加记录
				openWineWxUserId = newId();
				String nickName = "";
				String headimgurl = "";
				// 1 已关注
				if (wxuser.getSubscribe().equals("1")) {
					nickName = wxuser.getNickname();
					headimgurl = wxuser.getHeadimgurl();
					// 判断名称是否包含表情符号
					Boolean emoji = EmojiUtils.containsEmoji(nickName);
					if (emoji) {
						try {
							nickName = java.net.URLEncoder.encode(nickName, "UTF-8");
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
				}
				//保存一个参与开酒活动的微信小活动信息
				int saveOpenWineWxUser = saveOpenWineWxUser(openWineWxUserId, activityId, openid, nickName, headimgurl, uitils.newDate(), sellerPublicNumber.getId(), qrcode, openWine.getActivityName(), "1");
				if(saveOpenWineWxUser > 0){
					// 查询出所属运单    没有活动 新建一个二维码失效记录   保存当前所扫二维码已被使用的记录
					Map<String, Object> map1 = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
					//这是开启活动的运单
					ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map1.get("activitySellerInfo");
					int i = indexService.insertAtcitityCode(newId(), qrcode, activitySellerInfo.getSellerOutInfoRecordId().toString(), sellerPublicNumber.getId(), 
							sellerPublicNumber.getPublicNumberName(), openWineWxUserId, openid, wxuser.getNickname(), wxuser.getHeadimgurl(), 
							PropKit.use("system.properties").get("OpenWine"),"1", activityId,openWine.getActivityName());
					if(i > 0 ){
						//将参与人数+1
						int parseInt = Integer.parseInt(openWine.getJoinPropleNumber()) + 1;
						String updateOpenWineNumber = PropKit.use("database.properties").get("updateOpenWineNumber");
						saveOpenWineWxUser = Db.update(updateOpenWineNumber, parseInt + "", openWine.getId());
						if (saveOpenWineWxUser > 0) {
							rest = true;
						} else {
							rest = false;
						}
					}
				}
			}
			result = 3;
			map.put("openWine", openWine);
			map.put("openid", openid);
			map.put("wxUserInfo", wxuser);
			map.put("openWineWxUserId", openWineWxUserId);
			map.put("sellerPublicNumber", sellerPublicNumber);
			/**
			 * 朋友帮砍价链接 配置文件中的系统名称 PropKit.use("system.properties").get("systemname")
			 * Jfinal获取项目名称不需要配置JFinal.me().getContextPath()
			 */
			String shareUrl = "http://" + PropKit.use("system.properties").get("http") + JFinal.me().getContextPath()
					+ "/openWine/toShare?openWineWxUserId=" + openWineWxUserId +"&openWineId=" + openWine.getId()
					+ "&sellerPublicNumberId=" + sellerPublicNumber.getId()+ "&qrcode=" + qrcode;
			map.put("shareUrl", shareUrl);
		} else {
			// 二维码已经使用
			result = 2;
		}
		map.put("rest", rest);
		map.put("result", result);
		if (result == 1) {
			map.put("url","404");
		} else if (result == 2) {
			map.put("url","/index/QRCodeInvalid.html");
		} else if (result == 3) {
			map.put("url","/openWine/openWine-homepage.html");
		}
		return map;
	}
	
	
	/**
	 * 点击开瓶生成奖品(扫码奖品)
	 * openLuckDraw
	 * @author 81046
	 * @date 2018年6月21日下午4:39:12
	 * @param openWineWxUserId
	 * @param openWineId
	 * @param openid
	 * @param sellerPublicNumberId
	 * @param sellerPublicNumber
	 * @param accessToken
	 * @return  getOpenWineWxUserById #根据openid查询开酒瓶活动参与用户
	 */
	public synchronized Map<String, Object> openLuckDraw(String openWineWxUserId,String openWineId,String openid,String sellerPublicNumberId,SellerPublicNumber sellerPublicNumber,String accessToken){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				boolean result = true;
				Record record = Db.findFirst(PropKit.use("database.properties").get("getOpenWineWxUserById"),openWineWxUserId);
				log.error("***开酒瓶微信活动record***"+record);
				//根据id查询参与微信记录
				OpenWineWxUser openWineWxUser = new OpenWineWxUser().mapping(record, new OpenWineWxUser());
				//先查询该用户该码是否已经通过扫码中过奖了
				OpenWineWxUserWinning wxUserWinning = getOpenWineWinByIdOpenId(openWineWxUser.getOpenId(), openWineWxUser.getId(), "1");
				log.error("***wxUserWinning***"+wxUserWinning);
				//为空是表示该码该人还没有中过奖
				if(wxUserWinning == null ){
					String queryOpenWine = PropKit.use("database.properties").get("queryOpenWine");
					Record recode = Db.findFirst(queryOpenWine,openWineId);
					log.error("***开酒瓶大活动recode***"+recode);
					//这里查询开酒活动的
					OpenWine openWine = new OpenWine().mapping(recode, new OpenWine());
					//查询扫码中奖配置信息
					List<OpenWinePrize> winePrizeList = getOpenWinePrizeByAId(openWineId);
					log.error("***winePrizeList***"+winePrizeList);
					//计算出用户的中奖奖品
					Object[] winningPrize = generateWinningPrize(winePrizeList);
					//该次用户所中的奖品
					OpenWinePrize openWineWinInfo = (OpenWinePrize) winningPrize[0];
					log.error("***所中奖品openWineWinInfo***"+openWineWinInfo);
					//修改活动中奖人数
					int total = Integer.parseInt(openWine.getTotal());
					total = total - 1;
					int i = (int) winningPrize[1];
					log.error("原始中奖数量="+winePrizeList.get(i).getSurplusPrizeNumber());
					//中奖奖品数量减一
					int surplusPrizeNumber = Integer.parseInt(winePrizeList.get(i).getSurplusPrizeNumber())-1;
					log.error("中奖数量="+surplusPrizeNumber);
					winePrizeList.get(i).setSurplusPrizeNumber(surplusPrizeNumber+"");
					//重新计算和保存概率和修改活动获奖人数
					for (OpenWinePrize beprize : winePrizeList) {
						//中奖奖品数量减去后在计算概率
						String newProbability = probabilityUtils.algorithm(Integer.parseInt(beprize.getSurplusPrizeNumber()), total);
						log.error("中奖数量概率="+newProbability+"----"+beprize.getSurplusPrizeNumber());
						//修改剩余奖品数量和概率
						int updateNumAndProbability = updateWinePrizeNumAndProById(beprize.getSurplusPrizeNumber(), newProbability, beprize.getId());
						if (updateNumAndProbability > 0) {
							// 修改砸蛋活动剩余参与活动总数
							int updateBreakEggTotal = updateOpenWineTotalById(openWineId, total + "");
							if (updateBreakEggTotal == 0) {
								result = false;
							}
						}
					}
					log.error("***result***"+result);
					if(result){
						//活动用户信息
						ActivityWxUser activityWxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,sellerPublicNumberId);
						//创建一个用户获奖后记录ID
						String openWineWinningId = UUID.randomUUID().toString().replaceAll("-", "");
						// 奖品类型 1实物 2积分 3红包4谢谢惠顾
						if(openWineWinInfo.getPrizeType().equals("3")){
							int openWineRed = openWineRed(activityWxUser,openWine,openWineWxUser,openWineWinInfo,openid,openWineWinningId,sellerPublicNumber,accessToken,"1");
							if(openWineRed>0){
								log.error("---保存开酒瓶---红包记录");
							}
						}
						// 奖品类型 1实物 2积分 3红包4谢谢惠顾
						if(openWineWinInfo.getPrizeType().equals("4")){
							// 谢谢惠顾  保存砸蛋中奖记录 
							int saveWinning = saveOpenWineWinning(openWineWinningId, openWineWxUser.getId(),
									openWineWinInfo.getPrizeType(), openWineWinInfo.getId(),
									"0", openWineWinInfo.getPrizeName(),
									uitils.newDate(), openid, "1", "", "", "1");
							if(saveWinning>0){
								log.error("---保存开酒瓶---谢谢惠顾记录");
							}
							
						}
						//根据ScanCode修改当前二维码中奖情况+事物
						int updateWinningByScanCode = indexService.updateWinningByScanCode(openWineWxUserId,openWineWinInfo.getPrizeType(),openWineWinningId,openWineWxUser.getScanCode());
						if(updateWinningByScanCode>0){
							log.error("---修改扫码数据的中奖信息---");
						}
						map.put("openWineWinningId", openWineWinningId);
						log.error("---openWineWinningId---"+openWineWinningId);
					}
					//中的奖品
					map.put("openWineWinInfo", openWineWinInfo);
					//将该次用户的扫码抽奖机会置为0
					openWineWxUser.set("ID", openWineWxUserId).set("JOIN_TYPE_SCODE", "0").update();
					return true;
				}
				//说明该人该码已经抽奖了
				else{
					return false;
				}
			   }
			});
		log.error("---开酒瓶---返回"+map.toString());
		return map;
	}
	
	
	/**
	 * 点击开瓶生成奖品(分享奖品)
	 * openShareLuckDraw
	 * @author 81046
	 * @date 2018年6月21日下午4:39:12
	 * @param openWineWxUserId
	 * @param openWineId
	 * @param openid
	 * @param sellerPublicNumberId
	 * @param sellerPublicNumber
	 * @param accessToken
	 * @return  getOpenWineWxUserById #根据openid查询开酒瓶活动参与用户
	 */
	public synchronized Map<String, Object> openShareLuckDraw(String openWineWxUserId,String openWineId,String openid,String sellerPublicNumberId,SellerPublicNumber sellerPublicNumber,String accessToken){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				log.error("***点击开瓶生成奖品(分享奖品)***");
				boolean result = true;
				Record record = Db.findFirst(PropKit.use("database.properties").get("getOpenWineWxUserById"),openWineWxUserId);
				//根据id查询参与微信记录
				OpenWineWxUser openWineWxUser = new OpenWineWxUser().mapping(record, new OpenWineWxUser());
				log.error("***openWineWxUser***"+ openWineWxUser);
				//先查询该用户该码是否已经通过扫码中过奖了
				OpenWineWxUserWinning wxUserWinning = getOpenWineWinByIdOpenId(openWineWxUser.getOpenId(), openWineWxUser.getId(), "2");
				log.error("***wxUserWinning***"+ wxUserWinning);
				//为空是表示该码该人还没有中过奖
				if(wxUserWinning == null ){
					String queryOpenWine = PropKit.use("database.properties").get("queryOpenWine");
					Record recode = Db.findFirst(queryOpenWine,openWineId);
					//这里查询开酒活动的
					OpenWine openWine = new OpenWine().mapping(recode, new OpenWine());
					//查询扫码中奖配置信息
					List<OpenWineSharePrize> winePrizeList = getOpenWineSharePrizeByAId(openWineId);
					//计算出用户的中奖奖品
					Object[] winningPrize = generateWinningSharePrize(winePrizeList);
					//该次用户所中的奖品
					OpenWineSharePrize openWineWinInfo = (OpenWineSharePrize) winningPrize[0];
					//修改活动中奖人数
					int total = Integer.parseInt(openWine.getTotal());
					total = total - 1;
					int i = (int) winningPrize[1];
					log.error("原始中奖数量="+winePrizeList.get(i).getSurplusPrizeNumber());
					//中奖奖品数量减一
					int surplusPrizeNumber = Integer.parseInt(winePrizeList.get(i).getSurplusPrizeNumber())-1;
					log.error("中奖数量="+surplusPrizeNumber);
					winePrizeList.get(i).setSurplusPrizeNumber(surplusPrizeNumber+"");
					//重新计算和保存概率和修改活动获奖人数
					for (OpenWineSharePrize beprize : winePrizeList) {
						//中奖奖品数量减去后在计算概率
						String newProbability = probabilityUtils.algorithm(Integer.parseInt(beprize.getSurplusPrizeNumber()), total);
						log.error("中奖数量概率="+newProbability+"----"+beprize.getSurplusPrizeNumber());
						//修改剩余奖品数量和概率
						int updateNumAndProbability = updateWinePrizeNumAndProById(beprize.getSurplusPrizeNumber(), newProbability, beprize.getId());
						if (updateNumAndProbability > 0) {
							// 修改砸蛋活动剩余参与活动总数
							int updateBreakEggTotal = updateOpenWineTotalById(openWineId, total + "");
							if (updateBreakEggTotal == 0) {
								result = false;
							}
						}
					}
					
					if(result){
						//活动用户信息
						ActivityWxUser activityWxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,sellerPublicNumberId);
						//创建一个用户获奖后记录ID
						String openWineWinningId = UUID.randomUUID().toString().replaceAll("-", "");
						// 奖品类型 1实物 2积分 3红包4谢谢惠顾
						if(openWineWinInfo.getPrizeType().equals("3")){
							openWineShareRed(activityWxUser,openWine,openWineWxUser,openWineWinInfo,openid,openWineWinningId,sellerPublicNumber,accessToken,"2");
							log.error("---开酒瓶---红包");
						}
						// 奖品类型 1实物 2积分 3红包4谢谢惠顾
						if(openWineWinInfo.getPrizeType().equals("4")){
							// 谢谢惠顾  保存砸蛋中奖记录 
							int saveWinning = saveOpenWineWinning(openWineWinningId, openWineWxUser.getId(),
									openWineWinInfo.getPrizeType(), openWineWinInfo.getId(),
									"0", openWineWinInfo.getPrizeName(),
									uitils.newDate(), openid, "1", "", "", "1");
							if(saveWinning>0){
								log.error("---保存开酒瓶---谢谢惠顾记录");
							}
							
						}
						//根据ScanCode修改当前二维码中奖情况+事物
						indexService.updateWinningByScanCode(openWineWxUserId,openWineWinInfo.getPrizeType(),openWineWinningId,openWineWxUser.getScanCode());
						map.put("openWineWinningId", openWineWinningId);
					}
					//中的奖品
					map.put("openWineWinInfo", openWineWinInfo);
					//将该次用户的扫码分享抽奖机会置为0
					openWineWxUser.set("ID", openWineWxUserId).set("JOIN_TYPE_SHARE", "0").update();
					return true;
				}
				//说明该人该码已经抽奖了
				else{
					return false;
				}
			   }
			});
		log.error("---开酒瓶---返回"+map.toString());
		return map;
	}
	
	
	/**
	 * 中红包记录  
	 * 
	 */
	public int openWineRed(ActivityWxUser activityWxUser,OpenWine openWine,OpenWineWxUser openWineWxUser,OpenWinePrize openWinePrize,String openid,String openWineWinningId,SellerPublicNumber sellerPublicNumber,String accessToken,String joinType){
		//修改该次活动的中奖人数
		String updateOpenWineWinningPensonById= PropKit.use("database.properties").get("updateOpenWineWinningPensonById");
		Db.update(updateOpenWineWinningPensonById,(Integer.parseInt(openWine.getWinningPropleNumber()) + 1)+"",openWine.getId());
		
		DecimalFormat df = new DecimalFormat("##0.00");
		// 红包 保存砸蛋中奖记录 
		int saveWinning = saveOpenWineWinning(openWineWinningId, openWineWxUser.getId(),
				openWinePrize.getPrizeType(), openWinePrize.getId(),
				openWinePrize.getRedMoney(), openWinePrize.getPrizeName(),
				uitils.newDate(), openid, "1", openWinePrize.getPrizeImg(), "", joinType);
		// 这里是保存开酒瓶中奖记录成功
		if (saveWinning > 0) {
			// 修改开酒瓶活动本次中奖金额或积分值
			Float totalMoney = Float.parseFloat(openWineWxUser.getTotalMoney())+Float.parseFloat(openWinePrize.getRedMoney());
			log.error("***totalMoney***"+totalMoney+" ***ID***"+ openWineWxUser.getId());
//			saveWinning = updateOpenWineWxUserJoinNumberById(df.format(totalMoney), openWinePrize.getId(), openWineWxUser.getId());
			boolean update = openWineWxUser.set("ID", openWineWxUser.getId()).set("TOTAL_MONEY", df.format(totalMoney)).set("OPENWINE_PRZIE_ID", openWinePrize.getId()).update();
			log.error("***修改开酒瓶微信小活动本次中奖金额或积分值***update："+update);
			if(saveWinning > 0){
				// 查找是否存在参与的红包获奖记录
//				RedWinningInfo rwi = redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(openWine.getId(),openid, PropKit.use("system.properties").get("OpenWine"), openWineWxUser.getId());
				RedWinningInfo rwi = new RedWinningInfo();
				// 没有红包记录 则新增一条红包记录
				// 保存红包中奖记录
				rwi = new RedWinningInfo();
				rwi.setId(openWineWinningId);
				rwi.setBelongActivityId(openWine.getId());
				rwi.setActivityName(openWineWxUser.getActivityName());
				rwi.setActivityNameType(PropKit.use("system.properties").get("OpenWine"));
				rwi.setWinningRedTotal(openWinePrize.getRedMoney());
				rwi.setCreateTime(uitils.newDate());
				rwi.setState("1");
				rwi.setStartTime(openWine.getStartTime());
				rwi.setEndTime(openWine.getEndTime());
				rwi.setWithdrawals("0");
				rwi.setOpenid(openid);
				rwi.setActivityWxUserId(openWineWxUser.getId());
				rwi.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
				saveWinning = redWinningInfoService.saveRedInfo(rwi);
				if (saveWinning > 0) {
					//总金额
					Float upTotalMoney = Float.parseFloat(activityWxUser.getTotalMoney())+Float.parseFloat(openWinePrize.getRedMoney());
					//剩余总金额
					Float surplusTotalMoney = Float.parseFloat(activityWxUser.getSurplusTotalMoney())+Float.parseFloat(openWinePrize.getRedMoney());
					//修改该用户个人中心用户的总金额和剩余金额
					boolean update2 = activityWxUser.set("ID", activityWxUser.getId())
					              .set("TOTAL_MONEY", df.format(upTotalMoney))
					              .set("SURPLUS_TOTAL_MONEY", df.format(surplusTotalMoney))
					              .update();
					log.error("***修改该用户个人中心用户的总金额和剩余金额***update2"+update2);
				}
			}
		}
		//发送红包中奖通知
		String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + openWineWxUser.getOpenId();
		//这里推送中奖通知
		Tools.sendWinNotice(openWineWxUser.getOpenId(), sellerPublicNumber, activityUrl, openWine.getActivityName(), openWinePrize.getPrizeName(), accessToken);
		return saveWinning;
	}
	
	/**
	 * 中红包记录  (分享)
	 * 
	 */
	public int openWineShareRed(ActivityWxUser activityWxUser,OpenWine openWine,OpenWineWxUser openWineWxUser,OpenWineSharePrize openWineSharePrize,String openid,String openWineWinningId,SellerPublicNumber sellerPublicNumber,String accessToken,String joinType){
		//修改该次活动的中奖人数
		String updateOpenWineWinningPensonById= PropKit.use("database.properties").get("updateOpenWineWinningPensonById");
		Db.update(updateOpenWineWinningPensonById,(Integer.parseInt(openWine.getWinningPropleNumber()) + 1)+"",openWine.getId());
		
		DecimalFormat df = new DecimalFormat("##0.00");
		// 红包 保存砸蛋中奖记录 
		int saveWinning = saveOpenWineWinning(openWineWinningId, openWineWxUser.getId(),
				openWineSharePrize.getPrizeType(), openWineSharePrize.getId(),
				openWineSharePrize.getRedMoney(), openWineSharePrize.getPrizeName(),
				uitils.newDate(), openid, "1", openWineSharePrize.getPrizeImg(), "", joinType);
		// 这里是保存开酒瓶中奖记录成功
		if (saveWinning > 0) {
			// 修改开酒瓶活动本次中奖金额或积分值
			Float totalMoney = Float.parseFloat(openWineWxUser.getTotalMoney())+Float.parseFloat(openWineSharePrize.getRedMoney());
			log.error("***totalMoney***"+totalMoney+" ***ID***"+ openWineWxUser.getId());
			//修改中奖信息
//			saveWinning = updateOpenWineWxUserJoinNumberById(df.format(totalMoney), openWineSharePrize.getId(), openWineWxUser.getId());
			boolean update = openWineWxUser.set("ID", openWineWxUser.getId()).set("TOTAL_MONEY", df.format(totalMoney)).set("OPENWINE_PRZIE_ID", openWineSharePrize.getId()).update();
			log.error("***修改开酒瓶微信小活动本次中奖金额或积分值***update："+update);
			if(saveWinning > 0){
//				// 查找是否存在参与的红包获奖记录
				RedWinningInfo rwi = new RedWinningInfo();
				// 没有红包记录 则新增一条红包记录
				// 保存红包中奖记录 因为一个码会中两次奖品，所以不需要上面判断
				rwi = new RedWinningInfo();
				rwi.setId(openWineWinningId);
				rwi.setBelongActivityId(openWine.getId());
				rwi.setActivityName(openWineWxUser.getActivityName());
				rwi.setActivityNameType(PropKit.use("system.properties").get("OpenWine"));
				rwi.setWinningRedTotal(openWineSharePrize.getRedMoney());
				rwi.setCreateTime(uitils.newDate());
				rwi.setState("1");
				rwi.setStartTime(openWine.getStartTime());
				rwi.setEndTime(openWine.getEndTime());
				rwi.setWithdrawals("0");
				rwi.setOpenid(openid);
				rwi.setActivityWxUserId(openWineWxUser.getId());
				rwi.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
				saveWinning = redWinningInfoService.saveRedInfo(rwi);
				if (saveWinning > 0) {
					//总金额
					Float upTotalMoney = Float.parseFloat(activityWxUser.getTotalMoney())+Float.parseFloat(openWineSharePrize.getRedMoney());
					//剩余总金额
					Float surplusTotalMoney = Float.parseFloat(activityWxUser.getSurplusTotalMoney())+Float.parseFloat(openWineSharePrize.getRedMoney());
					//修改该用户个人中心用户的总金额和剩余金额
					boolean update2 = activityWxUser.set("ID", activityWxUser.getId())
					              .set("TOTAL_MONEY", df.format(upTotalMoney))
					              .set("SURPLUS_TOTAL_MONEY", df.format(surplusTotalMoney))
					              .update();
					log.error("***修改该用户个人中心用户的总金额和剩余金额***update2"+update2);
				}
			}
		}
		//发送红包中奖通知
		String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + openWineWxUser.getOpenId();
		//这里推送中奖通知
		Tools.sendWinNotice(openWineWxUser.getOpenId(), sellerPublicNumber, activityUrl, openWine.getActivityName(), openWineSharePrize.getPrizeName(), accessToken);
		return saveWinning;
	}
	
	/**
	 * 修改开酒瓶微信小活动本次中奖金额或积分值
	 */
	public int updateOpenWineWxUserJoinNumberById(String totalMoney,String prizeId,String id){
		String sql = "UPDATE TB_OPENWINE_WXUSER SET TOTAL_MONEY=? WHERE ID= ?";
		return Db.update(sql,totalMoney,id);
	}
	
	/**
	 * 保存开酒瓶中奖记录  中奖的方式是扫码1 2是分享成功的  joinType
	 */
	public int saveOpenWineWinning(String id,String openWineWxUserId,String prizeType,String winningPrizeId,String winningNumber,String prizeName,String createTime,String openid,String state,String productImg,String ProductWinningInfoId,String joinType){
		String sql = PropKit.use("database.properties").get("saveOpenWineWinning");
		return Db.update(sql,id,openWineWxUserId,prizeType,winningPrizeId,winningNumber,prizeName,createTime,openid,state,productImg,ProductWinningInfoId,joinType);
	}
	
	/**
	 * 修改开酒活动剩余参与活动总数
	 */
	public int updateOpenWineTotalById(String activityId,String number){
		String sql = PropKit.use("database.properties").get("updateOpenWineTotalById");
		return Db.update(sql,number,activityId);
	}
	
	/**
	 * 分享成功之后，将该人的JOIN_TYPE_SHARE 置为1 （每个人无论分享几次，该码，只加一次机会）（置为1前判断该用户是否已经分享过了）
	 */
	public int updateJoinTypeShareToOne(String openWineWxId){
		String sql = " UPDATE TB_OPENWINE_WXUSER SET JOIN_TYPE_SHARE = ? WHERE ID = ?  ";
		return Db.update(sql,"1", openWineWxId);
	}
	
	/**
	 * 将该条信息变为已经分享了   是否分享过了 0 未分享  1 分享过了
	 * updateIsShare
	 * @author 81046
	 * @date 2018年6月26日下午3:58:05
	 * @param openWineWxId
	 * @return
	 */
	public int updateIsShare(String openWineWxId){
		String sql = " UPDATE TB_OPENWINE_WXUSER SET IS_SHARE = ? WHERE ID = ?  ";
		return Db.update(sql,"1", openWineWxId);
	}
	
	
	/**
	 * 根据openid查询该用户所中的开酒瓶的中奖信息
	 *  //select t.*, t.rowid from TB_RED_WINNING_INFO t 
	 *  //select * from TB_OPENWINE_WXUSER_WIN t
	 */
	public List<OpenWineWxUserWinning> getOpenWinByOpenId(String openId){
		String sql="select * from TB_OPENWINE_WXUSER_WIN where openid = ? ";
		return OpenWineWxUserWinning.dao.find(sql,openId);
	}
	
	/**
	 * 
	 */
	
	/**
	 * 判断该用户是否分享成功过了  是否分享过了 0 未分享  1 分享过了
	 */
	public boolean isShared(String openWineWxId){
		String shared=null;
		String sql="select IS_SHARE from TB_OPENWINE_WXUSER WHERE OPENWINE_ID = ? ";
		List<Record> list = Db.find(sql);
		for (Record record : list) {
			shared = record.getStr("NICKNAME");
		}
		//0 未分享  1 分享过了
		if(shared.equals("1")){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 1.根据ID修改奖品剩余数量和概率
	 * @param Id
	 * @param Number
	 * @param Probability
	 * @return
	 */
	public int updateWinePrizeNumAndProById(String number,String probability,String prizeId){
		String sql = PropKit.use("database.properties").get("updateWinePrizeNumAndProById");
		return Db.update(sql,number,probability,prizeId);
	}
	
	/**
	 * 开酒瓶奖品集合根据概率和剩余数量生成中奖奖品
	 * @param turnTablePrizeList
	 * @return
	 */
	public Object[] generateWinningPrize(List<OpenWinePrize> winePrizeList ){
		Object[] winningPrize = new Object[2];
		//存储每个奖品新的概率区间
        List<Float> proSection = new ArrayList<Float>();
        proSection.add(0f);
        //总的概率区间
        float totalPro = 0f;
        for (OpenWinePrize ttpBL : winePrizeList) {
        	//当前中奖概率
			String probStr = ttpBL.getSurplusPrizeProbability().indexOf("%") > 0
					? ttpBL.getSurplusPrizeProbability().substring(0, ttpBL.getSurplusPrizeProbability().indexOf("%"))
					: ttpBL.getSurplusPrizeProbability();
        	Float probability = Float.parseFloat(probStr);
            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
            totalPro += probability * 1000 * Integer.parseInt(ttpBL.getSurplusPrizeNumber());
            proSection.add(totalPro);
        }
		//获取总的概率区间中的随机数
        Random random = new Random();
        //记录中奖奖品
        OpenWinePrize winningTurnTablePrize = null;
        float randomPro = (float)random.nextInt((int)totalPro);
		 //判断取到的随机数在哪个奖品的概率区间中
        for (int i = 0,size = proSection.size(); i < size; i++) {
            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
            	winningTurnTablePrize = winePrizeList.get(i);
            	winningPrize[0]=winningTurnTablePrize;
            	winningPrize[1]=i;
            }
        }
        return winningPrize;
	}
	
	
	/**
	 * 开酒瓶分享奖品集合根据概率和剩余数量生成中奖奖品
	 * @param turnTablePrizeList
	 * @return
	 */
	public Object[] generateWinningSharePrize(List<OpenWineSharePrize> winePrizeList ){
		Object[] winningPrize = new Object[2];
		//存储每个奖品新的概率区间
        List<Float> proSection = new ArrayList<Float>();
        proSection.add(0f);
        //总的概率区间
        float totalPro = 0f;
        for (OpenWineSharePrize ttpBL : winePrizeList) {
        	//当前中奖概率
			String probStr = ttpBL.getSurplusPrizeProbability().indexOf("%") > 0
					? ttpBL.getSurplusPrizeProbability().substring(0, ttpBL.getSurplusPrizeProbability().indexOf("%"))
					: ttpBL.getSurplusPrizeProbability();
        	Float probability = Float.parseFloat(probStr);
            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
            totalPro += probability * 1000 * Integer.parseInt(ttpBL.getSurplusPrizeNumber());
            proSection.add(totalPro);
        }
		//获取总的概率区间中的随机数
        Random random = new Random();
        //记录中奖奖品
        OpenWineSharePrize openWineWinSharePrize = null;
        float randomPro = (float)random.nextInt((int)totalPro);
		 //判断取到的随机数在哪个奖品的概率区间中
        for (int i = 0,size = proSection.size(); i < size; i++) {
            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
            	openWineWinSharePrize = winePrizeList.get(i);
            	winningPrize[0]=openWineWinSharePrize;
            	winningPrize[1]=i;
            }
        }
        return winningPrize;
	}
	
	/**
	 * 查询扫码中奖配置信息
	 * getOpenWinePrizeByAId
	 * @author 81046
	 * @date 2018年6月21日下午5:05:45
	 * @param openWineId  参加的开酒瓶的活动的id
	 * @return
	 */
	public List<OpenWinePrize> getOpenWinePrizeByAId(String openWineId){
		String sql="select *  from  TB_OPENWINE_PRIZE where OPENWINE_ID = ? ";
		return OpenWinePrize.dao.find(sql,openWineId);
	}
	
	/**
	 * 查询扫码分享中奖配置信息
	 * getOpenWinePrizeByAId
	 * @author 81046
	 * @date 2018年6月21日下午5:05:45
	 * @param openWineId  参加的开酒瓶的活动的id
	 * @return
	 */
	public List<OpenWineSharePrize> getOpenWineSharePrizeByAId(String openWineId){
		String sql="select *  from  TB_OPENWINE_SHARE_PRIZE where OPENWINE_ID = ? ";
		return OpenWineSharePrize.dao.find(sql,openWineId);
	}
	
	/**
	 * 先查询该用户该码是否已经通过扫码中过奖了
	 * getOpenWineWinByIdOpenId
	 * @author 81046
	 * @date 2018年6月21日下午4:59:42
	 * @param openId
	 * @param openWineWxUserId
	 * @param joinType  中奖的方式是扫码1 2是分享成功的
	 * @return
	 */
	public OpenWineWxUserWinning getOpenWineWinByIdOpenId(String openId,String openWineWxUserId,String joinType){
		//这里查询的是扫码的中奖奖品
		String sql="select * from TB_OPENWINE_WXUSER_WIN where OPENID = ? and OPENWINE_WXUSER_ID = ? and JOIN_TYPE = ?  ";
		return OpenWineWxUserWinning.dao.findFirst(sql,openId,openWineWxUserId , joinType);
	}
	
	public List<OpenWineWxUserWinning> getOpenWineWinListByIdOpenId(String openId,String openWineWxUserId){
		//这里查询的是扫码的中奖奖品
		String sql="select * from TB_OPENWINE_WXUSER_WIN where OPENID = ? and OPENWINE_WXUSER_ID = ? ";
		return OpenWineWxUserWinning.dao.find(sql,openId,openWineWxUserId);
	}
	
	/**
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public OpenWineWxUser getOpenWineByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getOpenWineByOpenidAndQrCode");
		return OpenWineWxUser.dao.findFirst(sql,openid,scanCode);
	}
	
	/**
	 * 根据微信参与用户查询该次中奖的记录
	 */
	public List<OpenWineWxUserWinning> getWinInfoByOpenWineWxId(String openWineWxId){
		String sql="select * from  TB_OPENWINE_WXUSER_WIN  where OPENWINE_WXUSER_ID = ? and WINNING_MONEY > 0 ";
		return OpenWineWxUserWinning.dao.find(sql,openWineWxId);
	}
	
	/**
	 * 提现成功将该条记录的状态修改为提现成功 9提现成功
	 */
	public int updateOpenWinState(String openWinInfoId){
		String sql = " UPDATE TB_OPENWINE_WXUSER_WIN SET STATE = ? WHERE ID = ? and WINNING_MONEY > 0  ";
		return Db.update(sql,"9",openWinInfoId);
	}
	
	/**
	 * 保存开酒活动微信参与记录
	 */
	public int saveOpenWineWxUser(String id,String openWineId,String openId,String nickName,String headImg,
			String createTime,String publicNumber,String scanCode,String activityName,String state){
		String saveSql = PropKit.use("database.properties").get("saveOpenWineWxUser");
		return Db.update(saveSql,id,openWineId,openId,nickName,headImg,createTime,publicNumber,scanCode,activityName,state);
	} 
	
	/**
	 * 修改参与记录状态为已提现
	 */
	public int updateOpenWineState(String id){
		String sql = " UPDATE TB_OPENWINE_WXUSER SET STATE = ? WHERE ID = ?   ";
		return Db.update(sql,"9",id);
	} 
	
	/**
	 * 红包总记录修改参与记录状态为已提现 是否提现0=未提现  1=已提现
	 */
	public int updateRedWinInfoState(String id){
		String sql = " UPDATE TB_RED_WINNING_INFO SET WITHDRAWALS = ? WHERE ID = ?   ";
		return Db.update(sql,"1",id);
	} 
	
	/**
	 * 根据openID查询该微信参与酒瓶活动的头像昵称更新
	 */
	public int updateOpenWxInfoByOpenWxUserId(String nickName,String headImgUrl,String openId){
		String sql="update TB_OPENWINE_WXUSER SET NICKNAME = ? , HEADIMGURL = ? where openid = ? ";
		return Db.update(sql,nickName,headImgUrl,openId);
	}
	
	
	/**
	 * 查询登录人申请的活动
	 */
	public List<OpenWine> getOpenWineAcByUserCode(String userCode){
		String sql="select * from TB_OPENWINE where ACITIVITY_LAUNCH_USERCODE = ?  ";
		return OpenWine.dao.find(sql,userCode);
	}
	
	/**
	 * 查询开酒瓶的中奖红包记录
	 */
	public List<RedWinningInfo> getRedWinList(){
		String sql="select * from TB_RED_WINNING_INFO where ACTIVITY_NAME_TYPE = ?  ";
		return RedWinningInfo.dao.find(sql,"openWine");
	}
	
	/**
	 * 根据活动ID查询该活动的奖金总额
	 */
	public String getTotalMoneyByActivityId(String activityId){
		return OpenWine.dao.findById(activityId).getTotalMoney();
	}
	
	/**
	 * 生成ID 当前毫秒数
	 * 
	 * @param args
	 */
	public static String newId() {
		return UUID.randomUUID().toString().replaceAll("-", "") + newDateByYMD();
	}
	
	/**
	 * 新建时间并格式转换 年月日
	 */
	public static String newDateByYMD() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");
		return time.format(date);
	}
	
	
}
