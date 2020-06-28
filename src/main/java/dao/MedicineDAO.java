package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import service.DBUtil;
import service.Validator;

public class MedicineDAO {
	
	static Logger logger = Logger.getLogger(MedicineDAO.class.getName());
	static int affectedrows=0;
	@SuppressWarnings("unchecked")
	public static JSONObject getIssuedMedicine(long patientId){
		JSONObject jsonObject = new JSONObject();
		try {
			Connection conn = DBUtil.getConnection();
		
			PreparedStatement stmt=conn.prepareStatement("SELECT medicine_table.\"medicine_name\",patient_medicine_table.\"issued_quantity\",medicine_table.\"rate\"\r\n" + 
					"FROM patient_medicine_table\r\n" + 
					"INNER JOIN medicine_table\r\n" + 
					"ON patient_medicine_table.\"medicine_ID\" = medicine_table.\"medicine_ID\" WHERE patient_medicine_table.\"patient_ID\"=?;");  
			stmt.setLong(1,patientId);//1 specifies the first parameter in the query  
			ResultSet rs=stmt.executeQuery();
			
			JSONArray array = new JSONArray();
			//converting resultset into json
			while(rs.next()) {
				   JSONObject record = new JSONObject();
				   //Inserting key-value pairs into the json object
				   record.put("medicine_name", rs.getString("medicine_name"));
				   record.put("issued_quantity", rs.getInt("issued_quantity"));
				   record.put("rate", rs.getDouble("rate"));
				   array.add(record);
				}
			jsonObject.put("Patient_Medicine_Details", array);
			
		}catch(Exception e) {
			logger.log(Level.SEVERE,"Exception Occured",e);
		}
		return jsonObject;
	}
	
	
	public static JSONObject getMedicine(String medicineName){
		JSONObject jsonObject = new JSONObject();
		try {
			Connection conn = DBUtil.getConnection();
		JSONArray array=new JSONArray();
			PreparedStatement stmt=conn.prepareStatement("SELECT \"medicine_ID\", medicine_name, quantity, rate\r\n" + 
					"	FROM public.medicine_table WHERE medicine_name=?;");  
			stmt.setString(1,medicineName);
			ResultSet rs=stmt.executeQuery();
			JSONObject record = new JSONObject();
					rs.next();
				   //Inserting key-value pairs into the json object
				   record.put("medicine_ID", rs.getLong("medicine_ID"));
				   record.put("medicine_name", rs.getString("medicine_name"));
				   record.put("quantity", rs.getInt("quantity"));
				   record.put("rate", rs.getDouble("rate"));
				   array.add(record);
			jsonObject.put("Medicine_Details",array);
			
		}catch(Exception e) {
			logger.log(Level.SEVERE,"Exception Occured",e);
		}
		return jsonObject;
	}
	
	public static int issueMedicine(long patientId,String medicineName,int issuedQuantity,int setValue) {
		int affectedRows = 0;
		//int affectedRows2=0;
		try {
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("INSERT INTO public.patient_medicine_table(\r\n" + 
					"	\"patient_ID\", \"medicine_ID\", issued_quantity)\r\n" + 
					"	VALUES (?,(SELECT \"medicine_ID\"\r\n" + 
					"	FROM public.medicine_table WHERE medicine_name=?) , ?);");
			stmt.setLong(1, patientId);
			stmt.setString(2, medicineName);
			stmt.setInt(3, issuedQuantity);
			affectedRows = stmt.executeUpdate();
			PreparedStatement stmt2 = conn.prepareStatement("UPDATE public.medicine_table" + 
					"	SET  quantity=?" + 
					"	WHERE medicine_name=?;");
			stmt2.setInt(1, setValue);
			stmt2.setString(2, medicineName);
			stmt2.executeUpdate();
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception Occured", e);
		}
		return affectedRows;
	}
	
	
}

