package cn.com.shxt.action_1;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.StrutsStatics;

import cn.com.shxt.beans.PageBean;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Loginfo;
import cn.com.shxt.model.Orderinfo;
import cn.com.shxt.model.Patient;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.utils.Dealyuyuedate;
import cn.com.shxt.utils.LoginfoTools;
import cn.com.shxt.utils.PageTools;

import com.opensymphony.xwork2.ActionContext;


public class ZhuanjiaAction {
	private Dao dao;
	private List<Patient> patientlistforZhuanjia;
	private PageBean pageBean;
	private String message;
	private List<Loginfo> loginfo;
	@SuppressWarnings("rawtypes")
	//显示病人
	public String showPa() throws Exception {
		dao = new DaoBean();
		Map map = ServletActionContext.getContext().getSession();
		UserinfoDoc userinfodoc = (UserinfoDoc)map.get("userinfoDoc");
		int uid = userinfodoc.getId();
		Dealyuyuedate.dealDateyuyue();
		try{
			//每页显示5条记录
			int pageRows = 5;
			//分页语句
			String hql = "from Patient p where p.userinfodoc.id = '"+uid+"' order by id desc";
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
		return "showPaforZhuanjia";
	}
	//病人出院
	public String chuyuan() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String pid = request.getParameter("pid");
		Patient pa = (Patient)dao.getObjectForId(Patient.class,""+pid);
		pa.setPstate("待定");
		pa.setUserinfodoc(null);
		dao.update(pa);
		LoginfoTools.logWrite(ZhuanjiaAction.class, "将病人"+pa.getPname()+"出院");
		message="病人成功出院";
		return "commclose";
	}
	//显示预约
	@SuppressWarnings("rawtypes")
	public String showyuyue() throws Exception {
		dao = new DaoBean();
		Map map = ServletActionContext.getContext().getSession();
		UserinfoDoc userinfodoc = (UserinfoDoc)map.get("userinfoDoc");
		int uid = userinfodoc.getId();
		Dealyuyuedate.dealDateyuyue();
		try{
			//每页显示5条记录
			int pageRows = 5;
			//分页语句
			String hql = "from Orderinfo where did = '"+uid+"' order by id desc";
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
		return "showyuyueforZhuanjia";
	}
	//对预约号进行校验
	@SuppressWarnings("rawtypes")
	public void addPaforYuyuenum() throws Exception{
		dao = new DaoBean();
		Map map = ServletActionContext.getContext().getSession();
		UserinfoDoc userinfo = (UserinfoDoc)map.get("userinfoDoc");
		int uid = userinfo.getId();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		HttpServletResponse response = (HttpServletResponse)ActionContext.getContext().get(StrutsStatics.HTTP_RESPONSE);
		response.setContentType("text/xml;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String yuyunum = request.getParameter("yuyunum");
		Orderinfo orderinfo = (Orderinfo)dao.getObjectForId(Orderinfo.class,yuyunum);
		if(orderinfo==null) {
			out.print(1);
		} else if(orderinfo.getOrderstate().equals("预约过期")||orderinfo.getOrderstate().equals("预约取消")) {
			out.print(2);
		} else if(orderinfo.getOrderstate().equals("预约完成")) {
			out.print(3);
		} else if(orderinfo.getDid()!=uid){
			out.print(4);
		} else if(orderinfo.getOrderstate().equals("预约中")){
			out.print(5);
		}
		out.flush();
		out.close();
	}
	//添加病人
	public String addPa() throws Exception {
		System.out.println("--------");
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String yuyunum = request.getParameter("yuyunum");
		System.out.println(yuyunum);
		Orderinfo orderinfo = (Orderinfo)dao.getObjectForId(Orderinfo.class, yuyunum);
		orderinfo.setOrderstate("预约完成");
		int pid = orderinfo.getPid();
		Patient patient = (Patient)dao.getObjectForId(Patient.class, ""+pid);
		patient.setPstate("就诊中");
		Date date  = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String nowday = sdf.format(date);
		orderinfo.setJiuzhenTime(nowday);
		dao.update(patient);
		dao.update(orderinfo);
		LoginfoTools.logWrite(ZhuanjiaAction.class, "添加了一个姓名为："+orderinfo.getPname()+"的病人");
		return showyuyue();
	}
	//查看自己的日志信息
	@SuppressWarnings("rawtypes")
	public String showlogforZJ() throws Exception {
		dao = new DaoBean();
		Map map = ServletActionContext.getContext().getSession();
		UserinfoDoc userinfodoc = (UserinfoDoc)map.get("userinfoDoc");
		try{
			//每页显示5条记录
			int pageRows = 5;
			//分页语句
			//将过期的预约修改预约状态
			Dealyuyuedate.dealDateyuyue();
			String hql = "from Loginfo where log_name ='"+userinfodoc.getDname()+"' order by id desc";
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
		return "showlogforZJ";
	}
	
	public List<Patient> getPatientlistforZhuanjia() {
		return patientlistforZhuanjia;
	}

	public void setPatientlistforZhuanjia(List<Patient> patientlistforZhuanjia) {
		this.patientlistforZhuanjia = patientlistforZhuanjia;
	}

	public PageBean getPageBean() {
		return pageBean;
	}

	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public List<Loginfo> getOrderlist() {
		return loginfo;
	}

	public void setOrderlist(List<Loginfo> loginfo) {
		this.loginfo = loginfo;
	}
	
}
