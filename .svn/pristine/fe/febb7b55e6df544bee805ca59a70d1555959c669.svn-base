package com.activity.common.utils.wxInterface;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.security.KeyStore;
import java.util.HashMap;
import java.util.Map;

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

import com.activity.common.controller.moblie.shareBargain.ShareBargainController;
import com.jfinal.kit.PropKit;

/**
 * 微信发放红包
 * @author 唐
 *
 */
public class WxRedPackageUitils {
	private final Logger log = LoggerFactory.getLogger(ShareBargainController.class);
	private static WxRedPackageUitils WxRedPackageUitils = new WxRedPackageUitils();;
	private WxRedPackageUitils() {
	}
	public static WxRedPackageUitils getWxRedPackageUitils() {
		return WxRedPackageUitils;
	}
	// 工具类
	WxConfigUitils wxConfigUitils = WxConfigUitils.getWxConfigUitils();
	
	/**
	 * 企业付款至微信个人账户
	 * @param mch_billno
	 * @param mchId
	 * @param appid
	 * @param sendName
	 * @param openid
	 * @param totalAmount
	 * @param totalNum
	 * @param redWishing
	 * @param activityName
	 * @param redRemark
	 * @param payKey
	 * @return
	 */
	public Map<String, String> enterprisePayment(String mch_billno,String mchId,String appid,String sendName,String openid,String totalAmount,String totalNum,
			String redWishing,String activityName,String redRemark,String payKey,String certPath){
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> redOk = new HashMap<String, String>();
		try {
			//微信分配的公众账号ID（企业号corpid即为此appId）
			String mch_appid = appid.trim();
			log.error("发送现金红包-公众账号ID="+mch_appid);
			//微信支付分配的商户号
			String mchid = mchId.trim();
			log.error("发送现金红包-商户号="+mchid);
			//随机字符串，不长于32位
			String nonce_str  = WxConfigUitils.create_nonce_str32();
			log.error("发送现金红包-随机字符串="+nonce_str);
			//商户订单号
			String partner_trade_no	= mch_billno;
			//用户在wxappid下的openid
			log.error("发送现金红包-接受红包的用户="+openid);
			//校验用户姓名选项 ，NO_CHECK：不校验真实姓名  FORCE_CHECK：强校验真实姓名
			String check_name = "NO_CHECK";
			//付款金额，单位分
			String total_amount = totalAmount;
			// 支付金额
			BigDecimal re1 = new BigDecimal(total_amount);
			BigDecimal re2 = new BigDecimal(Float.toString(100.00f));
			Float aa = re1.multiply(re2).floatValue();
			String total_fee = String.valueOf(aa);
			String[] smill = total_fee.split("\\.");
			int amount = Integer.parseInt(smill[0]);
			//企业付款描述信息
			String desc = "恭喜获奖！";
			String spbill_create_ip = PropKit.use("system.properties").get("client_ip").trim();
			//支付密钥
			String key = payKey.trim();
			log.error("发送企业付款-支付密钥="+key);
			map.put("mch_appid", mch_appid);
			map.put("mchid", mchid);
			map.put("nonce_str", nonce_str);
			map.put("partner_trade_no", partner_trade_no);
			map.put("openid", openid);
			map.put("check_name", check_name);
			map.put("amount", amount+"");
			map.put("desc", desc);
			map.put("spbill_create_ip", spbill_create_ip);
			//获取签名
			String sign = WxConfigUitils.getPayCustomSign(map, key);
			log.error("企业付款-签名是="+sign);
			map.put("sign", sign);
			String xml = WxConfigUitils.ArrayToXml(map);
			log.error("企业付款-请求前封装XML="+xml);
			//发送普通红包请求路径
			String url = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";
			String xmlStr = ssl(url, xml,mchid,certPath);
			log.error("发送现金红包-请求返回XMLString="+xmlStr);
			//String xmlStr = HttpKit.post(url, xml);
			//判读是否成功    indexOf 方法返回一个整数值，指出 String 对象内子字符串的开始位置。如果没有找到子字符串，则返回-1。
			if (xmlStr.indexOf("SUCCESS") != -1) {
				redOk = WxConfigUitils.doXMLParse(xmlStr);
				redOk.put("state", "OK");
				log.error("企业付款-请求返回XMLString="+redOk);
			}else{
				redOk.put("state", "NoMoney");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return redOk;
	}
	
	
	/**
	 * 发送普通红包
	 * @param mchId  微信支付分配的商户号
	 * @param appid  微信分配的公众账号ID（企业号corpid即为此appId）
	 * @param sendName  红包发送者名称
	 * @param openid   接受红包的用户,用户在wxappid下的openid
	 * @param totalAmount  付款金额，单位分
	 * @param totalNum  红包发放总人数total_num=1
	 * @param redWishing  红包祝福语
	 * @param activityName  活动名称
	 * @param redRemark  备注信息   猜越多得越多，快来抢！
	 * @param payKey  支付密钥
	 * @return
	 */
	public Map<String, String> ordinaryRedPackage(String mch_billno,String mchId,String appid,String sendName,String openid,String totalAmount,String totalNum,
			String redWishing,String activityName,String redRemark,String payKey,String certPath){
		Map<String, String> map = new HashMap<String, String>();
		Map<String, String> redOk = new HashMap<String, String>();
		try {
			//随机字符串，不长于32位
			String nonce_str  = WxConfigUitils.create_nonce_str32();
			log.error("发送现金红包-随机字符串="+nonce_str);
			//商户订单号（每个订单号必须唯一。取值范围：0~9，a~z，A~Z）
			//String mch_billno = "wly"+RandomNumber();//WxConfigUitils.MchBillno().trim();
			log.error("发送现金红包-商户订单号="+mch_billno);
			//微信支付分配的商户号
			String mch_id = mchId.trim();
			log.error("发送现金红包-商户号="+mch_id);
			//微信分配的公众账号ID（企业号corpid即为此appId）
			String wxappid = appid.trim();
			log.error("发送现金红包-公众账号ID="+wxappid);
			//红包发送者名称
			String send_name = sendName.trim();
			log.error("发送现金红包-红包发送者名称="+send_name);
			//接受红包的用户,用户在wxappid下的openid
			String re_openid = openid;
			log.error("发送现金红包-接受红包的用户="+re_openid);
			//付款金额，单位分
			String total_amount = totalAmount;
			// 支付金额
			BigDecimal re1 = new BigDecimal(total_amount);
			BigDecimal re2 = new BigDecimal(Float.toString(100.00f));
			Float aa = re1.multiply(re2).floatValue();
			String total_fee = String.valueOf(aa);
			String[] smill = total_fee.split("\\.");
			total_amount = smill[0];
			log.error("发送现金红包-支付金额="+total_amount);
			//红包发放总人数total_num=1
			String total_num = totalNum.trim();
			log.error("发送现金红包-红包发放总人数="+total_num);
			//红包祝福语
			String wishing = redWishing.trim();
			log.error("发送现金红包-红包祝福语="+wishing);
			//调用接口的机器Ip地址
			String client_ip = PropKit.use("system.properties").get("client_ip").trim();
			log.error("发送现金红包-调用接口的机器Ip地址="+client_ip);
			//活动名称
			String act_name = activityName.trim();
			log.error("发送现金红包-活动名称="+act_name);
			//备注信息   猜越多得越多，快来抢！
			String remark = redRemark.trim();
			log.error("发送现金红包-备注信息="+remark);
			//支付密钥
			String key = payKey.trim();
			log.error("发送现金红包-支付密钥="+key);
			map.put("wxappid", wxappid);
			map.put("mch_id", mch_id);
			map.put("nonce_str", nonce_str);
			map.put("mch_billno", mch_billno);
			map.put("send_name", send_name);
			map.put("re_openid", re_openid);
			map.put("total_amount", total_amount);
			map.put("total_num", total_num);
			map.put("wishing", wishing);
			map.put("client_ip", client_ip);
			map.put("act_name", act_name);
			map.put("remark", remark);
			//获取签名
			String sign = WxConfigUitils.getPayCustomSign(map, key);
			log.error("发送现金红包-签名是="+sign);
			map.put("sign", sign);
			String xml = WxConfigUitils.ArrayToXml(map);
			log.error("发送现金红包-请求前封装XML="+xml);
			//发送普通红包请求路径
			String url = "https://api.mch.weixin.qq.com/mmpaymkttransfers/sendredpack";
			String xmlStr = ssl(url, xml,mch_id,certPath);
			log.error("发送现金红包-请求返回XMLString="+xmlStr);
			//String xmlStr = HttpKit.post(url, xml);
			//判读是否成功    indexOf 方法返回一个整数值，指出 String 对象内子字符串的开始位置。如果没有找到子字符串，则返回-1。
			if (xmlStr.indexOf("SUCCESS") != -1) {
				redOk = WxConfigUitils.doXMLParse(xmlStr);
				redOk.put("state", "OK");
				log.error("发送现金红包-请求返回XMLString="+redOk);
			}else{
				redOk.put("state", "NoMoney");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return redOk;
	}
	
	private String ssl(String url,String data,String mch_id,String certPath){
        StringBuffer message = new StringBuffer();
        try {
            KeyStore keyStore  = KeyStore.getInstance("PKCS12");
            //FileInputStream instream = new FileInputStream(new File("E:/cert/apiclient_cert.p12"));
            log.error("发送红包--SSL方法--准备读取文件");
            //FileInputStream instream = new FileInputStream(new File("D:/cert-3/apiclient_cert.p12"));
            //FileInputStream instream = new FileInputStream(new File(PropKit.get("p12Path")));
            FileInputStream instream = new FileInputStream(new File(certPath));
            log.error("发送红包--SSL方法--找到文件发送="+instream.toString());
            log.error("抢红包发送红包--SSL方法--商户号="+mch_id);
            keyStore.load(instream, mch_id.toCharArray());
            SSLContext sslcontext = SSLContexts.custom()
                    .loadKeyMaterial(keyStore, mch_id.toCharArray())
                    .build();
            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
                    sslcontext,
                    new String[] { "TLSv1" },
                    null,
            SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
            CloseableHttpClient httpclient = HttpClients.custom()
                    .setSSLSocketFactory(sslsf)
                    .build();
            HttpPost httpost = new HttpPost(url);

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
                if (entity != null) {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(entity.getContent(),"UTF-8"));
                    String text;
                    while ((text = bufferedReader.readLine()) != null) {
                        message.append(text);
                    }
                }
                EntityUtils.consume(entity);
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                response.close();
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        } 

        return message.toString();
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
