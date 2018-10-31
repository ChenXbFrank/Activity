package com.activity.common.service.scratchCard;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.scratchCard.ScratchCard;
import com.activity.common.model.scratchCard.ScratchCardPrize;
import com.activity.common.model.scratchCard.ScratchCardWxUser;
import com.activity.common.model.scratchCard.ScratchCardWxUserWinning;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;

/**
 * 刮刮乐
 * @author 唐
 *
 */
public class ScratchCardService {
	private static ScratchCardService service = new ScratchCardService();
	private ScratchCardService() {}
	public static ScratchCardService getService(){return service;}
	
	/**
	 * 查询所有的刮刮乐活动
	 * @return
	 */
	public List<ScratchCard> allScratchCard(String activityName,String state){
		String sql = PropKit.use("database.properties").get("allScratchCard");
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
		return ScratchCard.dao.find(sql);
	}
	
	/**
	 * 报表查询所有的刮刮乐活动
	 */
	public List<ScratchCard> queryScratchCardReportAll(String userCode,String userId,String activityName,String state,String startTime,String endTime){
		String sql = PropKit.use("database.properties").get("allScratchCard");
		if(!userCode.equals("0")){
			sql+=" AND ACITIVITY_LAUNCH_USERID = "+userId+"AND ACITIVITY_LAUNCH_USERCODE="+userCode;
			if (!"".equals(userCode) && userCode != null) {
				sql += " and ACITIVITY_LAUNCH_USERCODE ="+"'"+userCode+"'";//'" +"'";
			}
		}
		// 这里是模糊查询名字
		if (activityName != null && !"".equals(activityName) ) {
			sql += " and ACTIVITY_NAME like '%" + activityName + "%'";
		}
		if (!"".equals(state) && state != null) {
			sql += " and STATE = " + state;
		}
		if (!"".equals(startTime) && !"".equals(endTime) && startTime != null && endTime != null) {
			sql += " and CREATE_TIME BETWEEN '" + startTime + "' and '" + endTime + "'";
		}
		return ScratchCard.dao.find(sql);
	}
	
	/**
	 * 查询本次扫码最多中奖三次的数据
	 */
	public List<ScratchCardWxUserWinning> queryScratchCardWxUserWinningByOpenidAndScratchCardWxUserId(String openid , String scratchCardWxUserId){
		String sql = PropKit.use("database.properties").get("queryScratchCardWxUserWinningByOpenidAndScratchCardWxUserId");
		return ScratchCardWxUserWinning.dao.find(sql,openid,scratchCardWxUserId);
	}
	
	/**
	 * 查询微信参与记录ID最多中奖三次的数据
	 */
	public List<ScratchCardWxUserWinning> queryScratchCardWxUserWinningByScratchCardWxUserId(String scratchCardWxUserId){
		String sql = PropKit.use("database.properties").get("queryScratchCardWxUserWinningByScratchCardWxUserId");
		return ScratchCardWxUserWinning.dao.find(sql,scratchCardWxUserId);
	}
	
	/**
	 * 根据活动ID查询微信用户参与记录
	 * @return
	 */
	public List<ScratchCardWxUser> queryScratchCardWxUserByActivityId(String id,String nickName){
		String sql = PropKit.use("database.properties").get("queryScratchCardWxUserByActivityId");
		if(nickName!=null){
			sql +=" AND NICKNAME like '%" + nickName + "%'";
		}
		return ScratchCardWxUser.dao.find(sql,id);
	}
	
	/**
	 * 根据活动ID查询出所有中奖奖品
	 */
	public List<ScratchCardPrize> queryScratchCardPrizeByActivityId(String activityId){
		String sql = PropKit.use("database.properties").get("queryScratchCardPrizeByActivityId");
		List<ScratchCardPrize> scratchCardPrizeList = ScratchCardPrize.dao.find(sql,activityId);
		return scratchCardPrizeList;
	}
	
	/**
	 * 根据openid和所扫码scanCode查询是否已经参加活动
	 * @param openid
	 * @param scanCode
	 * @return
	 */
	public List<ScratchCardWxUser> getScratchCardByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getScratchCardByOpenidAndQrCode");
		return ScratchCardWxUser.dao.find(sql,openid,scanCode);
	}
	
	/**
	 * 根据刮刮乐活动查询出相关活动所有的奖品配置
	 */
	public List<ScratchCardPrize>  getScratchCardPrizeByScratchCardId(String scratchCardId){
		String sql = PropKit.use("database.properties").get("getScratchCardPrizeByScratchCardId");
		List<ScratchCardPrize> scratchCardPrizeList = ScratchCardPrize.dao.find(sql,scratchCardId);
		return scratchCardPrizeList;
	}
	
	/**
	 * 1.根据刮刮乐ID修改奖品剩余数量和概率
	 * @param Id
	 * @param Number
	 * @param Probability
	 * @return
	 */
	public int updatePrizeNumberAndProbabilityById(String prizeId,String number,String probability){
		String sql = PropKit.use("database.properties").get("updatePrizeNumberAndProbabilityById");
		return Db.update(sql,number,probability,prizeId);
	}
	
	/**
	 * 修改转盘活动剩余参与活动总数
	 */
	public int updateScratchCardTotalById(String activityId,String number,int joinPropleNumber,int winningPropleNumber){
		String sql = PropKit.use("database.properties").get("updateScratchCardTotalById");
		return Db.update(sql,number,joinPropleNumber,winningPropleNumber,activityId);
	}
	
	/**
	 * 保存刮刮乐中奖记录
	 */
	public int saveScratchCardWinning(String id,String ScratchCardWxUserId,String prizeType,String winningPrizeId,String winningNumber,String prizeName,String createTime,String openid,String state,String productImg,String ProductWinningInfoId){
		String sql = PropKit.use("database.properties").get("saveScratchCardWinning");
		return Db.update(sql,id,ScratchCardWxUserId,prizeType,winningPrizeId,winningNumber,prizeName,createTime,openid,state,productImg,ProductWinningInfoId);
	}
	
	/**
	 * 修改刮刮乐活动剩余可抽奖次数和本次中奖金额或积分值
	 */
	public int updateScratchCardWxUserJoinNumberById(String scanWinningNumber,String totalMoney,String totalIntegral,String turntableWxuserId,String integralWinningNumber,String redWinningNumber
			,String goodsWinningNumber,String thinklWinningNumber){
		String sql = PropKit.use("database.properties").get("updateScratchCardWxUserJoinNumberById");
		return Db.update(sql,scanWinningNumber,totalMoney,totalIntegral,integralWinningNumber,redWinningNumber,goodsWinningNumber,thinklWinningNumber,turntableWxuserId);
	}
	
	/**
	 * 转盘奖品集合根据概率和剩余数量生成中奖奖品
	 * @param turnTablePrizeList
	 * @return
	 */
	public Object[] generateWinningPrize(List<ScratchCardPrize> scratchCardPrizeList ){
		Object[] winningPrize = new Object[2];
		//存储每个奖品新的概率区间
        List<Float> proSection = new ArrayList<Float>();
        proSection.add(0f);
        //总的概率区间
        float totalPro = 0f;
        for (ScratchCardPrize ttpBL : scratchCardPrizeList) {
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
        ScratchCardPrize winningTurnTablePrize = null;
        float randomPro = (float)random.nextInt((int)totalPro);
		 //判断取到的随机数在哪个奖品的概率区间中
        for (int i = 0,size = proSection.size(); i < size; i++) {
            if(randomPro >= proSection.get(i) && randomPro < proSection.get(i + 1)){
            	winningTurnTablePrize = scratchCardPrizeList.get(i);
            	winningPrize[0]=winningTurnTablePrize;
            	winningPrize[1]=i;
            }
        }
        
        return winningPrize;
	}
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public String scratchCardActivity(String scratchCardActivityID, String qrcode) {
		ScratchCard sc = ScratchCard.dao.findById(scratchCardActivityID);
		DateUitils.getUitils();
		// 判断是否属于活动时间内
		Date startDate = DateUitils.strToDateYMD(sc.getStartTime());
		Date endDate = DateUitils.strToDateYMD(sc.getEndTime());
		// 判断当前时间是否大于活动开始时间 返回fasle表示小于当前时间，代表活动已经开始
		boolean startTime = DateUitils.isDateBefore(startDate);
		// 判断当前时间是否大于活动结束时间 返回true表示大于当前时间，代表活动未结束
		boolean endTime = DateUitils.isDateBefore(endDate);
		String redirect = "";
		// 判断活动是否审批通过
		if (sc.getState().toString().equals("1")) {
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
					String userCode = sc.getAcitivityLaunchUserCode();
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
							+ JFinal.me().getContextPath() + "%2fscratchCard%2fscratchCard%3fActivity%3d"
							+ sc.getScratchcardId() + "%26qrcode%3d" + qrcode + "%26spn%3d" + spn.getId() 
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
	 * 分页查询 查询所有的红包活动的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		return ScratchCard.dao.paginate(pageNumber, pageSize,activityName,state,startTime,endTime,user);
	}
}
