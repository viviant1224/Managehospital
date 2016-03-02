package cn.com.shxt.lanjie;

import java.util.Map;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class Loginlanjie extends AbstractInterceptor{
	private static final long serialVersionUID = -7959757029585442169L;

	@SuppressWarnings("rawtypes")
	public String intercept(ActionInvocation arg0) throws Exception {
		// TODO Auto-generated method stub
		Map map = arg0.getInvocationContext().getSession();
		if(map.get("userinfoDoc")==null) {
			System.out.println("没有用户");
			return Action.LOGIN; 
		} else {
			System.out.println("有用户");
			return arg0.invoke();
		}
		
	}

}
