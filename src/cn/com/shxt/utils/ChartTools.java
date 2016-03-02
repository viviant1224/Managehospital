package cn.com.shxt.utils;
import java.util.List;
import cn.com.shxt.dao.Dao;
import cn.com.shxt.dao.bean.DaoBean;

public class ChartTools {
 
	Dao dao=new DaoBean();

	/**
	 * 统计专家的预约人数
	 * */
	 @SuppressWarnings("rawtypes")
	public List load() {
		 List rsList = null;
		try {
			String sql = "select DNAME,DID,COUNT(*) from ORDERINFO t where ORDERSTATE = '预约完成' group by DNAME,DID";
			rsList = dao.getListForSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rsList;
	}
	 
	 /**
		 * 按日期统计预约人数
		 * */
	 @SuppressWarnings("rawtypes")
	public List dateload() {
		 List rsList = null;
		try {
			String sql = "select ORDERDATE,COUNT(*) from ORDERINFO t where ORDERSTATE = '预约完成'  group by ORDERDATE order by ORDERDATE asc";
			rsList = dao.getListForSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rsList;
	}
	 
	 /**
		 * 按科室统计预约人数
		 * */
	 @SuppressWarnings("rawtypes")
	public List keshiload() {
		 List rsList = null;
		try {
			String sql = "select KNAME,COUNT(*) from ORDERINFO t where ORDERSTATE = '预约完成'  group by KNAME";
			rsList = dao.getListForSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rsList;
	}
}
