package cn.com.shxt.utils;

/**
 * @see 分页封装及业务的处理类
 * @author 黄威威
 * 
 */
public class PageTools {
	
	/**
	 * 
	 * @author 判断分页按钮位置的方法
	 * @param pageRows每页显示的记录数（固定不变），first当前页的起始位置(上一次)，maxNum总记录数，pagebutton分页按钮
	 * @return int类型firstPage每个按钮的分页起始位置
	 * 
	 */
	
	public static int getFirstPage(int first,int pageRows,int maxNum,int pageButton){
		
		int firstPage = 0;
		
		//首页
		if(pageButton==0){
			firstPage=0;
		}
		//上一页
		else if(pageButton==1){
			firstPage=first-pageRows;
		}
		//下一页
		else if(pageButton==2){
			firstPage=first+pageRows;
		}
		//尾页
		else if(pageButton==3){
			//举例算法如果每页显示5条记录 firstpage=((i+4)/5-1)*5;
			firstPage=((maxNum+(pageRows-1))/pageRows-1)*pageRows;				//总页数i+4/5   在-1*5最后一起的起始位置
		}
		
		return firstPage;
		
	}

}
