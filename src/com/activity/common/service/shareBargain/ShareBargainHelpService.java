package com.activity.common.service.shareBargain;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.bigDataPlatform.ProductInfo;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.shareBargain.ShareBargain;
import com.activity.common.model.shareBargain.ShareBargainHelp;
import com.activity.common.model.shareBargain.ShareBargainPrize;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.service.activity.ProductWinningInfoService;
import com.activity.common.service.system.ProductInfoService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.alibaba.druid.util.StringUtils;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;



/**
 * 帮忙砍价的用户的业务
 * 
 * @author ChenXb
 *
 *         2017年8月26日
 */
public class ShareBargainHelpService {

	private static ShareBargainHelpService shareBargainHelpService = new ShareBargainHelpService();

	public ShareBargainHelpService() {

	}
	/**
	 * 懒汉式 就是申明的时候不new 在下边的时候判断是否为空的时候 才new出来 这样线程不安全
	 * 
	 * @return
	 */
	public static ShareBargainHelpService getService() {
		return shareBargainHelpService;
	}

	EmojiUtils emojiUtils = EmojiUtils.getEmojiUtils();
	WxService wxService = WxService.getService();
	ProductWinningInfoService productWinningInfoService = ProductWinningInfoService.getService();
	
	
	/**
	 * 根据FRIEND_ACTIVITY_ID查询所有帮忙砍价的用户的砍价情况
	 */
	public List<ShareBargainHelp> getShareBargainHelpByFriendActivityId(String activityId) {
		String sql = PropKit.use("database.properties").get("getShareBargainHelpByFriendActivityId");
		return ShareBargainHelp.dao.find(sql, activityId);
	}
	
	public synchronized Map<String, Object> kanyidao(String accessToken,WxUserInfo wxuser,String appid ,String openid,String friendBargainId,String activityId,String shareBargainPrizeId,String joinBelongPublicNumberId){
		Map<String, Object> map = new HashMap<String, Object>();
		if(wxuser.getSubscribe().equals("1")){
			List<ShareBargainHelp> sbhList = ShareBargainWxuserService.getService().getSbhByOpenidAndFriendBargainId(openid,friendBargainId);
			if (sbhList.size() == 0) {
					ShareBargain sb = ShareBargain.dao.findById(activityId);
					int winningPropleNumber = sb.getWinningPropleNumber().intValue();
					ShareBargainPrize sbp = ShareBargainPrize.dao.findById(shareBargainPrizeId);
					Db.tx(new IAtom() {
						@Override
						public boolean run() throws SQLException {
							// TODO Auto-generated method stub
							// 获取帮朋友砍价活动
							ShareBargainWxuser sbw = ShareBargainWxuserService.getService().getShareBargainHelpById(friendBargainId);
							// 判断是否还剩余砍价次数
							if (Integer.parseInt(sbw.getBargainNumber()) != 0) {
								// 最低价
								Float lowPrice = Float.parseFloat(sbw.getLowPrice());
								// 现在价格
								Float nowPrice = Float.parseFloat(sbw.getNowPrice());
								// 判断当前价格是否是最低价
								if (nowPrice > lowPrice || nowPrice == lowPrice) {
									// 砍价区间
									String bargainSection[] = sbw.getBargainSection().split("-");
									Float start = Float.parseFloat(bargainSection[0]);
									Float end = Float.parseFloat(bargainSection[1]);
									float startF = start * 100;
									float endF = end * 100;
									int startIn = (int) startF;
									int endIn = (int) endF;
									Random rdm = new Random();
									int rdmNumber = rdm.nextInt(endIn) % (endIn - startIn + 1) + startIn;
									// 判断当前砍价价格，砍价后是否低于活动最低价，低于 ：随机砍价价格=朋友现在价格-最低价格
									Float newMoney = (float) rdmNumber / 100;
									// 现在价格减去随机砍价 价格是否小于最低价
									float result = Decimal(nowPrice, newMoney);
									// 记录这一次砍价是否砍到最低，是否发送推送消息
									boolean low = false;
									if (result < lowPrice) {
										newMoney = Decimal(nowPrice, lowPrice);
										low = true;
									}
									// 减去砍价区间 执行update语句
									String updateSql = PropKit.use("database.properties").get("updateNowPrice");
									if (low) {
										// 产品信息
										List<ProductInfo> piList = ProductInfoService.getService().getProductInfoById(sbp.getProductId());
										ProductInfo pi = new ProductInfo();
										for (ProductInfo piErgodic : piList) {
											pi = piErgodic;
										}
										//保存实物中奖记录
										String productWinningInfoId = newId();
										//保存一个实物中奖信息
					        			ProductWinningInfo productWinningInfo=new ProductWinningInfo();
										productWinningInfo.setId(productWinningInfoId);
										productWinningInfo.setBelongActivityId(activityId);
										productWinningInfo.setActivityName(sb.getActivityName());
										productWinningInfo.setActivityNameType(PropKit.use("system.properties").get("ShareBargain"));
										productWinningInfo.setProductId(sbp.getProductId());
										productWinningInfo.setProductName(pi.getProductName());
										productWinningInfo.setProductImg(sbp.getProductIMG());
										productWinningInfo.setActivityPrizeId(sbp.getId());
										productWinningInfo.setCreateTime(newDate());
										productWinningInfo.setStartTime(sb.getStartTime());
										productWinningInfo.setEndTime(sb.getEndTime());
										productWinningInfo.setOpenId(sbw.getOpenId());
										productWinningInfo.setActivityWxUserId(sbw.getId());
										productWinningInfo.setBelongPublicNumberId(joinBelongPublicNumberId);
										productWinningInfo.setState("2");
										productWinningInfo.setWinningInfoId(sbw.getId());
										productWinningInfo.setPayMoney(sbw.getPayMoney());
										productWinningInfo.setPrice(sbw.getPrice());
										productWinningInfo.setLowPrice(sbw.getLowPrice());
										productWinningInfoService.saveProductWinningInfo(productWinningInfo);
										String qrcode = sbw.getScanCode();
										//这里还要将参加的扫码的记录更新一下
										if(!StringUtils.isEmpty(qrcode)){
											//根据扫描的二维码查找出该二维码的参与情况
											String codeSql="select * from ACTIVITY_CODE where CODE =?";
											ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,qrcode);
											if(activityCode!=null){
											//以上查找出该码参与的情况
											activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", sbw.getId()).set("WINTYPE", "1").set("WININGID", productWinningInfoId).update();
											}
										}
										// 修改砍价为已完成状态
										Db.update(updateSql,
												String.valueOf(Decimal(Float.parseFloat(sbw.getNowPrice()), newMoney)),
												Integer.parseInt(sbw.getBargainNumber()) - 1, "2",productWinningInfoId, sbw.getId());
										// 发送推送模板消息
										SellerPublicNumber spn = SellerPublicNumber.dao.findById(joinBelongPublicNumberId);
										WxConfigUitils.getWxConfigUitils().wxInformation(sbw.getOpenId(),
												spn.getWinningNewId(), appid, PropKit.use("system.properties").get("http"),
												accessToken, sbw, sb, sbp, spn);
										//这里将中奖人数增加1
										sb.set("ID", activityId).set("WINNING_PROPLE_NUMBER", winningPropleNumber+1).update();
									} else {
										Db.update(updateSql,
												String.valueOf(Decimal(Float.parseFloat(sbw.getNowPrice()), newMoney)),
												Integer.parseInt(sbw.getBargainNumber()) - 1, "1",null, sbw.getId());
									}
									
									String nickName="";
									String headimgurl="";
									if(wxuser.getSubscribe().equals("1")){
										nickName = wxService.emoji(wxuser.getNickname());
										headimgurl = wxuser.getHeadimgurl();
									}
									String saveSql = PropKit.use("database.properties").get("saveShareBargainHelp");
									Db.update(saveSql, newId(), openid, nickName, headimgurl,
											friendBargainId, newMoney);
									map.put("result", "");
									map.put("money", newMoney);
									
								} else {
									map.put("result", "已经砍至最低价");
								}
								return true;
							} else {
								map.put("result", "您朋友砍价次数已完");
								return false;
							}
						}					
					});
			}else {
				map.put("result", "您已经帮忙砍价了");
			}
		}else{
			map.put("result", "nofollow");
		}
		return map;
	}
	/**
	 * 两个float相减
	 * 
	 * @param a
	 * @param b
	 * @return
	 */
	public float Decimal(float a, float b) {
		BigDecimal nowPriceDecimal = new BigDecimal(Float.toString(a));
		BigDecimal newMoneyDecimal = new BigDecimal(Float.toString(b));
		return nowPriceDecimal.subtract(newMoneyDecimal).floatValue();
	}
	
	public String newId(){
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyyMMddHHmmss");
		return UUID.randomUUID().toString().replaceAll("-", "") + time.format(date);
	}
	
	/**
	 * 新建时间并格式转换 年月日 时分秒
	 */
	public String newDate() {
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return time.format(date);
	}
}
