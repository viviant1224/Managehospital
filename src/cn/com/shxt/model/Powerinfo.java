package cn.com.shxt.model;

import java.io.Serializable;
import java.util.Set;

public class Powerinfo implements Serializable {
	private static final long serialVersionUID = 102990521077053691L;
	private int id;
	private String pname;
	private String purl;
	private int mid;
	private int pid;
	private Set<Roleinfo> roleinfo;
	/*public Powerinfo(int id,String pname,int mid,int pid,String purl,Set<Roleinfo> roleinfo) {
		this.id = id;
		this.mid = mid;
		this.pname = pname;
		this.pid = pid;
		this.purl = purl;
		this.roleinfo = roleinfo;
	}*/
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
	
	public String getPurl() {
		return purl;
	}
	public void setPurl(String purl) {
		this.purl = purl;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public Set<Roleinfo> getRoleinfo() {
		return roleinfo;
	}
	public void setRoleinfo(Set<Roleinfo> roleinfo) {
		this.roleinfo = roleinfo;
	}
	
	
	public int hashCode(){
		return 1;
	}
	public boolean equals(Object b){
		if(!(b instanceof Powerinfo))
			throw new RuntimeException();
		
			Powerinfo temp = (Powerinfo)b;
			
		if(temp.id==this.id){
			return true;
		}else{
			
			return this.pname.equals(temp.pname);
		}
		// return pname==temp.pname && purl.equals(temp.purl);
	}

}
