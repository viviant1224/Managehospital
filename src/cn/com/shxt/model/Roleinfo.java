package cn.com.shxt.model;

import java.io.Serializable;
import java.util.Set;

public class Roleinfo implements Serializable {
	private static final long serialVersionUID = -8156568616591350543L;
	private int id;
	private String rname;
	private Set<UserinfoDoc> userinfodoc;
	private Set<Powerinfo> powerinfo;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	
	public Set<UserinfoDoc> getUserinfodoc() {
		return userinfodoc;
	}
	public void setUserinfodoc(Set<UserinfoDoc> userinfodoc) {
		this.userinfodoc = userinfodoc;
	}
	public Set<Powerinfo> getPowerinfo() {
		return powerinfo;
	}
	public void setPowerinfo(Set<Powerinfo> powerinfo) {
		this.powerinfo = powerinfo;
	}
	
}
