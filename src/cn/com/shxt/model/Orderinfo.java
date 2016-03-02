package cn.com.shxt.model;

import java.io.Serializable;

public class Orderinfo implements Serializable{
	private static final long serialVersionUID = -8598673871551367160L;
	private int id;//id病人挂号信息
	private String pname;//病人
	private String dname;//医生
	private int pid;//病人的id
	private int did;//医生的id
	private String orderdate;//预约时间
	private String orderstate;//预约状态
	private String jiuzhenTime;//就诊时间
	private String kname;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	public String getOrderstate() {
		return orderstate;
	}
	public void setOrderstate(String orderstate) {
		this.orderstate = orderstate;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getDid() {
		return did;
	}
	public void setDid(int did) {
		this.did = did;
	}
	public String getKname() {
		return kname;
	}
	public void setKname(String kname) {
		this.kname = kname;
	}
	public String getJiuzhenTime() {
		return jiuzhenTime;
	}
	public void setJiuzhenTime(String jiuzhenTime) {
		this.jiuzhenTime = jiuzhenTime;
	}
	
}
