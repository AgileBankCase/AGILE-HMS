package service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

	static Connection conn = null;
	
	public static Connection getConnection() throws SQLException {
		if(!(conn!=null && !conn.isClosed())) {
			String dbUrl = "jdbc:postgresql://ec2-52-20-248-222.compute-1.amazonaws.com:5432/d7on0t7mv5ncrj?user=mlrktgbdxqibni&password=e2b5ff283d3461e9a8b20aca5b20eac0710da23f240e64ad747d77f2056d1f3c";
			//String dbUrl = System.getenv("JDBC_DATABASE_URL");
			conn = DriverManager.getConnection(dbUrl);
		}
		return conn;
	}
}
