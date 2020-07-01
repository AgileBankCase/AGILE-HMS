package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import service.DBUtil;

public class BillDAO 
{

	static Logger logger = Logger.getLogger(BillDAO.class.getName());
	
	public static int changeStatusDOD(long patient_Id,int no_of_days) 
	{
		int affectedRows = 0;
		try 
		{
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement("UPDATE public.patient_table \r\n" + 
					"SET \"DOD\"='now()', status='discharged', no_of_days=?\r\n" + 
					"WHERE \"patient_ID\"=?;\r\n" + 
					"DELETE  FROM public.diagnostic_table\r\n" + 
					"	WHERE \"patient_ID\"=?;\r\n" + 
					"	DELETE  FROM public.patient_medicine_table\r\n" + 
					"	WHERE \"patient_ID\"=?;");
			stmt.setInt(1, no_of_days);
			stmt.setLong(2, patient_Id);
			stmt.setLong(3, patient_Id);
			stmt.setLong(4, patient_Id);

			
			affectedRows = stmt.executeUpdate();
			


		} catch (Exception e)
		{
			logger.log(Level.SEVERE, "Exception Occured", e);
		}
		return affectedRows;
	}
	
}
