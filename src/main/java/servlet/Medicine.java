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
import service.Validator;

@WebServlet(name = "medicine", urlPatterns = { "/medicine" })
public class Medicine extends HttpServlet {
	static Logger logger = Logger.getLogger(Medicine.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String patIdStr = req.getParameter("patId");
			String medName = req.getParameter("medName");
			String issueQuantityStr = req.getParameter("issueQuantity");

			if (!(Validator.isValidString(patIdStr) && Validator.isValidString(medName)
					&& Validator.isValidString(issueQuantityStr))) {
				resp.getOutputStream().print("{\"status\":\"Please Enter ALL Fields\"}");
				return;
			}
			long patId = -1l;
			int issueQuantity = -1;
			if (Validator.isValidString(patIdStr)) {
				patId = Long.parseLong(patIdStr);
			}

			issueQuantity = Integer.parseInt(issueQuantityStr);
			JSONObject json = MedicineDAO.getMedicine(medName);
			JSONArray patientMedicine = (JSONArray) json.get("Medicine_Details");

			JSONObject record = (JSONObject) patientMedicine.get(0);
			int availableQuantity = (Integer) record.get("quantity");
			if (availableQuantity > issueQuantity) {
				int setValue = availableQuantity - issueQuantity;
				int result = MedicineDAO.issueMedicine(patId, medName, issueQuantity, setValue);
				if (result > 0) {
					resp.getOutputStream().print("{\"status\":\"Succesfully Registered!\"}");
					return;
				}
			} else {
				resp.getOutputStream().print("{\"status\":\"Quantity Not Available\"}");
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
		String medName = req.getParameter("medName");
		long patId = -1l;
		if (Validator.isValidString(patIdStr)) {
			patId = Long.parseLong(patIdStr);
			JSONObject json = MedicineDAO.getIssuedMedicine(patId);
			if (((JSONArray) json.get("Patient_Medicine_Details")) == null) {
				resp.getOutputStream().print("{\"status\":\"Please Enter Valid Patient ID\"}");
				return;
			} else {
				
				resp.getOutputStream().print(json.toString());
				return;
			}
		} else if (Validator.isValidString(medName)) {

			JSONObject json = MedicineDAO.getMedicine(medName);
			if (((JSONArray) json.get("Medicine_Details")) == null) {
				resp.getOutputStream().print("{\"status\":\"Please Enter Valid Medicine Name\"}");
				return;
			} else {
				resp.getOutputStream().print(json.toString());
				return;
			}
		} else {
			resp.getOutputStream().print("{\"status\":\"Please Enter Valid Medicine Name\"}");
			return;
		}
	}

}
