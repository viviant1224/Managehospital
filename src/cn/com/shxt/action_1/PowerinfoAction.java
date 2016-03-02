package cn.com.shxt.action_1;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import cn.com.shxt.beans.PageBean;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Powerinfo;
import cn.com.shxt.utils.LoginfoTools;
import cn.com.shxt.utils.PageTools;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;




public class PowerinfoAction extends  ActionSupport{
	private static final long serialVersionUID = 3472887914127736065L;
	private PageBean pageBean;
	private Dao dao ;
	private String addpname;//添加的权限名
	private String addpurl;
	private String addpid;
	private String message;
	
	//显示所有权限
	public String showPower() throws Exception {
		dao = new DaoBean();
		try{
			//每页显示5条记录
			int pageRows = 5;
			//分页语句
			String hql = "from Powerinfo where mid!=4 order by id";
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
		
		return "searchPower";
		}
	//添加权限
	public String Addpower() throws Exception {
		dao = new DaoBean();
		System.out.println("addpname="+addpname+"purl="+addpurl);
		if(addpname.trim().equals("")||addpurl.trim().equals("")) {
			message="对不起，权限名或路径不能为空！\n请返回重新操作...";
			return INPUT;
		}
		boolean flag = true;
		List<Powerinfo> powerlist = dao.getListForHql("from Powerinfo order by id");
		for(int i = 0;i<powerlist.size();i++) {
			if(powerlist.get(i).getPname().equals(addpname)) {
				flag = false;
				break;
			}
		}
		if(flag) {
			Powerinfo powerinfo = new Powerinfo();
			powerinfo.setPname(addpname);
			powerinfo.setPid(Integer.parseInt(addpid));
			powerinfo.setPurl(addpurl);
			LoginfoTools.logWrite(PowerinfoAction.class, "添加了权限:"+addpname);
			dao.save(powerinfo);
			return showPower();
		} else {
			message="对不起，该权限名已经存在！\n请返回重新操作...";
			return INPUT;
		}
	}
	//删除权限
	public String delete() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		LoginfoTools.logWrite(PowerinfoAction.class, "删除了一个权限");
		dao.delete(Powerinfo.class, id);
		return showPower();
	}
	//修改权限名
	public String updatePname() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		String purl = request.getParameter("purl");
		String newname = request.getParameter("newname");
		Powerinfo powerinfo = (Powerinfo)dao.getObjectForId(Powerinfo.class, id);
		String yuanname = powerinfo.getPname();
		if(newname.trim().equals("")||purl.trim().equals("")) {
			message="对不起，权限名或路径不能为空！\n请返回重新操作...";
			return INPUT;
		}
		boolean flag = true;
		List<Powerinfo> powerlist = dao.getListForHql("from Powerinfo where pname!='"+yuanname+"' order by id");
		for(int i = 0;i<powerlist.size();i++) {
			if(powerlist.get(i).getPname().equals(newname)) {
				flag = false;
				break;
			}
		}
		if(flag) {
			System.out.println("------------"+newname);
			powerinfo.setPname(newname);
			powerinfo.setPurl(purl);
			LoginfoTools.logWrite(PowerinfoAction.class, "修改了权限"+newname);
			dao.update(powerinfo);
			return showPower();
		} else {
			message="对不起，该权限名已经存在！\n请返回重新操作...";
			return INPUT;
		}
	
	}
	public PageBean getPageBean() {
		return pageBean;
	}


	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}

	public String getAddpname() {
		return addpname;
	}

	public void setAddpname(String addpname) {
		this.addpname = addpname;
	}

	public String getAddpurl() {
		return addpurl;
	}

	public void setAddpurl(String addpurl) {
		this.addpurl = addpurl;
	}

	public String getAddpid() {
		return addpid;
	}

	public void setAddpid(String addpid) {
		this.addpid = addpid;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
