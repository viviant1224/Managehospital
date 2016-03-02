package cn.com.shxt.model;

import java.io.Serializable;
import java.util.Set;

public class YuyueTime implements Serializable{
	private static final long serialVersionUID = 8541723989008661633L;
	private int id;
	private String week;
	private Set<UserinfoDoc> userinfo;
	private int weekid;
	private String timestate;
	
	public String getTimestate() {
		return timestate;
	}
	public void setTimestate(String timestate) {
		this.timestate = timestate;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public Set<UserinfoDoc> getUserinfo() {
		return userinfo;
	}
	public void setUserinfo(Set<UserinfoDoc> userinfo) {
		this.userinfo = userinfo;
	}
	public int getWeekid() {
		return weekid;
	}
	public void setWeekid(int weekid) {
		this.weekid = weekid;
	}
	
	
} 
