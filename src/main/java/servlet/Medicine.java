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

import dao.PatientDAO;
import service.Validator;

@WebServlet(name = "medicine", urlPatterns = { "/medicine" })
public class Medicine extends HttpServlet {
	static Logger logger = Logger.getLogger(Medicine.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String ssnIdStr = req.getParameter("ssnId");
			String name = req.getParameter("name");
			String ageStr = req.getParameter("age");
			String address = req.getParameter("address");
			String city = req.getParameter("city");
			String state = req.getParameter("state");
			String bed=req.getParameter("bed");
			String doaStr=req.getParameter("doa");
			if (!(Validator.isValidString(ssnIdStr) && Validator.isValidString(name) && Validator.isValidString(ageStr) && Validator.isValidString(address) && Validator.isValidString(bed)
					&& Validator.isValidString(city) && Validator.isValidString(state) && Validator.isValidString(doaStr))) {
				resp.getOutputStream().print("{\"status\":\"Please Enter ALL Fields\"}");
				return;
			}
			long ssnId=-1l;
			if(Validator.isValidString(ssnIdStr)) {ssnId=Long.parseLong(ssnIdStr);}
			Date doa=Date.valueOf(doaStr);

			int age = Integer.parseInt(ageStr);
			
			int result = PatientDAO.createPatient(ssnId, name, age, address, city, state,bed,doa);
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
		String medName=req.getParameter("medName");
		long patId=-1l;
    	if(Validator.isValidString(patIdStr)) {
    		patId=Long.parseLong(patIdStr);
    		JSONObject json=PatientDAO.getIssuedMedicine(patId);
    		if(((JSONArray)json.get("patient_details")).isEmpty()) {
        		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Patient ID\"}");
        		return;
        	}
    		else {
    			JSONArray patientMedicine = (JSONArray) json.get("patient_details");
    			for(int i=0;i <  patientMedicine.size();i++)
    			{
    				JSONObject record = (JSONObject) patientMedicine.get(i);
    				record.put("amount", ((Integer)record.get("issued_quantity"))*((Integer)record.get("rate")));
    			}
    			resp.getOutputStream().print(json.toString());
    	    	return;
    		}
    	}
    	else if(Validator.isValidString(medName)){
    		
    		JSONObject json=PatientDAO.getMedicine(medName);
	    	if(((JSONArray)json.get("patient_details")).isEmpty()) {
	    		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Medicine Name\"}");
	    		return;
	    	}
	    	else {
	    		resp.getOutputStream().print(json.toString());
	        	return;
	    	}
    	}
    	else {
    		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Medicine Name\"}");
    		return;
    	}
    }
    
}
