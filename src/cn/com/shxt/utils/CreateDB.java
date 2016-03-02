package cn.com.shxt.utils;



import org.hibernate.cfg.Configuration;
import org.hibernate.tool.hbm2ddl.SchemaExport;

public class CreateDB {

	public static void main(String[] args) {
		
		Configuration cfg = new Configuration();
		//因为默认就读取是src下面文件名
		cfg.configure();
		
		SchemaExport export = new SchemaExport(cfg);//把cfg.xml中的数据库信息和hbm中表信息全部变成sql脚本
		
		export.create(true, true);
	}
}
