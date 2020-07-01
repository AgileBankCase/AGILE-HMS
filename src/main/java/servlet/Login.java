package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.LoginDAO;
import service.Validator;

@WebServlet(
        name = "MyServlet",
        urlPatterns = {"/login"}
    )
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	String username = req.getParameter("username");
    	String password = req.getParameter("password");
    	String accountType="false";
    	if(Validator.isValidString(username) && Validator.isValidString(password)) { 
    		accountType = LoginDAO.checkCredentials(username,password);
    		
    		if(accountType.equals("mismatch")){
        		req.setAttribute("msg", "Username or Password not correct!");
        		RequestDispatcher requestDispatcher = req.getRequestDispatcher("login.jsp");
        		requestDispatcher.forward(req, resp);
        	}else if(Validator.isValidString(accountType)) {
    			HttpSession session=req.getSession();
    			session.setAttribute("uname", username);
        		session.setAttribute("type", accountType);
        		
        		if(accountType.equals("desk")) {
        			RequestDispatcher requestDispatcher = req.getRequestDispatcher("createpatient.jsp");
            		requestDispatcher.forward(req, resp);
        		}
        		else if(accountType.equals("pharma")) {
        			RequestDispatcher requestDispatcher = req.getRequestDispatcher("issuemedicines.jsp");
            		requestDispatcher.forward(req, resp);
        		}
        		else if(accountType.equals("diagno")) {
        			RequestDispatcher requestDispatcher = req.getRequestDispatcher("diagnostics.jsp");
            		requestDispatcher.forward(req, resp);
        		}
    		}
    	}else if(accountType.equals("false")){
    		req.setAttribute("msg", "Username or Password should not be empty!");
    		RequestDispatcher requestDispatcher = req.getRequestDispatcher("login.jsp");
    		requestDispatcher.forward(req, resp);
    		
    	}
    }

    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	HttpSession session=req.getSession();
    	if(session.getAttribute("uname")!=null||session.getAttribute("uname")=="") {
    		if(session.getAttribute("type").equals("desk")) {
    			RequestDispatcher requestDispatcher = req.getRequestDispatcher("createcustomerscreen.jsp");
        		requestDispatcher.forward(req, resp);
    		}
    		else if(session.getAttribute("type").equals("pharma")) {
    			RequestDispatcher requestDispatcher = req.getRequestDispatcher("transfermoney.html");
        		requestDispatcher.forward(req, resp);
    		}
    		else if(session.getAttribute("type").equals("diagno")) {
    			RequestDispatcher requestDispatcher = req.getRequestDispatcher("transfermoney.html");
        		requestDispatcher.forward(req, resp);
    		}
    	}
    	else {
    		RequestDispatcher requestDispatcher = req.getRequestDispatcher("login.jsp");
    		requestDispatcher.forward(req, resp);
    	}
    	
    }
}
