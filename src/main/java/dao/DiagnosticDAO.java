package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import service.DBUtil;
import service.Validator;

public class DiagnosticDAO {
	
	static Logger logger = Logger.getLogger(DiagnosticDAO.class.getName());
	static int affectedrows=0;
	@SuppressWarnings("unchecked")
	public static JSONObject getIssuedDiagnostics(long patientId){
		JSONObject jsonObject = new JSONObject();
		try {
			Connection conn = DBUtil.getConnection();
		
			PreparedStatement stmt=conn.prepareStatement("SELECT diagnostic.\"test_name\",diagnostic.\"amount\"\r\n" + 
					"FROM diagnostic\r\n" + 
					"INNER JOIN diagnostic_table\r\n" + 
					"ON diagnostic.\"test_ID\" = diagnostic_table.\"test_ID\" WHERE diagnostic_table.\"patient_ID\"=?;");  
			stmt.setLong(1,patientId);//1 specifies the first parameter in the query  
			ResultSet rs=stmt.executeQuery();
			
			JSONArray array = new JSONArray();
			//converting resultset into json
			while(rs.next()) {
				   JSONObject record = new JSONObject();
				   //Inserting key-value pairs into the json object
				   record.put("test_name", rs.getString("test_name"));
				   record.put("amount", rs.getDouble("amount"));
				   array.add(record);
				}
			jsonObject.put("Patient_Diagnostic_Details", array);
			
		}catch(Exception e) {
			logger.log(Level.SEVERE,"Exception Occured",e);
		}
		return jsonObject;
	}
	
	public static JSONObject getDiagnostic(String testName){
		JSONObject jsonObject = new JSONObject();
		try {
			Connection conn = DBUtil.getConnection();
		
			PreparedStatement stmt=conn.prepareStatement("SELECT \"test_ID\", test_name, amount\r\n" + 
					"	FROM public.diagnostic WHERE test_name=?;");  
			stmt.setString(1,testName);
			ResultSet rs=stmt.executeQuery();
			JSONObject record = new JSONObject();
				   //Inserting key-value pairs into the json object
				   record.put("test_ID", rs.getLong("test_ID"));
				   record.put("test_name", rs.getString("test_name"));
				   record.put("amount", rs.getDouble("amount"));
			jsonObject.put("Diagnostic_Details", record);
			
		}catch(Exception e) {
			logger.log(Level.SEVERE,"Exception Occured",e);
		}
		return jsonObject;
	}
	

	public static int addDiagnostics(long patientId,String testName) {
		int affectedRows = 0;
		try {
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.diagnostic_table(\r\n" + 
					"	\"patient_ID\", \"test_ID\")\r\n" + 
					"	VALUES (?, (SELECT \"test_ID\"\r\n" + 
					"	FROM public.diagnostic 	WHERE test_name=?));");
			stmt.setLong(1, patientId);
			stmt.setString(2, testName);
			affectedRows = stmt.executeUpdate();

		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception Occured", e);
		}
		return affectedRows;
	}
	
	
}

