package cn.com.shxt.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Date;

import org.apache.struts2.ServletActionContext;

public class FileUpload {
	public String getNewName(String filename) {
		if(filename!=null&&!filename.equals("")) {
			Date date = new Date();
			date.getTime();
			return ""+date.getTime();
		} else {
			return null;
		}
	}
	@SuppressWarnings("deprecation")
	public void uploadFile(File file,String filename){
		try{
			FileInputStream input = new FileInputStream(file);
			String path = ServletActionContext.getRequest().getRealPath("/upload");
			File outFile = new File(path,filename);
			FileOutputStream output = new FileOutputStream(outFile);
			byte [] aa = new byte[1024];
			int len = 0;
			while((len=input.read(aa))>0) {
				output.write(aa, 0, len);
			}
			System.out.println("上传成功");
			input.close();
			output.close();	
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	public static void main(String[] args) {
		FileUpload fu = new FileUpload();
		System.out.println(fu.getNewName("sss"));
	}
}
