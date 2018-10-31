package com.activity.common.utils.qrcode;

import javax.imageio.ImageIO;

import com.swetake.util.Qrcode;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;


public class ProduceQRCode {

	public static void main(String[] args) {
        String imgPath = "D:/新建/baidu.png";// 最后生成的图片地址
        String content = "https://www.baidu.com/";
        boolean boo = createQRCode(content, imgPath);
        System.out.println(boo);
        System.out.println(imgPath);
    }
	
	/**
	 * 	根据二维码内容，二维码存储路径生成二维码
	 * 详细参照上面main方法
	 * @param content
	 * @param imgPath
	 * @return 
	 * content内容,imgPath图片存储路径
	 */
	public static Boolean createQRCode(String content, String imgPath) {
        try {
            Qrcode qrcodeHandler = new Qrcode();
            qrcodeHandler.setQrcodeErrorCorrect('H');// 设置二维码排错率，可选L(7%)、M(15%)、Q(25%)、H(30%)，排错率越高可存储的信息越少，但对二维码清晰度的要求越小
            qrcodeHandler.setQrcodeEncodeMode('B');// N代表数字,A代表字符a-Z,B代表其他字符
            qrcodeHandler.setQrcodeVersion(9);// 设置设置二维码版本，取值范围1-40，值越大尺寸越大，可存储的信息越大
            byte[] contentBytes = content.getBytes("utf-8");// 设置编码格式为UTF-8
            BufferedImage bufImg = new BufferedImage(164, 164, BufferedImage.TYPE_INT_RGB);
            Graphics2D gs = bufImg.createGraphics();
            gs.setBackground(Color.white); // 设置背景色为白色
            gs.clearRect(0, 0, 168, 168);
            gs.setColor(Color.BLACK); // 设定图像颜色 为绿色
            int pixoff = 2; // 设置偏移量 不设置可能导致解析出错
            // 输出内容 > 二维码
            if (contentBytes.length > 0 && contentBytes.length < 150) {
                boolean[][] codeOut = qrcodeHandler.calQrcode(contentBytes);
                for (int i = 0; i < codeOut.length; i++) {
                    for (int j = 0; j < codeOut.length; j++) {
                        if (codeOut[j][i]) {
                            gs.fillRect(j * 3 + pixoff, i * 3 + pixoff, 3, 3);
                        }
                    }
                }
            } else {
                return false;
            }
            gs.dispose();
            bufImg.flush();
            File imgFile = new File(imgPath);
            ImageIO.write(bufImg, "png", imgFile);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
}
}
