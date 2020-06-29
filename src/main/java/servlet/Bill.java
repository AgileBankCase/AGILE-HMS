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

import dao.BillDAO;
import dao.DiagnosticDAO;
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
			long patId = -1l;

			if (Validator.isValidString(patIdStr)) {
				patId = Long.parseLong(patIdStr);
			}

			JSONObject json = PatientDAO.get(patId);
			JSONArray patientDetails = (JSONArray) json.get("patient_details");
			JSONObject record = (JSONObject) patientDetails.get(0);

			Date doa = Date.valueOf((String) record.get("DOA"));
			long doaMillis = doa.getTime();
			long millis = System.currentTimeMillis();

			long daysDiff = (long) (millis - doaMillis);
			int numDays = (int) (daysDiff / (60 * 60 * 24 * 1000));

			int result = BillDAO.changeStatusDOD(patId, numDays);
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
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String patIdStr = req.getParameter("patId");
		long patId = -1l;
		Double totalBill = 0.0;
		JSONObject resultJson = new JSONObject();
		if (Validator.isValidString(patIdStr)) {
			patId = Long.parseLong(patIdStr);
			JSONObject json = PatientDAO.get(patId);
			if (((JSONArray) json.get("patient_details")) == null) {
				resp.getOutputStream().print("{\"status\":\"Please Enter Valid Patient ID\"}");
				return;
			} else {

				JSONArray array = new JSONArray();
				JSONObject record = new JSONObject();
				array = (JSONArray) json.get("patient_details");
				record = (JSONObject) array.get(0);
				if (record.get("no_of_days") != null) {
					int roomCharge = 0;
					if (record.get("type_of_bed").equals("single")) {
						roomCharge = 8000;
					} else if (record.get("type_of_bed").equals("semi")) {
						roomCharge = 4000;
					} else if (record.get("type_of_bed").equals("general")) {
						roomCharge = 2000;
					}
					int billForRoom = (Integer) (record.get("no_of_days")) * roomCharge;
					resultJson.put("bill_for_room", billForRoom);
					resultJson.put("no_of_days", record.get("no_of_days"));
					totalBill += billForRoom;
				}
				json=MedicineDAO.getIssuedMedicine(patId);
				record = new JSONObject();
				int amount = 0;
				JSONArray patientMedicine = (JSONArray) json.get("Patient_Medicine_Details");
				for (int i = 0; i < patientMedicine.size(); i++) {
					record = (JSONObject) patientMedicine.get(i);
					record.put("amount", ((Integer) record.get("issued_quantity")) * ((Double) record.get("rate")));
					amount += (Double) (record.get("amount"));
				}
				resultJson.put("pharmaAmount",amount);
				totalBill+=amount;
				json = DiagnosticDAO.getIssuedDiagnostics(patId);
				record = new JSONObject();
    			int totAmount=0;
    			JSONArray diagnosticMedicine = (JSONArray) json.get("Patient_Diagnostic_Details");
	    		for(int i=0;i <  diagnosticMedicine.size();i++)
    			{	
    				 record = (JSONObject) diagnosticMedicine.get(i);
    				totAmount+=(Double)(record.get("amount"));
    				
    			}
	    		resultJson.put("diangnosticAmount",totAmount);
	    		totalBill+=totAmount;
	    		resultJson.put("total_bill",totalBill);
	    		resp.getOutputStream().print(resultJson.toString());
				return;
			}

		}

	}

}