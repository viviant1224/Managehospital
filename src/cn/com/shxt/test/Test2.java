/*package cn.com.shxt.test;

import java.util.HashSet;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.Transaction;

import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Keshi;
import cn.com.shxt.model.Roleinfo;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.model.YuyueTime;
import cn.com.shxt.utils.HibernateUtils;

public class Test2 {

	public static void main(String[] args) {
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		
		
		Dao dao = new DaoBean();
		String hql = "from UserinfoDoc order by id";
		List<UserinfoDoc> userlist = dao.getListForHql(hql);
		for(int i = 0;i<userlist.size();i++) {
			Keshi keshi = userlist.get(i).getKeshi();
			if(keshi==null) {
				System.out.println("33");
			} else {
				
				System.out.println("-------"+keshi.getKname());
			}
		}
		Roleinfo roleinfo = (Roleinfo)session.get(Roleinfo.class,3);
		roleinfo.setPowerinfo(null);
	//	roleinfo.setUserinfodoc(null);
		session.delete(roleinfo);
		
		UserinfoDoc userinfo = (UserinfoDoc)session.get(UserinfoDoc.class, 4);
		session.delete(userinfo);
		Roleinfo roleinfo = (Roleinfo)session.get(Roleinfo.class, 1);
		session.delete(roleinfo);
		
		Powerinfo p = (Powerinfo)session.get(Powerinfo.class, 16);
		p.setPname("cha1");
		session.save(p);
		
		
		
		Dao dao = new DaoBean();
		List<UserinfoDoc> userlist = dao.getListForHql("from UserinfoDoc where dname='admin' and dstate='可用'");

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
		
		//测试一对多删除    成功
		Keshi keshi = (Keshi)session.get(Keshi.class, 1);
		Set<UserinfoDoc> userinfo = keshi.getUserinfodoc();
		if(userinfo.size()!=0) {
			for(UserinfoDoc user :userinfo) {
				System.out.println(user.getDname());
			}
		}
		keshi.setUserinfodoc(null);
		session.delete(keshi);
		
		
		UserinfoDoc userinfo = (UserinfoDoc)session.get(UserinfoDoc.class, 1);
		Keshi k = userinfo.getKeshi();
		System.out.println(k.getKname());
		session.delete(userinfo);
		tx.commit();
		session.close();
		
		Powerinfo power = new Powerinfo();
		power.setPid(14);
		power.setPname("454534");
		power.setPurl("--------");
		session.save(power);
		Patient p = new Patient();
		p.setPname("啦啦");
		p.setPstate("可用");
		session.save(p);
		//LoginfoTools.logWrite(UserinfoDocAction.class, "注册了");
		
		UserinfoDoc userinfo = new UserinfoDoc();
		userinfo.setDbirthday("--");
		userinfo.setDimageFileName("sadasd");
		userinfo.setDname("赵发");
		userinfo.setDstate("可用");
		userinfo.setDtel("--");
		userinfo.setPassword("111");
////		//userinfo.setKeshi(keshi_);
//		
//		//多对多的级联更新、添加
		Dao dao = new DaoBean();
////		UserinfoDoc userinfo = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, "3");
		String yuyuetime="1,2,3";
////		
		String [] yuyuetime_ = yuyuetime.split(",");
		Set<YuyueTime> weekset = new HashSet<YuyueTime>();
		for(int i = 1;i<yuyuetime_.length;i++) {
			YuyueTime week = (YuyueTime)dao.getObjectForId(YuyueTime.class,""+yuyuetime_[i]);
			weekset.add(week);
		}
		userinfo.setWeek(weekset);
		dao.save(userinfo);
//		
		//LoginfoTools.logWrite(UserinfoDocAction.class, "注册了e");
		Date date = new Date();
		long l = date.getTime();
		int i = (int)l;
		System.out.println(i);
		Dao dao = new DaoBean();
		
		Roleinfo roleinfo = new Roleinfo();
		roleinfo.setRname("护士");
		dao.save(roleinfo);
		Keshi keshi = (Keshi)dao.getObjectForId(Keshi.class, "8");
		keshi.setUserinfodoc(null);
		session.delete(keshi);
		
		
		tx.commit();
		session.close();
	}

}
*/