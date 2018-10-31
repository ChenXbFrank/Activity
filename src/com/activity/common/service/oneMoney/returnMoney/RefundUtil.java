package com.activity.common.service.oneMoney.returnMoney;

import java.io.File;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.activity.common.model.publicNumber.SellerPublicNumber;
import com.activity.common.utils.wxInterface.WxConfigUitils;
import com.jfinal.kit.PropKit;

public class RefundUtil {
	private final Logger log = LoggerFactory.getLogger(RefundUtil.class);
	private static RefundUtil refundUtil = new RefundUtil();

	private RefundUtil() {
	}

	public static RefundUtil getRefundUtil() {
		return refundUtil;
	}
	/**
	 * 退款函数，该方法可以对曾经部分退款的订单进行再次退款
	 * 
	 * @param out_trade_no
	 *            商户订单号
	 * @param total_fee1
	 *            退款对应的订单的总金额（以“元”为单位）
	 * @param refund_fee1
	 *            计划退款的金额（以“元”为单位）
	 * @return
	 */
	public synchronized String wechatRefund1(SellerPublicNumber sellerPublicNumber, String out_trade_no, double total_fee1,
			double refund_fee1) {
		log.error("****out_trade_no***"+out_trade_no);
		String out_refund_no = UUID.randomUUID().toString().substring(0, 32);// 退款单号，随机生成
																				// ，但长度应该跟文档一样（32位）(卖家信息校验不一致，请核实后再试)
		int total_fee = (int) total_fee1 ;// 订单的总金额,以分为单位（填错了貌似提示：同一个out_refund_no退款金额要一致）
		int refund_fee = (int) refund_fee1;// 退款金额，以分为单位（填错了貌似提示：同一个out_refund_no退款金额要一致）
		String nonce_str = UUID.randomUUID().toString().substring(0, 32);// 随机字符串
		// 微信公众平台文档：“基本配置”--》“开发者ID”
		String appid = sellerPublicNumber.getAppId();
		// 微信公众平台文档：“基本配置”--》“开发者ID”
		String appsecret = sellerPublicNumber.getAppSecret();
		System.out.println("支付密要*****" + appsecret);
		// 商户号
		// 微信公众平台文档：“微信支付”--》“商户信息”--》“商户号”，将该值赋值给partner
		String mch_id = sellerPublicNumber.getShopNumber();
		// 微信公众平台："微信支付"--》“商户信息”--》“微信支付商户平台”（登录）--》“API安全”--》“API密钥”--“设置密钥”（设置之后的那个值就是partnerkey，32位）
		String partnerkey = sellerPublicNumber.getPayKey();
		Map<String, String> map = new HashMap<String, String>();
		map.put("appid", appid);
		map.put("mch_id", mch_id);
		map.put("nonce_str", nonce_str);
		map.put("out_refund_no", out_refund_no);
		map.put("out_trade_no", out_trade_no);
		map.put("refund_fee", refund_fee + "");
		map.put("total_fee", total_fee + "");
		String sign = null;
		try {
			sign = WxConfigUitils.getPayCustomSign(map, partnerkey);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		map.put("sign", sign);
		String xml = WxConfigUitils.ArrayToXml(map);
		String createOrderURL = "https://api.mch.weixin.qq.com/secapi/pay/refund";
		String refundResult=null;
		try {
			refundResult = doRefund(mch_id, createOrderURL, xml);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return refundResult;
	}

	/**
	 * 该方法默认全额退款，但如果该订单曾经退款一部分，那么就不可使用该方法
	 * 
	 * @param out_trade_no
	 *            商户订单号
	 * @param total_fee1
	 *            总的退款金额（以“元”为单位）
	 */
	public String wechatRefund(SellerPublicNumber sellerPublicNumber, String out_trade_no, double total_fee1) {
		String refundResult = wechatRefund1(sellerPublicNumber, out_trade_no, total_fee1, total_fee1);
		return refundResult;
	}

	public static String doRefund(String partner, String url, String data) throws Exception {
		KeyStore keyStore = KeyStore.getInstance("PKCS12");
		//FileInputStream instream = new FileInputStream("E:/cert/apiclient_cert.p12");// P12文件目录
		FileInputStream instream = new FileInputStream(new File(PropKit.get("p12Path")));
		try {
			keyStore.load(instream, partner.toCharArray());
		} finally {
			instream.close();
		}
		SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, partner.toCharArray())// 这里也是写密码的
				.build();
		SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" }, null,
				SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
		CloseableHttpClient httpclient = HttpClients.custom().setSSLSocketFactory(sslsf).build();
		try {
			HttpPost httpost = new HttpPost(url); // 设置响应头信息
			httpost.addHeader("Connection", "keep-alive");
			httpost.addHeader("Accept", "*/*");
			httpost.addHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
			httpost.addHeader("Host", "api.mch.weixin.qq.com");
			httpost.addHeader("X-Requested-With", "XMLHttpRequest");
			httpost.addHeader("Cache-Control", "max-age=0");
			httpost.addHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0) ");
			httpost.setEntity(new StringEntity(data, "UTF-8"));
			CloseableHttpResponse response = httpclient.execute(httpost);
			try {
				HttpEntity entity = response.getEntity();

				String jsonStr = EntityUtils.toString(response.getEntity(), "UTF-8");
				EntityUtils.consume(entity);
				return jsonStr;
			} finally {
				response.close();
			}
		} finally {
			httpclient.close();
		}
	}
}
