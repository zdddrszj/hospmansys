package cn.com.shxt.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author 张化龙
 * @Version 2012-12-29
 * @Description JDBC工具类
 */
public class JdbcUtil {
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	/*private String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	private String user = "user";
	private String password = "root";*/

	/** 1.加载驱动 (静态代码块) */
	static {
		try {
			Class.forName("org.logicalcobwebs.proxool.ProxoolDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/** 2.获取连接 */
	public Connection getConn() {
		try {
			conn = DriverManager.getConnection("proxool.datasource");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	/** 3.更新操作 */
	public int update(String sql) {
		try {
			stmt = getConn().createStatement();
			return stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		} finally {
			release();
		}
	}
	
	/** 4.查询操作 */
	/*public ResultSet query(String sql) {
		try {
			stmt = getConn().createStatement();
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
			
		}
		return rs;
	}*/
	public List<Map<String,Object>> query(String sql) {
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		try {
			stmt = getConn().createStatement();
			rs = stmt.executeQuery(sql);
			/*------将结果集rs转化为List<Map<String,Object>>-----*/
			ResultSetMetaData rsmd = rs.getMetaData();
			int count = rsmd.getColumnCount();//获得结果集中字段的个数
			
			while(rs.next()){
				Map<String,Object> map = new HashMap<String,Object>();
				for(int i = 0 ; i < count ; i++){
					String key = rsmd.getColumnName(i+1);
					Object value = rs.getObject(key);
					map.put(key, value);
				}
				list.add(map);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally{
			release();
		}
		return list;
	}
	
	/**5.批量更新(事务)*/
	public int[] batch(String[] sqls){
		try {
			conn = getConn();
			conn.setAutoCommit(false);//设置自动提交为false
			stmt = conn.createStatement();
			for(String sql : sqls){
				stmt.addBatch(sql);//添加sql语句进入批处理
			}
			return stmt.executeBatch();
		} catch (SQLException e) {
			try {
				conn.rollback();//事务回滚 
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			return null;
		} finally{
			try {
				conn.commit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			release();
		}
	}
	
	public int getCount(String sql){
		sql = "select count(*) as num from ("+sql+")";
		return Integer.parseInt(query(sql).get(0).get("NUM").toString());
	}
	
	/**7.释放资源*/
	public void release(){
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace(); 
			}
		}
		if(stmt!=null){
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
