package com.activity.common.service.breakEgg;

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
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.breakEgg.BreakEgg;
import com.activity.common.model.breakEgg.BreakEggPrize;
import com.activity.common.model.breakEgg.BreakEggWxUser;
import com.activity.common.model.breakEgg.BreakEggWxUserWinning;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
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

/**
 * @author ChenXb
 *
 * 2017年11月6日
 */
public class BreakEggService {
	private static BreakEggService breakEggService = new BreakEggService();
	public BreakEggService() {
	}

	public static BreakEggService getService() {
		return breakEggService;
	}
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	private final Logger log = LoggerFactory.getLogger(BreakEggService.class);
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	IndexService indexService = IndexService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IntegralService integralService = IntegralService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	WxService wxService = WxService.getService();
	
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public synchronized String breakEggActivity(String breakEggActivityID, String qrcode) {
		BreakEgg sb = BreakEgg.dao.findById(breakEggActivityID);
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
			} else {
				// 活动已经开始
				if (endTime) {
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
					// 重定向
					redirect = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + spn.getAppId()
							+ "&redirect_uri=http%3a%2f%2f"+ PropKit.use("system.properties").get("http")
							+ JFinal.me().getContextPath() + "%2fbreakEgg%2fbreakEgg%3fActivity%3d"
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
	 * 输入四位验证码
	 */
	public synchronized Map<String, Object> breakEgg(SellerPublicNumber sellerPublicNumber,String qrcode,String openid,String accessToken,String activityId) {
		Map<String, Object> map = new HashMap<String, Object>();
		String queryBreakEgg = PropKit.use("database.properties").get("queryBreakEgg");
		Record recode = Db.findFirst(queryBreakEgg,activityId);
		BreakEgg breakEgg = new BreakEgg().mapping(recode, new BreakEgg());
		boolean rest = IndexService.getService().queryQrcodeState(qrcode, activityId, openid);
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		// 默认该用户未关注
		String follow = "0";
		if (wxuser.getSubscribe().equals("1")) {
			// 不为空的时候则是获取该用户的关注情况
			follow = wxuser.getSubscribe();
		}
		map.put("follow", follow);
		String breakEggWxUserID;
		// 1=未保存成功 2=二维码已经使用 3=成功
		int resule = 1;
		if (rest) {
			// 判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
			//查询该用户这个码是否
			BreakEggWxUser breakEggWxUser = breakEggService.getBreakEggByOpenidAndQrCode(openid, qrcode);
			if (breakEggWxUser != null) {
				// 已经参加过了,再次进入
				breakEggWxUserID = breakEggWxUser.getId();
			} else {
				// 保存微信用户 现在的流程是不需要关注就可以参与抽奖，所以保存的信息就只有openid
				wxService.noSaveWxUser(wxuser, openid, sellerPublicNumber, newId());
				// 保存用户参加记录
				breakEggWxUserID = newId();
				String nickName = "";
				String headimgurl = "";
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
				int saveCommentWxUser = breakEggService.saveBreakEggWxUser(breakEggWxUserID, activityId, openid, nickName,
						headimgurl, uitils.newDate(), sellerPublicNumber.getId(), qrcode,
						breakEgg.getActivityName(), "1");
				if(saveCommentWxUser>0){
					// 查询出所属运单    没有活动 新建一个二维码失效记录   保存当前所扫二维码已被使用的记录
					Map<String, Object> map1 = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
					//这是开启活动的运单
					ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map1.get("activitySellerInfo");
					int i = indexService.insertAtcitityCode(newId(), qrcode, activitySellerInfo.getSellerOutInfoRecordId().toString(), sellerPublicNumber.getId(), 
							sellerPublicNumber.getPublicNumberName(), breakEggWxUserID, openid, wxuser.getNickname(), wxuser.getHeadimgurl(), 
							PropKit.use("system.properties").get("BreakEgg"),"1", activityId,breakEgg.getActivityName());
					if(i>0){
						int parseInt = Integer.parseInt(breakEgg.getJoinPropleNumber()) + 1;
						String updateBreakEggNumber = PropKit.use("database.properties").get("updateBreakEggNumber");
						saveCommentWxUser = Db.update(updateBreakEggNumber, parseInt + "", breakEgg.getId());
						if (saveCommentWxUser > 0) {
							rest = true;
						} else {
							rest = false;
						}
					}
				}
			}
			resule = 3;
			map.put("breakEgg", breakEgg);
			map.put("openid", openid);
			map.put("wxUserInfo", wxuser);
			map.put("breakEggWxUserId", breakEggWxUserID);
			map.put("sellerPublicNumber", sellerPublicNumber);
		} else {
			// 二维码已经使用
			resule = 2;
		}
		map.put("rest", rest);
		map.put("resule", resule);
		if (resule == 1) {
			map.put("url","404");
		} else if (resule == 2) {
			map.put("url","/index/QRCodeInvalid.html");
		} else if (resule == 3) {
			map.put("url","/breakEgg/breakEgg-homepage.html");
		}
		return map;
	}
	
	/**
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public BreakEggWxUser getBreakEggByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getBreakEggByOpenidAndQrCode");
		return BreakEggWxUser.dao.findFirst(sql,openid,scanCode);
	}
	
	/**
	 * 查询本次扫码中奖的数据
	 */
	public BreakEggWxUserWinning queryBreakEggWxUserWinningByOpenidAndBreakEggWxUserId(String openid , String breakEggWxUserId){
		String sql = PropKit.use("database.properties").get("queryBreakEggWxUserWinningByOpenidAndBreakEggWxUserId");
		return BreakEggWxUserWinning.dao.findFirst(sql,openid,breakEggWxUserId);
	}
	
	
	/**
	 * 保存砸蛋活动用户记录
	 */
	public int saveBreakEggWxUser(String id,String breakEggId,String openId,String nickName,String headImg,
			String createTime,String publicNumber,String scanCode,String activityName,String state){
		String saveSql = PropKit.use("database.properties").get("saveBreakEggWxUser");
		return Db.update(saveSql,id,breakEggId,openId,nickName,headImg,createTime,publicNumber,scanCode,activityName,state);
	}
	
	/**
	 * 根据砸蛋id查找配置的奖品
	 */
	public List<BreakEggPrize> getPrizeByEggId(String eggId){
		//获取该活动配置的奖品
		String sql="select * from TB_BREAK_EGG_PRIZE where EGG_ID = ? ";
		return BreakEggPrize.dao.find(sql,eggId);
	}
	
	/**
	 * 转盘奖品集合根据概率和剩余数量生成中奖奖品
	 * @param turnTablePrizeList
	 * @return
	 */
	public Object[] generateWinningPrize(List<BreakEggPrize> breakEggPrizeList ){
		Object[] winningPrize = new Object[2];
		//存储每个奖品新的概率区间
        List<Float> proSection = new ArrayList<Float>();
        proSection.add(0f);
        //总的概率区间
        float totalPro = 0f;
        for (BreakEggPrize ttpBL : breakEggPrizeList) {
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
        BreakEggPrize winningTurnTablePrize = null;
        float randomPro = (float)random.nextInt((int)totalPro);
		 //判断取到的随机数在哪个奖品的概率区间中
        for (int i = 0,size = proSection.size(); i < size; i++) {
            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
            	winningTurnTablePrize = breakEggPrizeList.get(i);
            	winningPrize[0]=winningTurnTablePrize;
            	winningPrize[1]=i;
            }
        }
        return winningPrize;
	}
	
	/**
	 * 立即砸蛋
	 * @param breakEggWxUserId
	 * @param breakEggId
	 * @param openid
	 * @param sellerPublicNumberId
	 * @param sellerPublicNumber
	 * @param accessToken
	 * @return
	 */
	public synchronized Map<String, Object> breakEggLuckDraw(String breakEggWxUserId,String breakEggId,String openid,String sellerPublicNumberId,SellerPublicNumber sellerPublicNumber,String accessToken){
		Map<String, Object> map = new HashMap<String, Object>();
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// TODO Auto-generated method stub
				//定义实物结果返回
				Boolean result = true;
				Record rec = Db.findFirst(PropKit.use("database.properties").get("getBreakEggWxUserById"),breakEggWxUserId);
				BreakEggWxUser breakEggWxUser = new BreakEggWxUser().mapping(rec, new BreakEggWxUser());
				//查询用户是否存在中奖记录
				String sql = PropKit.use("database.properties").get("queryBreakEggWxUserWinningByOpenidAndBreakEggWxUserId");
				BreakEggWxUserWinning breakEggWxUserWinning = BreakEggWxUserWinning.dao.findFirst(sql,openid,breakEggWxUser.getId());
				if(breakEggWxUserWinning == null){
					//查询出该用户所参加的活动
					String queryBreakEgg = PropKit.use("database.properties").get("queryBreakEgg");
					Record recode = Db.findFirst(queryBreakEgg,breakEggId);
					BreakEgg breakEgg = new BreakEgg().mapping(recode, new BreakEgg());
					//查询出该活动的中奖配置
					List<BreakEggPrize> breakEggPrizeList =getPrizeByEggId(breakEggId);
					//计算出用户的中奖奖品
					Object[] winningPrize = generateWinningPrize(breakEggPrizeList);
					BreakEggPrize winningBreakEggPrize = (BreakEggPrize) winningPrize[0];
					//修改活动中奖人数
					int total = Integer.parseInt(breakEgg.getTotal());
					total = total - 1;
					int i = (int) winningPrize[1];
					log.error("原始中奖数量="+breakEggPrizeList.get(i).getSurplusPrizeNumber());
					//中奖奖品数量减一
					int surplusPrizeNumber = Integer.parseInt(breakEggPrizeList.get(i).getSurplusPrizeNumber())-1;
					log.error("中奖数量="+surplusPrizeNumber);
					breakEggPrizeList.get(i).setSurplusPrizeNumber(surplusPrizeNumber+"");
					//重新计算和保存概率和修改活动获奖人数
					for (BreakEggPrize beprize : breakEggPrizeList) {
						//中奖奖品数量减去后在计算概率
						String newProbability = probabilityUtils.algorithm(Integer.parseInt(beprize.getSurplusPrizeNumber()), total);
						log.error("中奖数量概率="+newProbability+"----"+beprize.getSurplusPrizeNumber());
						//修改剩余奖品数量和概率
						int updateNumAndProbability = updateEggPrizeNumberAndProbabilityById(beprize.getSurplusPrizeNumber(), newProbability, beprize.getId());
						if (updateNumAndProbability > 0) {
							// 修改砸蛋活动剩余参与活动总数
							int updateBreakEggTotal = updateBreakEggTotalById(breakEggId, total + "");
							if (updateBreakEggTotal == 0) {
								result = false;
							}
						}
					}
					//记录中奖-判断奖品数量是否修改成功
					int recordSaveWinning = 0;
					if(result){
						//活动用户信息
						ActivityWxUser activityWxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,sellerPublicNumberId);
						//创建一个用户获奖后记录ID
						String breakEggWinningId = newId();
						// 奖品类型 1实物 2积分 3红包4谢谢惠顾
						if (winningBreakEggPrize.getPrizeType().equals("1")) {
							recordSaveWinning=breakEggGoods(activityWxUser,breakEgg,breakEggWxUser,winningBreakEggPrize,openid,breakEggWinningId,sellerPublicNumber,accessToken);
							/**
							 * 这里修改微信砸蛋用户的中奖详情
							 */
							breakEggWxUser.set("ID", breakEggWxUserId).set("GOODSNUMBER", "1").update();
							log.error("---砸蛋---实物");
						}else if(winningBreakEggPrize.getPrizeType().equals("2")){
							recordSaveWinning=breakEggIntegral(activityWxUser,breakEgg,breakEggWxUser,winningBreakEggPrize,openid,breakEggWinningId,sellerPublicNumber,accessToken);
							breakEggWxUser.set("ID", breakEggWxUserId).set("TOTAL_INTEGRAL", winningBreakEggPrize.getIntegral()).update();
							log.error("---砸蛋---积分");
						}else if(winningBreakEggPrize.getPrizeType().equals("3")){
							recordSaveWinning=breakEggRed(activityWxUser,breakEgg,breakEggWxUser,winningBreakEggPrize,openid,breakEggWinningId,sellerPublicNumber,accessToken);
							breakEggWxUser.set("ID", breakEggWxUserId).set("TOTAL_MONEY", winningBreakEggPrize.getRedMoney()).update();
							log.error("---砸蛋---红包");
						}else if (winningBreakEggPrize.getPrizeType().equals("4")) {
							log.error("---砸蛋---谢谢惠顾");
							breakEggWxUser.set("ID", breakEggWxUserId).set("THANKNUMBER", "1").update();
							// 谢谢惠顾
							recordSaveWinning = saveBreakEggWinning(breakEggWinningId, breakEggWxUserId,
									winningBreakEggPrize.getPrizeType(), winningBreakEggPrize.getId(), "0",
									winningBreakEggPrize.getPrizeName(), uitils.newDate(), openid, "1",
									winningBreakEggPrize.getPrizeImg(), "");
							if (recordSaveWinning > 0) {
								recordSaveWinning = updateBreakEggWxUserJoinNumberById(
										breakEggWxUser.getTotalMoney(), breakEggWxUser.getTotalIntegral(),
										Integer.parseInt(breakEggWxUser.getThankNumber()) + 1 + "",
										breakEggWxUser.getGoodsNumber(), winningBreakEggPrize.getId(),
										breakEggWxUser.getId());
							}
						}
						//根据ScanCode修改当前二维码中奖情况+事物
						indexService.updateWinningByScanCode(breakEggWxUserId,winningBreakEggPrize.getPrizeType(),breakEggWinningId,breakEggWxUser.getScanCode());
						map.put("breakEggWinningId", breakEggWinningId);
					}
					map.put("winningBreakEggPrize", winningBreakEggPrize);
					breakEggWxUser.set("ID", breakEggWxUser.getId()).set("ISCLICK", 1).update();
				}else{
					result = true;
				}
				return result;
			}
		});
		log.error("---砸蛋---返回"+map.toString());
		return map;
	}
	
	/**
	 * 砸蛋中实物
	 */
	public int breakEggGoods(ActivityWxUser activityWxUser,BreakEgg breakEgg,BreakEggWxUser breakEggWxUser,BreakEggPrize breakEggPrize,String openid,String breakEggWinningId,SellerPublicNumber sellerPublicNumber,String accessToken){
		//修改活动中累计获奖人数
		String updateBreakEggWinningPensonByIdSql= PropKit.use("database.properties").get("updateBreakEggWinningPensonById");
		Db.update(updateBreakEggWinningPensonByIdSql,Integer.parseInt(breakEgg.getWinningPropleNumber()) + 1,breakEgg.getId());
		//保存一个实物中奖信息
		String productWinningInfoId = newId();
		ProductWinningInfo productWinningInfo = new ProductWinningInfo();
		productWinningInfo.setId(productWinningInfoId);
		productWinningInfo.setBelongActivityId(breakEgg.getId());
		productWinningInfo.setActivityName(breakEgg.getActivityName());
		productWinningInfo.setActivityNameType(PropKit.use("system.properties").get("BreakEgg"));
		productWinningInfo.setProductId("");
		productWinningInfo.setProductName(breakEggPrize.getPrizeName());
		productWinningInfo.setProductImg(breakEggPrize.getPrizeImg());
		productWinningInfo.setActivityPrizeId(breakEggPrize.getId());
		productWinningInfo.setCreateTime(uitils.newDate());
		productWinningInfo.setStartTime(breakEgg.getStartTime());
		productWinningInfo.setEndTime(breakEgg.getEndTime());
		productWinningInfo.setOpenId(openid);
		productWinningInfo.setActivityWxUserId(breakEggWxUser.getId());
		productWinningInfo.setBelongPublicNumberId(activityWxUser.getBelongPublicNumberId());
		productWinningInfo.setState("2");
		productWinningInfo.setWinningInfoId(breakEggWinningId);
		productWinningInfo.setPayMoney("0");
		productWinningInfo.setPrice("0");
		productWinningInfo.setLowPrice("0");
		int saveWinning = productWinningInfoService.saveProductWinningInfo(productWinningInfo);
		if (saveWinning > 0) {
			// 保存砸蛋中奖记录
			saveWinning = saveBreakEggWinning(breakEggWinningId, breakEggWxUser.getId(),
					breakEggPrize.getPrizeType(), breakEggPrize.getId(), "0",
					breakEggPrize.getPrizeName(), uitils.newDate(), openid, "2",
					breakEggPrize.getPrizeImg(), productWinningInfoId);
			if (saveWinning > 0) {
				// 修改砸蛋活动本次中奖金额或积分值
				saveWinning = updateBreakEggWxUserJoinNumberById(
						breakEggWxUser.getTotalMoney(), breakEggWxUser.getTotalIntegral(),
						breakEggWxUser.getThankNumber(),
						Integer.parseInt(breakEggWxUser.getGoodsNumber()) + 1 + "",
						breakEggPrize.getId(), breakEggWxUser.getId());
			}
		}
		String activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + breakEggWxUser.getOpenId()+ "%26selectedVal%3d" + "";
		//这里推送中奖通知  实物
		Tools.sendWinNotice(breakEggWxUser.getOpenId(), sellerPublicNumber, activityUrl, breakEgg.getActivityName(), breakEggPrize.getPrizeName(), accessToken);
		return saveWinning;
	}
	
	/**
	 * 砸蛋中积分
	 */
	public int breakEggIntegral(ActivityWxUser activityWxUser,BreakEgg breakEgg,BreakEggWxUser breakEggWxUser,BreakEggPrize breakEggPrize,String openid,String breakEggWinningId,SellerPublicNumber sellerPublicNumber,String accessToken){
		//修改活动中累计获奖人数
		String updateBreakEggWinningPensonByIdSql= PropKit.use("database.properties").get("updateBreakEggWinningPensonById");
		Db.update(updateBreakEggWinningPensonByIdSql,Integer.parseInt(breakEgg.getWinningPropleNumber()) + 1,breakEgg.getId());
		// 查询是否存在参与的积分获奖记录
		IntegralWinningInfo integralWinningInfo = IntegralService.queryIntegralWinningInfo(breakEgg.getId(), breakEggWxUser.getId(), openid);
		// 保存砸蛋中奖的记录
		int saveWinning = saveBreakEggWinning(breakEggWinningId, breakEggWxUser.getId(),
				breakEggPrize.getPrizeType(), breakEggPrize.getId(),
				breakEggPrize.getIntegral(), breakEggPrize.getPrizeName(),
				uitils.newDate(), openid, "1", breakEggPrize.getPrizeImg(), "");
		if (saveWinning > 0) {
			// 修改砸蛋活动剩余可抽奖次数和本次中奖金额或积分值
			saveWinning =updateBreakEggWxUserJoinNumberById(breakEggWxUser.getTotalMoney(),
					Integer.parseInt(breakEggWxUser.getTotalIntegral())+ Integer.parseInt(breakEggPrize.getIntegral()) + "",
					breakEggWxUser.getThankNumber(), breakEggWxUser.getGoodsNumber(),
					breakEggPrize.getId(), breakEggWxUser.getId());
			if(saveWinning > 0){
				//是否存在中获奖记录
				if (integralWinningInfo!=null) {
					// 修改中奖积分
					saveWinning = integralService.updateIntegralWinningInfoByIntegralNumber(
							Integer.parseInt(integralWinningInfo.getWinningIntegral())+ Integer.parseInt(breakEggPrize.getIntegral()),integralWinningInfo.getId());
				}else {
					integralWinningInfo = new IntegralWinningInfo();
					integralWinningInfo.setId(newId());
					integralWinningInfo.setBelongActivityId(breakEgg.getId());
					integralWinningInfo.setActivityName(breakEgg.getActivityName());
					integralWinningInfo.setActivityNameType(PropKit.use("system.properties").get("BreakEgg"));
					integralWinningInfo.setWinningIntegral(breakEggPrize.getIntegral());
					integralWinningInfo.setCreateTime(uitils.newDate());
					integralWinningInfo.setStartTime("0");
					integralWinningInfo.setEndTime("0");
					integralWinningInfo.setOpenid(openid);
					integralWinningInfo.setActivityWxUserId(breakEggWxUser.getId());
					integralWinningInfo.setBelongPublicnumberId(sellerPublicNumber.getId());
					integralService.saveIntegralWinningInfo(integralWinningInfo);
				}
			}
		}
		if(saveWinning>0){
			//修改当前用户系统记录中的信息
			int totalIntegral = Integer.parseInt(activityWxUser.getTotalIntegral())+Integer.parseInt(breakEggPrize.getIntegral());
			int surplusTotalIntegral = Integer.parseInt(activityWxUser.getSurplusTotalIntegral())+Integer.parseInt(breakEggPrize.getIntegral());
			saveWinning = indexService.updateWxUserIntegralAndMoneyById(totalIntegral+"",surplusTotalIntegral+"",activityWxUser.getTotalMoney(),activityWxUser.getSurplusTotalMoney(), activityWxUser.getId());
			String activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + breakEggWxUser.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
			//这里推送中奖通知  积分
			Tools.sendWinNotice(breakEggWxUser.getOpenId(), sellerPublicNumber, activityUrl, breakEgg.getActivityName(), breakEggPrize.getPrizeName(), accessToken);
		}
		return saveWinning;
	}
	
	/**
	 * 砸蛋中红包
	 */
	public int breakEggRed(ActivityWxUser activityWxUser,BreakEgg breakEgg,BreakEggWxUser breakEggWxUser,BreakEggPrize breakEggPrize,String openid,String breakEggWinningId,SellerPublicNumber sellerPublicNumber,String accessToken){
		//修改活动中累计获奖人数
		String updateBreakEggWinningPensonByIdSql= PropKit.use("database.properties").get("updateBreakEggWinningPensonById");
		Db.update(updateBreakEggWinningPensonByIdSql,Integer.parseInt(breakEgg.getWinningPropleNumber()) + 1,breakEgg.getId());
		DecimalFormat df = new DecimalFormat("##0.00");
		// 红包 保存砸蛋中奖记录
		int saveWinning = saveBreakEggWinning(breakEggWinningId, breakEggWxUser.getId(),
				breakEggPrize.getPrizeType(), breakEggPrize.getId(),
				breakEggPrize.getRedMoney(), breakEggPrize.getPrizeName(),
				uitils.newDate(), openid, "1", breakEggPrize.getPrizeImg(), "");
		// 这里是保存砸蛋中奖记录成功
		if (saveWinning > 0) {
			// 修改砸蛋活动本次中奖金额或积分值
			Float totalMoney = Float.parseFloat(breakEggWxUser.getTotalMoney())+Float.parseFloat(breakEggPrize.getRedMoney());
			saveWinning = updateBreakEggWxUserJoinNumberById(df.format(totalMoney),
					breakEggWxUser.getTotalIntegral(), breakEggWxUser.getThankNumber(),
					breakEggWxUser.getGoodsNumber(), breakEggPrize.getId(), breakEggWxUser.getId());
			if(saveWinning > 0){
				// 查找是否存在参与的红包获奖记录
				RedWinningInfo rwi = redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(breakEgg.getId(),openid, PropKit.use("system.properties").get("BreakEgg"), breakEggWxUser.getId());
				// 没有红包记录 则新增一条红包记录
				if (rwi == null) {
					// 保存红包中奖记录
					rwi = new RedWinningInfo();
					rwi.setId(newId());
					rwi.setBelongActivityId(breakEgg.getId());
					rwi.setActivityName(breakEggWxUser.getActivityName());
					rwi.setActivityNameType(PropKit.use("system.properties").get("BreakEgg"));
					rwi.setWinningRedTotal(breakEggPrize.getRedMoney());
					rwi.setCreateTime(uitils.newDate());
					rwi.setState("1");
					rwi.setStartTime(breakEgg.getStartTime());
					rwi.setEndTime(breakEgg.getEndTime());
					rwi.setWithdrawals("0");
					rwi.setOpenid(openid);
					rwi.setActivityWxUserId(breakEggWxUser.getId());
					rwi.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
					saveWinning = redWinningInfoService.saveRedInfo(rwi);
				} else {
					Float winningRedTotal = Float.parseFloat(rwi.getWinningRedTotal())+Float.parseFloat(breakEggPrize.getRedMoney());
					saveWinning = redWinningInfoService.updateRedInfo("1", df.format(winningRedTotal),breakEgg.getActivityName(), rwi.getId());
					if(saveWinning > 0){
						saveWinning = redWinningInfoService.updateRedInfoByState("1", rwi.getId());
						if (!breakEggPrize.getPrizeType().equals("3")) {
							// 最后的中奖不是红包中奖，将之前红包中奖修改已完成，累加值微信用户可提现金额中，如果最后一次扫码中奖红包已经累加
							Float surplusTotalMoney = Float.parseFloat(activityWxUser.getSurplusTotalMoney())
									+ Float.parseFloat(rwi.getWinningRedTotal());
							saveWinning = indexService.updateWxUserIntegralAndMoneyById(
									activityWxUser.getTotalIntegral(), activityWxUser.getSurplusTotalIntegral(),
									activityWxUser.getTotalMoney(), df.format(surplusTotalMoney),
									activityWxUser.getId());
						}
					}
				}
				if (saveWinning > 0) {
					Float upTotalMoney = Float.parseFloat(activityWxUser.getTotalMoney())+Float.parseFloat(breakEggPrize.getRedMoney());
					Float surplusTotalMoney = Float.parseFloat(activityWxUser.getSurplusTotalMoney())+Float.parseFloat(rwi.getWinningRedTotal());
					saveWinning = indexService.updateWxUserIntegralAndMoneyById(
							activityWxUser.getTotalIntegral(), activityWxUser.getSurplusTotalIntegral(),
							df.format(upTotalMoney), df.format(surplusTotalMoney), activityWxUser.getId());
				}
			}
		}
		//发送红包中奖通知
		String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + breakEggWxUser.getOpenId();
		//这里推送中奖通知
		Tools.sendWinNotice(breakEggWxUser.getOpenId(), sellerPublicNumber, activityUrl, breakEgg.getActivityName(), breakEggPrize.getPrizeName(), accessToken);
		return saveWinning;
	}
	
	/**
	 * 1.根据ID修改奖品剩余数量和概率
	 * @param Id
	 * @param Number
	 * @param Probability
	 * @return
	 */
	public int updateEggPrizeNumberAndProbabilityById(String number,String probability,String prizeId){
		String sql = PropKit.use("database.properties").get("updateEggPrizeNumberAndProbabilityById");
		return Db.update(sql,number,probability,prizeId);
	}
	
	/**
	 * 修改转盘活动剩余参与活动总数
	 */
	public int updateBreakEggTotalById(String activityId,String number){
		String sql = PropKit.use("database.properties").get("updateBreakEggTotalById");
		return Db.update(sql,number,activityId);
	}
	
	/**
	 * 保存砸蛋中奖记录
	 */
	public int saveBreakEggWinning(String id,String breakEggWxUserId,String prizeType,String winningPrizeId,String winningNumber,String prizeName,String createTime,String openid,String state,String productImg,String ProductWinningInfoId){
		String sql = PropKit.use("database.properties").get("saveBreakEggWinning");
		return Db.update(sql,id,breakEggWxUserId,prizeType,winningPrizeId,winningNumber,prizeName,createTime,openid,state,productImg,ProductWinningInfoId);
	}
	
	/**
	 * 修改砸蛋活动本次中奖金额或积分值
	 */
	public int updateBreakEggWxUserJoinNumberById(String totalMoney,String totalIntegral,String thankNum,String goodsNum,String prizeId,String id){
		String sql = PropKit.use("database.properties").get("updateBreakEggWxUserJoinNumberById");
		return Db.update(sql,totalMoney,totalIntegral,thankNum,goodsNum,prizeId,id);
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
