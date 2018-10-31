package com.activity.common.utils.wxInterface;

import java.io.BufferedOutputStream;
import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xml.sax.InputSource;
import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.WxPayResult;
import com.activity.common.model.activity.ProductWinningInfo;
import com.activity.common.model.groupPurchase.GroupPurchase;
import com.activity.common.model.groupPurchase.GroupPurchaseGroupWxUser;
import com.activity.common.model.groupPurchase.GroupPurchaseWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyGroupWxUser;
import com.activity.common.model.oneMoneyShop.OneMoneyShop;
import com.activity.common.model.oneMoneyShop.OneMoneyWxUser;
import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.model.shareBargain.ShareBargainWxuser;
import com.activity.common.service.shareBargain.ShareBargainWxuserService;
import com.activity.common.utils.system.Tools;
import com.jfinal.aop.Clear;
import com.jfinal.weixin.sdk.api.ApiConfigKit;
import com.web.Interceptor.LoginInterceptor;
import com.web.controller.ControllerPath;

@ControllerPath(controllerKey = "/wxpayxml")
public class PayNotify extends BaseController {
	
	private final Logger log = LoggerFactory.getLogger(PayNotify.class);
	@Clear(LoginInterceptor.class)
	public void analysisXml() throws Exception {
		String inputLine;
		String notityXml = "";
		String resXml = "";
		try {
			while ((inputLine = getRequest().getReader().readLine()) != null) {
				notityXml += inputLine;
			}
			getRequest().getReader().close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, String> m = parseXmlToList2(notityXml);
		WxPayResult wpr = new WxPayResult();
		wpr.setAppid(m.get("appid").toString());
		wpr.setBankType(m.get("bank_type").toString());
		wpr.setCashFee(m.get("cash_fee").toString());
		wpr.setFeeType(m.get("fee_type").toString());
		wpr.setIsSubscribe(m.get("is_subscribe").toString());
		wpr.setMchId(m.get("mch_id").toString());
		wpr.setNonceStr(m.get("nonce_str").toString());
		wpr.setOpenid(m.get("openid").toString());
		String openId = m.get("openid").toString();
		// out_trade_no：系统本身订单ID
		String out_trade_no = m.get("out_trade_no").toString();
		wpr.setOutTradeNo(out_trade_no);
		wpr.setResultCode(m.get("result_code").toString());
		wpr.setReturnCode(m.get("return_code").toString());
		wpr.setSign(m.get("sign").toString());
		wpr.setTimeEnd(m.get("time_end").toString());
		wpr.setTotalFee(m.get("total_fee").toString());
		wpr.setTradeType(m.get("trade_type").toString());
		// //transaction_id：微信支付系统订单ID，有微信支付系统生成
		wpr.setTransactionId(m.get("transaction_id").toString());
		if ("SUCCESS".equals(wpr.getResultCode())) {
			//在这里处理业务逻辑    // 支付成功
			/**
			 * 1.根据商户号和订单号查询出支付的参与活动用户 2.保存支付金额    这是分享砍价
			 */
			if(m.get("out_trade_no").contains("share")){
				List<ShareBargainWxuser> sbwList = ShareBargainWxuserService.getService()
						.getSbwByMchIdAndoutTradeNo(m.get("mch_id").toString(), m.get("out_trade_no").toString());
				if (sbwList.size() > 0) {
					ShareBargainWxuser sbw = new ShareBargainWxuser();
					for (ShareBargainWxuser sbwErgodic : sbwList) {
						sbw = sbwErgodic;
					}
					String money = m.get("total_fee").toString();
					int moneyInt = Integer.parseInt(money);
					float moneyNum = (float) (moneyInt * 0.01);
					String moneyStr=moneyNum+"";
					String id = sbw.getId();
					new ShareBargainWxuser().set("ID", id).set("PAY_MONEY", moneyStr).set("STATE", "6").update();
					String sql="select* from TB_PRODUCT_WINNING_INFO where ACTIVITY_WXUSER_ID = ? ";
					ProductWinningInfo pwi = ProductWinningInfo.dao.findFirst(sql,id);
					pwi.set("ID", pwi.getId()).set("PAY_MONEY", moneyStr).set("PRICE", sbw.getPrice()).set("LOW_PRICE", sbw.getLowPrice()).update();
				}
			}
			//这里是处理支付完成 一元购
			else if(m.get("out_trade_no").toString().contains("money")){
				String payoutNo = m.get("out_trade_no");
				log.error("---微信回调记录订单---"+out_trade_no+"---openid---"+wpr.getOpenid());
				//首先去团里面找一下这个用户，如果这个用户是该活动发起者，则执行下面的代码     如果是团员的话，则执行新增的代码
				String sqlGroup="select * from TB_ONE_MONEY_GROUP_WXUSER where PAYOUTNO = ? ";
				OneMoneyGroupWxUser oneMoneyGroupWxUser = OneMoneyGroupWxUser.dao.findFirst(sqlGroup,payoutNo);
				if(oneMoneyGroupWxUser!=null){
					//根据参与人找出该团的团长参与的用户
					String oneMoneyWxUserId = oneMoneyGroupWxUser.getOneMoneyWxUserId();
					OneMoneyWxUser oneMoneyWxUser = OneMoneyWxUser.dao.findById(oneMoneyWxUserId);
					//该团长的活动所属公众号
					String sellerNumberId = oneMoneyWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber= SellerPublicNumber.dao.findById(sellerNumberId);
					//这是查找的一元购的大活动
					String oneMoneyId= oneMoneyWxUser.getOneMoneyId();
					OneMoneyShop oneMoneyShop= OneMoneyShop.dao.findById(oneMoneyId);
					oneMoneyWxUser.set("ID", oneMoneyWxUserId)
                                  .set("PAYMONEY", oneMoneyWxUser.getPayMoney())
                                  .set("PAYSTATE", "1")
                                  .update();
					// 发送参与成功通知
					if(sellerNumberId!=null){
						String activityUrl="%2foneMoneyShop%2fgoFriendRedirect%3foneMoneyWxUserId%3d" + oneMoneyWxUser.getId() + "%26oneMoneyId%3d" + oneMoneyId+ "%26sellerNumberId%3d" + sellerNumberId+ "%26qrcode%3d" + oneMoneyWxUser.getScanCode();
						//这里推送参与成功通知
						ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
						ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
						Tools.sendJoinNotice(openId, sellerPublicNumber, activityUrl, oneMoneyShop.getActivityName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
						ApiConfigKit.removeThreadLocalAppId();
					}
				}
			}
			//这里是处理支付完成 拼团
			else if(m.get("out_trade_no").toString().contains("purchase")){
				String payoutNo = m.get("out_trade_no").toString();
				//根据订单号查询  拼团的组团的团长 所属的信息
				String sql="select * from TB_GROUP_PURCHASE_GROUP_WXUSER where PAYOUTNO = ? ";
				GroupPurchaseGroupWxUser groupPurchaseGroupWxUser = GroupPurchaseGroupWxUser.dao.findFirst(sql,payoutNo);
				if(groupPurchaseGroupWxUser!=null){
					//这是该团的团长参与的微信活动
					String groupPurchaseWxUserId = groupPurchaseGroupWxUser.getGroupPurchaseWxUserId();
					GroupPurchaseWxUser groupPurchaseWxUser = GroupPurchaseWxUser.dao.findById(groupPurchaseWxUserId);
					//该活动的拼团大活动
					String groupPurchaseId = groupPurchaseWxUser.getGroupPurchaseId();
					GroupPurchase groupPurchase = GroupPurchase.dao.findById(groupPurchaseId);
					//公众号
					String sellerNumberId = groupPurchaseWxUser.getBelongPublicNumberId();
					SellerPublicNumber sellerPublicNumber = SellerPublicNumber.dao.findById(sellerNumberId);
					String money = m.get("total_fee").toString();
					int moneyInt = Integer.parseInt(money);
					float moneyNum = (float) (moneyInt * 0.01);
					String moneyStr=moneyNum+"";
					groupPurchaseWxUser.set("ID", groupPurchaseWxUserId)
                            .set("PAYMONEY", moneyStr)
                            .set("PAYSTATE", "1")
                            .update();
					if(sellerPublicNumber!=null){
						String activityUrl="%2fgroupPurchase%2fgoFriendRedirect%3fgroupPurchaseWxUserId%3d" + groupPurchaseWxUser.getId() + "%26groupPurchaseId%3d" + groupPurchase.getId()+ "%26sellerNumberId%3d" + sellerNumberId+ "%26qrcode%3d" + groupPurchaseWxUser.getScanCode();
						//这里推送参与成功通知
						ApiConfigKit.putApiConfig(WxConfigUitils.getApiConfig(sellerPublicNumber.getToKen(), sellerPublicNumber.getAppId(), sellerPublicNumber.getAppSecret()));
						ApiConfigKit.setThreadLocalAppId(sellerPublicNumber.getAppId());
						Tools.sendJoinNotice(openId, sellerPublicNumber, activityUrl, groupPurchase.getActivityName(), getAccessToken(sellerPublicNumber.getAppId(),sellerPublicNumber.getAppSecret()));
						ApiConfigKit.removeThreadLocalAppId();
						groupPurchaseGroupWxUser.set("ID", groupPurchaseGroupWxUser.getId()).set("PAYSTATE", "1").update();
					}
				}
			}
			resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
					+ "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
			
		} else {
			resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
					+ "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
			
		}
		BufferedOutputStream out = new BufferedOutputStream(getResponse().getOutputStream());
		out.write(resXml.getBytes());
		out.flush();
		out.close();
		renderNull();
	}

	/**
	 * description: 解析微信通知xml
	 * 
	 * @param xml
	 * @return
	 * @author
	 * @see
	 */
	private Map<String, String> parseXmlToList2(String xml) {
		Map<String, String> retMap = new HashMap<String, String>();
		try {
			StringReader read = new StringReader(xml);
			// 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
			InputSource source = new InputSource(read);
			// 创建一个新的SAXBuilder
			SAXBuilder sb = new SAXBuilder();
			// 通过输入源构造一个Document
			Document doc = (Document) sb.build(source);
			Element root = doc.getRootElement();// 指向根节点
			@SuppressWarnings("unchecked")
			List<Element> es = root.getChildren();
			if (es != null && es.size() != 0) {
				for (Element element : es) {
					retMap.put(element.getName(), element.getValue());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}
}
