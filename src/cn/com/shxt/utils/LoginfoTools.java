package cn.com.shxt.utils;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.MDC;

import cn.com.shxt.model.UserinfoDoc;

import com.opensymphony.xwork2.ActionContext;

/**
 * @author 黄为I额为
 * @see 处理打印日志信息的工具类
 */
public class LoginfoTools {
	
	@SuppressWarnings({ "rawtypes" })
	public static void  logWrite(Class cla,String message){
		Log logger = LogFactory.getLog(cla);
		Map<String,Object> map = ActionContext.getContext().getSession();
		UserinfoDoc userinfo = (UserinfoDoc)map.get("userinfoDoc");
		String username = userinfo.getDname();
		MDC.put("user",username);
		MDC.put("message",message);
		logger.info("打印日志");
		MDC.getContext().clear();
	}

}
