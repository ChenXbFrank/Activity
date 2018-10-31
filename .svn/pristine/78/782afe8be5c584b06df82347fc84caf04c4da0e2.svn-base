package com.activity.common.service.robRed;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import com.activity.common.model.activity.ActivityCode;
import com.activity.common.model.activity.ActivitySellerOutInfo;
import com.activity.common.model.activity.ActivityWxUser;
import com.activity.common.model.centerObjcet.wx.WxUserInfo;
import com.activity.common.model.integral.IntegralWinningInfo;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.robRed.RobRed;
import com.activity.common.model.robRed.RobRedPrize;
import com.activity.common.model.robRed.RobRedWxUser;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.system.ActivitySellerOutInfoService;
import com.activity.common.service.system.IndexService;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.service.system.WxService;
import com.activity.common.utils.date.DateUitils;
import com.activity.common.utils.emoji.EmojiUtils;
import com.activity.common.utils.system.Tools;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

/**
 * 抢红包活动
 * @author 唐
 *
 */
public class RobRedService {
	private static RobRedService robRedService = new RobRedService();
	public RobRedService() {
	}
	public static RobRedService getService() {
		return robRedService;
	}
	IndexService indexService = IndexService.getService();
	RobRedWxUserService robRedWxUserService = RobRedWxUserService.getService();
	DateUitils uitils = DateUitils.getUitils();
	WxService wxService = WxService.getService();
	RobRedPrizeService robRedPrizeService = RobRedPrizeService.getService();
	RobRedWxUserWiningService robRedWxUserWiningService = RobRedWxUserWiningService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param ShareBargainActivityID
	 * @return
	 */
	public String RobRedActivity(String robRedActivityID, String qrcode) {
		RobRed rr = RobRed.dao.findById(robRedActivityID);
		// 判断是否属于活动时间内
		Date startDate = DateUitils.strToDateYMD(rr.getStartTime());
		Date endDate = DateUitils.strToDateYMD(rr.getEndTime());
		// 判断当前时间是否大于活动开始时间 返回fasle表示小于当前时间，代表活动已经开始
		boolean startTime = DateUitils.isDateBefore(startDate);
		// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
		boolean endTime = DateUitils.isDateBefore(endDate);
		String redirect = "";
		// 判断活动是否审批通过
		if (rr.getState().toString().equals("1")) {
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
					 * 1.进入这里代表当前人可参加当前活动 
					 * 2.获取活动发起者经销商公众号配置
					 */
					// 活动发起人的userCode
					String userCode = rr.getAcitivityLaunchUserCode();
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
							+ JFinal.me().getContextPath() + "%2frobRed%2frobRedIndex%3frobRedActivityId%3d"
							+ rr.getRedId() + "%26qrcode%3d" + qrcode + "%26SPNId%3d" + spn.getId() 
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
	public synchronized Map<String, Object> robRed(SellerPublicNumber sellerPublicNumber,String qrcode,String openid,String accessToken,String robRedActivityId) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 查询当前二维码是否已参加活动
		String queryActivityCode = PropKit.use("database.properties").get("getCodeByCodeAndActivity");
		Record recActivityCode = Db.findFirst(queryActivityCode,qrcode,robRedActivityId);
		ActivityCode ac = null;
		if(recActivityCode!=null){
			ac = new ActivityCode().mapping(recActivityCode, new ActivityCode());
		}
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
		WxUserInfo wxuser = WxConfigUitils.getWxConfigUitils().getPublicUser(openid, sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret());
		if(rest){
			//判断扫码进入是否是第一次进入，还是当前用户已经参加后又扫码进入
			RobRedWxUser rrwu = robRedWxUserService.getRobRedWxUserByOpenidAndQrCode(openid, qrcode);
			//根据ID查询红包活动
			String queryRobRed = PropKit.use("database.properties").get("getRobRedById");
			Record rec = Db.findFirst(queryRobRed,robRedActivityId);
			RobRed robRed = new RobRed().mapping(rec, new RobRed());
			if(rrwu==null){
				rrwu = new RobRedWxUser();
				rrwu.setRedWxuserId(newId());
				//保存微信用户
				wxService.noSaveWxUser(wxuser,openid,sellerPublicNumber,newId());
				rrwu.setScanRedNumber(robRed.getScanRedNumber());
				if (wxuser.getSubscribe().equals("1")) {
					// 判断名称是否包含表情符号
					Boolean emoji = EmojiUtils.containsEmoji(wxuser.getNickname());
					if (emoji) {
						try {
							wxuser.setNickname(java.net.URLEncoder.encode(wxuser.getNickname(), "UTF-8"));
						} catch (UnsupportedEncodingException e) {
							e.printStackTrace();
						}
					}
				}
				//保存抢红包活动用户参加记录
				new RobRedWxUser().set("RED_WXUSER_ID", rrwu.getRedWxuserId()).set("ACTIVITY_NAME", robRed.getActivityName()).set("STARTTIME", robRed.getStartTime())
					.set("ENDTIME", robRed.getEndTime()).set("RED_ID", robRed.getRedId()).set("OPENID", openid).set("NICKNAME", wxuser.getNickname())
					.set("HEADIMGURL", wxuser.getHeadimgurl()).set("BELONG_PUBLICNUMBER_ID", sellerPublicNumber.getId()).set("CREATE_TIME", uitils.newDate()).set("SCAN_CODE", qrcode)
					.set("SCAN_RED_NUMBER", robRed.getScanRedNumber()).save();
				if(rest){
					// 查询出所属运单
					Map<String, Object> map1 = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
					//这是开启活动的运单
					ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map1.get("activitySellerInfo");
					int i = indexService.insertAtcitityCode(newId(), qrcode, activitySellerInfo.getSellerOutInfoRecordId().toString(), sellerPublicNumber.getId(), 
							sellerPublicNumber.getPublicNumberName(), rrwu.getRedWxuserId(), openid, wxuser.getNickname(), wxuser.getHeadimgurl(),PropKit.use("system.properties").get("RobRed"),"1", robRed.getRedId(),robRed.getActivityName());
					if(i==1){
						//将参与人数+1
						int joinNumebrUpdate = updateRobRedNumber(robRed.getRedId(),Integer.parseInt(robRed.getJoinPropleNumber())+1+"");
						if(joinNumebrUpdate==0){
							rest = false;
						}
					}
				}
			}
			map.put("scanWinningNumber", rrwu.getScanRedNumber());
			map.put("qrcode", qrcode);
			map.put("robRed", robRed);
			map.put("openid", openid);
			map.put("mch_billno", "wly"+uitils.RandomNumber());
			map.put("redWxUserId", rrwu.getRedWxuserId());
			map.put("sellerPublicNumber", sellerPublicNumber);
			map.put("wxUserInfo", wxuser);
			map.put("url","0");
		}else{
			// 二维码已经使用
			map.put("url","1");
		}
		map.put("rest", rest);
		return map;
	}
	
	/**
	 * 马上抢
	 * @param robRedActivityId
	 * @param SPNId
	 * @param openid
	 * @param redWxUserId
	 * @param accessToken
	 * @return
	 */
	public synchronized Map<String, Object> nowRobRed(String robRedActivityId,String sellerPublicNumberId,String openid,String redWxUserId,String accessToken){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean rest = false;
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		//首先获取微信用户参加抢红包活动，是否有参与机会
		Record rec = Db.findFirst(PropKit.use("database.properties").get("getRobredWxUserById"),redWxUserId);//RobRedWxUser.dao.findById(redWxUserId);
		RobRedWxUser rrwu = new RobRedWxUser().mapping(rec, new RobRedWxUser());
		String scanCode = rrwu.getScanCode();
		//根据扫描的二维码查找出该二维码的参与情况
		String codeSql="select * from ACTIVITY_CODE where CODE =?";
		ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
		String winId="";
		String winType="";
		//获取奖品配置
		List<RobRedPrize> rrpList =  robRedPrizeService.getRobRedPrizeByActivityId(robRedActivityId);
		if(rrwu.getScanRedNumber().equals("0")){
			map.put("scanWinningNumber", "0");
		}else{
			String sql="UPDATE TB_ROB_RED SET WINNING_PROPLE_NUMBER=? WHERE RED_ID=?";
			// TODO Auto-generated method stub
			RobRed robRed = RobRed.dao.findById(robRedActivityId);
			String winningPropleNumber = robRed.getWinningPropleNumber();
			int parseInt = Integer.parseInt(winningPropleNumber);
			String winNum=parseInt+1+"";
			//剩余总瓶数
			int bottleTotal = Integer.parseInt(robRed.getTotal());
			ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,sellerPublicNumber.getId());
			//判断中奖方式是模式一还是模式二
			if(robRed.getPattern().equals("1")){
				//中奖总概率
				Float prizeTotal = (float) 0.00;
				//谢谢惠顾中奖人数
				int thankPeopleNum = 0;
				for(RobRedPrize rrp:rrpList){
					//获取剩余概率，在相加
					prizeTotal = prizeTotal + Float.parseFloat(rrp.getSurplusPrizeProbability());
					//获取剩余数量
					thankPeopleNum += Integer.parseInt(rrp.getSurplusNumber());
				}
				//谢谢惠顾概率
				Float thank = (float) 100.00 - prizeTotal;
				thankPeopleNum = bottleTotal-thankPeopleNum;
				//格式化小数   
				DecimalFormat df = new DecimalFormat("##0.00");
				String thankProbability = df.format(thank);
				RobRedPrize rrp = new RobRedPrize();
				rrp.setRedPrizeId(newId());
				rrp.setPrizeProject("谢谢惠顾");
				rrp.setRedId(robRedActivityId);
				rrp.setSurplusNumber(thankPeopleNum+"");
				rrp.setSurplusPrizeProbability(thankProbability);
				rrpList.add(rrp);
				//存储每个奖品新的概率区间
		        List<Float> proSection = new ArrayList<Float>();
		        proSection.add(0f);
		        //总的概率区间
		        float totalPro = 0f;
		        for (RobRedPrize rrpBL : rrpList) {
		        	//当前中奖概率
		        	Float probability = Float.parseFloat(rrpBL.getSurplusPrizeProbability());
		            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
		            totalPro += probability * 1000 * Integer.parseInt(rrpBL.getSurplusNumber());
		            proSection.add(totalPro);
		        }
		        //获取总的概率区间中的随机数
		        Random random = new Random();
		        float randomPro = (float)random.nextInt((int)totalPro);
		        //记录所中奖
		        RobRedPrize rrpWinning;
		        //判断取到的随机数在哪个奖品的概率区间中
		        for (int i = 0,size = proSection.size(); i < size; i++) {
		            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
		            	//将单个中奖奖品数量减一
		            	rrpList.get(i).setSurplusNumber(Integer.parseInt(rrpList.get(i).getSurplusNumber())-1+"");
		            	rrpWinning = rrpList.get(i);
		            	//总瓶数减去一个
		            	bottleTotal = bottleTotal -1;
		            	String probability = "";
		            	//重新算出中奖概率
		            	for(RobRedPrize newRrpBL : rrpList){
		            		//谢谢惠顾不保存
		            		if(!newRrpBL.getPrizeProject().equals("谢谢惠顾")){
		            			//保存重新计算后的概率和奖品数量
		            			probability = algorithm(Integer.parseInt(newRrpBL.getSurplusNumber()),bottleTotal);
			            		String updateSql = PropKit.use("database.properties").get("updateRobredNewProbability");
			            		int updateRobredNewProbability = Db.update(updateSql, newRrpBL.getSurplusNumber(), probability, newRrpBL.getRedPrizeId());
			            		if(updateRobredNewProbability > 0){
			            			rest = true;
			            		}
		            		}
		            	}
		            	if(rest){
		            	//修改剩余总瓶数
		            	String updateRobRedTotalSql = PropKit.use("database.properties").get("updateRobRedTotal");
		            	int updateRobRedTotal = Db.update(updateRobRedTotalSql,bottleTotal, robRed.getRedId());
			            	if(updateRobRedTotal > 0){
			            		//修改微信参与用户剩余次数
			            		String updataScanRedNumber = Integer.parseInt(rrwu.getScanRedNumber())-1+"";
			            		String updateRobredWxUserScanNumberSql = PropKit.use("database.properties").get("updateRobredWxUserScanNumber");
			            		int updateRobredWxUserScanNumber = Db.update(updateRobredWxUserScanNumberSql,updataScanRedNumber,rrwu.getRedWxuserId());
			            		if(updateRobredWxUserScanNumber > 0){	
			            			if(rrpWinning.getPrizeProject().equals("谢谢惠顾")){
			            				String newId = newId();
			            				winId=newId;
			            				winType="4";
			            				//保存中奖记录
			            				robRedWxUserWiningService.saveRobRedWxUserWining(newId, redWxUserId, rrpWinning.getRedPrizeId(), null,
				            					rrpWinning.getPrizeProject(), uitils.newDate(), openid);
			            			}else if(rrpWinning.getPrizeProject().equals("积分")){
			            				String newId = newId();
			            				winId=newId;
			            				winType="2";
			            				Db.update(sql,winNum,robRedActivityId);
			            				//保存积分中奖
			            				robRedWxUserWiningService.saveRobRedWxUserWining(newId, redWxUserId, rrpWinning.getRedPrizeId(), rrpWinning.getWinningIntegral(),
				            					rrpWinning.getPrizeProject(), uitils.newDate(), openid);
			            				new IntegralWinningInfo().set("ID", newId()).set("BELONG_ACTIVITY_ID", robRedActivityId).set("ACTIVITY_NAME", robRed.getActivityName())
				            				.set("ACTIVITY_NAME_TYPE", "robRed").set("WINNING_INTEGRAL", rrpWinning.getWinningIntegral())
				            				.set("STARTTIME", robRed.getStartTime()).set("ENDTIME", robRed.getEndTime()).set("OPENID", openid)
				            				.set("ACTIVITY_WXUSER_ID", redWxUserId).set("CREATE_TIME", uitils.newDate()).set("BELONG_PUBLICNUMBER_ID", sellerPublicNumberId).save();
			            				if(awu != null){
					            			int integralTotal = Integer.parseInt(awu.getTotalIntegral())+Integer.parseInt(rrpWinning.getWinningIntegral());
					            			int surplusIntegralTotal = Integer.parseInt(awu.getSurplusTotalIntegral())+Integer.parseInt(rrpWinning.getWinningIntegral());
					            			new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_INTEGRAL", integralTotal).set("SURPLUS_TOTAL_INTEGRAL", surplusIntegralTotal).update();
					            		}
			            				//发送中奖积分通知
			            				String activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + rrwu.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
										//这里推送中奖通知  积分
										Tools.sendWinNotice(rrwu.getOpenId(), sellerPublicNumber, activityUrl, robRed.getActivityName(), "积分", accessToken);
			            			}else{
			            				//保存红包中奖记录
			            				Db.update(sql,winNum,robRedActivityId);
			            				String newId = newId();
			            				winId=newId;
			            				winType="3";
			            				robRedWxUserWiningService.saveRobRedWxUserWining(newId, redWxUserId, rrpWinning.getRedPrizeId(), rrpWinning.getPrizeProjectMoney(),
				            					rrpWinning.getPrizeProject(), uitils.newDate(), openid);
			            				if(awu != null){
					            			Float moneyTotal = Float.parseFloat(awu.getTotalMoney()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
					            			Float surplusMoneyTotal = Float.parseFloat(awu.getSurplusTotalMoney()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
					            			new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_MONEY", df.format(moneyTotal)).set("SURPLUS_TOTAL_MONEY", surplusMoneyTotal).update();
					            			//修改单次记录总共中奖金额
					            			Float aMoneyTotal = Float.parseFloat(rrwu.getTotalMoney()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
					            			new RobRedWxUser().set("RED_WXUSER_ID",  rrwu.getRedWxuserId()).set("TOTAL_MONEY", df.format(aMoneyTotal)).update();
					            			//保存红包中奖记录信息
					            			saveRedWinningInfo(1,newId(),robRedActivityId,robRed,"1",rrpWinning.getPrizeProjectMoney(),openid,redWxUserId,sellerPublicNumberId);
					            		}
			            				
			            				//发送红包中奖通知
			            				String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + rrwu.getOpenId();
										//这里推送中奖通知  
										Tools.sendWinNotice(rrwu.getOpenId(), sellerPublicNumber, activityUrl, robRed.getActivityName(), "红包", accessToken);
			            			}
			            			map.put("robRedPrize", rrpWinning);
			            		}else{
			            			rest = false;
			            		}
		            		}else{
		            			rest = false;
		            		}
		            	}
		            	map.put("scanWinningNumber", "0");
		            }
		        }
			}else if(robRed.getPattern().equals("2")){
				//奖品集合
				List<RobRedPrize> newRrpList = new ArrayList<RobRedPrize>();
				//遍历集合，算出三种奖品，积分，红包，谢谢惠顾
				for (RobRedPrize rrpBL : rrpList) {
					//积分对象
					newRrpList.add(robRedPrizeService.IntegralRRP(rrpBL));
					//红包奖项
					newRrpList.add(robRedPrizeService.redRRP(rrpBL));
					//奖品概率合计
					Float prizeProbabilityTotal = Float.parseFloat(rrpBL.getSurplusIntegralProbability()) + Float.parseFloat(rrpBL.getSurplusPrizeProbability());
					Float thank = (float) 100.00 - prizeProbabilityTotal;
					//格式化小数   
					DecimalFormat df = new DecimalFormat("##0.00");
					//返回的是String类型		谢谢惠顾概率
					String thankProbability = df.format(thank);
					//谢谢惠顾的数量
					int thankPeopleNum = bottleTotal-Integer.parseInt(rrpBL.getSurplusNumber());
					RobRedPrize rrp = new RobRedPrize();
					rrp.setRedPrizeId(newId());
					rrp.setPrizeProject("谢谢惠顾");
					rrp.setRedId(rrpBL.getRedId());
					rrp.setSurplusNumber(thankPeopleNum+"");
					rrp.setSurplusProbability(thankProbability);
					rrp.setSurplusPrizeProbability(thankProbability);
					rrp.setSurplusIntegral(rrpBL.getSurplusIntegral());
					rrp.setSurplusMoney(rrpBL.getSurplusMoney()); 
					newRrpList.add(rrp);
					//存储每个奖品新的概率区间
			        List<Float> proSection = new ArrayList<Float>();
			        proSection.add(0f);
			        //总的概率区间
			        float totalPro = 0f;
			        for (RobRedPrize rrpProbability : newRrpList) {
			        	//当前中奖概率
			        	Float probability = Float.parseFloat(rrpProbability.getSurplusPrizeProbability());
			            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
			            totalPro += probability * 1000 * Integer.parseInt(rrpProbability.getSurplusNumber());
			            proSection.add(totalPro);
			        }
			        //获取总的概率区间中的随机数
			        Random random = new Random();
			        float randomPro = (float)random.nextInt((int)totalPro);
			        //记录所中奖
			        RobRedPrize rrpWinning;
			        //判断取到的随机数在哪个奖品的概率区间中
			        for (int i = 0,size = proSection.size(); i < size; i++) {
			            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
			            	rrpWinning = newRrpList.get(i);
			            	//总瓶数减去一个
			            	bottleTotal = bottleTotal -1;
			            	String probability = "";
			            	//计算中奖金额或中奖积分
			            	if(rrpWinning.getPrizeProject().equals("积分")){
			            		Db.update(sql,winNum,robRedActivityId);
			            		//判断是否剩余最后一个人
			            		if(Integer.parseInt(rrpWinning.getSurplusNumber()) == 1){
			            			//设置获奖积分
			            			rrpWinning.setPrizeProjectMoney(rrpWinning.getSurplusIntegral());
			            		}else{
			            			//剩余积分或金额/剩余中奖人数
				            		int surp =(int) Math.ceil(Integer.parseInt(rrpWinning.getSurplusIntegral())/Integer.parseInt(rrpWinning.getSurplusNumber()));
				            		int result=random.nextInt(3);// 生成1-3的随机数
				            		if(result == 1){
				            			int a=random.nextInt(10);// 生成1-10的随机数
				            			surp = surp - a;
				            		}else if(result == 2){
				            			int b=random.nextInt(10);// 生成1-10的随机数
				            			surp = surp + b;
				            		}else if(result == 3){
				            			int c=random.nextInt(20);// 生成1-20的随机数
				            			surp = surp - c;
				            		}
				            		//中奖积分
				            		rrpWinning.setPrizeProjectMoney(surp+"");
			            		}
			            		//剩余积分
			            		rrpWinning.setSurplusIntegral(Integer.parseInt(rrpWinning.getSurplusIntegral())-Integer.parseInt(rrpWinning.getPrizeProjectMoney())+"");
			            	}else if(rrpWinning.getPrizeProject().equals("谢谢惠顾")){
			            		rrpWinning.setPrizeProjectMoney("0");
			            	}else{
			            		Db.update(sql,winNum,robRedActivityId);
			            		//判断是否剩余最后一个人
			            		if(Integer.parseInt(rrpWinning.getSurplusNumber()) == 1){
			            			//设置获奖金额
			            			rrpWinning.setPrizeProjectMoney(rrpWinning.getSurplusMoney());
			            		}else{
			            			float num = (float)Float.parseFloat(rrpWinning.getSurplusMoney())/Float.parseFloat(rrpWinning.getSurplusNumber());
			            			String s = df.format(num);
			            			float a =  (float)Float.parseFloat(s)*100;
			            			int sup = (int)a;
			            			int result=random.nextInt(3);// 生成1-3的随机数
				            		if(result == 1){
				            			int d=random.nextInt(80);
				            			sup = sup + d;
				            		}else if(result == 2){
				            			int e=random.nextInt(50);
				            			sup = sup + e;
				            		}else if(result == 3){
				            			int f=random.nextInt(150);
				            			sup = sup + f;
				            		}
				            		//判断中奖金额是否等于1，1就是1分钱，最低满足一分钱
				            		if((float)sup < 1){
				            			sup = 1;
				            		}
				            		//必须保障中奖金额小于属于奖金
				            		if((float)sup/100 < Float.parseFloat(rrpWinning.getSurplusMoney())){
				            			//中奖金额
					            		rrpWinning.setPrizeProjectMoney(df.format((float)sup/100));
				            		}else{
				            			//中奖金额
					            		rrpWinning.setPrizeProjectMoney(rrpWinning.getSurplusMoney());
				            		}
			            		}
			            		float sups = (float)Float.parseFloat(rrpWinning.getSurplusMoney())-(float)Float.parseFloat(rrpWinning.getPrizeProjectMoney());
			            		//剩余金额
			            		rrpWinning.setSurplusMoney(df.format(sups));
			            		//判断剩余金额是否最低满足剩余可中奖人数0.01元
			            		float a =  (float)Float.parseFloat(rrpWinning.getSurplusMoney())*100;
			            		int b = Integer.parseInt(rrpWinning.getSurplusNumber())-1;
			            		//剩余金额满足剩余每个人中奖0.01
			            		if((int)a < b){
			            			//不满足，将本次中奖金额+剩余金额-最低满足人数0.01=本次中奖金额
			            			float totala = (float)Float.parseFloat(rrpWinning.getPrizeProjectMoney())+(float)Float.parseFloat(rrpWinning.getSurplusMoney());
			            			float totalb =  totala*100;
			            			int total = (int)totalb - b;
			            			//中奖金额
				            		rrpWinning.setPrizeProjectMoney(df.format((float)total/100));
				            		//剩余金额
				            		float newsups = totala-(float)Float.parseFloat(rrpWinning.getPrizeProjectMoney());
				            		rrpWinning.setSurplusMoney(df.format(newsups));
			            		}
			            	}
			            	//将单个中奖奖品数量减一
			            	newRrpList.get(i).setSurplusNumber(Integer.parseInt(newRrpList.get(i).getSurplusNumber())-1+"");
			            	//重新算出中奖概率
			            	for(RobRedPrize newRrpBL : newRrpList){
			            		//判断当前奖品属于什么奖品
			            		//谢谢惠顾不保存
			            		if(!newRrpBL.getPrizeProject().equals("谢谢惠顾")){
			            			probability = algorithm(Integer.parseInt(newRrpBL.getSurplusNumber()),bottleTotal);
			            			if(newRrpBL.getPrizeProject().equals("积分")){
			            				//保存重新计算后的概率和奖品数量 修改积分概率和积分数量
					            		String updateSql = PropKit.use("database.properties").get("updateRobredNewIntegralProbability");
					            		int updateRobredNewIntegralProbability = Db.update(updateSql, newRrpBL.getSurplusNumber(),
					            				probability,rrpWinning.getSurplusIntegral(),newRrpBL.getRedPrizeId());
					            		if(updateRobredNewIntegralProbability > 0){
					            			rest = true;
					            		}
				            		}else{
				            			//保存重新计算后的概率和奖品数量
					            		String updateSql = PropKit.use("database.properties").get("updateRobredNewRedProbability");
					            		int updateRobredNewRedProbability = Db.update(updateSql, newRrpBL.getSurplusNumber(), 
					            				probability,rrpWinning.getSurplusMoney(),newRrpBL.getRedPrizeId());
					            		if(updateRobredNewRedProbability > 0){
					            			rest = true;
					            		}
				            		}
			            		}
			            	}
			            	if(rest){
			            	//修改剩余总瓶数
			            	String updateRobRedTotalSql = PropKit.use("database.properties").get("updateRobRedTotal");
			            	int updateRobRedTotal = Db.update(updateRobRedTotalSql,bottleTotal+"", robRed.getRedId());
				            	if(updateRobRedTotal > 0){
				            		//修改微信参与用户剩余次数
				            		String updataScanRedNumber = Integer.parseInt(rrwu.getScanRedNumber())-1+"";
				            		String updateRobredWxUserScanNumberSql = PropKit.use("database.properties").get("updateRobredWxUserScanNumber");
				            		int updateRobredWxUserScanNumber = Db.update(updateRobredWxUserScanNumberSql,updataScanRedNumber,rrwu.getRedWxuserId());
				            		if(updateRobredWxUserScanNumber > 0){
				            			String newId1 = newId();
			            				winId=newId1;
			            				String prizeProject = rrpWinning.getPrizeProject();
			            				if(prizeProject.equals("谢谢惠顾")){
			            					winType="4";
			            				}else{
			            					winType="3";
			            					//发送红包中奖通知
			            					String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + rrwu.getOpenId();
											//这里推送中奖通知  
											Tools.sendWinNotice(rrwu.getOpenId(), sellerPublicNumber, activityUrl, robRed.getActivityName(), "红包", accessToken);
			            				}
				            			//保存抢红包活动中奖记录
				            			int saveRobRedWxUserWining = robRedWxUserWiningService.saveRobRedWxUserWining(newId1, redWxUserId, rrpWinning.getRedPrizeId(), rrpWinning.getPrizeProjectMoney(),
				            					rrpWinning.getPrizeProject(), uitils.newDate(), openid);
				            			if(saveRobRedWxUserWining > 0){
							            	if(rrpWinning.getPrizeProject().equals("积分")){
							            		IntegralWinningInfo integralWinningInfoL = IntegralService.queryIntegralWinningInfo(robRedActivityId,redWxUserId,openid);
							            		if(integralWinningInfoL!=null){
							            			//修改当前积分记录值
							            			new IntegralWinningInfo().set("ID", integralWinningInfoL.getId())
							            				.set("WINNING_INTEGRAL", Integer.parseInt(integralWinningInfoL.getWinningIntegral())+Integer.parseInt(rrpWinning.getPrizeProjectMoney())).update();
							            		}else{
							            			//新增一个积分获奖记录
							            			new IntegralWinningInfo().set("ID", newId()).set("BELONG_ACTIVITY_ID", robRedActivityId).set("ACTIVITY_NAME", robRed.getActivityName())
							            			.set("ACTIVITY_NAME_TYPE", "robRed").set("WINNING_INTEGRAL", rrpWinning.getPrizeProjectMoney()).set("CREATE_TIME", uitils.newDate())
							            			.set("STARTTIME", robRed.getStartTime()).set("ENDTIME", robRed.getEndTime()).set("OPENID", openid)
						            				.set("ACTIVITY_WXUSER_ID", redWxUserId).set("BELONG_PUBLICNUMBER_ID",sellerPublicNumberId).save();
							            		}
							            		if(awu != null){
							            			int integralTotal = Integer.parseInt(awu.getTotalIntegral())+Integer.parseInt(rrpWinning.getPrizeProjectMoney());
							            			int surplusIntegralTotal = Integer.parseInt(awu.getSurplusTotalIntegral())+Integer.parseInt(rrpWinning.getPrizeProjectMoney());
							            			new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_INTEGRAL", integralTotal).set("SURPLUS_TOTAL_INTEGRAL", surplusIntegralTotal).update();
							            		}
							            	}else{
							            		if(awu != null){
							            			//单个扫码记录总中奖金额
							            			Float aMoneyTotal = Float.parseFloat(rrwu.getTotalMoney()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
							            			Float moneyTotal = Float.parseFloat(awu.getTotalMoney()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
							            			//查找是否存在本人本次活动参与记录
							            			RedWinningInfo rwi =redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(robRedActivityId,openid,"robRed",redWxUserId);
							            			//判断剩余抽奖次数是否是0次，零次可提现
							            			if(Integer.parseInt(updataScanRedNumber) == 0){
							            				//将当前记录去总共中奖金额累加至可提现金额
							            				Float surplusMoneyTotal = Float.parseFloat(awu.getSurplusTotalMoney()) + aMoneyTotal;
							            				new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_MONEY", df.format(moneyTotal)).set("SURPLUS_TOTAL_MONEY", surplusMoneyTotal).update();
							            				if(rwi == null){
							            					saveRedWinningInfo(1,newId(),robRedActivityId,robRed,"1",rrpWinning.getPrizeProjectMoney(),openid,redWxUserId,sellerPublicNumberId);
							            				}else{
							            					Float redWinningInfoMoneyTotal = Float.parseFloat(rwi.getWinningRedTotal()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
							            					saveRedWinningInfo(0,rwi.getId(),robRedActivityId,robRed,"1",df.format(redWinningInfoMoneyTotal),openid,redWxUserId,sellerPublicNumberId);
							            				}
							            			}else{
							            				//只将本次中奖金额累加至总共中奖金额
							            				new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_MONEY", df.format(moneyTotal)).update();
							            				if(rwi == null){
							            					saveRedWinningInfo(1,newId(),robRedActivityId,robRed,"0",rrpWinning.getPrizeProjectMoney(),openid,redWxUserId,sellerPublicNumberId);
							            				}else{
							            					Float redWinningInfoMoneyTotal = Float.parseFloat(rwi.getWinningRedTotal()) + Float.parseFloat(rrpWinning.getPrizeProjectMoney());
							            					saveRedWinningInfo(0,rwi.getId(),robRedActivityId,robRed,"0",df.format(redWinningInfoMoneyTotal),openid,redWxUserId,sellerPublicNumberId);
							            				}
							            			}
							            			//修改单次记录总共中奖金额
							            			new RobRedWxUser().set("RED_WXUSER_ID",  rrwu.getRedWxuserId()).set("TOTAL_MONEY", df.format(aMoneyTotal)).update();
							            		}
							            	}
				            			}
					            		map.put("robRedPrize", rrpWinning);
				            		}else{
				            			rest = false;
				            		}
				            		map.put("scanWinningNumber",updataScanRedNumber);
			            		}else{
			            			rest = false;
			            		}
			            	}
			            }
			        }
				}
			}
			if(activityCode!=null){
				activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", redWxUserId).set("WINTYPE", winType).set("WININGID", winId).update();
			}
		}
		map.put("rest",rest);
		return map;
	}
	
	/**
	 * 只修改用户参与数量
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public int updateRobRedNumber(String activityId,String joinedNum){
		String sql = PropKit.use("database.properties").get("updateRorRedNumber");
		return Db.update(sql,joinedNum,activityId);
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
	
	/**
	 *查询当前登陆人的所有抢红包活动
	 */
	public List<RobRed> getRobRedByUserCode(String userCode,String activityName,String state){
		String sql = PropKit.use("database.properties").get("getRobRedByUserCode");
		if(!activityName.equals("")){
			sql+=" AND ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if(!state.equals("")){
			if(state.equals("全部")){
				
			}else if(state.equals("通过")){
				state="1";
				sql += " and STATE = " + state;
			}else if(state.equals("驳回")){
				state="2";
				sql += " and STATE = " + state;
			}else if(state.equals("申请中")){
				state="0";
				sql += " and STATE = " + state;
			}
		}
		return RobRed.dao.find(sql, userCode);
	}
	
	/**
	 *查询当前登陆人的所有抢红包活动全部
	 */
	public List<RobRed> getAllRobRedByUserCode(String userCode,String activityName,String state,String startTime,String endTime){
		String neirong = "1=1 ";
		// 这里是模糊查询名字
		if (activityName != null && !"".equals(activityName) ) {
			neirong += "and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) && state != null) {
			neirong += " and STATE = " + state;
		}
		if (!"".equals(userCode) && userCode != null) {
			neirong += " and ACITIVITY_LAUNCH_USERCODE ="+"'"+userCode+"'";//'" +"'";
		}
		if (!"".equals(startTime) && !"".equals(endTime) && startTime != null && endTime != null) {
			neirong += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		String sql = "select * from TB_ROB_RED where " + neirong;
		return RobRed.dao.find(sql);
	}
	
	/**
	 * 查询所有所有的抢红包活动
	 */
	public List<RobRed> getAllRodRed(String activityName,String state){
		String sql = PropKit.use("database.properties").get("getAllRodRed");
		if(!activityName.equals("")){
			sql+=" AND ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if(!state.equals("")){
			if(state.equals("全部")){
				
			}else if(state.equals("通过")){
				state="1";
				sql += " and STATE = " + state;
			}else if(state.equals("驳回")){
				state="2";
				sql += " and STATE = " + state;
			}else if(state.equals("申请中")){
				state="0";
				sql += " and STATE = " + state;
			}
		}
		return RobRed.dao.find(sql);
	}
	
	/**
	 * 分页查询 查询所有的红包活动的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		return RobRed.dao.paginate(pageNumber, pageSize,activityName,state,startTime,endTime,user);
	}
	
	public synchronized ActivityCode scanCode(String qrcode,String robRedActivityId){
		String queryActivityCode = PropKit.use("database.properties").get("getCodeByCodeAndActivity");
		Record recActivityCode = Db.findFirst(queryActivityCode,qrcode,robRedActivityId);
		ActivityCode ac = null;
		if(recActivityCode!=null){
			ac = new ActivityCode().mapping(recActivityCode, new ActivityCode());
		}
		return ac;
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
	
	/**
	 * 算概率
	 * */
	public String algorithm(int SurplusNumber ,int number){
		Float nowprize = (float)SurplusNumber/ (float)number*100;
		DecimalFormat df = new DecimalFormat("##0.00");//格式化小数   
		String probability = df.format(nowprize);//返回的是String类型
		return probability;
	}
	
}
