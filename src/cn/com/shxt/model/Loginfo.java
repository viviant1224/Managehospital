package cn.com.shxt.model;

import java.io.Serializable;

public class Loginfo implements Serializable{
	private static final long serialVersionUID = 7306630174162147154L;
	private String log_date;
	private String log_message;
	private String log_name;
	
	public String getLog_date() {
		return log_date;
	}
	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}
	public String getLog_message() {
		return log_message;
	}
	public void setLog_message(String log_message) {
		this.log_message = log_message;
	}
	public String getLog_name() {
		return log_name;
	}
	public void setLog_name(String log_name) {
		this.log_name = log_name;
	}
	
	
}
