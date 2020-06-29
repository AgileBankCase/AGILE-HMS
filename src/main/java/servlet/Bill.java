package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.MedicineDAO;
import dao.PatientDAO;
import service.Validator;

@WebServlet(name = "Bill", urlPatterns = { "/bill" })
public class Bill extends HttpServlet {
	static Logger logger = Logger.getLogger(Medicine.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String patIdStr = req.getParameter("patId");
			
			if (!(Validator.isValidString(patIdStr))) {
				resp.getOutputStream().print("{\"status\":\"Please Enter ALL Fields\"}");
				return;
			}
			long patId=-1l;
			
			if(Validator.isValidString(patIdStr)) {
				patId=Long.parseLong(patIdStr);
			}
			
			JSONObject json=PatientDAO.get(patId);
			JSONArray patientMedicine = (JSONArray) json.get("Patient_Medicine_Details");
			JSONObject record = (JSONObject) patientMedicine.get(0);
			
			Date doa=(Date) record.get("DOA");
			long doaMillis=doa.getTime();
			long millis=System.currentTimeMillis();
			Date dod=new java.sql.Date(millis);
			long daysDiff= (long) (millis - doaMillis);
			int numDays=0;
 			int result = BillDAO.changeStatusDOD(patId,dod,numDays);
 			if (result > 0) {
 				resp.getOutputStream().print("{\"status\":\"Succesfully Registered!\"}");
 				return;
 			}
 				
			
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception occured", e);
		}
		resp.getOutputStream().print("{\"status\":\"Registration failed\"}");
		return;
	}

	// doGet()//used for customer status display if time permits
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		String patIdStr = req.getParameter("patId");
		long patId=-1l;
    	if(Validator.isValidString(patIdStr)) {
    		patId=Long.parseLong(patIdStr);
    		JSONObject json=PatientDAO.get(patId);
        	if(((JSONArray)json.get("patient_details"))==null) {
        		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Patient ID\"}");
        		return;
        	}
        	else {
        		
        	}
    		
    	}
  
    }
    
}