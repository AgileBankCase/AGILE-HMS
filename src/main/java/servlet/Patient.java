package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
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

import org.json.simple.JSONObject;

import dao.CustomerSearchDAO;
import dao.PatientDAO;
import service.Validator;

@WebServlet(name = "customer", urlPatterns = { "/customer" })
public class Patient extends HttpServlet {
	static Logger logger = Logger.getLogger(Patient.class.getName());

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String ssnid = req.getParameter("ssn-id");
			String name = req.getParameter("cname");
			String ageStr = req.getParameter("age");
			String addline1 = req.getParameter("addline1");
			String addline2 = req.getParameter("addline2");
			String city = req.getParameter("city");
			String state = req.getParameter("state");
			if (ssnid.isEmpty() || name.isEmpty() || ageStr.isEmpty() || addline1.isEmpty() || addline2.isEmpty()
					|| city.isEmpty() || state.isEmpty()) {
				resp.getOutputStream().print("{\"status\":\"Please Enter Mandatory Fields\"}");
				return;
			}
			int age = Integer.parseInt(ageStr);
			int result = PatientDAO.registerCustomer(ssnid, name, age, addline1, addline2, city, state);
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

	// doPut() //used for update customer

	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			String cusid = req.getParameter("cusid");
			String name = req.getParameter("ncname");
			String age = req.getParameter("nage");
			String addline1 = req.getParameter("naddress1");
			String addline2 = req.getParameter("naddress2");

			int result = PatientDAO.updateCustomer(cusid, name, Integer.parseInt(age), addline1, addline2);
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
		String cusid = req.getParameter("dcusid");
		try{
			int result=PatientDAO.deleteCustomer(cusid);
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
    	String ssnIdStr=req.getParameter("ssn-id");
    	String cusIdStr=req.getParameter("cid");
    	long ssnID=-1l,cusID=-1l;
    	if(Validator.isValidString(ssnIdStr)) {
    		ssnID=Long.parseLong(ssnIdStr);
    	}else if(Validator.isValidString(cusIdStr)) {
    		cusID=Long.parseLong(cusIdStr);
    	}
    	JSONObject json=PatientDAO.userDetails(ssnID,cusID);
    	resp.getOutputStream().print(json.toString());
    	return;
    }
}
