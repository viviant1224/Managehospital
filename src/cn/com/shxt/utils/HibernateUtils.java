package cn.com.shxt.utils;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtils {
	private static Configuration  configuration;
	private static SessionFactory sessionFactory;
	static{
		configuration= new Configuration();
		configuration.configure();
		sessionFactory = configuration.buildSessionFactory();
	}
	public static Session getSession() {
		try{
			
			Session session = sessionFactory == null?null:sessionFactory.openSession();
			return session;
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}
		
	}
}
