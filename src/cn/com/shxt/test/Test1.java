/*package cn.com.shxt.test;



import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.Transaction;

import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Powerinfo;
import cn.com.shxt.model.Roleinfo;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.utils.HibernateUtils;

public class Test1 {

	public static void main(String[] args) {
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		
		
		
		//一对多 一方维护关系    session只维护级联关系的维护方（主控方）
		//级联关系的建立（级联添加）
		//添加效果 首先添加班级 其次添加学生但是不添加外键  当学生添加完毕之后再去修改学生外键
		
	
		Userinfo userinfo = new Userinfo();
		userinfo.setAge("20");
		userinfo.setUsername("小明");
		userinfo.setBirthday("92-12-21");
		userinfo.setPassword("123");
		session.save(userinfo);
		Dao dao = new DaoBean();
		List<Userinfo> userlist = dao.getListForHql("from Userinfo");
		Userinfo userinfo = new Userinfo();
		userinfo.setAge("19");
		userinfo.setBirthday("ssss");
		userinfo.setUsername("啊啊");
		session.save(userinfo);
		System.out.println(userlist.size());
		
		
		Roleinfo roleinfo = new Roleinfo();
		roleinfo.setRname("管理员");
		session.save(roleinfo);
		
		
		Roleinfo roleinfo1 = new Roleinfo();
		roleinfo1.setRname("专家");
		session.save(roleinfo1);
		
		
		
		Powerinfo power = new Powerinfo();
		power.setMid(1);
		power.setPid(0);
		power.setPname("菜单管理");
		power.setPurl("javascript:;");
		
			Powerinfo power1 = new Powerinfo();
			power1.setMid(2);
			power1.setPid(1);
			power1.setPname("系统管理");
			power1.setPurl("javascript:;");
			
				//管理员权限
			
				
				Powerinfo power3 = new Powerinfo();
				power3.setMid(4);
				power3.setPid(2);
				power3.setPname("角色管理");
				power3.setPurl("javascript:;");
				
			
				Powerinfo power4 = new Powerinfo();
				power4.setMid(5);
				power4.setPid(2);
				power4.setPname("科室管理");
				power4.setPurl("javascript:;");
				
			
				
				Powerinfo power5 = new Powerinfo();
				power5.setMid(6);
				power5.setPid(2);
				power5.setPname("权限管理");
				power5.setPurl("javascript:;");
		//
		//只有管理员才有删除的权限
			Powerinfo power6 = new Powerinfo();
			power6.setMid(7);
			power6.setPid(1);
			power6.setPname("日志管理");
			power6.setPurl("javascript:;");
			
			
				
		
	
		//用户权限
			Powerinfo power7 = new Powerinfo();
			power7.setMid(8);
			power7.setPid(1);
			power7.setPname("病人管理");
			power7.setPurl("javascript:;");
		
		
				Powerinfo power8 = new Powerinfo();
				power8.setMid(9);
				power8.setPid(8);
				power8.setPname("添加病人");
				power8.setPurl("javascript:;");
				
				Powerinfo power9 = new Powerinfo();
				power9.setMid(10);
				power9.setPid(8);
				power9.setPname("查看病人");
				power9.setPurl("javascript:;");
				
		
			
			//管理员权限
			Powerinfo power10 = new Powerinfo();
			power10.setMid(11);
			power10.setPid(1);
			power10.setPname("专家管理");
			power10.setPurl("javascript:;");
			
				Powerinfo power11 = new Powerinfo();
				power11.setMid(12);
				power11.setPid(11);
				power11.setPname("添加专家");
				power11.setPurl("javascript:;");
				
				Powerinfo power12 = new Powerinfo();
				power12.setMid(13);
				power12.setPid(11);
				power12.setPname("专家查看");
				power12.setPurl("javascript:;");
				
				
				
				
			Powerinfo power13 = new Powerinfo();
			power13.setMid(14);
			power13.setPid(1);
			power13.setPname("预约管理");
			power13.setPurl("javascript:;");
				//用户权限
				Powerinfo power14 = new Powerinfo();
				power14.setMid(15);
				power14.setPid(14);
				power14.setPname("添加预约");
				power14.setPurl("javascript:;");
				
				//用户权限
				Powerinfo power15 = new Powerinfo();
				power15.setMid(16);
				power15.setPid(14);
				power15.setPname("查看预约");
				power15.setPurl("javascript:;");
				
				
			
				//管理员权限
				Powerinfo power16 = new Powerinfo();
				power16.setMid(17);
				power16.setPid(14);
				power16.setPname("查看所有预约");
				power16.setPurl("javascript:;");
				
				//管理员权限  列出所有专家的预约时间并且可以修改
				Powerinfo power17 = new Powerinfo();
				power17.setMid(18);
				power17.setPid(14);
				power17.setPname("预约时间管理");
				power17.setPurl("javascript:;");
			
			
			
			
			
				//
		session.save(power);
		session.save(power1);
		session.save(power3);
		session.save(power4);
		session.save(power5);
		session.save(power6);
		session.save(power7);
		session.save(power8);
		session.save(power9);
		session.save(power10);
		session.save(power11);
		
		session.save(power12);
		session.save(power14);
		session.save(power13);
		session.save(power15);
		session.save(power16);
		session.save(power17);
		
		
		
		
		
		UserinfoDoc userinfo1 = new UserinfoDoc();
		userinfo1.setDname("李时珍");
		userinfo1.setDstate("可用");
		userinfo1.setDtel("11111111");
		userinfo1.setPassword("111");
		session.save(userinfo1);
		
		UserinfoDoc userinfo2 = new UserinfoDoc();
		userinfo2.setDname("喜鹊");
		userinfo2.setDstate("可用");
		userinfo2.setDtel("11111111");
		userinfo2.setPassword("111");
		session.save(userinfo2);
		
		UserinfoDoc userinfo3 = new UserinfoDoc();
		userinfo3.setDname("喜来乐");
		userinfo3.setDstate("可用");
		userinfo3.setDtel("11111111");
		userinfo3.setPassword("111");
		session.save(userinfo3);
		
		UserinfoDoc userinfo4 = new UserinfoDoc();
		userinfo4.setDname("admin");
		userinfo4.setDstate("可用");
		userinfo4.setDtel("admin");
		userinfo4.setPassword("111");
		session.save(userinfo4);
		
		Keshi keshi = new Keshi();
		keshi.setKname("眼科");
		session.save(keshi);
		
		Keshi keshi1 = new Keshi();
		keshi1.setKname("内科");
		session.save(keshi1);
		
		Keshi keshi2 = new Keshi();
		keshi2.setKname("外科");
		session.save(keshi2);
		
		Keshi keshi3 = new Keshi();
		keshi3.setKname("咽喉科");
		session.save(keshi3);
		
		UserinfoDoc userinfodoc = (UserinfoDoc)session.get(UserinfoDoc.class, 8);
		
		Patient p = new Patient();
		p.setPname("小王");
		p.setPstate("可用");
		p.setPassword("111");
		p.setUserinfodoc(userinfodoc);
		session.save(p);
		
		UserinfoDoc userinfo = new UserinfoDoc();
		userinfo.setDname("华佗");
		userinfo.setDstate("可用");
		userinfo.setDtel("11111111");
		userinfo.setPassword("111");
		session.save(userinfo);
		
		//UserinfoDoc userinfodoc = (UserinfoDoc)session.get(UserinfoDoc.class, 14);
		
		/*Patient p = (Patient)session.get(Patient.class, 8);
		//userinfodoc.setPatient(null);
		p.setUserinfodoc(null);
		session.delete(p);
		
		
		
		
		
		
		UserinfoDoc userinfo = (UserinfoDoc)session.get(UserinfoDoc.class,1);
		
		session.delete(userinfo);
		
	
		
		Powerinfo power6 = new Powerinfo();
		power6.setMid(20);
		power6.setPid(7);
		power6.setPname("------");
		power6.setPurl("javascript:;");
		session.save(power6);
		
		Powerinfo power7 = new Powerinfo();
		power7.setId(19);
		power7.setMid(20);
		power7.setPid(7);
		power7.setPname("查看所有日志");
		power7.setPurl("javascript:;");
		session.save(power7);
		
		
		Dao dao = new DaoBean();

		List<UserinfoDoc> userlist = dao.getListForHql("from UserinfoDoc where dname='admin'");
		Set<Powerinfo> setall = new HashSet<Powerinfo>();
		UserinfoDoc userinfo = userlist.get(0);
		Set<Roleinfo> setr = userinfo.getRoleinfo();
		System.out.println(setr.size());
		for (Roleinfo roleinfo : setr) {
			System.out.println("当前用户的角色名" + roleinfo.getRname());
			Set<Powerinfo> setp = roleinfo.getPowerinfo();
			for (Powerinfo powerinfo : setp) {
				System.out.println("当前用户的权限名"
						+ powerinfo.getPname());
				setall.add(powerinfo);
			}
		}
		
		
		Dao dao = new DaoBean();
		UserinfoDoc userinfo = new UserinfoDoc();
		
		Keshi keshi_ = (Keshi)dao.getObjectForId(Keshi.class,"3");
		userinfo.setDbirthday("111");
		userinfo.setDimageFileName("1111");
		userinfo.setDname("赵发");
		userinfo.setDstate("可用");
		userinfo.setDtel("111111111");
		userinfo.setPassword("111111111");
		userinfo.setYuyuetime("222222");
		userinfo.setKeshi(keshi_);
		dao.save(userinfo);
		
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
		
		Powerinfo power = new Powerinfo();
		//power.setMid(1);
		power.setPid(0);
		power.setPname("菜单管理");
		power.setPurl("javascript:;");
		
		Powerinfo power1 = new Powerinfo();
	//	power1.setMid(2);
		power1.setPid(4);
		power1.setPname("系统管理");
		power1.setPurl("javascript:;");
		
		Powerinfo power1 = new Powerinfo();
		//	power1.setMid(2);
			power1.setPid(4);
			power1.setPname("系统管理");
			power1.setPurl("javascript:;");
			
			Powerinfo power2 = new Powerinfo();
			//	power1.setMid(2);
				power2.setPid(4);
				power2.setPname("日志管理");
				power2.setPurl("javascript:;");
				
				Powerinfo power3 = new Powerinfo();
				//	power1.setMid(2);
					power3.setPid(4);
					power3.setPname("专家管理");
					power3.setPurl("javascript:;");
					
					Powerinfo power4 = new Powerinfo();
					//	power1.setMid(2);
						power4.setPid(4);
						power4.setPname("病人管理");
						power4.setPurl("javascript:;");
						
						Powerinfo power5 = new Powerinfo();
						//	power1.setMid(2);
							power5.setPid(4);
							power5.setPname("预约管理");
							power5.setPurl("javascript:;");
		
		Powerinfo power3 = new Powerinfo();
	//	power3.setMid(4);
		power3.setPid(8);
		power3.setPname("添加病人");
		power3.setPurl("javascript:;");
		
	
		Powerinfo power4 = new Powerinfo();
	//	power4.setMid(5);
		power4.setPid(8);
		power4.setPname("查看病人");
		power4.setPurl("javascript:;");
		
	
		
		Powerinfo power5 = new Powerinfo();
	//	power5.setMid(6);
		power5.setPid(8);
		power5.setPname("查看所有病人");
		power5.setPurl("javascript:;");
		
		Powerinfo power2 = new Powerinfo();
		//	power5.setMid(6);
			power2.setPid(9);
			power2.setPname("---------");
			power2.setPurl("javascript:;");
//
		
	//	session.save(power1);
		session.save(power2);
//		session.save(power3);
//		session.save(power4);
//		session.save(power5);
		tx.commit();
		session.close();
	}

}
*/