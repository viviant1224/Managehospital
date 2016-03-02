package cn.com.shxt.model;

import java.io.Serializable;

public class City implements Serializable{
	private static final long serialVersionUID = -1057634856207373077L;
	private int id;
	private int cityid;
	private String city;
	private int fatherid;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getCityid() {
		return cityid;
	}
	public void setCityid(int cityid) {
		this.cityid = cityid;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public int getFatherid() {
		return fatherid;
	}
	public void setFatherid(int fatherid) {
		this.fatherid = fatherid;
	}
	
}
