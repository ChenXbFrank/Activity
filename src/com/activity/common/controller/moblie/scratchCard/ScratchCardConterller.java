package com.activity.common.controller.moblie.scratchCard;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.scratchCard.ScratchCard;
import com.activity.common.model.scratchCard.ScratchCardPrize;
import com.activity.common.model.scratchCard.ScratchCardWxUser;
import com.activity.common.model.scratchCard.ScratchCardWxUserWinning;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
import com.activity.common.service.scratchCard.ScratchCardService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.probability.ProbabilityUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.controller.ControllerPath;

/**
 * 刮刮乐
 * 
 * @author 唐
 *
 */
@ControllerPath(controllerKey = "/scratchCard")
public class ScratchCardConterller extends BaseController {
	ScratchCardService scratchCardSrevice = ScratchCardService.getService();
	WxService wxService = WxService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ProbabilityUtils probabilityUtils = ProbabilityUtils.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	IndexService indexService = IndexService.getService();
	IntegralService integralService = IntegralService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	/**
	 * 进入刮刮卡活动
	 */
	public void scratchCard() {
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				// 公众号ID
				String sellerPublicNumberId = getPara("spn");
				// 活动ID
				String activity = getPara("Activity");
				// 所扫二维码
				String qrcode = getPara("qrcode");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
				String openid = getOpenid(sellerPublicNumber);
				WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
				ApiConfigKit.removeThreadLocalAppId();
				// 查询当前二维码是否已参加活动
				ActivityCode ac = IndexService.getService().getCodeByCodeAndActivity(qrcode, activity);
				boolean rest = false;
				if (ac!=null) {// 说明有活动
					if (ac.getOpenId().equals(openid)) {
						// 自己进来查看，可以查看，但不用新建一个二维码失效记录
						rest = true;
					} else {
						rest = false;
					}
				} else {
					rest = true;
				}
				// 1=未保存成功 2=二维码已经使用 3=成功
				int resule = 1;
				if (rest) {
					String scanWinningNumber = "";
					String WxUserId = "";
					// 判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
					List<ScratchCardWxUser> scratchCardWxUserList = scratchCardSrevice.getScratchCardByOpenidAndQrCode(openid, qrcode);
					ScratchCard scratchCard = ScratchCard.dao.findById(activity);
					// 默认该用户未关注
					String follow = "0";
					if (wxuser.getSubscribe().equals("1")) {
						// 不为空的时候则是获取该用户的关注情况
						follow = wxuser.getSubscribe();
					}
					setAttr("follow", follow);
					if (scratchCardWxUserList.size() > 0) {
						// 已经参加过了,再次进入
						for (ScratchCardWxUser scratchCardWxUserBL : scratchCardWxUserList) {
							WxUserId = scratchCardWxUserBL.getScratchCardWxuserId();
							scanWinningNumber = scratchCardWxUserBL.getScanWinningNumber();
						}
					} else {
						WxUserId = newId();
						// 第一次扫码进入
						// 保存微信用户 现在的流程是不需要关注就可以参与抽奖，所以保存的信息就只有openid
						wxService.noSaveWxUser(wxuser, openid, sellerPublicNumber, newId());
						scanWinningNumber = scratchCard.getScanNumber();
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
						// 保存刮刮乐活动用户参加记录
						rest = new ScratchCardWxUser().set("SCRATCHCARD_WXUSER_ID", WxUserId)
								.set("SCRATCHCARD_ID", activity).set("ACTIVITY_NAME", scratchCard.getActivityName())
								.set("OPENID", openid).set("NICKNAME", nickName)
								.set("HEADIMGURL", headimgurl)
								.set("BELONG_PUBLICNUMBER_ID", sellerPublicNumberId)
								.set("CREATE_TIME", uitils.newDate()).set("STATE", "0").set("SCAN_CODE", qrcode)
								.set("SCAN_WINNING_NUMBER", scanWinningNumber).save();
						// 查询出所属运单   没有活动 新建一个二维码失效记录   保存当前所扫二维码已被使用的记录
						Map<String, Object> map = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
						//这是开启活动的运单
						ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map.get("activitySellerInfo");
						String mark = PropKit.use("system.properties").get("ScratchCard");
						rest = new ActivityCode().set("ID", newId()).set("CODE", qrcode).set("SELLEROUTINFO_RECORDID", activitySellerInfo.getSellerOutInfoRecordId())
								.set("ACTIVITYNAME", scratchCard.getActivityName()).set("SELLERPUBLICID", sellerPublicNumber.getId()).set("SELLERPUBLICNAME", sellerPublicNumber.getPublicNumberName()).set("ACTIVITY_WXID", WxUserId).set("OPENID", openid).set("NICKNAME", nickName).set("HEADIMG", headimgurl).set("MARK", mark).set("SING_NUMBER", "1").set("ACTIVITY_ID", activity).save();
						//将活动的参与人数+1
						String joinPropleNumber = scratchCard.getJoinPropleNumber();
						int joinNum=Integer.parseInt(joinPropleNumber)+1;
						//这里将参与的人数+1
						scratchCard.set("SCRATCHCARD_ID", activity).set("JOIN_PROPLE_NUMBER", joinNum+"").update();
					}
					resule = 3;
					List<ScratchCardPrize> scratchCardPrizeList = scratchCardSrevice
							.getScratchCardPrizeByScratchCardId(activity);
					ScratchCardWxUser scratchCardWxUser = ScratchCardWxUser.dao.findById(WxUserId);
					setAttr("wxUserInfo", wxuser);
					setAttr("scanWinningNumber", scanWinningNumber);
					setAttr("qrcode", qrcode);
					setAttr("scratchCard", scratchCard);
					setAttr("openid", openid);
					setAttr("scratchCardPrizeList", scratchCardPrizeList);
					setAttr("scratchCardWxUser", scratchCardWxUser);
					setAttr("sellerPublicNumber", sellerPublicNumber);
				} else {
					// 二维码已经使用
					resule = 2;
				}
				if (resule == 1) {
					renderError(404);
				} else if (resule == 2) {
					render("/index/QRCodeInvalid.html");
				} else if (resule == 3) {
					render("/scratchCard/scratch-homepage.html");
				}
				return rest;
			}
		});
	}

	
	
	
	/**
	 * 刮刮乐--刮奖
	 */
	public void scratchCardLuckDraw() {
		Map<String, Object> map = new HashMap<String, Object>();
		String openid = getPara("openid");
		Db.tx(new IAtom() {
			@Override
			public boolean run() throws SQLException {
				boolean resutl = false;
				// 所参加活动ID
				String scratchCardId = getPara("activityId");
				// 公众号ID
				String sellerPublicNumberId = getPara("sellerPublicNumberId");
				SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
				String scratchCardWxUserId = getPara("scratchCardWxUserId");
				Record rec = Db.findFirst(PropKit.use("database.properties").get("getScratchCardWxUserById"),scratchCardWxUserId);//RobRedWxUser.dao.findById(redWxUserId);
				ScratchCardWxUser scratchCardWxUser = new ScratchCardWxUser().mapping(rec, new ScratchCardWxUser());
				//这里是处理扫码分析数据**************
				String scanCode = scratchCardWxUser.getScanCode();
				//根据扫描的二维码查找出该二维码的参与情况
				String codeSql="select * from ACTIVITY_CODE where CODE =?";
				ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
				String winId="";
				String winType="";
				//以上查找出该码参与的情况*************
				if (!scratchCardWxUser.getScanWinningNumber().equals("0")) {
					// 修改用户参与转盘中奖纪录剩余抽奖次数
					int surplusScanWinningNumber = Integer.parseInt(scratchCardWxUser.getScanWinningNumber()) - 1;
					// 格式化小数
					DecimalFormat df = new DecimalFormat("##0.00");
					ScratchCard scratchCard = ScratchCard.dao.findById(scratchCardId);
					int winningPropleNumber =Integer.parseInt(scratchCard.getWinningPropleNumber());
					// 剩余总瓶数
					int bottleTotal = Integer.parseInt(scratchCard.getTotal());
					List<ScratchCardPrize> scratchCardPrizeList = scratchCardSrevice
							.getScratchCardPrizeByScratchCardId(scratchCardId);
					// 生产中奖奖品
					Object[] winningPrize = scratchCardSrevice.generateWinningPrize(scratchCardPrizeList);
					// 所中奖品
					ScratchCardPrize winningScratchCardPrize = (ScratchCardPrize) winningPrize[0];
					map.put("winningScratchCardPrize", winningScratchCardPrize);
					// 所中奖品属于集合第几个
					int i = (int) winningPrize[1];
					// 将单个中奖奖品数量减一
					scratchCardPrizeList.get(i).setSurplusPrizeNumber(
							Integer.parseInt(scratchCardPrizeList.get(i).getSurplusPrizeNumber()) - 1 + "");
					// 总瓶数减去一个
					bottleTotal = bottleTotal - 1;
					// 从新计算和保存概率
					for (ScratchCardPrize scratchCardBL : scratchCardPrizeList) {
						String newProbability = probabilityUtils
								.algorithm(Integer.parseInt(scratchCardBL.getSurplusPrizeNumber()), bottleTotal);
						int updateTrunPrize = scratchCardSrevice.updatePrizeNumberAndProbabilityById(
								scratchCardBL.getScratchCardPrizeId(), scratchCardBL.getSurplusPrizeNumber(),
								newProbability);
						if (updateTrunPrize > 0) {
							int updateTurnTableTotal = scratchCardSrevice.updateScratchCardTotalById(scratchCardId,
									bottleTotal + "", Integer.parseInt(scratchCard.getJoinPropleNumber()),
									Integer.parseInt(scratchCard.getWinningPropleNumber()));
							if (updateTurnTableTotal > 0) {
								resutl = true;
							} else {
								resutl = false;
							}
						}
					}
					int saveWinning = 0;
					if (resutl) {
						ActivityWxUser activityWxUser = indexService.queryUserByOpenidAndPublicNumberId(openid,
								sellerPublicNumberId);
						// 查找是否存在参与的红包获奖记录
						RedWinningInfo rwi = redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(scratchCardId,
								openid, PropKit.use("system.properties").get("ScratchCard"), scratchCardWxUserId);
						// 查询是否存在参与的积分获奖记录
						IntegralWinningInfo integralWinningInfoL = IntegralService
								.queryIntegralWinningInfo(scratchCardId, scratchCardWxUserId, openid);
						if (winningScratchCardPrize.getPrizeType().equals("2")) {
							String scanwinId=newId();
							saveWinning = scratchCardSrevice.saveScratchCardWinning(scanwinId, scratchCardWxUserId,
									winningScratchCardPrize.getPrizeType(),
									winningScratchCardPrize.getScratchCardPrizeId(),
									winningScratchCardPrize.getIntegralNumber(), winningScratchCardPrize.getPrizeName(),
									uitils.newDate(), openid, "1", winningScratchCardPrize.getPrizeImg(), "");
	        				winId=scanwinId;
	        				winType="2";
	        				winningPropleNumber=winningPropleNumber+1;
							if (saveWinning > 0) {
								saveWinning = scratchCardSrevice.updateScratchCardWxUserJoinNumberById(
										surplusScanWinningNumber + "", scratchCardWxUser.getTotalMoney(),
										Integer.parseInt(scratchCardWxUser.getTotalIntegral())
												+ Integer.parseInt(winningScratchCardPrize.getIntegralNumber()) + "",
										scratchCardWxUser.getScratchCardWxuserId(),
										Integer.parseInt(scratchCardWxUser.getIntegralWinningNumber()) + 1 + "",
										scratchCardWxUser.getRedWinningNumber(),
										scratchCardWxUser.getGoodsWinningNumber(),
										scratchCardWxUser.getThinkWinningNumber());
							}
							if (integralWinningInfoL!=null) {
								saveWinning = integralService.updateIntegralWinningInfoByIntegralNumber(
										Integer.parseInt(integralWinningInfoL.getWinningIntegral())
												+ Integer.parseInt(winningScratchCardPrize.getIntegralNumber()),
												integralWinningInfoL.getId());
							} else {
								IntegralWinningInfo integralWinningInfo = new IntegralWinningInfo();
								integralWinningInfo.setId(newId());
								integralWinningInfo.setBelongActivityId(scratchCardId);
								integralWinningInfo.setActivityName(scratchCard.getActivityName());
								integralWinningInfo
										.setActivityNameType(PropKit.use("system.properties").get("ScratchCard"));
								integralWinningInfo.setWinningIntegral(winningScratchCardPrize.getIntegralNumber());
								integralWinningInfo.setCreateTime(uitils.newDate());
								integralWinningInfo.setStartTime("0");
								integralWinningInfo.setEndTime("0");
								integralWinningInfo.setOpenid(openid);
								integralWinningInfo.setActivityWxUserId(scratchCardWxUserId);
								integralWinningInfo.setBelongPublicnumberId(sellerPublicNumberId);
								integralService.saveIntegralWinningInfo(integralWinningInfo);
							}
							int totalIntegral = Integer.parseInt(activityWxUser.getTotalIntegral())
									+ Integer.parseInt(winningScratchCardPrize.getIntegralNumber());
							int surplusTotalIntegral = Integer.parseInt(activityWxUser.getSurplusTotalIntegral())
									+ Integer.parseInt(winningScratchCardPrize.getIntegralNumber());
							saveWinning = indexService.updateWxUserIntegralAndMoneyById(totalIntegral + "",
									surplusTotalIntegral + "", activityWxUser.getTotalMoney(),
									activityWxUser.getSurplusTotalMoney(), activityWxUser.getId());
							//发送中奖积分通知
            				String activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + scratchCardWxUser.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
            				ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
            				Tools.sendWinNotice(scratchCardWxUser.getOpenId(), sellerPublicNumber, activityUrl, scratchCard.getActivityName(), winningScratchCardPrize.getPrizeName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
            				ApiConfigKit.removeThreadLocalAppId();
						} else if (winningScratchCardPrize.getPrizeType().equals("1")) {
							String turnTableTotalWinningId = newId();
							String productWinningInfoId = newId();
							// 保存一个实物中奖信息
							ProductWinningInfo productWinningInfo = new ProductWinningInfo();
							productWinningInfo.setId(productWinningInfoId);
							productWinningInfo.setBelongActivityId(scratchCardId);
							productWinningInfo.setActivityName(scratchCard.getActivityName());
							productWinningInfo.setActivityNameType(PropKit.use("system.properties").get("ScratchCard"));
							productWinningInfo.setProductId("");
							productWinningInfo.setProductName(winningScratchCardPrize.getPrizeName());
							productWinningInfo.setProductImg(winningScratchCardPrize.getPrizeImg());
							productWinningInfo.setActivityPrizeId(winningScratchCardPrize.getScratchCardPrizeId());
							productWinningInfo.setCreateTime(uitils.newDate());
							productWinningInfo.setStartTime(scratchCard.getStartTime());
							productWinningInfo.setEndTime(scratchCard.getEndTime());
							productWinningInfo.setOpenId(openid);
							productWinningInfo.setActivityWxUserId(scratchCardWxUserId);
							productWinningInfo.setBelongPublicNumberId(activityWxUser.getBelongPublicNumberId());
							productWinningInfo.setState("2");
							productWinningInfo.setPayMoney("0");
							productWinningInfo.setPrice("0");
							productWinningInfo.setLowPrice("0");
							productWinningInfo.setWinningInfoId(turnTableTotalWinningId);
							saveWinning = productWinningInfoService.saveProductWinningInfo(productWinningInfo);
							if (saveWinning > 0) {
								saveWinning = scratchCardSrevice.saveScratchCardWinning(turnTableTotalWinningId,
										scratchCardWxUserId, winningScratchCardPrize.getPrizeType(),
										winningScratchCardPrize.getScratchCardPrizeId(), "0",
										winningScratchCardPrize.getPrizeName(), uitils.newDate(), openid, "2",
										winningScratchCardPrize.getPrizeImg(), productWinningInfoId);
								//这里修改中奖的类型和id********************这里是保存的刮刮乐的实物奖品信息
								winId=turnTableTotalWinningId;
		        				winType="1";
		        				winningPropleNumber=winningPropleNumber+1;
								if (saveWinning > 0) {
									saveWinning = scratchCardSrevice.updateScratchCardWxUserJoinNumberById(
											surplusScanWinningNumber + "", scratchCardWxUser.getTotalMoney(),
											scratchCardWxUser.getTotalIntegral(),
											scratchCardWxUser.getScratchCardWxuserId(),
											scratchCardWxUser.getIntegralWinningNumber(),
											scratchCardWxUser.getRedWinningNumber(),
											Integer.parseInt(scratchCardWxUser.getGoodsWinningNumber()) + 1 + "",
											scratchCardWxUser.getThinkWinningNumber());
								}
							}
							//发送实物中奖通知
							String activityUrl="%2fpersonalCenter%2fmyPrize%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + scratchCardWxUser.getOpenId()+ "%26selectedVal%3d" + "";
							ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
							Tools.sendWinNotice(scratchCardWxUser.getOpenId(), sellerPublicNumber, activityUrl, scratchCard.getActivityName(), winningScratchCardPrize.getPrizeName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
							ApiConfigKit.removeThreadLocalAppId();
						} else if (winningScratchCardPrize.getPrizeType().equals("3")) {
							String newId=newId();
							// 红包
							saveWinning = scratchCardSrevice.saveScratchCardWinning(newId, scratchCardWxUserId,
									winningScratchCardPrize.getPrizeType(),
									winningScratchCardPrize.getScratchCardPrizeId(),
									winningScratchCardPrize.getRedNumber(), winningScratchCardPrize.getPrizeName(),
									uitils.newDate(), openid, "1", winningScratchCardPrize.getPrizeImg(), "");
							winId=newId;
	        				winType="3";
	        				winningPropleNumber=winningPropleNumber+1;
							if (saveWinning > 0) {
								// 修改用户参与转盘中奖纪录剩余抽奖次数
								Float totalMoney = Float.parseFloat(scratchCardWxUser.getTotalMoney())
										+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
								saveWinning = scratchCardSrevice.updateScratchCardWxUserJoinNumberById(
										surplusScanWinningNumber + "", df.format(totalMoney),
										scratchCardWxUser.getTotalIntegral(),
										scratchCardWxUser.getScratchCardWxuserId(),
										scratchCardWxUser.getIntegralWinningNumber(),
										Integer.parseInt(scratchCardWxUser.getRedWinningNumber()) + 1 + "",
										scratchCardWxUser.getGoodsWinningNumber(),
										scratchCardWxUser.getThinkWinningNumber());
							}
							if (rwi == null) {
								// 保存红包中奖记录
								RedWinningInfo redWinningInfo = new RedWinningInfo();
								redWinningInfo.setId(newId());
								redWinningInfo.setBelongActivityId(scratchCardId);
								redWinningInfo.setActivityName(scratchCard.getActivityName());
								redWinningInfo.setActivityNameType(PropKit.use("system.properties").get("ScratchCard"));
								redWinningInfo.setWinningRedTotal(winningScratchCardPrize.getRedNumber());
								redWinningInfo.setCreateTime(uitils.newDate());
								if (surplusScanWinningNumber == 0) {
									redWinningInfo.setState("1");
								} else {
									redWinningInfo.setState("0");
								}
								redWinningInfo.setStartTime(scratchCard.getStartTime());
								redWinningInfo.setEndTime(scratchCard.getEndTime());
								redWinningInfo.setWithdrawals("0");
								redWinningInfo.setOpenid(openid);
								redWinningInfo.setActivityWxUserId(scratchCardWxUserId);
								redWinningInfo.setBelongPublicnumberId(activityWxUser.getBelongPublicNumberId());
								saveWinning = redWinningInfoService.saveRedInfo(redWinningInfo);
								// 判断该次扫码剩余0次抽奖机会
								if (surplusScanWinningNumber == 0) {
									// 修改用户参与转盘中奖纪录剩余抽奖次数
									Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
											+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
									Float surplusTotalMoney = Float.parseFloat(activityWxUser.getSurplusTotalMoney())
											+ Float.parseFloat(redWinningInfo.getWinningRedTotal());
									saveWinning = indexService.updateWxUserIntegralAndMoneyById(
											activityWxUser.getTotalIntegral(), activityWxUser.getSurplusTotalIntegral(),
											df.format(totalMoney), df.format(surplusTotalMoney),
											activityWxUser.getId());
								} else {
									Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
											+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
									saveWinning = indexService.updateWxUserIntegralAndMoneyById(
											activityWxUser.getTotalIntegral(), activityWxUser.getSurplusTotalIntegral(),
											df.format(totalMoney), activityWxUser.getSurplusTotalMoney(),
											activityWxUser.getId());
								}
							} else {
								if (surplusScanWinningNumber == 0) {
									Float winningRedTotal = Float.parseFloat(rwi.getWinningRedTotal())
											+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
									saveWinning = redWinningInfoService.updateRedInfo("1", df.format(winningRedTotal),
											scratchCard.getActivityName(), rwi.getId());
									if (saveWinning > 0) {
										// 修改用户参与转盘中奖纪录剩余抽奖次数
										Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
												+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
										Float surplusTotalMoney = Float
												.parseFloat(activityWxUser.getSurplusTotalMoney())
												+ Float.parseFloat(rwi.getWinningRedTotal());
										saveWinning = indexService.updateWxUserIntegralAndMoneyById(
												activityWxUser.getTotalIntegral(),
												activityWxUser.getSurplusTotalIntegral(), df.format(totalMoney),
												df.format(surplusTotalMoney), activityWxUser.getId());
									}
								} else {
									Float winningRedTotal = Float.parseFloat(rwi.getWinningRedTotal())
											+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
									saveWinning = redWinningInfoService.updateRedInfo("0", df.format(winningRedTotal),
											scratchCard.getActivityName(), rwi.getId());
									if (saveWinning > 0) {
										Float totalMoney = Float.parseFloat(activityWxUser.getTotalMoney())
												+ Float.parseFloat(winningScratchCardPrize.getRedNumber());
										saveWinning = indexService.updateWxUserIntegralAndMoneyById(
												activityWxUser.getTotalIntegral(),
												activityWxUser.getSurplusTotalIntegral(), df.format(totalMoney),
												activityWxUser.getSurplusTotalMoney(), activityWxUser.getId());
									}
								}
							}
							//发送红包中奖通知
							String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + scratchCardWxUser.getOpenId();
							ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
							Tools.sendWinNotice(scratchCardWxUser.getOpenId(), sellerPublicNumber, activityUrl, scratchCard.getActivityName(), winningScratchCardPrize.getPrizeName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
							ApiConfigKit.removeThreadLocalAppId();
						} else if (winningScratchCardPrize.getPrizeType().equals("4")) {
							//谢谢惠顾
		        			String newId = newId();
							// 谢谢惠顾
							saveWinning = scratchCardSrevice.saveScratchCardWinning(newId, scratchCardWxUserId,
									winningScratchCardPrize.getPrizeType(),
									winningScratchCardPrize.getScratchCardPrizeId(), "0",
									winningScratchCardPrize.getPrizeName(), uitils.newDate(), openid, "1",
									winningScratchCardPrize.getPrizeImg(), "");
							winId=newId;
	        				winType="4";
							if (saveWinning > 0) {
								saveWinning = scratchCardSrevice.updateScratchCardWxUserJoinNumberById(
										surplusScanWinningNumber + "", scratchCardWxUser.getTotalMoney(),
										scratchCardWxUser.getTotalIntegral(),
										scratchCardWxUser.getScratchCardWxuserId(),
										scratchCardWxUser.getIntegralWinningNumber(),
										scratchCardWxUser.getRedWinningNumber(),
										scratchCardWxUser.getGoodsWinningNumber(),
										Integer.parseInt(scratchCardWxUser.getThinkWinningNumber()) + 1 + "");
							}
						}
						if (saveWinning > 0) {
							resutl = true;
							if (rwi != null) {
								if (surplusScanWinningNumber == 0) {
									saveWinning = redWinningInfoService.updateRedInfoByState("1", rwi.getId());
									if (!winningScratchCardPrize.getPrizeType().equals("3")) {
										// 最后的中奖不是红包中奖，将之前红包中奖修改已完成，累加值微信用户可提现金额中，如果最后一次扫码中奖红包已经累加
										Float surplusTotalMoney = Float
												.parseFloat(activityWxUser.getSurplusTotalMoney())
												+ Float.parseFloat(rwi.getWinningRedTotal());
										saveWinning = indexService.updateWxUserIntegralAndMoneyById(
												activityWxUser.getTotalIntegral(),
												activityWxUser.getSurplusTotalIntegral(),
												activityWxUser.getTotalMoney(), df.format(surplusTotalMoney),
												activityWxUser.getId());
									}
								}
							}
						}
						map.put("resutl", "true");
						scratchCard.set("SCRATCHCARD_ID",scratchCardId).set("WINNING_PROPLE_NUMBER", winningPropleNumber+"").update();
					}
				} else {
					map.put("resutl", "false");
				}
				if(activityCode!=null){
				activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", scratchCardWxUserId).set("WINTYPE", winType).set("WININGID", winId).update();
				}
				return resutl;
			}
		});
		//查询当前的微信用户给前端
		String sq="select * from ACTIVITY_WXUSER where openid = ? ";
		ActivityWxUser activityWxUser = ActivityWxUser.dao.findFirst(sq,openid);
		String surplusTotalMoney = activityWxUser.getSurplusTotalMoney();
		map.put("surplusTotalMoney", surplusTotalMoney);
		String orderId="wly"+RandomNumber();
		map.put("orderId", orderId);
		renderJson(map);
	}

	/**
	 * 刮刮乐中奖-我的奖品-本次扫码最多中奖三次的数据
	 */
	public void myPrize() {
		String openid = getPara("openid");
		String scratchCardWxUserId = getPara("scratchCardWxUserId");
		List<ScratchCardWxUserWinning> scratchCardWxUserWinningList = scratchCardSrevice
				.queryScratchCardWxUserWinningByOpenidAndScratchCardWxUserId(openid, scratchCardWxUserId);
		renderJson(scratchCardWxUserWinningList);
	}

	/**
	 * 刮刮乐-我的奖品-填写奖品收货地址等信息
	 */
	public void address() {
		String scratchCardWinningId = getPara("scratchCardWinningId");
		String addresseeName = getPara("name");
		String address = getPara("address");
		String tel = getPara("tel");
		ScratchCardWxUserWinning scratchCardWxUserWinning = ScratchCardWxUserWinning.dao.findById(scratchCardWinningId);
		Boolean resutl = new ScratchCardWxUserWinning().set("SCRATCHCARD_WXUSER_WINNING_ID", scratchCardWinningId)
				.set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address).set("ADDRESSEE_PHONE", tel)
				.set("STATE", "3").update();
		if (resutl) {
			resutl = new ProductWinningInfo().set("ID", scratchCardWxUserWinning.getProductWinningInfoId())
					.set("STATE", "3").set("ADDRESSEE_NAME", addresseeName).set("ADDRESSEE_ADDRESS", address)
					.set("ADDRESSEE_PHONE", tel).update();
		}
		String openid = scratchCardWxUserWinning.getOpenId();
		if (openid != null) {
			String cardWxuserId = scratchCardWxUserWinning.getScratchCardWxuserId();
			ScratchCardWxUser scratchCardWxUser = ScratchCardWxUser.dao.findById(cardWxuserId);
			String belongPublicNumberId = scratchCardWxUser.getBelongPublicNumberId();
			SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(belongPublicNumberId);
			ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(),sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
			ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
			//补全用户信息
			WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
			ApiConfigKit.removeThreadLocalAppId();
			//保存或修改微信用户
			wxService.saveWxUser(wxuser,openid,sellerPublicNumber,newId());
			//修改记录中的微信名称和头像地址  这是修改刮刮乐的
			String sqlCard = PropKit.use("database.properties").get("updateCardNameByOpenid");
			Db.update(sqlCard,wxuser.getNickname(),wxuser.getHeadimgurl(),openid);
		}
		renderJson(resutl);
	}
	
	//10位随机数
	public static String RandomNumber(){
		int a[] = new int[10];
		String number ="";
	      for(int i=0;i<a.length;i++ ) {
	          a[i] = (int)(10*(Math.random()));
	          number += a[i]+"";
	      }
	     return number+"";
	}
}
