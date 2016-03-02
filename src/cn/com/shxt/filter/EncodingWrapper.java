package cn.com.shxt.filter;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * @author 乐毅
 * @日期 2012 2012-11-23 下午10:26:21
 * @描述
 *
 */
public class EncodingWrapper extends HttpServletRequestWrapper {
	//设置编码
	private String ENCODING;
	
	
	/**
	 * @see 注意必须调用父类构造器，传入HttpServletRequest实例
	 * @param request
	 */
	public EncodingWrapper(HttpServletRequest request,String ENCODING) {
	    super(request);
	    // 设置编码过滤器
	    this.ENCODING = ENCODING;
    }

	/*
	 * 重新定义 getParameter（） 方法
	 */
	@Override
    public String getParameter(String name) {
	    String value = this.getRequest().getParameter(name);
	    if(value != null){
	    	try {
	    		//将取得的请求参数值进行编码转化
	            byte[] b = value.getBytes("ISO-8859-1");
	            value = new String(b,ENCODING);
            } catch (UnsupportedEncodingException e) {
	           throw new RuntimeException(e);
            }
	    }
		
		
	    return value;
    }
	
	
	

}
