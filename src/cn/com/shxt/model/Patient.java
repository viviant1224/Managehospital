package cn.com.shxt.model;

import java.io.File;
import java.io.Serializable;

public class Patient implements Serializable {
	private static final long serialVersionUID = 4904063047372609339L;
	private int id;//id  可用作登录名
	private String pname;
	private String password;
	private String pimageFileName;
	private File  pimage;
	private String pstate;
	private String pbirthday;
	private String ptel;
	private String paddress;
	private String pmoney;
	private String pquestion;
	private String panswer;//密保问题答案
	private UserinfoDoc userinfodoc;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPimageFileName() {
		return pimageFileName;
	}
	public void setPimageFileName(String pimageFileName) {
		this.pimageFileName = pimageFileName;
	}
	public File getPimage() {
		return pimage;
	}
	public void setPimage(File pimage) {
		this.pimage = pimage;
	}
	public String getPstate() {
		return pstate;
	}
	public void setPstate(String pstate) {
		this.pstate = pstate;
	}
	public String getPbirthday() {
		return pbirthday;
	}
	public void setPbirthday(String pbirthday) {
		this.pbirthday = pbirthday;
	}
	public String getPtel() {
		return ptel;
	}
	public void setPtel(String ptel) {
		this.ptel = ptel;
	}
	public String getPaddress() {
		return paddress;
	}
	public void setPaddress(String paddress) {
		this.paddress = paddress;
	}
	public String getPmoney() {
		return pmoney;
	}
	public void setPmoney(String pmoney) {
		this.pmoney = pmoney;
	}
	
	public String getPquestion() {
		return pquestion;
	}
	public void setPquestion(String pquestion) {
		this.pquestion = pquestion;
	}
	public String getPanswer() {
		return panswer;
	}
	public void setPanswer(String panswer) {
		this.panswer = panswer;
	}
	public UserinfoDoc getUserinfodoc() {
		return userinfodoc;
	}
	public void setUserinfodoc(UserinfoDoc userinfodoc) {
		this.userinfodoc = userinfodoc;
	}
	
	
}
