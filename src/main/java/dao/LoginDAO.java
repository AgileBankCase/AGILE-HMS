package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import service.DBUtil;
import service.Validator;

public class LoginDAO {
	
	static Logger logger = Logger.getLogger(LoginDAO.class.getName());

	public static String checkCredentials(String username, String password){
		try {
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt=conn.prepareStatement("SELECT * FROM login_table where \"username\"=? and \"password\"=?;");  
			stmt.setString(1,username);//1 specifies the first parameter in the query  
			stmt.setString(2,password); 
			ResultSet rs=stmt.executeQuery();  
			if(rs!=null&& rs.next()) {
				return rs.getString("type");
			}
			
		}catch(Exception e) {
			logger.log(Level.SEVERE,"Exception Occured",e);
		}
		return "mismatch";
	}
}
