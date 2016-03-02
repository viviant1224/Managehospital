package cn.com.shxt.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;



public class EncodingFilter implements Filter{
	protected String ENCODING = "UTF-8";
	
	protected FilterConfig config = null;

	

	
    public void doFilter(ServletRequest request, ServletResponse response,
	        FilterChain chain) throws IOException, ServletException {
	    // 需要进行强制转换
		HttpServletRequest req = (HttpServletRequest)request;
		
		if("GET".equals(req.getMethod())){
			req = new EncodingWrapper(req, ENCODING);
		}else{
			req.setCharacterEncoding(ENCODING);
		}
		chain.doFilter(req, response);
	    
    }

	
    public void init(FilterConfig filterConfig) throws ServletException {
	    
	    this.config = filterConfig;
	    // 从web.xml配置文件中获取编码配置
	    this.ENCODING = this.config.getInitParameter("ENCODING");
    }




    public void destroy() {
	   //过滤器销毁
	    
    }

}
