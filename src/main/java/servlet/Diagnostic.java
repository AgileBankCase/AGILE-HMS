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

import dao.DiagnosticDAO;
import service.Validator;

@WebServlet(name = "diagno", urlPatterns = { "/diagno" })
public class Diagnostic extends HttpServlet {
	static Logger logger = Logger.getLogger(Diagnostic.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String patIdStr = req.getParameter("patId");
			String testName = req.getParameter("testName");
			
			
			if (!(Validator.isValidString(patIdStr) && Validator.isValidString(testName))) {
				resp.getOutputStream().print("{\"status\":\"Please Enter ALL Fields\"}");
				return;
			}
			long patId=-1l;
			if(Validator.isValidString(patIdStr)) {patId=Long.parseLong(patIdStr);}
			
			
 					int result = DiagnosticDAO.addDiagnostics(patId, testName);
 					if (result > 0) {
 						resp.getOutputStream().print("{\"status\":\"Test Succesfully Added!\"}");
 						return;
 					}		
		} catch (Exception e) {
			logger.log(Level.SEVERE, "Exception occured", e);
		}
		resp.getOutputStream().print("{\"status\":\"Test Addition failed\"}");
		return;
	}

	// doGet()//used for customer status display if time permits
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
		String patIdStr = req.getParameter("patId");
		String testName=req.getParameter("testName");
		long patId=-1l;
    	if(Validator.isValidString(patIdStr)) {
    		patId=Long.parseLong(patIdStr);
    		JSONObject json=DiagnosticDAO.getIssuedDiagnostics(patId);
    		if(((JSONArray)json.get("Patient_Diagnostic_Details"))==null) {
        		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Patient ID\"}");
        		return;
        	}
    		else {
    			
    			resp.getOutputStream().print(json.toString());
    	    	return;
    		}
    	}
    	else if(Validator.isValidString(testName)){
    		
    		JSONObject json=DiagnosticDAO.getDiagnostic(testName);
	    	if(((JSONArray)json.get("Diagnostic_Details"))==null) {
	    		resp.getOutputStream().print("{\"status\":\"Please Enter Valid Test Name\"}");
	    		return;
	    	}
	    	else {
	    		
	    		resp.getOutputStream().print(json.toString());
	        	return;
	    	}
    	}
    	else {
    		resp.getOutputStream().print("{\"status\":\"Please Enter Patient Id or Test Name\"}");
    		return;
    	}
    }
    
}
