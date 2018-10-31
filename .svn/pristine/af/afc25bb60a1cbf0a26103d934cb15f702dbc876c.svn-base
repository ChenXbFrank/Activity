package com.activity.common.service.jzRed;

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
import com.activity.common.model.jzRed.JzRed;
import com.activity.common.model.jzRed.JzRedPrize;
import com.activity.common.model.jzRed.JzRedWxUser;
import com.activity.common.model.jzRed.JzRedWxUserWining;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.robRed.RedWinningInfo;
import com.activity.common.model.robRed.RobRedWxUser;
import com.activity.common.service.integral.IntegralService;
import com.activity.common.service.robRed.RedWinningInfoService;
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
 * 尖庄红包活动服务类
 * @author tangh
 *
 */
public class JzRedService {
	private static JzRedService jzRedService = new JzRedService();
	private JzRedService() {}
	public static JzRedService getService() {return jzRedService;}
	
	WxService wxService = WxService.getService();
	DateUitils uitils = DateUitils.getUitils();
	ActivitySellerOutInfoService activitySellerOutInfoService = ActivitySellerOutInfoService.getService();
	IndexService indexService = IndexService.getService();
	RedWinningInfoService redWinningInfoService = RedWinningInfoService.getService();
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public String JzRedActivity(JzRed jzRed, String qrcode) {
		DateUitils.getUitils();
		Date startDate = DateUitils.strToDateYMD(jzRed.getStartTime());
		Date endDate = DateUitils.strToDateYMD(jzRed.getEndTime());
		boolean startTime = DateUitils.isDateBefore(startDate);
		boolean endTime = DateUitils.isDateBefore(endDate);
		String redirect = "";
		// 判断活动是否审批通过
		if (jzRed.getState().toString().equals("1")) {
			if (startTime) {
				// 活动未开始
			} else {
				// 活动已经开始
				if (endTime) {
					/**
					 * 1.进入这里代表当前人可参加当前活动 2.获取活动发起者经销商公众号配置
					 */
					// 活动发起人的userCode
					String userCode = jzRed.getAcitivityLaunchUserCode();
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
							+ JFinal.me().getContextPath() + "%2fjzRed%2findex%3factivityId%3d"
							+ jzRed.getId() + "%26qrcode%3d" + qrcode + "%26sellerPublicNumberId%3d" + spn.getId() 
							+ "&response_type=code&scope=snsapi_userinfo&state=wx"
							+ "&connect_redirect=1#wechat_redirect";
				}
			}
		}
		return redirect;
	}
	
	/**
	 * 验证二维码是否进入活动
	 * @param sellerPublicNumber
	 * @param qrcode
	 * @param openid
	 * @param accessToken
	 * @param robRedActivityId
	 * @return
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
			JzRedWxUser jzwxuser = getJzRedWxUserByOpenidAndQrCode(openid, qrcode);
			//根据ID查询红包活动
			String queryRobRed = PropKit.use("database.properties").get("getJzRedById");
			Record rec = Db.findFirst(queryRobRed,robRedActivityId);
			JzRed jzred = new JzRed().mapping(rec, new JzRed());
			if(jzwxuser==null){
				jzwxuser = new JzRedWxUser();
				jzwxuser.setId(newId());
				jzwxuser.setScanRedNumber("1");
				wxService.noSaveWxUser(wxuser,openid,sellerPublicNumber,newId());
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
				new JzRedWxUser().set("ID", jzwxuser.getId()).set("ACTIVITY_NAME", jzred.getActivityName()).set("STARTTIME", jzred.getStartTime())
					.set("ENDTIME", jzred.getEndTime()).set("JZ_RED_ID", jzred.getId()).set("OPENID", openid).set("NICKNAME", wxuser.getNickname())
					.set("HEADIMGURL", wxuser.getHeadimgurl()).set("BELONG_PUBLICNUMBER_ID", sellerPublicNumber.getId()).set("CREATE_TIME", uitils.newDate()).set("SCAN_CODE", qrcode)
					.save();
				if(rest){
					// 查询出所属运单
					Map<String, Object> map1 = activitySellerOutInfoService.getActivitySellerOutInfoByQrcode(qrcode);
					//这是开启活动的运单
					ActivitySellerOutInfo activitySellerInfo = (ActivitySellerOutInfo) map1.get("activitySellerInfo");
					int i = indexService.insertAtcitityCode(newId(), qrcode, activitySellerInfo.getSellerOutInfoRecordId().toString(), sellerPublicNumber.getId(), 
							sellerPublicNumber.getPublicNumberName(), jzwxuser.getId(), openid, wxuser.getNickname(), wxuser.getHeadimgurl(),PropKit.use("system.properties").get("JzRed"),"1", jzred.getId(),jzred.getActivityName());
					if(i==1){
						//将参与人数+1
						int joinNumebrUpdate = updateJzRedNumber(jzred.getId(),Integer.parseInt(jzred.getJoinPropleNumber())+1+"");
						if(joinNumebrUpdate==0){
							rest = false;
						}
					}
				}
			}
			map.put("scanWinningNumber", jzwxuser.getScanRedNumber());
			map.put("qrcode", qrcode);
			map.put("jzRed", jzred);
			map.put("openid", openid);
			map.put("mch_billno", "wly"+uitils.RandomNumber());
			map.put("jzwxuserid", jzwxuser.getId());
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
	 * @param activityId
	 * @param sellerPublicNumberId
	 * @param openid
	 * @param jzwxuserid
	 * @param accessToken
	 * @return
	 */
	public synchronized Map<String, Object> nowJzRed(String activityId,String sellerPublicNumberId,String openid,String jzwxuserid,String accessToken){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean rest = false;
		SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerPublicNumberId);
		//首先获取微信用户参加抢红包活动，是否有参与机会
		Record rec = Db.findFirst(PropKit.use("database.properties").get("getjzRedWxUserById"),jzwxuserid);//RobRedWxUser.dao.findById(redWxUserId);
		JzRedWxUser jzRedWxUser = new JzRedWxUser().mapping(rec, new JzRedWxUser());
		String scanCode = jzRedWxUser.getScanCode();
		//根据扫描的二维码查找出该二维码的参与情况
		String codeSql="select * from ACTIVITY_CODE where CODE =?";
		ActivityCode activityCode = ActivityCode.dao.findFirst(codeSql,scanCode);
		String winId="";
		String winType="";
		//获取奖品配置
		List<JzRedPrize> jzRedPrizeList =  getJzRedPrizeByActivityId(activityId);
		System.out.println("奖品集合"+jzRedPrizeList.size());
		if(jzRedWxUser.getScanRedNumber().equals("0")){
			map.put("scanWinningNumber", "0");
		}else{
			String sql="UPDATE TB_JZ_RED SET WINNING_PROPLE_NUMBER=? WHERE ID=?";
			// TODO Auto-generated method stub
			JzRed jzRed = new JzRed().dao().findById(activityId);
			String winningPropleNumber = jzRed.getWinningPropleNumber();
			int parseInt = Integer.parseInt(winningPropleNumber);
			String winNum=parseInt+1+"";
			//剩余总瓶数
			int bottleTotal = Integer.parseInt(jzRed.getTotal());
			ActivityWxUser awu = indexService.getUserByopenidAndappId(openid,sellerPublicNumber.getId());
			//判断中奖方式是模式一还是模式二
			System.out.println("模式==="+jzRed.getPattern());
			if(jzRed.getPattern().equals("1")){
				//中奖总概率
				Float prizeTotal = (float) 0.00;
				//谢谢惠顾中奖人数
				int thankPeopleNum = 0;
				for(JzRedPrize jzRedPrize:jzRedPrizeList){
					//获取剩余概率，在相加
					prizeTotal = prizeTotal + Float.parseFloat(jzRedPrize.getSurplusPrizeProbability());
					//获取剩余数量
					thankPeopleNum += Integer.parseInt(jzRedPrize.getSurplusNumber());
				}
				//谢谢惠顾概率
				Float thank = (float) 100.00 - prizeTotal;
				thankPeopleNum = bottleTotal-thankPeopleNum;
				//格式化小数   
				DecimalFormat df = new DecimalFormat("##0.00");
				String thankProbability = df.format(thank);
				JzRedPrize newJzRedPrize = new JzRedPrize();
				newJzRedPrize.setId(newId());
				newJzRedPrize.setPrizeProject("谢谢惠顾");
				newJzRedPrize.setJzRedId(activityId);
				newJzRedPrize.setSurplusNumber(thankPeopleNum+"");
				newJzRedPrize.setSurplusPrizeProbability(thankProbability);
				jzRedPrizeList.add(newJzRedPrize);
				//存储每个奖品新的概率区间
		        List<Float> proSection = new ArrayList<Float>();
		        proSection.add(0f);
		        //总的概率区间
		        float totalPro = 0f;
		        for (JzRedPrize jzRed_Prize : jzRedPrizeList) {
		        	//当前中奖概率
		        	Float probability = Float.parseFloat(jzRed_Prize.getSurplusPrizeProbability());
		            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
		            totalPro += probability * 1000 * Integer.parseInt(jzRed_Prize.getSurplusNumber());
		            proSection.add(totalPro);
		        }
		        //获取总的概率区间中的随机数
		        Random random = new Random();
		        float randomPro = (float)random.nextInt((int)totalPro);
		        //记录所中奖
		        JzRedPrize jzRedPrize_Winning;
		        //判断取到的随机数在哪个奖品的概率区间中
		        for (int i = 0,size = proSection.size(); i < size; i++) {
		            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
		            	//将单个中奖奖品数量减一
		            	jzRedPrizeList.get(i).setSurplusNumber(Integer.parseInt(jzRedPrizeList.get(i).getSurplusNumber())-1+"");
		            	jzRedPrize_Winning = jzRedPrizeList.get(i);
		            	System.out.println("记录中奖=="+jzRedPrize_Winning.getId());
		            	//总瓶数减去一个
		            	bottleTotal = bottleTotal -1;
		            	String probability = "";
		            	//重新算出中奖概率
		            	for(JzRedPrize count_newJzRedPrize : jzRedPrizeList){
		            		//谢谢惠顾不保存
		            		if(!count_newJzRedPrize.getPrizeProject().equals("谢谢惠顾")){
		            			//保存重新计算后的概率和奖品数量
		            			probability = algorithm(Integer.parseInt(count_newJzRedPrize.getSurplusNumber()),bottleTotal);
			            		int updateRobredNewProbability = Db.update(PropKit.use("database.properties").get("updateJzRedNewProbability"), count_newJzRedPrize.getSurplusNumber(), probability, count_newJzRedPrize.getId());
			            		if(updateRobredNewProbability > 0){
			            			rest = true;
			            		}
		            		}
		            	}
		            	if(rest){
		            	//修改剩余总瓶数
		            	int updateJzRedTotal = Db.update(PropKit.use("database.properties").get("updateJzRedTotal"),bottleTotal, jzRed.getId());
			            	if(updateJzRedTotal > 0){
			            		//修改微信参与用户剩余次数
			            		String updataScanRedNumber = Integer.parseInt(jzRedWxUser.getScanRedNumber())-1+"";
			            		int updateRobredWxUserScanNumber = Db.update(PropKit.use("database.properties").get("updateJzRedWxUserScanNumber"),updataScanRedNumber,jzRedWxUser.getId());
			            		if(updateRobredWxUserScanNumber > 0){	
			            			if(jzRedPrize_Winning.getPrizeProject().equals("谢谢惠顾")){
			            				String newId = newId();
			            				winId=newId;
			            				winType="4";
			            				//保存中奖记录
			            				saveJzRedWxUserWining(newId, jzwxuserid, jzRedPrize_Winning.getId(), null,
			            						jzRedPrize_Winning.getPrizeProject(), uitils.newDate(), openid);
			            			}else if(jzRedPrize_Winning.getPrizeProject().equals("积分")){
			            				String newId = newId();
			            				winId=newId;
			            				winType="2";
			            				Db.update(sql,winNum,activityId);
			            				//保存积分中奖
			            				saveJzRedWxUserWining(newId, jzwxuserid, jzRedPrize_Winning.getId(), jzRedPrize_Winning.getWinningIntegral(),
			            						jzRedPrize_Winning.getPrizeProject(), uitils.newDate(), openid);
			            				new IntegralWinningInfo().set("ID", newId()).set("BELONG_ACTIVITY_ID", activityId).set("ACTIVITY_NAME", jzRed.getActivityName())
				            				.set("ACTIVITY_NAME_TYPE", "robRed").set("WINNING_INTEGRAL", jzRedPrize_Winning.getWinningIntegral())
				            				.set("STARTTIME", jzRed.getStartTime()).set("ENDTIME", jzRed.getEndTime()).set("OPENID", openid)
				            				.set("ACTIVITY_WXUSER_ID", jzwxuserid).set("CREATE_TIME", uitils.newDate()).set("BELONG_PUBLICNUMBER_ID", sellerPublicNumberId).save();
			            				if(awu != null){
					            			int integralTotal = Integer.parseInt(awu.getTotalIntegral())+Integer.parseInt(jzRedPrize_Winning.getWinningIntegral());
					            			int surplusIntegralTotal = Integer.parseInt(awu.getSurplusTotalIntegral())+Integer.parseInt(jzRedPrize_Winning.getWinningIntegral());
					            			new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_INTEGRAL", integralTotal).set("SURPLUS_TOTAL_INTEGRAL", surplusIntegralTotal).update();
					            		}
			            				//发送中奖积分通知
			            				String activityUrl="%2fpersonalCenter%2fmyIntegral%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + jzRedWxUser.getOpenId()+ "%26startTime%3d" + ""+ "%26endTime%3d" + "";
										//这里推送中奖通知  积分
										Tools.sendWinNotice(jzRedWxUser.getOpenId(), sellerPublicNumber, activityUrl, jzRed.getActivityName(), "积分", accessToken);
			            			}else{
			            				System.out.println("记录中奖=是否红包="+jzRedPrize_Winning.getId());
			            				//保存红包中奖记录
			            				Db.update(sql,winNum,activityId);
			            				String newId = newId();
			            				winId=newId;
			            				winType="3";
			            				saveJzRedWxUserWining(newId, jzwxuserid, jzRedPrize_Winning.getId(), jzRedPrize_Winning.getPrizeProjectMoney(),
			            						jzRedPrize_Winning.getPrizeProject(), uitils.newDate(), openid);
			            				if(awu != null){
					            			Float moneyTotal = Float.parseFloat(awu.getTotalMoney()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
					            			Float surplusMoneyTotal = Float.parseFloat(awu.getSurplusTotalMoney()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
					            			new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_MONEY", df.format(moneyTotal)).set("SURPLUS_TOTAL_MONEY", surplusMoneyTotal).update();
					            			//修改单次记录总共中奖金额
					            			Float aMoneyTotal = Float.parseFloat(jzRedWxUser.getTotalMoney()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
					            			new JzRedWxUser().set("ID",  jzRedWxUser.getId()).set("TOTAL_MONEY", df.format(aMoneyTotal)).update();
					            			//保存红包中奖记录信息
					            			saveRedWinningInfo(1,newId(),activityId,jzRed,"1",jzRedPrize_Winning.getPrizeProjectMoney(),openid,jzwxuserid,sellerPublicNumberId);
					            		}
			            				
			            				//发送红包中奖通知
			            				String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + jzRedWxUser.getOpenId();
										//这里推送中奖通知  
										Tools.sendWinNotice(jzRedWxUser.getOpenId(), sellerPublicNumber, activityUrl, jzRed.getActivityName(), "红包", accessToken);
			            			}
			            			map.put("jzRedPrize", jzRedPrize_Winning);
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
			}else if(jzRed.getPattern().equals("2")){
				//奖品集合
				List<JzRedPrize> jzRedPrize_total = new ArrayList<JzRedPrize>();
				//遍历集合，算出三种奖品，积分，红包，谢谢惠顾
				for (JzRedPrize jzRedPrize_bl : jzRedPrizeList) {
					//积分对象
					jzRedPrize_total.add(IntegralRRP(jzRedPrize_bl));
					//红包奖项
					jzRedPrize_total.add(redRRP(jzRedPrize_bl));
					//奖品概率合计
					Float prizeProbabilityTotal = Float.parseFloat(jzRedPrize_bl.getSurplusIntegralProbability()) + Float.parseFloat(jzRedPrize_bl.getSurplusPrizeProbability());
					Float thank = (float) 100.00 - prizeProbabilityTotal;
					//格式化小数   
					DecimalFormat df = new DecimalFormat("##0.00");
					//返回的是String类型		谢谢惠顾概率
					String thankProbability = df.format(thank);
					//谢谢惠顾的数量
					int thankPeopleNum = bottleTotal-Integer.parseInt(jzRedPrize_bl.getSurplusNumber());
					JzRedPrize newJzRedPrize = new JzRedPrize();
					newJzRedPrize.setId(newId());
					newJzRedPrize.setPrizeProject("谢谢惠顾");
					newJzRedPrize.setJzRedId(jzRedPrize_bl.getJzRedId());
					newJzRedPrize.setSurplusNumber(thankPeopleNum+"");
					newJzRedPrize.setSurplusProbability(thankProbability);
					newJzRedPrize.setSurplusPrizeProbability(thankProbability);
					newJzRedPrize.setSurplusIntegral(jzRedPrize_bl.getSurplusIntegral());
					newJzRedPrize.setSurplusMoney(jzRedPrize_bl.getSurplusMoney()); 
					jzRedPrize_total.add(newJzRedPrize);
					//存储每个奖品新的概率区间
			        List<Float> proSection = new ArrayList<Float>();
			        proSection.add(0f);
			        //总的概率区间
			        float totalPro = 0f;
			        for (JzRedPrize jzRedPrize : jzRedPrize_total) {
			        	//当前中奖概率
			        	Float probability = Float.parseFloat(jzRedPrize.getSurplusPrizeProbability());
			            //每个概率区间为奖品概率乘以10000（把三位小数转换为整）再乘以剩余奖品数量
			            totalPro += probability * 1000 * Integer.parseInt(jzRedPrize.getSurplusNumber());
			            proSection.add(totalPro);
			        }
			        //获取总的概率区间中的随机数
			        Random random = new Random();
			        float randomPro = (float)random.nextInt((int)totalPro);
			        //记录所中奖
			        JzRedPrize jzRedPrize_Winning;
			        //判断取到的随机数在哪个奖品的概率区间中
			        for (int i = 0,size = proSection.size(); i < size; i++) {
			            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
			            	jzRedPrize_Winning = jzRedPrize_total.get(i);
			            	//总瓶数减去一个
			            	bottleTotal = bottleTotal -1;
			            	String probability = "";
			            	//计算中奖金额或中奖积分
			            	if(jzRedPrize_Winning.getPrizeProject().equals("积分")){
			            		Db.update(sql,winNum,activityId);
			            		//判断是否剩余最后一个人
			            		if(Integer.parseInt(jzRedPrize_Winning.getSurplusNumber()) == 1){
			            			//设置获奖积分
			            			jzRedPrize_Winning.setPrizeProjectMoney(jzRedPrize_Winning.getSurplusIntegral());
			            		}else{
			            			//剩余积分或金额/剩余中奖人数
				            		int surp =(int) Math.ceil(Integer.parseInt(jzRedPrize_Winning.getSurplusIntegral())/Integer.parseInt(jzRedPrize_Winning.getSurplusNumber()));
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
				            		jzRedPrize_Winning.setPrizeProjectMoney(surp+"");
			            		}
			            		//剩余积分
			            		jzRedPrize_Winning.setSurplusIntegral(Integer.parseInt(jzRedPrize_Winning.getSurplusIntegral())-Integer.parseInt(jzRedPrize_Winning.getPrizeProjectMoney())+"");
			            	}else if(jzRedPrize_Winning.getPrizeProject().equals("谢谢惠顾")){
			            		jzRedPrize_Winning.setPrizeProjectMoney("0");
			            	}else{
			            		Db.update(sql,winNum,activityId);
			            		//判断是否剩余最后一个人
			            		if(Integer.parseInt(jzRedPrize_Winning.getSurplusNumber()) == 1){
			            			//设置获奖金额
			            			jzRedPrize_Winning.setPrizeProjectMoney(jzRedPrize_Winning.getSurplusMoney());
			            		}else{
			            			float num = (float)Float.parseFloat(jzRedPrize_Winning.getSurplusMoney())/Float.parseFloat(jzRedPrize_Winning.getSurplusNumber());
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
				            		if((float)sup/100 < Float.parseFloat(jzRedPrize_Winning.getSurplusMoney())){
				            			//中奖金额
				            			jzRedPrize_Winning.setPrizeProjectMoney(df.format((float)sup/100));
				            		}else{
				            			//中奖金额
				            			jzRedPrize_Winning.setPrizeProjectMoney(jzRedPrize_Winning.getSurplusMoney());
				            		}
			            		}
			            		float sups = (float)Float.parseFloat(jzRedPrize_Winning.getSurplusMoney())-(float)Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
			            		//剩余金额
			            		jzRedPrize_Winning.setSurplusMoney(df.format(sups));
			            		//判断剩余金额是否最低满足剩余可中奖人数0.01元
			            		float a =  (float)Float.parseFloat(jzRedPrize_Winning.getSurplusMoney())*100;
			            		int b = Integer.parseInt(jzRedPrize_Winning.getSurplusNumber())-1;
			            		//剩余金额满足剩余每个人中奖0.01
			            		if((int)a < b){
			            			//不满足，将本次中奖金额+剩余金额-最低满足人数0.01=本次中奖金额
			            			float totala = (float)Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney())+(float)Float.parseFloat(jzRedPrize_Winning.getSurplusMoney());
			            			float totalb =  totala*100;
			            			int total = (int)totalb - b;
			            			//中奖金额
			            			jzRedPrize_Winning.setPrizeProjectMoney(df.format((float)total/100));
				            		//剩余金额
				            		float newsups = totala-(float)Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
				            		jzRedPrize_Winning.setSurplusMoney(df.format(newsups));
			            		}
			            	}
			            	//将单个中奖奖品数量减一
			            	jzRedPrize_total.get(i).setSurplusNumber(Integer.parseInt(jzRedPrize_total.get(i).getSurplusNumber())-1+"");
			            	//重新算出中奖概率
			            	for(JzRedPrize jzRedPrize_count : jzRedPrize_total){
			            		//判断当前奖品属于什么奖品
			            		//谢谢惠顾不保存
			            		if(!jzRedPrize_count.getPrizeProject().equals("谢谢惠顾")){
			            			probability = algorithm(Integer.parseInt(jzRedPrize_count.getSurplusNumber()),bottleTotal);
			            			if(jzRedPrize_count.getPrizeProject().equals("积分")){
			            				//保存重新计算后的概率和奖品数量 修改积分概率和积分数量
					            		int updateRobredNewIntegralProbability = Db.update(PropKit.use("database.properties").get("updatejzRedNewIntegralProbability"), 
					            				jzRedPrize_count.getSurplusNumber(),probability,jzRedPrize_Winning.getSurplusIntegral(),jzRedPrize_count.getId());
					            		if(updateRobredNewIntegralProbability > 0){
					            			rest = true;
					            		}
				            		}else{
				            			//保存重新计算后的概率和奖品数量
					            		int updateRobredNewRedProbability = Db.update(PropKit.use("database.properties").get("updateJzRedNewRedProbability"), 
					            				jzRedPrize_count.getSurplusNumber(),probability,jzRedPrize_Winning.getSurplusMoney(),jzRedPrize_count.getId());
					            		if(updateRobredNewRedProbability > 0){
					            			rest = true;
					            		}
				            		}
			            		}
			            	}
			            	if(rest){
			            	//修改剩余总瓶数
			            	String updateRobRedTotalSql = PropKit.use("database.properties").get("updateRobRedTotal");
			            	int updateRobRedTotal = Db.update(updateRobRedTotalSql,bottleTotal+"", jzRed.getId());
				            	if(updateRobRedTotal > 0){
				            		//修改微信参与用户剩余次数
				            		String updataScanRedNumber = Integer.parseInt(jzRedWxUser.getScanRedNumber())-1+"";
				            		int updateRobredWxUserScanNumber = Db.update(PropKit.use("database.properties").get("updateJzRedWxUserScanNumber"),updataScanRedNumber,jzRedWxUser.getId());
				            		if(updateRobredWxUserScanNumber > 0){
				            			String newId1 = newId();
			            				winId=newId1;
			            				String prizeProject = jzRedPrize_Winning.getPrizeProject();
			            				if(prizeProject.equals("谢谢惠顾")){
			            					winType="4";
			            				}else{
			            					winType="3";
			            					//发送红包中奖通知
			            					String activityUrl="%2fpersonalCenter%2fmyRed%3fBPN%3d" + sellerPublicNumber.getId() + "%26oid%3d" + jzRedWxUser.getOpenId();
											//这里推送中奖通知  
											Tools.sendWinNotice(jzRedWxUser.getOpenId(), sellerPublicNumber, activityUrl, jzRed.getActivityName(), "红包", accessToken);
			            				}
				            			//保存抢红包活动中奖记录
				            			int saveRobRedWxUserWining = saveJzRedWxUserWining(newId1, jzwxuserid, jzRedPrize_Winning.getId(), jzRedPrize_Winning.getPrizeProjectMoney(),
				            					jzRedPrize_Winning.getPrizeProject(), uitils.newDate(), openid);
				            			if(saveRobRedWxUserWining > 0){
							            	if(jzRedPrize_Winning.getPrizeProject().equals("积分")){
							            		IntegralWinningInfo integralWinningInfoL = IntegralService.queryIntegralWinningInfo(activityId,jzwxuserid,openid);
							            		if(integralWinningInfoL!=null){
							            			//修改当前积分记录值
							            			new IntegralWinningInfo().set("ID", integralWinningInfoL.getId())
							            				.set("WINNING_INTEGRAL", Integer.parseInt(integralWinningInfoL.getWinningIntegral())+Integer.parseInt(jzRedPrize_Winning.getPrizeProjectMoney())).update();
							            		}else{
							            			//新增一个积分获奖记录
							            			new IntegralWinningInfo().set("ID", newId()).set("BELONG_ACTIVITY_ID", activityId).set("ACTIVITY_NAME", jzRed.getActivityName())
							            			.set("ACTIVITY_NAME_TYPE", "robRed").set("WINNING_INTEGRAL", jzRedPrize_Winning.getPrizeProjectMoney()).set("CREATE_TIME", uitils.newDate())
							            			.set("STARTTIME", jzRed.getStartTime()).set("ENDTIME", jzRed.getEndTime()).set("OPENID", openid)
						            				.set("ACTIVITY_WXUSER_ID", jzwxuserid).set("BELONG_PUBLICNUMBER_ID",sellerPublicNumberId).save();
							            		}
							            		if(awu != null){
							            			int integralTotal = Integer.parseInt(awu.getTotalIntegral())+Integer.parseInt(jzRedPrize_Winning.getPrizeProjectMoney());
							            			int surplusIntegralTotal = Integer.parseInt(awu.getSurplusTotalIntegral())+Integer.parseInt(jzRedPrize_Winning.getPrizeProjectMoney());
							            			new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_INTEGRAL", integralTotal).set("SURPLUS_TOTAL_INTEGRAL", surplusIntegralTotal).update();
							            		}
							            	}else{
							            		if(awu != null){
							            			//单个扫码记录总中奖金额
							            			Float aMoneyTotal = Float.parseFloat(jzRedWxUser.getTotalMoney()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
							            			Float moneyTotal = Float.parseFloat(awu.getTotalMoney()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
							            			//查找是否存在本人本次活动参与记录
							            			RedWinningInfo rwi =redWinningInfoService.getRedWinningInfoByActivityIdAndOpenid(activityId,openid,"robRed",jzwxuserid);
							            			//判断剩余抽奖次数是否是0次，零次可提现
							            			if(Integer.parseInt(updataScanRedNumber) == 0){
							            				//将当前记录去总共中奖金额累加至可提现金额
							            				Float surplusMoneyTotal = Float.parseFloat(awu.getSurplusTotalMoney()) + aMoneyTotal;
							            				new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_MONEY", df.format(moneyTotal)).set("SURPLUS_TOTAL_MONEY", surplusMoneyTotal).update();
							            				if(rwi == null){
							            					saveRedWinningInfo(1,newId(),activityId,jzRed,"1",jzRedPrize_Winning.getPrizeProjectMoney(),openid,jzwxuserid,sellerPublicNumberId);
							            				}else{
							            					Float redWinningInfoMoneyTotal = Float.parseFloat(rwi.getWinningRedTotal()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
							            					saveRedWinningInfo(0,rwi.getId(),activityId,jzRed,"1",df.format(redWinningInfoMoneyTotal),openid,jzwxuserid,sellerPublicNumberId);
							            				}
							            			}else{
							            				//只将本次中奖金额累加至总共中奖金额
							            				new ActivityWxUser().set("ID", awu.getId()).set("TOTAL_MONEY", df.format(moneyTotal)).update();
							            				if(rwi == null){
							            					saveRedWinningInfo(1,newId(),activityId,jzRed,"0",jzRedPrize_Winning.getPrizeProjectMoney(),openid,jzwxuserid,sellerPublicNumberId);
							            				}else{
							            					Float redWinningInfoMoneyTotal = Float.parseFloat(rwi.getWinningRedTotal()) + Float.parseFloat(jzRedPrize_Winning.getPrizeProjectMoney());
							            					saveRedWinningInfo(0,rwi.getId(),activityId,jzRed,"0",df.format(redWinningInfoMoneyTotal),openid,jzwxuserid,sellerPublicNumberId);
							            				}
							            			}
							            			//修改单次记录总共中奖金额
							            			new RobRedWxUser().set("RED_WXUSER_ID",  jzRedWxUser.getId()).set("TOTAL_MONEY", df.format(aMoneyTotal)).update();
							            		}
							            	}
				            			}
					            		map.put("jzRedPrize", jzRedPrize_Winning);
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
				activityCode.set("ID", activityCode.getId()).set("ACTIVITY_WXID", jzwxuserid).set("WINTYPE", winType).set("WININGID", winId).update();
			}
		}
		map.put("rest",rest);
		return map;
	}
	
	
	/**
	 * 根据activityId查询抢红包奖品配置
	 * @param activityId
	 */
	public List<JzRedPrize> getJzRedPrizeByActivityId(String activityId){
		String sql = PropKit.use("database.properties").get("getJzRedPrizeByActivityId");
		List<JzRedPrize> rrpList = JzRedPrize.dao.find(sql,activityId);
		return rrpList;
	}
	
	/**
	 * 只修改用户参与数量
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public int updateJzRedNumber(String activityId,String joinedNum){
		String sql = PropKit.use("database.properties").get("updateJzRedNumber");
		return Db.update(sql,joinedNum,activityId);
	}
	
	/**
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public JzRedWxUser getJzRedWxUserByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getJzRedWxUserByOpenidAndQrCode");
		return JzRedWxUser.dao.findFirst(sql,openid,scanCode);
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
	
	/**
	 * 保存一个微信用户中奖记录
	 */
	public int saveJzRedWxUserWining(String id, String redWxUserId, String redPrizeId, String prizeProjectMoney,
			String prizeProject, String date, String openid) {
		// 保存中奖记录
		String saveSql = PropKit.use("database.properties").get("saveJzRedWxUserWining");
		return Db.update(saveSql, id, redWxUserId, redPrizeId, prizeProjectMoney, prizeProject, date, openid);
	}
	
	/**
	 * 保存红包中奖信息
	 */
	public void saveRedWinningInfo(int one,String id,String robRedActivityId,JzRed jzRed,String state,String redWinningInfoMoneyTotal,String openid,String redWxUserId,String publicNumber){
		if(one == 1){
			new RedWinningInfo().set("ID", id).set("BELONG_ACTIVITY_ID", robRedActivityId).set("ACTIVITY_NAME", jzRed.getActivityName())
			.set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("RobRed")).set("WINNING_RED_TOTAL", redWinningInfoMoneyTotal).set("CREATE_TIME", uitils.newDate())
			.set("STATE", state).set("STARTTIME", jzRed.getStartTime()).set("ENDTIME", jzRed.getEndTime()).set("WITHDRAWALS", "0")
			.set("OPENID", openid).set("ACTIVITY_WXUSER_ID", redWxUserId).set("BELONG_PUBLICNUMBER_ID", publicNumber).save();
		}else{
			new RedWinningInfo().set("ID", id).set("BELONG_ACTIVITY_ID", robRedActivityId).set("ACTIVITY_NAME", jzRed.getActivityName())
			.set("ACTIVITY_NAME_TYPE", PropKit.use("system.properties").get("RobRed")).set("WINNING_RED_TOTAL", redWinningInfoMoneyTotal).set("CREATE_TIME", uitils.newDate())
			.set("STATE", state).set("STARTTIME", jzRed.getStartTime()).set("ENDTIME", jzRed.getEndTime()).set("WITHDRAWALS", "0")
			.set("OPENID", openid).set("ACTIVITY_WXUSER_ID", redWxUserId).set("BELONG_PUBLICNUMBER_ID", publicNumber).update();
		}
	}
	
	/**
	 * 转积分对象
	 */
	public JzRedPrize IntegralRRP(JzRedPrize rrpBL){
		JzRedPrize IntegralRRP = new JzRedPrize();
		IntegralRRP.setId(rrpBL.getId());
		IntegralRRP.setJzRedId(rrpBL.getJzRedId());
		IntegralRRP.setPrizeProject("积分");
		IntegralRRP.setPrizeProjectMoney(rrpBL.getWinningIntegral());//积分和金额都存放在奖项金额中
		IntegralRRP.setGetPrizeNumber(rrpBL.getWinningIntegralNumber());
		IntegralRRP.setSurplusIntegral(rrpBL.getSurplusIntegral());
		IntegralRRP.setSurplusMoney(rrpBL.getSurplusMoney()); 
		IntegralRRP.setRedWinningProbability(rrpBL.getIntegralWinningProbability());
		IntegralRRP.setProbabilityTotal(rrpBL.getIntegralProbabilityTotal());
		IntegralRRP.setSurplusProbability(rrpBL.getSurplusProbability());
		IntegralRRP.setSurplusNumber(rrpBL.getSurplusIntegralNumber());
		IntegralRRP.setSurplusPrizeProbability(rrpBL.getSurplusIntegralProbability());
		return IntegralRRP;
	}
	
	/**
	 * 转红包对象
	 */
	public JzRedPrize redRRP(JzRedPrize rrpBL){
		JzRedPrize redRRP = new JzRedPrize();
		redRRP.setId(rrpBL.getId());
		redRRP.setJzRedId(rrpBL.getJzRedId());
		redRRP.setPrizeProject("红包");
		redRRP.setPrizeProjectMoney(rrpBL.getPrizeProjectMoney());
		redRRP.setGetPrizeNumber(rrpBL.getGetPrizeNumber());
		redRRP.setSurplusIntegral(rrpBL.getSurplusIntegral());
		redRRP.setSurplusMoney(rrpBL.getSurplusMoney()); 
		redRRP.setRedWinningProbability(rrpBL.getRedWinningProbability());
		redRRP.setProbabilityTotal(rrpBL.getProbabilityTotal());//红包中奖概率合计=积分中奖概率合计
		redRRP.setSurplusProbability(rrpBL.getSurplusProbability());
		redRRP.setSurplusNumber(rrpBL.getSurplusNumber());//红包剩余数量=积分剩余数量
		redRRP.setSurplusPrizeProbability(rrpBL.getSurplusPrizeProbability());//红包剩余概率=积分剩余概率
		return redRRP;
	}
	
	/**
	 * 根据微信参与记录ID ，查询出该记录的所有奖品
	 * 
	 * @param id
	 * @return
	 */
	public List<JzRedWxUserWining> queryJzRedWxUserWiningByWxUserId(String id) {
		// 保存中奖记录
		String sql = PropKit.use("database.properties").get("queryJzRedWxUserWiningByWxUserId");
		return JzRedWxUserWining.dao.find(sql, id);
	}
}
