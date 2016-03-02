package cn.com.shxt.model;

import java.io.Serializable;

public class Area implements Serializable{
	private static final long serialVersionUID = -7027692814907193903L;
	private int id;
	private int areaid;
	private String area;
	private int fatherid;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAreaid() {
		return areaid;
	}
	public void setAreaid(int areaid) {
		this.areaid = areaid;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public int getFatherid() {
		return fatherid;
	}
	public void setFatherid(int fatherid) {
		this.fatherid = fatherid;
	}
	
}
