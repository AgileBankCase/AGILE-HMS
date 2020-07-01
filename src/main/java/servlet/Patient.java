package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.ArrayList;
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

@WebServlet(name = "patient", urlPatterns = { "/patient" })
public class Patient extends HttpServlet {
	static Logger logger = Logger.getLogger(Patient.class.getName());
	static ArrayList<String> ssnID=new ArrayList<String>();
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
			if(ssnID.contains(ssnIdStr)) {
				resp.getOutputStream().print("{\"status\":\"SSN ID already present!\"}");
				return;
			}
			long ssnId=-1l;
			if(Validator.isValidString(ssnIdStr)) {ssnId=Long.parseLong(ssnIdStr);}
			Date doa=Date.valueOf(doaStr);

			int age = Integer.parseInt(ageStr);
			
			int result = PatientDAO.createPatient(ssnId, name, age, address, city, state,bed,doa);
			if (result > 0) {
				ssnID.add(ssnIdStr);
				resp.getOutputStream().print("{\"status\":\"Succesfully Registered!\"}");
				return;
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception occured", e);
		}
		resp.getOutputStream().print("{\"status\":\"Registration failed\"}");
		return;
	}

	// doPut() //used for update customer

	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			String patIdStr = req.getParameter("patId");
			String name = req.getParameter("name");
			String ageStr = req.getParameter("age");
			String address = req.getParameter("address");
			String state = req.getParameter("state");
			String city=req.getParameter("city");
			String bed=req.getParameter("bed");
			String doaStr=req.getParameter("doa"); 
			String status=req.getParameter("status");
			//get status
			long patId=-1l;
			if (!(Validator.isValidString(patIdStr) && Validator.isValidString(name) && Validator.isValidString(ageStr) && Validator.isValidString(address) && Validator.isValidString(bed)
					&& Validator.isValidString(city) && Validator.isValidString(state) && Validator.isValidString(doaStr)) && Validator.isValidString(status)) {
				resp.getOutputStream().print("{\"status\":\"Please Enter ALL Fields\"}");
				return;
			}
			int age = Integer.parseInt(ageStr);
			Date doa=Date.valueOf(doaStr);
			if(Validator.isValidString(patIdStr)) {
	    		 patId=Long.parseLong(patIdStr);
	    	}
			
			int result = PatientDAO.updatePatient(patId, name, age, address, city, state, bed, doa,status);
			if (result > 0) {
				resp.getOutputStream().print("{\"status\":\"Succesfully Updated!\"}");
				return;
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception occured", e);
		}
		resp.getOutputStream().print("{\"status\":\"Update failed\"}");
		return;
	}

	// doDelete() //used for delete customer
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String patIdStr = req.getParameter("patId");
		long patId=-1l;

		try{
			if(Validator.isValidString(patIdStr)) {
	    		 patId=Long.parseLong(patIdStr);
	    	}
			
			int result=PatientDAO.deletePatient(patId);
			
			if (result > 0) {
				resp.getOutputStream().print("{\"status\":\"Succesfully Deleted!\"}");
				return;
			}
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception occured", e);
		}
		resp.getOutputStream().print("{\"status\":\"Delete failed\"}");
		return;
	}
	 
	// doGet()//used for customer status display if time permits
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		String patIdStr = req.getParameter("patId");
		String genBillStr = req.getParameter("genBill");
		long patId=-1l;
    	if(Validator.isValidString(patIdStr)) {
    		patId=Long.parseLong(patIdStr);
    	}
    	JSONObject json=PatientDAO.get(patId);
    	if(((JSONArray)json.get("patient_details"))==null) {
    		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Patient ID\"}");
    		return;
    	}
    	
    	if(Validator.isValidString(genBillStr) && genBillStr.equals("true")) {
    		JSONArray patientDetails = (JSONArray) json.get("patient_details");
			JSONObject record = (JSONObject) patientDetails.get(0);
    		Date doa = Date.valueOf((String) record.get("DOA"));
			long doaMillis = doa.getTime();
			long millis = System.currentTimeMillis();
			
			long daysDiff = (long) (millis - doaMillis);
			int numDays = (int) (daysDiff / (60 * 60 * 24 * 1000));
			if (numDays > 0) {
				int roomCharge = 0;
				record.put("no_of_days",numDays);
				if (record.get("type_of_bed").equals("Single room")) {
					roomCharge = 8000;
				} else if (record.get("type_of_bed").equals("Semi sharing")) {
					roomCharge = 4000;
				} else if (record.get("type_of_bed").equals("General Ward")) {
					roomCharge = 2000;
				}
				int billForRoom = (Integer) (record.get("no_of_days")) * roomCharge;
				record.put("bill_for_room",billForRoom);
			}
    	}
    	resp.getOutputStream().print(json.toString());
    	return;
    }
    
}
