package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
 private static final long serialVersionUID = 1L;

 protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
     String jdbcUrl = "jdbc:mysql://localhost:3306/railway_reservation";
     String dbUser = "root";
     String dbPassword = "Zx#Ud2aDay";

     try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         Connection con = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

         String username = request.getParameter("txtName");
         String password = request.getParameter("txtPwd");

         PreparedStatement ps = con.prepareStatement("SELECT username FROM users WHERE username=? AND password=?");
         ps.setString(1, username);
         ps.setString(2, password);

         ResultSet rs = ps.executeQuery();

         if (rs.next()) {
             // Set an attribute to indicate successful login
             request.setAttribute("loginSuccess", true);
             RequestDispatcher rd = request.getRequestDispatcher("welcome.jsp");
             rd.forward(request, response);
         } else {
             response.getWriter().println("<font color=red size=18>Login Failed!!<br>");
             response.getWriter().println("<a href=Login.jsp>TRY AGAIN!!</a>");
         }

         con.close();
     } catch (ClassNotFoundException | SQLException e) {
         e.printStackTrace();
         // Handle exceptions appropriately, log or show an error page.
     }
 }
}