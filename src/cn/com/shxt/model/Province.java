package cn.com.shxt.model;

import java.io.Serializable;

public class Province implements Serializable{
	private static final long serialVersionUID = 8949159865388443804L;
	private int id;
	private int provinceid;
	private String province;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProvinceid() {
		return provinceid;
	}
	public void setProvinceid(int provinceid) {
		this.provinceid = provinceid;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	
}
