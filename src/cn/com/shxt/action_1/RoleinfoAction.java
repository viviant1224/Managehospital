package cn.com.shxt.action_1;




import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.StrutsStatics;

import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Powerinfo;
import cn.com.shxt.model.Roleinfo;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.utils.LoginfoTools;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class RoleinfoAction extends  ActionSupport{
	private static final long serialVersionUID = 5044214732250695045L;
	private Dao dao;
	private List<Roleinfo> rolelist;
	private Set<Powerinfo> powerset;
	private String addrolename;
	private String message;
	private List<UserinfoDoc> allUser;//分配用户所用到
	private Set<UserinfoDoc> haveUser;
	private String fenpeiUser;
	private String rid;//要实现分配的角色id
	private Set<Powerinfo> havepower;
	private List<Powerinfo> listquanbu;
	//显示角色名
	public String showRole() throws Exception {
		dao = new DaoBean();
		powerset = new HashSet<Powerinfo>();
		rolelist = dao.getListForHql("from Roleinfo order by id");
		List<Powerinfo> powerall = dao.getListForHql("from Powerinfo order by id");
		powerset.addAll(powerall);
		return "ShowRole";
	}
	//分配权限给角色
	public String updateR_P() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String rid = request.getParameter("rid");
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class,rid);
		String R_Pids = request.getParameter("R_powerids");
		String [] R_Pid = R_Pids.split(",");
		Set<Powerinfo> powerinfoset = new HashSet<Powerinfo>();
		roleinfo.getPowerinfo().clear();
		for(int i = 0;i<R_Pid.length;i++) {
			Powerinfo power = (Powerinfo)dao.getObjectForId(Powerinfo.class,""+R_Pid[i]);
			powerinfoset.add(power);
		}
		roleinfo.setPowerinfo(powerinfoset);
		LoginfoTools.logWrite(RoleinfoAction.class, "给角色"+roleinfo.getRname()+"分配了权限");

		dao.update(roleinfo);
		return showRole();
	}
	//显示可分配用户的页面
	public String showfenpeiUser() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		rid = request.getParameter("rid");
		allUser = dao.getListForHql("from UserinfoDoc where dstate='可用'");
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, rid);
		haveUser = roleinfo.getUserinfodoc();
		allUser.removeAll(haveUser);
		return "fenpei";
	}
	
	
/*	//查询拥有权限
	@SuppressWarnings("unchecked")
	public String searchPower() throws Exception {
		dao = new DaoBean();
		System.out.println("------------sssssssssssssssss");
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String rid = request.getParameter("rid");
		System.out.println(rid);
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, rid);
		havepower = roleinfo.getPowerinfo();
		
		System.out.println(havepower.size());
		String hql = "from Powerinfo order by id";
		listquanbu = dao.getListForHql(hql);
		listquanbu.removeAll(havepower);
		return "fenpeiquanxian";
	}
	*/
	
	
	//给角色分配用户
	public String fenpeiUser() throws Exception {
		dao = new DaoBean();
		System.out.println("-------------"+rid);
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, rid);
		Set<UserinfoDoc> uset = new HashSet<UserinfoDoc>();
		
		if(fenpeiUser!=null) {
			String [] fenpeiUid = fenpeiUser.toString().split(", ");
			System.out.println(fenpeiUser.toString());
			for(int i = 0;i<fenpeiUid.length;i++) {
				UserinfoDoc user = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, fenpeiUid[i]);
				uset.add(user);
			}
			roleinfo.setUserinfodoc(uset);
		} else {
			roleinfo.setUserinfodoc(null);
		}
		LoginfoTools.logWrite(RoleinfoAction.class, "给角色"+roleinfo.getRname()+"分配了用户");
		dao.update(roleinfo);
		message="角色分配成功";
		return "commclose";
		
	}
	//移除某个用户
	public String removeUser() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String rid = request.getParameter("rid");
		String uid = request.getParameter("uid");
		UserinfoDoc userinfo = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, uid);
		System.out.println("-------------------------");
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, rid);
		Set<UserinfoDoc> uset = roleinfo.getUserinfodoc();
		uset.remove(userinfo);
		roleinfo.setUserinfodoc(uset);
		LoginfoTools.logWrite(RoleinfoAction.class, "角色"+roleinfo.getRname()+"移除了用户"+userinfo.getDname());
		dao.update(roleinfo);
		return showRole();
	}
	//添加角色
	public String AddRolename() throws Exception {
		dao = new DaoBean();
		String addrolename_ = addrolename;
		System.out.println("--"+addrolename);
		if(addrolename_.trim()==null) {
			message="对不起，角色不能为空！\n请返回重新操作...";
			return INPUT;
		}
		boolean flag = true;
		List<Roleinfo> rolelist = dao.getListForHql("from Roleinfo order by id");
		for(int i = 0;i<rolelist.size();i++) {
			if(rolelist.get(i).getRname().equals(addrolename_)) {
				flag = false;
				break;
			}
		}
		if(flag) {
			Roleinfo roleinfo = new Roleinfo();
			roleinfo.setRname(addrolename_);
			LoginfoTools.logWrite(RoleinfoAction.class, "添加了角色:"+addrolename_);
			dao.save(roleinfo);
			return showRole();
		} else {
			message="对不起，该角色名已经存在！\n请返回重新操作...";
			return INPUT;
		}
	}
	//修改角色名
	public String updateRname() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		String newname = request.getParameter("newname");
		
		if(newname.trim()==null) {
			message="对不起，角色不能为空！\n请返回重新操作...";
			return INPUT;
		}
		
		boolean flag = true;
		List<Roleinfo> rolelist = dao.getListForHql("from Roleinfo order by id");
		for(int i = 0;i<rolelist.size();i++) {
			if(rolelist.get(i).getRname().equals(newname)) {
				flag = false;
				break;
			}
		}
		if(flag) {
			Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, id);
			roleinfo.setRname(newname);
			LoginfoTools.logWrite(RoleinfoAction.class, "修改了角色"+roleinfo.getRname());
			dao.update(roleinfo);
			return showRole();
		} else {
			message="对不起，该角色名已经存在！\n请返回重新操作...";
			return INPUT;
		}
	}
	//删除某个角色
	public String delete() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		LoginfoTools.logWrite(RoleinfoAction.class, "删除了一个角色");
		dao.delete(Roleinfo.class, id);
		return showRole();
	}
	public List<Roleinfo> getRolelist() {
		return rolelist;
	}

	public void setRolelist(List<Roleinfo> rolelist) {
		this.rolelist = rolelist;
	}

	public Set<Powerinfo> getPowerset() {
		return powerset;
	}

	public void setPowerset(Set<Powerinfo> powerset) {
		this.powerset = powerset;
	}
	public String getAddrolename() {
		return addrolename;
	}
	public void setAddrolename(String addrolename) {
		this.addrolename = addrolename;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public List<UserinfoDoc> getAllUser() {
		return allUser;
	}
	public void setAllUser(List<UserinfoDoc> allUser) {
		this.allUser = allUser;
	}
	public Set<UserinfoDoc> getHaveUser() {
		return haveUser;
	}
	public void setHaveUser(Set<UserinfoDoc> haveUser) {
		this.haveUser = haveUser;
	}
	public String getFenpeiUser() {
		return fenpeiUser;
	}
	public void setFenpeiUser(String fenpeiUser) {
		this.fenpeiUser = fenpeiUser;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public Set<Powerinfo> getHavepower() {
		return havepower;
	}
	public void setHavepower(Set<Powerinfo> havepower) {
		this.havepower = havepower;
	}
	public List<Powerinfo> getListquanbu() {
		return listquanbu;
	}
	public void setListquanbu(List<Powerinfo> listquanbu) {
		this.listquanbu = listquanbu;
	}
	
	
	
}
