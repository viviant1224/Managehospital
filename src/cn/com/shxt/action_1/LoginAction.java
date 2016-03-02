package cn.com.shxt.action_1;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Keshi;
import cn.com.shxt.model.Powerinfo;
import cn.com.shxt.model.Roleinfo;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.model.YuyueTime;
import cn.com.shxt.utils.Dealyuyuedate;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
public class LoginAction extends ActionSupport{
	private static final long serialVersionUID = 8784326318024513815L;
	private String loginusername;
	private String loginpassword;
	private Dao dao;
	public String getLoginusername() {
		return loginusername;
	}
	public void setLoginusername(String loginusername) {
		this.loginusername = loginusername;
	}
	public String getLoginpassword() {
		return loginpassword;
	}
	public void setLoginpassword(String loginpassword) {
		this.loginpassword = loginpassword;
	}
	public String execute(){
		System.out.println("login-----------------------------");
		dao = new DaoBean();
		int id = 0;
		try{
			Integer.parseInt(loginusername);
			id  = Integer.parseInt(loginusername);
		} catch(Exception e){
			id=-1;
		}
		List<UserinfoDoc> userlist = dao.getListForHql("from UserinfoDoc where id="+id+" and dstate='可用'");
		System.out.println("mingzi="+loginusername);
		if(userlist.size()!=0) {
			if(loginpassword.trim().equals(userlist.get(0).getPassword())) {
				System.out.println("success");
				List<Keshi> keshiList = dao.getListForHql("from Keshi where kstate='可用'");
				List<YuyueTime> weeklist = dao.getListForHql("from YuyueTime where timestate='可用'");
				ActionContext.getContext().getSession().put("weeklist", weeklist);
				ActionContext.getContext().getSession().put("userinfoDoc", userlist.get(0));
				ActionContext.getContext().getSession().put("keshiList", keshiList);
				List<Powerinfo> listall = new ArrayList<Powerinfo>();
				UserinfoDoc userinfo = userlist.get(0);
				Set<Roleinfo> setr = userinfo.getRoleinfo();
				System.out.println(setr.size());
				for (Roleinfo roleinfo : setr) {
					System.out.println("当前用户的角色名" + roleinfo.getRname());
					Set<Powerinfo> setp = roleinfo.getPowerinfo();
					for (Powerinfo powerinfo : setp) {
						System.out.println("当前用户的权限名"
								+ powerinfo.getPname()+powerinfo.getPurl());
						listall.add(powerinfo);
					}
				}
				ActionContext.getContext().getSession().put("listall", listall);
				try {
					Dealyuyuedate.dealDateyuyue();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return   SUCCESS;
			} else {
				System.out.println("pwcuowu");
				return INPUT;
		}
		} else {
			System.out.println("用户名不存在");
			return INPUT;
		}
		
	}
}
