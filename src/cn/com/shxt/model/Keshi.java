package cn.com.shxt.model;

import java.io.Serializable;
import java.util.Set;

public class Keshi implements Serializable{
	private static final long serialVersionUID = 4418073427359236746L;
	private int id;
	private String kname;
	private String kstate;
	private Set<UserinfoDoc> userinfodoc;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getKname() {
		return kname;
	}
	public void setKname(String kname) {
		this.kname = kname;
	}
	public Set<UserinfoDoc> getUserinfodoc() {
		return userinfodoc;
	}
	public void setUserinfodoc(Set<UserinfoDoc> userinfodoc) {
		this.userinfodoc = userinfodoc;
	}
	public String getKstate() {
		return kstate;
	}
	public void setKstate(String kstate) {
		this.kstate = kstate;
	}
	
}
