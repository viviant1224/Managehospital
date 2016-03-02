package cn.com.shxt.action_1;

import java.io.File;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;


import org.apache.struts2.ServletActionContext;
import cn.com.shxt.beans.PageBean;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Keshi;
import cn.com.shxt.model.Orderinfo;
import cn.com.shxt.model.Patient;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.model.YuyueTime;
import cn.com.shxt.utils.Dealyuyuedate;
import cn.com.shxt.utils.FileUpload;
import cn.com.shxt.utils.LoginfoTools;
import cn.com.shxt.utils.PageTools;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserinfoDocAction extends  ActionSupport{
	private static final long serialVersionUID = -7610185450181922985L;
	private UserinfoDoc userinfo;
	private UserinfoDoc userinfo1;//修改的用户
	private Dao dao = new DaoBean();
	private String keshi;
	private String keshi1;//修改的科室
	private List<UserinfoDoc> userlist ;
	private PageBean pageBean;
	private String yuyuetime;
	private String yuyuetime1;//修改的预约时间
	private List<YuyueTime> yuyueTimelist;
	private String UpyuyueTime;//修改用户的预约时间
	private String message;
	//返回预约号状态
	
	//添加专家
public String add() throws Exception {
	System.out.println("------"+userinfo.getDname());
	System.out.println("------"+userinfo.getDtel());
	System.out.println("------"+userinfo.getDbirthday());
	System.out.println("------"+keshi);
	Keshi keshi_ = (Keshi)dao.getObjectForId(Keshi.class,keshi);
	FileUpload fu = new FileUpload();
	String houzui = userinfo.getDimageFileName().substring(userinfo.getDimageFileName().lastIndexOf("."));
	String changename = fu.getNewName(userinfo.getDimageFileName());
	String newname = ""+changename+houzui;
	fu.uploadFile(userinfo.getDimage(),newname);
	System.out.println("--------1-------");
	userinfo.setDbirthday(userinfo.getDbirthday());
	userinfo.setDimageFileName(newname);
	userinfo.setDname(userinfo.getDname());
	userinfo.setDstate("可用");
	userinfo.setDtel(userinfo.getDtel());
	userinfo.setPassword(userinfo.getPassword());
	userinfo.setKeshi(keshi_);
	System.out.println("--------2-------");
	Set<UserinfoDoc> usetforyuyue = new HashSet<UserinfoDoc>();
	usetforyuyue.add(userinfo);
	//判断是否有选中预约日期
		if(yuyuetime!=null) {
			String [] yuyuetime_ = yuyuetime.toString().split(", ");
			Set<YuyueTime> weekset = new HashSet<YuyueTime>();
			for(int i = 0;i<yuyuetime_.length;i++) {
				YuyueTime week = (YuyueTime)dao.getObjectForId(YuyueTime.class,""+yuyuetime_[i]);
				weekset.add(week);
			}
			System.out.println("--------3-------");
			userinfo.setWeek(weekset);
		}
		dao.save(userinfo);
	LoginfoTools.logWrite(UserinfoDocAction.class, "注册了姓名为："+userinfo.getDname()+"编号为："+userinfo.getId()+"的专家。");
	return showall();
}
@SuppressWarnings("deprecation")
//删除专家
public String delete() throws Exception {
	String id = ServletActionContext.getRequest().getParameter("id");
	System.out.println("----------------------"+id);
	UserinfoDoc userinfo = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, id);
	String path = ServletActionContext.getRequest().getRealPath("/upload");
	File file = new File(path+File.separator+userinfo.getDimageFileName());
	if(file.exists()) {
		file.delete();
		System.out.println("删除成功");
	} else {
		System.out.println("没有该文件存在");
	}
	userinfo.setDstate("不可用");
	LoginfoTools.logWrite(UserinfoDocAction.class, "删除了姓名为："+userinfo.getDname()+"的专家");
	dao.update(userinfo);
	return showall();
}
//修改用户预约时间

public String upYuyueTime() throws Exception {
	String yuyueid = ServletActionContext.getRequest().getParameter("yuyuenum");
	Orderinfo orderinfo = (Orderinfo)dao.getObjectForId(Orderinfo.class, yuyueid);
	orderinfo.setOrderdate(UpyuyueTime);
	dao.update(orderinfo);
	LoginfoTools.logWrite(UserinfoDocAction.class, "延迟了姓名为："+orderinfo.getPname()+"的预约时间");
	return showAllyuyue();
	
}
//删除病人
@SuppressWarnings("deprecation")
public String deletePa() throws Exception {
	String id = ServletActionContext.getRequest().getParameter("id");
	System.out.println("----------------------"+id);
	Patient patient = (Patient)dao.getObjectForId(Patient.class, id);
	String path = ServletActionContext.getRequest().getRealPath("/upload");
	File file = new File(path+File.separator+patient.getPimageFileName());
	if(file.exists()) {
		file.delete();
		System.out.println("删除成功");
	} else {
		System.out.println("没有该文件存在");
	}
	LoginfoTools.logWrite(UserinfoDocAction.class, "删除了姓名为："+patient.getPname()+"的病人");
	dao.deleteObject(patient);
	return showpa();
}
//管理预约时间
public String yuyueTiem() throws Exception{
	String hql = "from YuyueTime order by id";
	yuyueTimelist = dao.getListForHql(hql);
	return "manageryuyueTime";
}
//查询专家详情
public String update() throws Exception {
	String id = ServletActionContext.getRequest().getParameter("id");
	userinfo1 = new UserinfoDoc();
	userinfo1 = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, id);
	System.out.println("username = "+userinfo1.getDname());
	return "update";
}
//更改预约时间的状态表
@SuppressWarnings("rawtypes")
public String updateYuyuTime() throws Exception {
	String yid = ServletActionContext.getRequest().getParameter("yid");
	YuyueTime yuyueTime = (YuyueTime)dao.getObjectForId(YuyueTime.class, yid);
	yuyueTime.setUserinfo(null);
	String yuyuestate = yuyueTime.getTimestate();
	if(yuyuestate.equals("可用")) {
		yuyueTime.setTimestate("不可用");
	} else {
		yuyueTime.setTimestate("可用");
	}
	dao.update(yuyueTime);
	Map map = ServletActionContext.getContext().getSession();
	map.remove("weeklist");
	List<YuyueTime> weeklist = dao.getListForHql("from YuyueTime where timestate='可用'");
	ActionContext.getContext().getSession().put("weeklist", weeklist);
	LoginfoTools.logWrite(UserinfoDocAction.class, "修改了预约时间表");
	message="时间表更改成功";
	return "commclose";
}
//查看所有日志
public String showAlllog() {
	try{
		//每页显示5条记录
		int pageRows = 5;
		//分页语句
		//将过期的预约修改预约状态
		Dealyuyuedate.dealDateyuyue();
		String hql = "from Loginfo where log_name !=null order by id desc";
		//分页的总记录数
		int maxNum = dao.pageMaxList(hql);
		//求最新的分页起始位置  =  上一次firstPage 依据pageButton（分页按钮）来进行计算  pageRows  
		//需要我们注意的是分页显示头一次从登录过来的时候pageBean是没实例化的所以需要对pageBean进行初始化
		if(pageBean == null){
			pageBean = new PageBean();
			pageBean.setFirstPage(0);//初始化的时候firstPage从0开始代表首页位置
			pageBean.setPageButton(0);////初始化的时候paegBotton从0开始代表首页按钮
		}
		int firstPage = PageTools.getFirstPage(pageBean.getFirstPage(), pageRows, maxNum, pageBean.getPageButton());
		pageBean = dao.pageList(hql, pageRows, firstPage, maxNum);
	}catch(Exception e){
		e.printStackTrace();
	}
	return "showalllog";
	}


//修改专家信息
@SuppressWarnings("deprecation")
public String change() throws Exception {
	System.out.println("------------change--------------");
	System.out.println("image="+userinfo1.getDimageFileName());
	FileUpload fu = new FileUpload();
	String houzui = userinfo1.getDimageFileName().substring(userinfo1.getDimageFileName().lastIndexOf("."));
	String changename = fu.getNewName(userinfo1.getDimageFileName());
	if(changename==null) {
		return INPUT;
	} else {
		String newname = ""+changename+houzui;
		fu.uploadFile(userinfo1.getDimage(),newname);
		String id = ""+userinfo1.getId();
		System.out.println("username"+userinfo1.getDname());
		UserinfoDoc userinfo3  = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, id);
		String firstimagename = userinfo3.getDimageFileName();
		System.out.println("firstimagename="+firstimagename);
		String path = ServletActionContext.getRequest().getRealPath("/upload");
		File file = new File(path+File.separator+firstimagename);
		System.out.println(path+File.separator+firstimagename);
		if(file.exists()) {
			file.delete();
			System.out.println("删除成功");
		} else {
			System.out.println("没有该文件存在");
		}
		//判断是否有选中预约日期
				if(yuyuetime1!=null) {
					String [] yuyuetime_1 = yuyuetime1.toString().split(", ");
					Set<YuyueTime> weekset1 = new HashSet<YuyueTime>();
					for(int i = 0;i<yuyuetime_1.length;i++) {
						YuyueTime week1 = (YuyueTime)dao.getObjectForId(YuyueTime.class,""+yuyuetime_1[i]);
						weekset1.add(week1);
					}
					userinfo3.setWeek(weekset1);
				} else {
					userinfo3.setWeek(null);
				}
		Keshi keshi_1 = (Keshi)dao.getObjectForId(Keshi.class,keshi1);
		userinfo3.setDname(userinfo1.getDname());
		userinfo3.setPassword(userinfo1.getPassword());
		userinfo3.setDimageFileName(newname);
		userinfo3.setDbirthday(userinfo1.getDbirthday());
		userinfo3.setDtel(userinfo1.getDtel());
		userinfo3.setInfo(userinfo1.getInfo());
		userinfo3.setKeshi(keshi_1);
		LoginfoTools.logWrite(UserinfoDocAction.class, "编辑了"+userinfo1.getDname()+"专家详细信息");
		dao.update(userinfo3);
		message="专家信息编辑成功";
		return "commclose";
	}
}
//查看所有预约
public String showAllyuyue() throws Exception {
	try{
		//每页显示5条记录
		int pageRows = 5;
		//分页语句
		//from UserinfoDoc u where u.roleinfo. is not null order by id
		//将过期的预约修改预约状态
		Dealyuyuedate.dealDateyuyue();
		String hql = "from Orderinfo order by id desc";
		//分页的总记录数
		int maxNum = dao.pageMaxList(hql);
		//求最新的分页起始位置  =  上一次firstPage 依据pageButton（分页按钮）来进行计算  pageRows  
		//需要我们注意的是分页显示头一次从登录过来的时候pageBean是没实例化的所以需要对pageBean进行初始化
		if(pageBean == null){
			pageBean = new PageBean();
			pageBean.setFirstPage(0);//初始化的时候firstPage从0开始代表首页位置
			pageBean.setPageButton(0);////初始化的时候paegBotton从0开始代表首页按钮
		}
		int firstPage = PageTools.getFirstPage(pageBean.getFirstPage(), pageRows, maxNum, pageBean.getPageButton());
		pageBean = dao.pageList(hql, pageRows, firstPage, maxNum);
	}catch(Exception e){
		e.printStackTrace();
	}
	return "showallyuyue";
	}
//删除预约记录
public String deleteyuyue() throws Exception {
	String id = ServletActionContext.getRequest().getParameter("id");
	Orderinfo orderinfo = (Orderinfo)dao.getObjectForId(Orderinfo.class, id);
	int pid = orderinfo.getPid();
	Patient patient = (Patient)dao.getObjectForId(Patient.class, ""+pid);
	patient.setUserinfodoc(null);
	LoginfoTools.logWrite(UserinfoDocAction.class, "删除了日期为："+orderinfo.getOrderdate()+"预约者为："+orderinfo.getPname()+"的记录");
	dao.update(patient);
	dao.deleteObject(orderinfo);
	return showAllyuyue();
}
//修改个人信息

@SuppressWarnings({ "rawtypes", "unchecked" })
public String updategeren() throws Exception {
	String id = ""+userinfo.getId();
	System.out.println(id);
	UserinfoDoc upuserinfo = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class,id);
	FileUpload fu = new FileUpload();
	String houzui = userinfo.getDimageFileName().substring(userinfo.getDimageFileName().lastIndexOf("."));
	String changename = fu.getNewName(userinfo.getDimageFileName());
	String newname = ""+changename+houzui;
	fu.uploadFile(userinfo.getDimage(),newname);
	String firstimagename = upuserinfo.getDimageFileName();
	System.out.println("firstimagename="+firstimagename);
	@SuppressWarnings("deprecation")
	String path = ServletActionContext.getRequest().getRealPath("/upload");
	File file = new File(path+File.separator+firstimagename);
	System.out.println(path+File.separator+firstimagename);
	if(file.exists()) {
		file.delete();
		System.out.println("删除成功");
	} else {
		System.out.println("没有该文件存在");
	}
	upuserinfo.setDtel(userinfo.getDtel());
	upuserinfo.setDbirthday(userinfo.getDbirthday());
	upuserinfo.setPassword(userinfo.getPassword());
	upuserinfo.setDimageFileName(newname);
	LoginfoTools.logWrite(UserinfoDocAction.class,"修改了个人信息");
	dao.update(upuserinfo);
	Map map = ServletActionContext.getContext().getSession();
	map.remove("userinfoDoc");
	map.put("userinfoDoc", upuserinfo);
	message="个人信息修改成功";
	return "commclose";
}
//查看病人
public String showpa() throws Exception {
	try{
		//每页显示5条记录
		int pageRows = 5;
		//分页语句
		//from UserinfoDoc u where u.roleinfo. is not null order by id
		String hql = "from Patient order by id";
		//分页的总记录数
		int maxNum = dao.pageMaxList(hql);
		//求最新的分页起始位置  =  上一次firstPage 依据pageButton（分页按钮）来进行计算  pageRows  
		//需要我们注意的是分页显示头一次从登录过来的时候pageBean是没实例化的所以需要对pageBean进行初始化
		if(pageBean == null){
			pageBean = new PageBean();
			pageBean.setFirstPage(0);//初始化的时候firstPage从0开始代表首页位置
			pageBean.setPageButton(0);////初始化的时候paegBotton从0开始代表首页按钮
		}
		int firstPage = PageTools.getFirstPage(pageBean.getFirstPage(), pageRows, maxNum, pageBean.getPageButton());
		pageBean = dao.pageList(hql, pageRows, firstPage, maxNum);
	}catch(Exception e){
		e.printStackTrace();
	}
	return "showpatient";
	}
@SuppressWarnings("rawtypes")
//退出登录
public String tuichu() throws Exception {
	Map map = ServletActionContext.getContext().getSession();
	map.remove("userinfoDoc");
	return "login";
}
//查看所有专家
public String showall() throws Exception {
	try{
		//每页显示5条记录
		int pageRows = 5;
		//分页语句
		//from UserinfoDoc u where u.roleinfo. is not null order by id
		String hql = "from UserinfoDoc where dstate='可用' order by id";
		//分页的总记录数
		int maxNum = dao.pageMaxList(hql);
		//求最新的分页起始位置  =  上一次firstPage 依据pageButton（分页按钮）来进行计算  pageRows  
		//需要我们注意的是分页显示头一次从登录过来的时候pageBean是没实例化的所以需要对pageBean进行初始化
		if(pageBean == null){
			pageBean = new PageBean();
			pageBean.setFirstPage(0);//初始化的时候firstPage从0开始代表首页位置
			pageBean.setPageButton(0);////初始化的时候paegBotton从0开始代表首页按钮
		}
		int firstPage = PageTools.getFirstPage(pageBean.getFirstPage(), pageRows, maxNum, pageBean.getPageButton());
		pageBean = dao.pageList(hql, pageRows, firstPage, maxNum);
	
	}catch(Exception e){
		e.printStackTrace();
	}
	return "search";
	}
	public String getKeshi() {
	return keshi;
	}
	public void setKeshi(String keshi) {
		this.keshi = keshi;
	}
	public String getKeshi1() {
		return keshi1;
	}
	public void setKeshi1(String keshi1) {
		this.keshi1 = keshi1;
	}
	public PageBean getPageBean() {
	return pageBean;
	}
	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}
		public List<UserinfoDoc> getUserlist() {
		return userlist;
	}
	public void setUserlist(List<UserinfoDoc> userlist) {
		this.userlist = userlist;
	}
	public UserinfoDoc getUserinfo() {
		return userinfo;
	}
	public void setUserinfo(UserinfoDoc userinfo) {
		this.userinfo = userinfo;
	}
	public String getYuyuetime() {
		return yuyuetime;
	}
	public void setYuyuetime(String yuyuetime) {
		this.yuyuetime = yuyuetime;
	}

	public String getYuyuetime1() {
		return yuyuetime1;
	}

	public void setYuyuetime1(String yuyuetime1) {
		this.yuyuetime1 = yuyuetime1;
	}

	public UserinfoDoc getUserinfo1() {
		return userinfo1;
	}

	public void setUserinfo1(UserinfoDoc userinfo1) {
		this.userinfo1 = userinfo1;
	}
	public List<YuyueTime> getYuyueTimelist() {
		return yuyueTimelist;
	}
	public void setYuyueTimelist(List<YuyueTime> yuyueTimelist) {
		this.yuyueTimelist = yuyueTimelist;
	}
	public String getUpyuyueTime() {
		return UpyuyueTime;
	}
	public void setUpyuyueTime(String upyuyueTime) {
		UpyuyueTime = upyuyueTime;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
