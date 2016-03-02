/*package cn.com.shxt.test;

import java.math.BigDecimal;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.utils.HibernateUtils;

public class Test3 {

	@SuppressWarnings("unchecked")
	public static void main(String[] args) {
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		List<UserinfoDoc> list = session.createQuery("from UserinfoDoc u where u.keshi is not null order by id").list();
		System.out.println("--"+list.size());
		
		Dao dao = new DaoBean();
		//根据输入的科室查询专家
	  String kname = "眼科";
	  List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null order by id");
		for(int  i = 0;i<userinfo.size();i++) {
			Keshi keshi = userinfo.get(i).getKeshi();
			if(keshi.getKname().equals(kname)) {
				boolean flag = false;
				Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
					for( YuyueTime y :yuyue) {
						flag=false;
						if(y.getWeek()!=null) {
							flag=true;
						}
					}
					if(flag) {
						listtiaojian.add(userinfo.get(i));
					}
			}
		}
		for(int i = 0;i<listtiaojian.size();i++) {
			System.out.println("姓名："+listtiaojian.get(i).getDname());
		}
		//根据输入的预约时间查询专家
		  String time = "星期四";
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
			List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null order by id");
			for(int  i = 0;i<userinfo.size();i++) {
					boolean flag = false;
					Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
						for( YuyueTime y :yuyue) {
							flag=false;
							if(y.getWeek().equals(time)) {
								flag=true;
								break;
							}
						}
						if(flag) {
							listtiaojian.add(userinfo.get(i));
						}
			}
			for(int i = 0;i<listtiaojian.size();i++) {
				System.out.println("姓名："+listtiaojian.get(i).getDname());
			}
		
		//模糊查询 根据姓名和电话号码的模糊查询
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		String tiaojian="阿";
		List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null and (dstate='可用' and dname like '%"+tiaojian+"%' or dtel like'%"+tiaojian+"%')");
		for(int i = 0;i<userinfo.size();i++) {
			boolean flag = false;
			Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
				for( YuyueTime y :yuyue) {
					flag=false;
					if(y.getWeek()!=null) {
						flag=true;
						break;
					}
				}
				if(flag) {
					listtiaojian.add(userinfo.get(i));
				}
		}
		for(int i = 0;i<listtiaojian.size();i++) {
			Keshi keshi = listtiaojian.get(i).getKeshi();
			
			System.out.println("姓名："+listtiaojian.get(i).getDname()+"科室："+keshi.getKname());
		}
		//获得年龄的方法
		List<UserinfoDoc> u = dao.getListForHql("from UserinfoDoc where id=1");
		String bir = u.get(0).getDbirthday();
		String bir_ = bir.substring(0, 4);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
			Date d1= new Date();
			System.out.println(d1.getDate()+1);
			String d2 = sdf.format(d1);
			System.out.println(d2);
			int week = d1.getDay();
			System.out.println(week);
			
			Date dateTime=new Date();
			 //设置30天后的日期
			 dateTime.setDate(2+dateTime.getDate());
			System.out.println(sdf.format(dateTime));
			System.out.println(dateTime.getDate());
//			System.out.println(d1);
		
			String d2_ = d2.substring(0, 4);
//			System.out.println(sdf.format(d1));
			int age = Integer.parseInt(d2_)-Integer.parseInt(bir_);
			System.out.println(age);
		
		//角色里移除某个用户
		
		
		
		 * UserinfoDoc userinfo = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, "48");
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, "7");

		Set<UserinfoDoc> uset = roleinfo.getUserinfodoc();
//		Set<UserinfoDoc> nowset = new HashSet<UserinfoDoc>();
//		nowset.add(userinfo);
		
		System.out.println(uset.size());
		uset.remove(userinfo);
		System.out.println(uset.size());
		
		roleinfo.setUserinfodoc(uset);
		
		dao.update(roleinfo);
		
		//给角色分配用户，
		Roleinfo roleinfo = (Roleinfo)dao.getObjectForId(Roleinfo.class, "7");
//		System.out.println(roleinfo.getRname());
		Set<UserinfoDoc> uset = roleinfo.getUserinfodoc();
		List<UserinfoDoc> userall = dao.getListForHql("from UserinfoDoc u where dstate='可用' and u.keshi is not null order by id");
				System.out.println(userall.size());
				userall.removeAll(uset);
				System.out.println(userall.size());
		//给角色分配这样就实现不了
		
		Keshi keshi = new Keshi();
		keshi.setKname("ssss");
		dao.save(keshi);
		
		//医生和病人关系
		UserinfoDoc u = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, "62");
		Patient p = (Patient)dao.getObjectForId(Patient.class, "2");
		session.delete(p);
		Set<Patient> pp = u.getPatient();
		for(Patient pa:pp) {
			pa.setUserinfodoc(null);
			session.update(pa);
			tx.commit();
		}
		session.delete(u);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date= new Date();
		sdf.format(date);
		
		List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo order by id desc");
		for(int i = 0;i<orderlist.size();i++) {
			try {
				Date orderdate = sdf.parse(orderlist.get(i).getOrderdate());
				if(date.before(orderdate)) {
					System.out.println("keyi");
				} else {
					System.out.println("过期");
				}
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		UserinfoDoc u = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, "99");
		u.setWeek(null);
		session.delete(u);
		UserinfoDoc u = (UserinfoDoc)dao.getObjectForId(UserinfoDoc.class, "63");
		YuyueTime yuyue  = (YuyueTime)dao.getObjectForId(YuyueTime.class, "8");
		yuyue.setWeek(null);
		session.delete(yuyue);
		String searchUser="眼";
		String hql = "from UserinfoDoc u where dstate='可用' " +
				"and dname like '%"+searchUser+"%' or " +
						"dtel like '%"+searchUser+"%' or dbirthday like '%"+searchUser+"%' or" +
								" id like '%"+searchUser+"%' or" +
										" u.keshi.kname like '%"+searchUser+"%' order by id";
		List<UserinfoDoc> userlist = dao.getListForHql(hql);
		System.out.println(userlist.size());
		
		List<UserinfoDoc> userinfo = dao.getListForHql("from UserinfoDoc u where u.keshi is not null and dstate='可用' order by id");
		System.out.println(userinfo.size());
		
		String sql = "select KNAME,COUNT(*) from ORDERINFO t where ORDERSTATE = '预约过期'  group by KNAME";
		List orderinfo = session.createSQLQuery(sql).list();
		
		for(int i = 0 ; i < orderinfo.size() ; i++){
			Object[] obj  =  (Object[])orderinfo.get(i);
			
			String orderdate = (String)obj[0];
//			BigDecimal did = (BigDecimal)obj[1];
			BigDecimal num = (BigDecimal)obj[1];
		//	String dname = (String)map.get("DNAME");
			System.out.println(orderdate+"--"+num);
		}
		///Map<String,Object> map = (Map<String,Object>)orderinfo.get(0);
		
		
		
		
		
		
		tx.commit();
		session.close();
	}

}
 */