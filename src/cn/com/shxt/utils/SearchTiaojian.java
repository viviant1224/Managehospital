package cn.com.shxt.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import cn.com.shxt.model.Keshi;
import cn.com.shxt.model.Roleinfo;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.model.YuyueTime;

public class SearchTiaojian {
	public static List<UserinfoDoc> gettiaojianT_U (List<UserinfoDoc> userinfo) {
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		for(int i = 0;i<userinfo.size();i++) {
			boolean flag1= false;
			Set<Roleinfo> roleinfo = userinfo.get(i).getRoleinfo();
			for(Roleinfo r:roleinfo) {
				if(r.getRname().equals("专家")) {
					flag1=true;
				}
			}
			boolean flag = false;
			Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
				for( YuyueTime y :yuyue) {
					flag=false;
					if(y.getWeek()!=null) {
						flag=true;
						break;
					}
				}
				if(flag&&flag1) {
					listtiaojian.add(userinfo.get(i));
				}
		}
		return listtiaojian;
	}
	public static List<UserinfoDoc> gettiaojianKeshi(String kname,List<UserinfoDoc> userinfo) {
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		for(int  i = 0;i<userinfo.size();i++) {
			
			boolean flag1= false;
			Set<Roleinfo> roleinfo = userinfo.get(i).getRoleinfo();
			for(Roleinfo r:roleinfo) {
				if(r.getRname().equals("专家")) {
					flag1=true;
				}
			}
			
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
					if(flag&&flag1) {
						listtiaojian.add(userinfo.get(i));
					}
			}
		}
		return listtiaojian;
	}
	public static List<UserinfoDoc> gettiaojianweek(String time,List<UserinfoDoc> userinfo) {
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		for(int  i = 0;i<userinfo.size();i++) {
			boolean flag1= false;
			Set<Roleinfo> roleinfo = userinfo.get(i).getRoleinfo();
			for(Roleinfo r:roleinfo) {
				if(r.getRname().equals("专家")) {
					flag1=true;
				}
			}
				boolean flag = false;
				Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
					for( YuyueTime y :yuyue) {
						flag=false;
						if(y.getWeek().equals(time)) {
							flag=true;
							break;
						}
					}
					if(flag&&flag1) {
						listtiaojian.add(userinfo.get(i));
					}
		}
		return listtiaojian;
	}
	
	
	
	
	//全部
	public static List<UserinfoDoc> getall(List<UserinfoDoc> userinfo) {
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		for(int i = 0;i<userinfo.size();i++) {
			boolean flag1= false;
			Set<Roleinfo> roleinfo = userinfo.get(i).getRoleinfo();
			for(Roleinfo r:roleinfo) {
				if(r.getRname().equals("专家")) {
					flag1=true;
				}
			}
			boolean flag = false;
			Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
				for( YuyueTime y :yuyue) {
					flag=false;
					if(y.getWeek()!=null) {
						flag=true;
						break;
					}
				}
				if(flag&&flag1) {
					listtiaojian.add(userinfo.get(i));
				}
		}
		return listtiaojian;
	}
	public static int getAllSize(List<UserinfoDoc> userinfo) {
		List<UserinfoDoc> listtiaojian = new ArrayList<UserinfoDoc>();
		for(int i = 0;i<userinfo.size();i++) {
			boolean flag1= false;
			Set<Roleinfo> roleinfo = userinfo.get(i).getRoleinfo();
			for(Roleinfo r:roleinfo) {
				if(r.getRname().equals("专家")) {
					flag1=true;
				}
			}
			boolean flag = false;
			Set<YuyueTime> yuyue = userinfo.get(i).getWeek();
				for( YuyueTime y :yuyue) {
					flag=false;
					if(y.getWeek()!=null) {
						flag=true;
						break;
					}
				}
				if(flag&&flag1) {
					listtiaojian.add(userinfo.get(i));
				}
		}
		return listtiaojian.size();
	}
}
