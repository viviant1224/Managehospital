package cn.com.shxt.dao;

import java.io.Serializable;
import java.util.List;

import cn.com.shxt.beans.PageBean;

public interface Dao {

	/**
	 * @return 
	 * @描述：数据添加
	 * @作者：黄威威
	 * @开发时间： 2013-10-26 下午03:19:52
	 * @方法参数： @param object
	 * @方法返回值：void
	 */
	public abstract void save(Object object);
	
	/**
	 * @描述：数据编辑
	 * @作者：黄威威
	 * @开发时间： 2013-10-26 下午03:19:52
	 * @方法参数： @param object
	 * @方法返回值：void
	 */
	public abstract void update(Object object);
	

	/**
	 * @描述：数据查询根据hql
	 * @作者：黄威威
	 * @开发时间： 2013-10-26 下午03:38:47
	 * @方法参数： @param <T>
	 * @方法参数： @param hql
	 * @方法参数： @return
	 * @方法返回值：List<T>
	 */
	public <T extends Serializable> List<T>  getListForHql(String hql);
	
	/**
	 * @描述：根据主键检索数据
	 * @作者：黄威威
	 * @开发时间： 2013-10-29 下午07:22:10
	 * @方法参数： @param id
	 * @方法参数： @return
	 * @方法返回值：Object
	 */
	
	@SuppressWarnings("rawtypes")
	public Object getObjectForId(Class cla,String id);
	
	
	/**
	 * @描述：根据所选ID删除
	 * @作者：黄威威
	 * @开发时间： 2013-10-29 下午08:07:21
	 * @方法参数： @param cla
	 * @方法参数： @param id
	 * @方法返回值：void
	 */
	
	@SuppressWarnings("rawtypes")
	public void delete(Class cla,  String id);
	/**
	 * @描述：数据分页查询
	 * @作者：黄威威
	 * @开发时间： 2013-6-29 下午12:17:20
	 * @方法参数： @param hql语句  每页显示记录数  分页的起始位置  总记录数
	 * @方法返回值：当前持久态对象
	 */

	public PageBean pageList(String hql,int pageRows,int firstPage,int maxNum);	
	
	/**
	 * @描述：分页求总记录数
	 * @作者：黄威威
	 * @开发时间： 2013-7-25 下午02:31:05
	 * @方法参数： @param stringhql
	 * @方法参数： @return
	 * @方法返回值：int
	 */
	public int pageMaxList(String hql);
	
	/**
	 * @描述：删除某一对象
	 * @作者：黄威威
	 * @开发时间： 2013-7-25 下午02:31:05
	 * @方法参数： @param stringhql
	 * @方法参数： @return
	 * @方法返回值：int
	 */
	public void deleteObject(Object obj);
	
	/**
	 * @描述：数据查询根据sql
	 * @作者：黄威威
	 * @开发时间： 2013-10-26 下午03:38:47
	 * @方法参数： @param <T>
	 * @方法参数： @param hql
	 * @方法参数： @return
	 * @方法返回值：List<T>
	 */
	@SuppressWarnings("rawtypes")
	public List getListForSql(String sql);
}