package cn.com.shxt.action_1;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.StrutsStatics;

import cn.com.shxt.beans.PageBean;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Keshi;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.utils.LoginfoTools;
import cn.com.shxt.utils.PageTools;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
public class KeshiAction extends  ActionSupport{
	private static final long serialVersionUID = 3472887914127736065L;
	private PageBean pageBean;
	private Dao dao ;
	private String addkname;//添加的权限名
	private String message;
	private Set<UserinfoDoc> haveUser;
	
	//显示所有科室
	public String showKeshi() throws Exception {
		dao = new DaoBean();
		try{
			//每页显示5条记录
			int pageRows = 5;
			//分页语句
			String hql = "from Keshi order by id";
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
		
		return "searchKeshi";
		}
	//添加科室
	@SuppressWarnings("rawtypes")
	public String Addkeshi() throws Exception {
		System.out.println("-------添加-----------------");
		dao = new DaoBean();
		if(addkname.trim()==null) {
			message="对不起，科室名不能为空！\n请返回重新操作...";
			return INPUT;
		}
		boolean flag = true;
		List<Keshi> keshilist = dao.getListForHql("from Keshi order by id");
		for(int i = 0;i<keshilist.size();i++) {
			if(keshilist.get(i).getKname().equals(addkname)) {
				flag = false;
				break;
			}
		}
		if(flag) {
			Keshi keshi = new Keshi();
			keshi.setKname(addkname);
			keshi.setKstate("可用");
			dao.save(keshi);
			LoginfoTools.logWrite(KeshiAction.class,"添加了科室:"+addkname);
			Map map = ServletActionContext.getContext().getSession();
			map.remove("keshiList");
			List<Keshi> keshiList = dao.getListForHql("from Keshi where kstate='可用'");
			ActionContext.getContext().getSession().put("keshiList", keshiList);
			return showKeshi();
		} else {
			message="对不起，该科室已经存在！\n请返回重新操作...";
			return INPUT;
		}
	}
	//显示分配用户
	public String showfenpeiUser() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String kid = request.getParameter("kid");
		System.out.println("--"+kid);
		Keshi keshi = (Keshi)dao.getObjectForId(Keshi.class, kid);
		haveUser = keshi.getUserinfodoc();
		System.out.println(haveUser.size());
		return "fenpei";
	}
	//删除科室
	@SuppressWarnings("rawtypes")
	public String delete() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		Keshi keshi = (Keshi)dao.getObjectForId(Keshi.class, id);
		keshi.setUserinfodoc(null);
		LoginfoTools.logWrite(KeshiAction.class,"删除了"+keshi.getKname());
		dao.deleteObject(keshi);
		Map map = ServletActionContext.getContext().getSession();
		map.remove("keshiList");
		List<Keshi> keshiList = dao.getListForHql("from Keshi where kstate='可用'");
		ActionContext.getContext().getSession().put("keshiList", keshiList);
		return showKeshi();
	}
	
	//修改科室名
	@SuppressWarnings("rawtypes")
	public String updateKname() throws Exception {
		dao = new DaoBean();
		HttpServletRequest request = (HttpServletRequest) ActionContext.getContext().get(StrutsStatics.HTTP_REQUEST);
		String id = request.getParameter("id");
		String newname = request.getParameter("newname");
		if(newname.trim()==null) {
			message="对不起，科室名不能为空！\n请返回重新操作...";
			return INPUT;
		}
		boolean flag = true;
		List<Keshi> keshilist = dao.getListForHql("from Keshi order by id");
		for(int i = 0;i<keshilist.size();i++) {
			if(keshilist.get(i).getKname().equals(newname)) {
				flag = false;
				break;
			}
		}
		if(flag) {
			System.out.println("------------"+newname);
			Keshi keshi = (Keshi)dao.getObjectForId(Keshi.class, id);
			keshi.setKname(newname);
			LoginfoTools.logWrite(KeshiAction.class,"修改了"+keshi.getKname());
			dao.update(keshi);
			Map map = ServletActionContext.getContext().getSession();
			map.remove("keshiList");
			List<Keshi> keshiList = dao.getListForHql("from Keshi where kstate='可用'");
			ActionContext.getContext().getSession().put("keshiList", keshiList);
			return showKeshi();
		} else {
			message="对不起，该科室已经存在！\n请返回重新操作...";
			return INPUT;
		}		
	
	}
	public PageBean getPageBean() {
		return pageBean;
	}


	public void setPageBean(PageBean pageBean) {
		this.pageBean = pageBean;
	}



	public String getAddkname() {
		return addkname;
	}

	public void setAddkname(String addkname) {
		this.addkname = addkname;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	public Set<UserinfoDoc> getHaveUser() {
		return haveUser;
	}
	public void setHaveUser(Set<UserinfoDoc> haveUser) {
		this.haveUser = haveUser;
	}
	
	
}
