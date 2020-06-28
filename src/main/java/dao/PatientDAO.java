package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import service.DBUtil;

public class PatientDAO {

	static Logger logger = Logger.getLogger(PatientDAO.class.getName());
	
	public static int createPatient(long SSN_ID,String name,int age,String address,String city,String state,String type_of_bed,String DOA ) {
		int affectedRows = 0;
		try {
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.patient_table(\r\n" + 
					"	\"SSN_ID\", name, age, \"DOA\", type_of_bed, address, city, state)\r\n" + 
					"	VALUES (?, ?, ?, ?, ?, ?, ?, ?);");
			stmt.setLong(1, SSN_ID);
			stmt.setString(2, name);
			stmt.setInt(3, age);
			stmt.setString(4,DOA);
			stmt.setString(5, type_of_bed);
			stmt.setString(6, address);
			stmt.setString(7, city);
			stmt.setString(8, state);
			affectedRows = stmt.executeUpdate();

		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception Occured", e);
		}
		return affectedRows;
	}
	public static int updatePatient(long patientID,String name,int age,String address,String city,String state,String type_of_bed,String DOA ) {
		int affectedRows = 0;
		try {
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("UPDATE public.patient_table\r\n" + 
					"			SET name=?, age=?, \"DOA\"=?, type_of_bed=?, address=?, city=?, state=?\r\n" + 
					"			WHERE \"patient_ID\"=?;");
			
			stmt.setString(1, name);
			stmt.setInt(2, age);
			stmt.setString(3,DOA);
			stmt.setString(4, type_of_bed);
			stmt.setString(5, address);
			stmt.setString(6, city);
			stmt.setString(7, state);
			stmt.setLong(8, patientID);
			

			affectedRows = stmt.executeUpdate();

		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception Occured", e);
		}
		return affectedRows;
	}
	public static JSONObject get(long patientID) {
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray=new JSONArray();
		int affectedRows = 0,index=0;
		try {
			Connection conn = DBUtil.getConnection();
			
			if(patientID!=-1) {
				PreparedStatement stmt=conn.prepareStatement("SELECT \"SSN_ID\", name, age, \"DOA\", \"DOD\", type_of_bed, address, city, state, status, no_of_days, \"patient_ID\"\r\n" + 
						"	FROM public.patient_table WHERE \"patient_ID\"=?;");  
				stmt.setLong(1,patient_ID); 
				
			}else {
				PreparedStatement stmt=conn.prepareStatement("SELECT \"SSN_ID\", name, age, \"DOA\", \"DOD\", type_of_bed, address, city, state, status, no_of_days, \"patient_ID\"\r\n" + 
						"	FROM public.patient_table WHERE status='active';");
			}
			ResultSet rs=stmt.executeQuery();
			
			JSONArray array = new JSONArray();
			//converting resultset into json
			while(rs.next()) {
				   JSONObject record = new JSONObject();
				   //Inserting key-value pairs into the json object
				   record.put("SSN_ID", rs.getLong("SSN_ID"));
				   record.put("name", rs.getString("name"));
				   record.put("age", rs.getInt("age"));
				   record.put("DOA", rs.getDate("DOA").toString());
				   record.put("DOD", rs.getDate("DOD").toString());
				   record.put("type_of_bed", rs.getString("type_of_bed"));
				   record.put("address", rs.getString("address"));
				   record.put("city", rs.getString("city"));
				   record.put("state", rs.getString("state"));
				   record.put("status", rs.getString("status"));
				   record.put("no_of_days", rs.getInt("no_of_days"));
				   record.put("patient_ID", rs.getLong("patient_ID"));
				   array.add(record);
				}
			jsonObject.put("patient_details", array);
			
		}catch(Exception e) {
			logger.log(Level.SEVERE,"Exception Occured",e);
		}
		return jsonObject;
	}

	public static int deletePatient(long patientId) {
		int affectedrows = 0;
		try {
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("DELETE FROM public.patient_table\r\n" + 
					"	WHERE \"patient_ID\"=?;");
		
			stmt.setLong(1,patientID);
			affectedrows = stmt.executeUpdate();

		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception Occured", e);
		}
		return affectedrows;
	}
}
