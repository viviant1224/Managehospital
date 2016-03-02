package cn.com.shxt.utils;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;
import cn.com.shxt.model.Orderinfo;
import cn.com.shxt.model.Patient;
public class Dealyuyuedate {
	public static void dealDateyuyue() throws Exception{
		Dao dao = new DaoBean();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
		Date date= new Date();
		sdf.format(date);
		List<Orderinfo> orderlist = dao.getListForHql("from Orderinfo order by id desc");
		for(int i = 0;i<orderlist.size();i++) {
				Date  orderdate = sdf.parse(orderlist.get(i).getOrderdate());
				if(date.before(orderdate)||
				orderlist.get(i).getOrderstate().equals("预约取消")||
				orderlist.get(i).getOrderstate().equals("预约完成")||
				orderlist.get(i).getOrderstate().equals("预约过期")) {
				} else {
					orderlist.get(i).setOrderstate("预约过期");
					dao.update(orderlist.get(i));
					String pid = ""+orderlist.get(i).getPid();
					Patient p = (Patient)dao.getObjectForId(Patient.class, pid);
					p.setPstate("待定");
					String money = p.getPmoney();
					int money_ = Integer.parseInt(money)+20;
					String mmoney = ""+money_;
					p.setPmoney(mmoney);
					p.setUserinfodoc(null);
					dao.update(p);
				}
		}
	}
}
