package com.activity.common.controller.pc.system;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.SocketException;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.system.SystemUser;
import com.activity.common.model.system.UploadImg;
import com.jfinal.kit.PropKit;
import com.jfinal.upload.UploadFile;
import com.web.controller.ControllerPath;

/**
 * 上传
 * 
 * @author 唐
 */
@ControllerPath(controllerKey = "/upload")
public class UploadController extends BaseController {
	public static UploadController upload = new UploadController();
	public UploadController() {}
	public static UploadController getUilt(){return upload;}
	
	public void loadImg() {
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		UploadFile img = getFile();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", 1);
		String url = PropKit.use("system.properties").get("upload") + img.getFileName();
		//集群文件共享，通过FTP上传至共享文件夹
		//ftp(img.getUploadPath()+"\\",img.getFileName());
		map.put("path", url);
		UploadImg upi = new UploadImg();
		upi.set("ID", newId()).set("IMG_URL", url).set("USERCODE", user.getUserCode())
				.set("USERID", user.getUserId().toString()).save();
		renderJson(map);
	}
	
	/**
	 * FTP文件上传
	 */
	 public void ftp(String filePath,String fileName){
	       //创建客户端对象
	       FTPClient ftp = new FTPClient();
	       InputStream local=null;
	       try {
	           //连接ftp服务器
	           ftp.connect("192.168.0.17", 21);
	           //登录
	           ftp.login("thb", "1234");
	           //设置上传路径
	           String path="E:\\ActivityUploadPath";
	           //检查上传路径是否存在 如果不存在返回false
	           boolean flag = ftp.changeWorkingDirectory(path);
	           if(!flag){
	               //创建上传的路径  该方法只能创建一级目录，在这里如果/home/ftpuser存在则可创建image
	               ftp.makeDirectory(path);
	           }
	           //指定上传路径
	           ftp.changeWorkingDirectory(path);
	           //指定上传文件的类型  二进制文件
	           ftp.setFileType(FTP.BINARY_FILE_TYPE);
	           //读取本地文件
	           File file = new File(filePath+fileName);
	           local = new FileInputStream(file);
	           //第一个参数是文件名
	           ftp.storeFile(file.getName(), local);
	        } catch (SocketException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }finally {
	            try {
	                //关闭文件流
	                local.close();
	                //退出
	                ftp.logout();
	                //断开连接
	                ftp.disconnect();
	            } catch (IOException e) {
	                e.printStackTrace();
	            }
	        }
	   }
	
	//生成上传文件的名称
    public static String getFileName(String primitiveFileName){
        //使用uuid生成文件名
        String fileName=UUID.randomUUID().toString();
        //获取文件后缀
        String suffix=primitiveFileName.substring(primitiveFileName.lastIndexOf("."));
        return fileName+suffix;
    }
	 
	 public String getPlsImg(HttpServletRequest request,String path) throws Exception {  
	        //new一个URL对象  
	        URL url = new URL(path);  
	        //打开链接  
	        HttpURLConnection conn = (HttpURLConnection)url.openConnection();
	        //设置请求方式为"GET"  
	        conn.setRequestMethod("GET");  
	        //超时响应时间为5秒  
	        conn.setConnectTimeout(5 * 1000);  
	        //通过输入流获取图片数据  
	        InputStream inStream = conn.getInputStream();  
	        //得到图片的二进制数据，以二进制封装得到数据，具有通用性  
	        byte[] data = readInputStream(inStream);  
	        //new一个文件对象用来保存图片，默认保存当前工程根目录  
	        java.util.Random random=new java.util.Random();
			int result=random.nextInt(1000);
			String imgName = Long.toString(System.currentTimeMillis() / 1000)+result+".jpg";
	        File imageFile = new File(PropKit.get("uploadFilePath")+"/"+imgName);  
	       	//创建输出流  
	        FileOutputStream outStream = new FileOutputStream(imageFile);  
	        //写入数据  
	        outStream.write(data);  
	        //关闭输出流  
	        outStream.close();
	        return PropKit.use("system.properties").get("upload")+imgName;
	    }  
	 
	 
	    public static byte[] readInputStream(InputStream inStream) throws Exception{  
	        ByteArrayOutputStream outStream = new ByteArrayOutputStream();  
	        //创建一个Buffer字符串  
	        byte[] buffer = new byte[1024];  
	        //每次读取的字符串长度，如果为-1，代表全部读取完毕  
	        int len = 0;  
	        //使用一个输入流从buffer里把数据读取出来  
	        while( (len=inStream.read(buffer)) != -1 ){  
	            //用输出流往buffer里写入数据，中间参数代表从哪个位置开始读，len代表读取的长度  
	            outStream.write(buffer, 0, len);  
	        }  
	        //关闭输入流  
	        inStream.close();  
	        //把outStream里的数据写入内存  
	        return outStream.toByteArray();  
	    }  
	
	
	
	
	/**
	 * 获取当前人全部图片
	 */
	public void getUserAllImg() {
		SystemUser user = (SystemUser) getSession().getAttribute("loginUser");
		String sql = PropKit.use("database.properties").get("getUserAllImg");
		List<UploadImg> upi = UploadImg.dao.find(sql, user.getUserCode(), user.getUserId());
		renderJson(upi);
	}

	/**
	 * 保存微信获取的图片
	 */
	public void WxImgSave() {
		String serverId = getPara("serverId");
		String imageName=null;
		try {
			imageName = saveImageToDisk(serverId,null,null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String,String> map=new HashMap<>();
		map.put("imageName", imageName);
		renderJson(map);
		}

	/**
	 * 获取下载图片信息（jpg）
	 * @param mediaId 文件的id
	 * @throws Exception
	 */

	public String saveImageToDisk(String mediaId,String appid,String appSecret) throws Exception {
		InputStream inputStream = getInputStream(mediaId,appid,appSecret);
		byte[] data = new byte[1024];
		int len = 0;
		FileOutputStream fileOutputStream = null;
		String imgName=null;
		try {
			String imgPath=PropKit.use("system.properties").get("imgPath");
			imgName=newId()+".png";
			String filePath=imgPath+imgName;
			fileOutputStream = new FileOutputStream(filePath);
			while ((len = inputStream.read(data)) != -1) {
				fileOutputStream.write(data, 0, len);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fileOutputStream != null) {
				try {
					fileOutputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return imgName;
	}
	
	/**
	 * 删除图片
	 */
	public void deleteImg(){
		String srcUrl = getPara("srcUrl");
		String sql="select * from upload_img where img_url = ? ";
		List<UploadImg> list = UploadImg.dao.find(sql,srcUrl);
		boolean deleteById=false;
		for (UploadImg uploadImg : list) {
			deleteById = UploadImg.dao.deleteById(uploadImg.getId());
		}
		if(deleteById){
			deleteFile(getRequest(),srcUrl);
		}
		renderJson(deleteById);
	}
	
	/**
     * 删除单个文件
     *
     * @param fileName
     *            要删除的文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
	public static boolean deleteFile(HttpServletRequest request,String fileName) {
		File file = new File(request.getSession().getServletContext().getRealPath("/")+fileName);
		// 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
		if (file.exists() && file.isFile()) {
			if (file.delete()) {
				System.out.println("删除单个文件" + fileName + "成功！");
				return true;
			} else {
				System.out.println("删除单个文件" + fileName + "失败！");
				return false;
				}
			} 
		else {
			System.out.println("删除单个文件失败：" + fileName + "不存在！");
			return false;
			}
	}
	
	
	/**
	 * 根据文件id下载文件
	 * @param mediaId媒体id
	 * @throws Exception
	 */

	public InputStream getInputStream(String mediaId,String appid,String appSecret) {
		InputStream is = null;
		String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				+ getAccessToken(appid,appSecret) + "&media_id=" + mediaId;
		try {
			URL urlGet = new URL(url);
			HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
			http.setRequestMethod("GET"); // 必须是get方式请求
			http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
			http.setDoOutput(true);
			http.setDoInput(true);
			System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
			System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
			http.connect();
			// 获取文件转化为byte流
			is = http.getInputStream();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return is;

	}

	
}
