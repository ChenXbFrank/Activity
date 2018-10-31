package com.activity.common.service.puzzle;

import java.util.Date;
import java.util.List;
import java.util.Map;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.puzzle.Puzzle;
import com.activity.common.model.puzzle.PuzzleWxUser;
import com.activity.common.model.system.SystemUser;
import com.activity.common.service.system.SellerPublicNumberService;
import com.activity.common.utils.date.DateUitils;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;

/**
 * @author ChenXb
 *
 * 2017年11月6日
 */
public class PuzzleService {
	private static PuzzleService puzzleService = new PuzzleService();

	private PuzzleService() {
	}

	public static PuzzleService getService() {
		return puzzleService;
	}
	
	/**
	 * 1.根据运单中的活动ID，找到活动 2.判断活动是否属于时间内 3.返回需要跳转的地址或公众号
	 * 
	 * @param turntableActivityID
	 * @param qrcode
	 * @return
	 */
	public String puzzleActivity(String puzzleActivityID, String qrcode) {
		Puzzle sb = Puzzle.dao.findById(puzzleActivityID);
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
							+ JFinal.me().getContextPath() + "%2fpuzzle%2fpuzzle%3fActivity%3d"
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
	public PuzzleWxUser getPuzzleByOpenidAndQrCode(String openid,String scanCode){
		String sql = PropKit.use("database.properties").get("getPuzzleByOpenidAndQrCode");
		return PuzzleWxUser.dao.findFirst(sql,openid,scanCode);
	}
	
	/**
	 * 分页查询 查询所有的集赞活动的信息
	 * 
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public Map<String, Object> paginate(int pageNumber, int pageSize,String activityName,String state,String startTime,String endTime,SystemUser user) {
		return Puzzle.dao.paginate(pageNumber, pageSize,activityName,state,startTime,endTime,user);
	}
	
	/**
	 * 保存集赞评论记录
	 */
	public int savePuzzleWxUser(String id,String puzzleId,String openId,String nickName,String headImg,
			String createTime,String publicNumber,String scanCode,String activityName,String state){
		String saveSql = PropKit.use("database.properties").get("savePuzzleWxUser");
		return Db.update(saveSql,id,puzzleId,openId,nickName,headImg,createTime,publicNumber,scanCode,activityName,state);
	}
}
