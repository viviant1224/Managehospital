package cn.com.shxt.beans;

import java.util.List;


/**
 * @author 黄威威
 * @version1.0
 *
 */
public class PageBean {
	//结果集
	@SuppressWarnings("rawtypes")
	private List list;
	//总记录数
	private int maxNum;
	//总页数
	private int maxPageNum;
	//当前页数
	private int pageNum;
	//分页游标起始位置start
	private int firstPage;
	//每页显示记录数
	private int pageRows;
	//分页按钮
	private int pageButton;
	
	
	@SuppressWarnings("rawtypes")
	public List getList() {
		return list;
	}
	@SuppressWarnings("rawtypes")
	public void setList(List list) {
		this.list = list;
	}
	public int getMaxNum() {
		return maxNum;
	}
	public void setMaxNum(int maxNum) {
		this.maxNum = maxNum;
	}
	public int getMaxPageNum() {
		return maxPageNum;
	}
	public void setMaxPageNum(int maxPageNum) {
		this.maxPageNum = maxPageNum;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getFirstPage() {
		return firstPage;
	}
	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}
	public int getPageRows() {
		return pageRows;
	}
	public void setPageRows(int pageRows) {
		this.pageRows = pageRows;
	}
	public int getPageButton() {
		return pageButton;
	}
	public void setPageButton(int pageButton) {
		this.pageButton = pageButton;
	}
	
	
}
