package cn.com.shxt.model;

import java.io.File;
import java.io.Serializable;
import java.util.Set;

public class UserinfoDoc implements Serializable {
	private static final long serialVersionUID = -3503516717489584949L;
	private int id;
	private String dname;
	private String password;
	private String dstate;
	private String dbirthday;
	private String dimageFileName;
	private File  dimage;
	private String dtel;
	private Set<Roleinfo> roleinfo;//对应的角色
	private Set<Patient> patient;
	private Set<YuyueTime> week;
	private Keshi keshi;
	private String info;
	public String getDimageFileName() {
		return dimageFileName;
	}
	public void setDimageFileName(String dimageFileName) {
		this.dimageFileName = dimageFileName;
	}
	public File getDimage() {
		return dimage;
	}
	public void setDimage(File dimage) {
		this.dimage = dimage;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getDstate() {
		return dstate;
	}
	public void setDstate(String dstate) {
		this.dstate = dstate;
	}
	public String getDbirthday() {
		return dbirthday;
	}
	public void setDbirthday(String dbirthday) {
		this.dbirthday = dbirthday;
	}

	public String getDtel() {
		return dtel;
	}
	public void setDtel(String dtel) {
		this.dtel = dtel;
	}
	
	public Set<YuyueTime> getWeek() {
		return week;
	}
	public void setWeek(Set<YuyueTime> week) {
		this.week = week;
	}
	public Set<Roleinfo> getRoleinfo() {
		return roleinfo;
	}
	public void setRoleinfo(Set<Roleinfo> roleinfo) {
		this.roleinfo = roleinfo;
	}
	public Set<Patient> getPatient() {
		return patient;
	}
	public void setPatient(Set<Patient> patient) {
		this.patient = patient;
	}
	public Keshi getKeshi() {
		return keshi;
	}
	public void setKeshi(Keshi keshi) {
		this.keshi = keshi;
	}
	
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public int hashCode(){
		return this.dname.hashCode();
	}
	public boolean equals(Object b){
		if(!(b instanceof UserinfoDoc))
			throw new RuntimeException();
			UserinfoDoc temp = (UserinfoDoc)b;
		if(temp.id==this.id){
			return true;
		}else{
			return this.dname.equals(temp.dname);
		}
	}

}
