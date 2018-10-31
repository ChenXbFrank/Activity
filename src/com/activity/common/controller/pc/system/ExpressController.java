package com.activity.common.controller.pc.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.activity.common.controller.moblie.base.BaseController;
import com.activity.common.model.system.Express;
import com.jfinal.kit.PropKit;
import com.web.controller.ControllerPath;

/**
 * @author ChenXb
 *
 * 2018年1月26日
 */
@ControllerPath(controllerKey = "/express")
public class ExpressController extends BaseController {
	
	/**
	 * 进入首页
	 */
	public void index(){
		render("/system/logistics-management.html");
	}
	
	/**
	 * 查询所有的快递公司   分页
	 */
	public void list(){
		Integer pageNumber = getParaToInt("currentPage");
		String name = getPara("name");
		String pageCount = PropKit.use("system.properties").get("pageCount");
		int page = Integer.parseInt(pageCount);
		Map<String, Object> map = Express.dao.paginate(pageNumber, page, name);
		renderJson(map);
	}
	
	/**
	 * 下拉框快递公司
	 */
	public void comPanyList(){
		String sql="select * from TB_EXPRESS";
		List<Express> list = Express.dao.find(sql);
		Map<String, Object> map=new HashMap<>();
		map.put("list", list);
		renderJson(map);
	}
	
	
	/**
	 * 新增快递公司
	 */
	public void add(){
		String name = getPara("name");
		String remark = getPara("remark");
		Express e=new Express();
		boolean save = e.set("ID", newId()).set("NAME", name).set("REMARK", remark).save();
		if(save){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 修改快递公司
	 */
	public void edit(){
		String id = getPara("id");
		String name = getPara("name");
		String remark = getPara("remark");
		Express express = Express.dao.findById(id);
		boolean update = express.set("ID", id).set("NAME", name).set("REMARK", remark).update();
		if(update){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
	/**
	 * 删除快递公司
	 */
	public void delete(){
		String id = getPara("id");
		boolean deleteById = Express.dao.deleteById(id);
		if(deleteById){
			renderJson("result","true");
		}else{
			renderJson("result","false");
		}
	}
	
}
