package cn.com.shxt.action_1;

import java.io.File;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.StrutsStatics;

import cn.com.shxt.beans.PageBean;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Area;
import cn.com.shxt.model.City;
import cn.com.shxt.model.Keshi;
import cn.com.shxt.model.Orderinfo;
import cn.com.shxt.model.Patient;
import cn.com.shxt.model.Province;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.model.YuyueTime;
import cn.com.shxt.utils.FileUpload;
import cn.com.shxt.utils.PageTools;
import cn.com.shxt.utils.SearchTiaojian;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class PatientAction extends  ActionSupport{
	private static final long serialVersionUID = -7610185450181922985L;
	private UserinfoDoc userinfo;
	private Dao dao = new DaoBean();
	private List<UserinfoDoc> userlist ;
	private PageBean pageBean;
	private String tiaojianT_U;//根据用户输入进行电话或姓名的模糊查询条件
	private List<UserinfoDoc> userinfotiaojianT_U;
	private List<Keshi> keshi;
	private List<YuyueTime> yuyuelist;
	private Patient patient;
	private String message;
	private String provinceId;
	private String cityId;
	private String areaId;
	
	
	private List<Province> provinceList;
	//查询省份
	public String initProvince() throws Exception {
		provinceList = dao.getListForHql("from Province");
		return "initPro";
	}
	//查询地级
	public void findArea() throws Exception{
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)ActionContext.getContext().get(StrutsStatics.HTTP_RESPONSE);
		response.setContentType("text/xml;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String cityId = request.getParameter("cityId");
		List<Area>  areaList = dao.getListForHql("from Area where fatherid='"+Integer.parseInt(cityId)+"'");
		out.print("<area>");
		   for (int i = 0; i < areaList.size(); i++) {
			String areaId=""+areaList.get(i).getAreaid();
			String area=areaList.get(i).getArea();
			System.out.println(area+"------"+areaId);
			out.print("<id>"+areaId+"</id>");
			out.print("<name>"+area+"</name>");
		}
		out.print("</area>");
		out.flush();
		out.close();
	}
	//查询市级
	public void findCity() throws Exception{
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)ActionContext.getContext().get(StrutsStatics.HTTP_RESPONSE);
		response.setContentType("text/xml;charset=UTF-8");
		String provinceId=request.getParameter("provinceId");
		PrintWriter out = response.getWriter();
		List<City>  cityList = dao.getListForHql("from City where fatherid='"+Integer.parseInt(provinceId)+"'");
		out.print("<city>");
		   for (int i = 0; i < cityList.size(); i++) {
			String cityId = ""+cityList.get(i).getCityid();
			String city = cityList.get(i).getCity();
			System.out.println(city+"------"+cityId);
			out.print("<id>"+cityId+"</id>");
			out.print("<name>"+city+"</name>");
		}
		out.print("</city>");
		out.flush();
		out.close();
	}
	//找回密码
	public String findpassword() throws Exception {
		String pid = ""+patient.getId();
		Patient pa = (Patient)dao.getObjectForId(Patient.class, pid);
		if(pa==null) {
			message="对不起，该账户不存在。";
			return INPUT;
		}
		if(pa.getPquestion().equals(patient.getPquestion())) {
			if(pa.getPanswer().equals(patient.getPanswer())) {
				String password = pa.getPassword();
				message="您的密码为："+password+"，请妥善保管。并尽快修改密码。";
				return INPUT;
			} else {
				message="对不起，密保问题或答案输入有误";
				return INPUT;
			}
		} else {
			message="对不起，密保问题或答案输入有误";
			return INPUT;
		}
	}
	
	//用户注册
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String add() throws Exception {
		dao  = new DaoBean();
		String city = "";
		String area = "";
		System.out.println(provinceId+"   "+cityId+"          "+areaId);
		List<Province> province_ = dao.getListForHql("from Province where provinceid = '"+Integer.parseInt(provinceId)+"'");
		System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++");
		String province = province_.get(0).getProvince();
		System.out.println(province);
		if(cityId==null) {
			city = " ";
		} else {
			List<City> city_ = dao.getListForHql("from City where cityid = '"+Integer.parseInt(cityId)+"'");
			city = city_.get(0).getCity();
		}
		if(areaId==null) {
			area = " ";
		} else {
			List<Area> area_ = dao.getListForHql("from Area where areaid = '"+Integer.parseInt(areaId)+"'");
			area = area_.get(0).getArea();
		}
		System.out.println(city+area);
		String address = province+" "+city+" "+area;
		FileUpload fu = new FileUpload();
		String houzui = patient.getPimageFileName().substring(patient.getPimageFileName().lastIndexOf("."));
		String changename = fu.getNewName(patient.getPimageFileName());
		String newname = ""+changename+houzui;
		fu.uploadFile(patient.getPimage(),newname);
		Patient addpatient = new Patient();
		addpatient.setPassword(patient.getPassword());
		addpatient.setPanswer(patient.getPanswer());
		addpatient.setPbirthday(patient.getPbirthday());
		addpatient.setPquestion(patient.getPquestion());
		addpatient.setPstate("待定");
		addpatient.setPtel(patient.getPtel());
		addpatient.setPmoney("0");
		addpatient.setPname(patient.getPname());
		addpatient.setPimageFileName(newname);
		addpatient.setPaddress(address);
		Map map = ServletActionContext.getContext().getSession();
		map.put("patient", addpatient);
		dao.save(addpatient);
		message="注册成功。您的医保卡号为："+addpatient.getId();
		return "commclose";
	}
	//客户的详情界面
	public String patientInfo() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String pid = request.getParameter("pid");
		patient = (Patient)dao.getObjectForId(Patient.class, pid);
		System.out.println("--"+patient.getPname());
		return "updateInfo";
	}
	
	//预约取消
	public String quxiaoyuyue() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		Orderinfo order = (Orderinfo)dao.getObjectForId(Orderinfo.class, id);
		System.out.println(order.getDname()+"--------"+order.getKname()+"----"+order.getOrderdate()+"--"+order.getOrderstate());
		order.setOrderstate("预约取消");
		dao.update(order);
		int pid = order.getPid();
		Patient patient = (Patient)dao.getObjectForId(Patient.class, ""+pid);
		patient.setUserinfodoc(null);
		int money = Integer.parseInt(patient.getPmoney());
		money = money+20;
		patient.setPmoney(""+money);
		patient.setPstate("待定");
		dao.update(patient);
		message="预约成功取消，预约金已成功返回至您的账户，请查收。";
		return "commclose";
	}
	//客户预约的详情界面
	@SuppressWarnings("rawtypes")
	public String yuyueInfo() throws Exception {
		Map map = ServletActionContext.getContext().getSession();
		Patient patient = (Patient)map.get("patient");
		String pid = ""+patient.getId();
		System.out.println("---------------pid----------"+pid);
		try{
			//每页显示5条记录
			int pageRows = 5;
			//分页语句
			String hql = "from Orderinfo where pid='"+Integer.parseInt(pid)+"' order by orderdate desc";
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
		return "yuyueInfo";
	}
	//修改资料
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String change() throws Exception {
		System.out.println(patient.getPname()+"--"+patient.getPassword()+"--"+patient.getId()+"--"+patient.getPaddress());
		String id  = ""+patient.getId();
		Patient patient1 = (Patient)dao.getObjectForId(Patient.class,id);
		System.out.println(patient.getPquestion());
		FileUpload fu = new FileUpload();
		String houzui = patient.getPimageFileName().substring( patient.getPimageFileName().lastIndexOf("."));
		String changename = fu.getNewName(patient.getPimageFileName());
		if(changename==null) {
			System.out.println("111111111111");
			return INPUT;
		} else {
			System.out.println("222222222222");
			String newname = ""+changename+houzui;
			fu.uploadFile(patient.getPimage(),newname);
			String firstimagename = patient.getPimageFileName();
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
			patient1.setPaddress(patient.getPaddress());
			patient1.setPanswer(patient.getPanswer());
			patient1.setPimageFileName(newname);
			patient1.setPtel(patient.getPtel());
			patient1.setPbirthday(patient.getPbirthday());
			patient1.setPname(patient.getPname());
			patient1.setPassword(patient.getPassword());
			patient1.setPquestion(patient.getPquestion());
			dao.update(patient1);
			Map map = ServletActionContext.getContext().getSession();
			map.remove("patient");
			map.put("patient", patient1);
		}
		return showallDoc();
	}
	
	//根据条件查询
	public String searchT_U() throws Exception {
		String tiaojian=tiaojianT_U;
		System.out.println(tiaojianT_U);
		List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null and (dstate='可用' and dname like '%"+tiaojian+"%' or dtel like'%"+tiaojian+"%')");
		userinfotiaojianT_U = SearchTiaojian.gettiaojianT_U(userinfo);
		keshi = dao.getListForHql("from Keshi order by id");
		yuyuelist = dao.getListForHql("from YuyueTime where timestate = '可用' order by id");
		System.out.println("size="+userinfotiaojianT_U.size());
		return "search";
	}
	//根据科室查询专家
	public String getDocbyKeshi() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String kname = request.getParameter("kname");
		List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null and dstate='可用' order by id");
			keshi = dao.getListForHql("from Keshi order by id");
			yuyuelist = dao.getListForHql("from YuyueTime where timestate = '可用' order by id");
			userinfotiaojianT_U = SearchTiaojian.gettiaojianKeshi(kname, userinfo);
		return "search";
	}
	//用户登录
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String Login() throws Exception {
		int cardnum = patient.getId();
		String password = patient.getPassword();
		List<Patient> patientlist = dao.getListForHql("from Patient where id="+cardnum+"");
		if(patientlist.size()!=0) {
			if(patientlist.get(0).getPassword().equals(password)) {
				Map map = ServletActionContext.getContext().getSession();
				map.put("patient", patientlist.get(0));
				return showallDoc();
			} else {
				message="对不起，密码输入错误，请返回重新输入";
				return INPUT;
			}
		} else {
			message="对不起，该用户名不存在，请返回重新输入";
			return INPUT;
		}
	}
	@SuppressWarnings("rawtypes")
	//用户注销
	public String Loginout() throws Exception {
		Map map = ServletActionContext.getContext().getSession();
		map.remove("patient");
		return showallDoc();
	}
	//根据预约时间查询专家
	public String getDocbyWeek() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String week = request.getParameter("week");
		List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null and dstate='可用' order by id");
		keshi = dao.getListForHql("from Keshi order by id");
		yuyuelist = dao.getListForHql("from YuyueTime where timestate = '可用' order by id");
		userinfotiaojianT_U = SearchTiaojian.gettiaojianweek(week, userinfo);
		return "search";
	}
	//查询某个专家
	public String showDocInfo() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String did = request.getParameter("did");
		userinfo = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, did);
		return "showoneDoc";
	}
	//预约
	public String yuyue() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String did = request.getParameter("did");
		String pid = request.getParameter("pid");
		UserinfoDoc u = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, did);
		Patient p = (Patient)dao.getObjectForId(Patient.class, pid);
		String money_ =  p.getPmoney();
		String zhifu = request.getParameter("zhifu");
		System.out.println("zhifu"+zhifu);
	
		if(zhifu.equals("zhanghu")) {
			int money = Integer.parseInt(p.getPmoney());
			if(money<20) {
				message="对不起，您账户的余额不足，请修改缴费方式或去充值";
				return INPUT;
			} else {
				money = money-20;
				money_ = ""+money;
			}
		}
		if(p.getUserinfodoc()!=null) {
			message="预约失败，您已经就诊或已经预约";
			return INPUT;
		}else {
			String dname = request.getParameter("dname");
			String pname = request.getParameter("pname");
			String orderdate = request.getParameter("orderdate");
			String kname = request.getParameter("kname");
			System.out.println("did="+did);
			System.out.println("pid="+pid);
			System.out.println("dname="+dname);
			System.out.println("pname="+pname);
			System.out.println("orderdate="+orderdate);
			System.out.println("kname="+kname);
			Orderinfo orderinfo = new Orderinfo();
			orderinfo.setDid(Integer.parseInt(did));
			orderinfo.setDname(dname);
			orderinfo.setOrderdate(orderdate);
			orderinfo.setOrderstate("预约中");
			orderinfo.setPid(Integer.parseInt(pid));
			orderinfo.setPname(pname);
			orderinfo.setKname(kname);
			dao.save(orderinfo);
			p.setUserinfodoc(u);
			p.setPstate("预约中");
			p.setPmoney(money_);
			dao.update(p);
			int guahao = orderinfo.getId();
			message="预约成功,您的挂号为："+guahao+",请您准时去红心医院赴约！";
			return INPUT;
		}
	}
	//显示所有专家
	public String showallDoc() throws Exception {
		try{
			//每页显示5条记录
			int pageRows = 8;
			//分页语句
			String hql = "from UserinfoDoc u where u.keshi is not null and dstate='可用' order by id ";
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
			keshi = dao.getListForHql("from Keshi order by id");
			yuyuelist = dao.getListForHql("from YuyueTime where timestate = '可用' order by id");
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "search";
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

	public String getTiaojianT_U() {
		return tiaojianT_U;
	}

	public void setTiaojianT_U(String tiaojianT_U) {
		this.tiaojianT_U = tiaojianT_U;
	}

	public List<UserinfoDoc> getUserinfotiaojianT_U() {
		return userinfotiaojianT_U;
	}

	public void setUserinfotiaojianT_U(List<UserinfoDoc> userinfotiaojianT_U) {
		this.userinfotiaojianT_U = userinfotiaojianT_U;
	}

	public List<Keshi> getKeshi() {
		return keshi;
	}

	public void setKeshi(List<Keshi> keshi) {
		this.keshi = keshi;
	}

	public List<YuyueTime> getYuyuelist() {
		return yuyuelist;
	}

	public void setYuyuelist(List<YuyueTime> yuyuelist) {
		this.yuyuelist = yuyuelist;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<Province> getProvinceList() {
		return provinceList;
	}
	public void setProvinceList(List<Province> provinceList) {
		this.provinceList = provinceList;
	}

	public String getProvinceId() {
		return provinceId;
	}

	public void setProvinceId(String provinceId) {
		this.provinceId = provinceId;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}


	
}
