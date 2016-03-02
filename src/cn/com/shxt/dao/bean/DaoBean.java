package cn.com.shxt.dao.bean;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import cn.com.shxt.beans.PageBean;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.model.UserinfoDoc;
import cn.com.shxt.utils.HibernateUtils;

public class DaoBean implements Dao {
	
private PageBean pagebean;
	
	public DaoBean(){
		pagebean = new PageBean();
	}

	public void save(Object object) {
		
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		try{
			session.save(object);
			tx.commit();
		}catch(Exception e){
			e.printStackTrace();
			tx.rollback();
		}finally{
			session.close();
		}
		
	}

	public void update(Object object) {
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		try{
			session.update(object);
			tx.commit();
		}catch(Exception e){
			e.printStackTrace();
			tx.rollback();
		}finally{
			session.close();
		}
	}

	@SuppressWarnings("unchecked")
	public <T extends Serializable> List<T> getListForHql(String hql) {
		Session session = HibernateUtils.getSession();
		try{
//			Query query = session.createQuery(arg0);
//			List<T> list = query.list();
			List<T> list = session.createQuery(hql).list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally{
			session.close();
		}
	}
	
	@SuppressWarnings("rawtypes")
	public List getListForSql(String sql) {
		Session session = HibernateUtils.getSession();
		try{
			List list = session.createSQLQuery(sql).list();
			return list;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally{
			session.close();
		}
	}
	
	@SuppressWarnings("rawtypes")
	public Object getObjectForId(Class cla, String id) {
		Session session = HibernateUtils.getSession();
		try{
			if(id instanceof String){
				int id1 = Integer.parseInt(id);
				Object object = session.get(cla, id1);
				return object;
			}else{
				Object object = session.get(cla, id);
				return object;
			}
			//Object object = session.get(cla, Integer.parseInt(id));
			//return object;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally{
			session.close();
		}
	}

	@SuppressWarnings("rawtypes")
	public void delete(Class cla,  String id) {
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		try{
			Object object  =  session.get(cla, Integer.parseInt(id));
			session.delete(object);
			tx.commit();
		}catch(Exception e){
			e.printStackTrace();
			tx.rollback();
		}finally{
			session.close();
		}
		
	}


@SuppressWarnings("unchecked")
public PageBean pageList(String hql,int pageRows,int firstPage,int maxNum){
		
	Session session = HibernateUtils.getSession();
		try{
			Query query = session.createQuery(hql);
			query.setFirstResult(firstPage);
			query.setMaxResults(pageRows);
			//开始封装
			List<UserinfoDoc> list = query.list();
			pagebean.setList(list);//封装分页结构
			System.out.println(new Date()+"当前页记录数量"+list.size()+"条");
			pagebean.setFirstPage(firstPage);//封装当前页的分页起始位置
			System.out.println(new Date()+"当前页的分页起始位置"+firstPage);
			pagebean.setMaxNum(maxNum);//封装总记录数
			System.out.println(new Date()+"总记录数量"+maxNum+"条");
			pagebean.setMaxPageNum((maxNum+(pageRows-1))/pageRows);//封装总页数
			System.out.println(new Date()+"共有"+(maxNum+(pageRows-1))/pageRows+"页记录");
			pagebean.setPageNum(firstPage/pageRows+1);//封装当前页
			System.out.println(new Date()+"当前是第"+(firstPage/pageRows+1)+"页");
			pagebean.setPageRows(pageRows);//封装每页显示记录数
			System.out.println(new Date()+"每页显示"+pageRows+"条");
		
			return pagebean;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally{
			session.close();
		}
	}
	
	public int pageMaxList(String hql){
		Session session = HibernateUtils.getSession();
		try{
			Query query = session.createQuery(hql);
			return query.list().size();
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}finally{
			session.close();
		}
	}
	
	public void deleteObject(Object obj) {
		Session session = HibernateUtils.getSession();
		Transaction tx = session.beginTransaction();
		try{
			session.delete(obj);
			tx.commit();
		}catch(Exception e){
			e.printStackTrace();
			tx.rollback();
		}finally{
			session.close();
		}
		
	}

}
