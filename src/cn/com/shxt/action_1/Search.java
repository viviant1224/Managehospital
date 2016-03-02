package cn.com.shxt.action_1;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.StrutsStatics;

import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Loginfo;
import cn.com.shxt.model.Orderinfo;
import cn.com.shxt.model.Patient;
import cn.com.shxt.model.Powerinfo;
import cn.com.shxt.model.UserinfoDoc;

import com.opensymphony.xwork2.ActionContext;

public class Search {
	private List<UserinfoDoc> userlist;
	private List<Powerinfo> powerlist;
	private List<Patient> patientlist;
	private List<Orderinfo> orderlist;
	private List<Loginfo> loginfo;
	private Dao dao = new DaoBean();
	
	//按条件查询专家
	public String searUser() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String  searchUser = request.getParameter("searchUser");
		String hql = "from UserinfoDoc u where dstate='可用' " +
				"and dname like '%"+searchUser+"%' or " +
						"dtel like '%"+searchUser+"%' or dbirthday like '%"+searchUser+"%' or" +
								" id like '%"+searchUser+"%' or" +
										" u.keshi.kname like '%"+searchUser+"%' order by id";
		userlist = dao.getListForHql(hql);
		return "searchUser";
	}
	//按条件查询权限
	public String searPower() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String  searchPower = request.getParameter("searchPower");
		String hql = "from Powerinfo  where " +
				"pname like '%"+searchPower+"%' or " +
						"pid like '%"+searchPower+"%' or purl like '%"+searchPower+"%' or" +
								" mid like '%"+searchPower+"%' order by id";
		powerlist = dao.getListForHql(hql);
		return "searchPower";
	}
	//按条件查询病人
	public String searPa() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String  searchPa = request.getParameter("searchPa");
		String hql = "from Patient  where " +
				"pname like '%"+searchPa+"%' or " +
						"ptel like '%"+searchPa+"%' or paddress like '%"+searchPa+"%' or" +
								" pstate like '%"+searchPa+"%' order by id";
		patientlist = dao.getListForHql(hql);
		return "searchPa";
	}
	//按条件查询预约
	public String searyuyue() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String  searchyuyue = request.getParameter("searchyuyue");
		String hql = "from Orderinfo  where " +
				"log_date like '%"+searchyuyue+"%' or " +
						"log_message like '%"+searchyuyue+"%' or log_name like '%"+searchyuyue+"%'";
		loginfo = dao.getListForHql(hql);
		return "searchyuyue";
	}
	//按条件查询预约2
	@SuppressWarnings("rawtypes")
	public String searyuyueforZhuanjia() throws Exception {
		Map map = ServletActionContext.getContext().getSession();
		UserinfoDoc userinfo = (UserinfoDoc)map.get("userinfoDoc");
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String  searchyuyue = request.getParameter("searchyuyue");
		String hql = "from Orderinfo  where did = '"+userinfo.getId()+"' and" +
				"(pname like '%"+searchyuyue+"%' or " +
						"dname like '%"+searchyuyue+"%' or id like '%"+searchyuyue+"%' or" +
								" orderdate like '%"+searchyuyue+"%' or" +
								" orderstate like '%"+searchyuyue+"%' or" +
										" kname like '%"+searchyuyue+"%') order by id";
		orderlist = dao.getListForHql(hql);
		return "searyuyueforZhuanjia";
	}
	//按条件查询日志
	public String searLog() throws Exception {
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String  searchLog = request.getParameter("searchLog");
		System.out.println("------"+searchLog);
		String hql = "from Loginfo  " +
				"where log_name is not null and (log_date like '%"+searchLog+"%' or" +
						" log_message like '%"+searchLog+"%' or" +
								" log_name like '%"+searchLog+"%') order by log_date desc";
		loginfo = dao.getListForHql(hql);
		System.out.println(loginfo.size());
		return "searLog";
	}
	public List<UserinfoDoc> getUserlist() {
		return userlist;
	}

	public void setUserlist(List<UserinfoDoc> userlist) {
		this.userlist = userlist;
	}

	public List<Powerinfo> getPowerlist() {
		return powerlist;
	}

	public void setPowerlist(List<Powerinfo> powerlist) {
		this.powerlist = powerlist;
	}

	public List<Patient> getPatientlist() {
		return patientlist;
	}

	public void setPatientlist(List<Patient> patientlist) {
		this.patientlist = patientlist;
	}

	public List<Orderinfo> getOrderlist() {
		return orderlist;
	}

	public void setOrderlist(List<Orderinfo> orderlist) {
		this.orderlist = orderlist;
	}

	public List<Loginfo> getLoginfo() {
		return loginfo;
	}

	public void setLoginfo(List<Loginfo> loginfo) {
		this.loginfo = loginfo;
	}
	
}
